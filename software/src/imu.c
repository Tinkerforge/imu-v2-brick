/* imu-v2-brick
 * Copyright (C) 2015 Olaf Lüke <olaf@tinkerforge.com>
 *
 * imu.c: Inertial Measurement Unit implementation
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#include "imu.h"

#include "config.h"
#include "communication.h"
#include "bricklib/com/com_messages.h"
#include "bricklib/com/com_common.h"
#include "bricklib/logging/logging.h"

#include "bricklib/drivers/pio/pio.h"
#include "bricklib/drivers/twi/twi.h"
#include "bricklib/drivers/twi/twid.h"
#include "bricklib/drivers/async/async.h"
#include "bricklib/drivers/pwmc/pwmc.h"
#include "bricklib/drivers/tc/tc.h"
#include "bricklib/drivers/adc/adc.h"
#include "bricklib/drivers/usb/USBD_HAL.h"
#include "bricklib/utility/util_definitions.h"
#include "bricklib/utility/init.h"
#include "bricklib/utility/led.h"
#include "bricklib/utility/sqrt.h"
#include "bricklib/utility/mutex.h"
#include "bricklib/drivers/flash/flashd.h"

#include <stdio.h>
#include <string.h>
#include <math.h>

uint32_t imu_period[IMU_PERIOD_NUM] = {0};
uint32_t imu_period_counter[IMU_PERIOD_NUM] = {0};

int16_t imu_acc_x = 0;
int16_t imu_acc_y = 0;
int16_t imu_acc_z = 0;

int16_t imu_mag_x = 0;
int16_t imu_mag_y = 0;
int16_t imu_mag_z = 0;

int16_t imu_gyr_x = 0;
int16_t imu_gyr_y = 0;
int16_t imu_gyr_z = 0;

int16_t imu_pitch = 0;
int16_t imu_roll = 0;
int16_t imu_yaw = 0;

int16_t imu_gyr_temperature = 0;
int32_t imu_gyr_temperature_sum = 0;
uint32_t imu_gyr_temperature_counter = 0;

float imu_qua_x = 1.0;
float imu_qua_y = 0.0;
float imu_qua_z = 0.0;
float imu_qua_w = 0.0;

bool imu_use_leds = false;
bool imu_use_orientation = true;
bool imu_mode_update = true;
Async imu_async;
uint8_t imu_sensor_data[8] = {0};

extern Twid twid;
extern Mutex mutex_twi_bricklet;

extern ComInfo com_info;
extern bool usb_first_connection;

Pin pins_imu_led[] = {PINS_IMU_LED};
int8_t pins_led_tc_channel[] = {-1, -1, -1, -1, -1, -1, 1, 2, 0, -1};
int8_t pins_led_pwm_channel[] = {0, 0, 1, 1, 2, 2, -1, -1, -1, 3};
bool pins_led_is_pwm[] = {true,
                          true,
                          true,
                          true,
                          true,
                          true,
                          false,
                          false,
                          false,
                          true};

SensorData sensor_data = {0};
uint8_t update_sensor_counter = 0;

void tick_task(const uint8_t tick_type) {
	static int8_t message_counter = 0;

	if(tick_type == TICK_TASK_TYPE_CALCULATION) {
		update_sensors();

		for(uint8_t i = 0; i < IMU_PERIOD_NUM; i++) {
			if(imu_period_counter[i] < UINT32_MAX) {
				imu_period_counter[i]++;
			}
		}
	} else if(tick_type == TICK_TASK_TYPE_MESSAGE) {
		if(usb_first_connection && !usbd_hal_is_disabled(IN_EP)) {
			message_counter++;
			if(message_counter >= 100) {
				message_counter = 0;
				if(brick_init_enumeration(COM_USB)) {
					com_info.current = COM_USB;
					usb_first_connection = false;
					message_counter = 0;
				}
			}
		}

		for(uint8_t i = 0; i < IMU_PERIOD_NUM; i++) {
			if((imu_period[i] != 0) &&
			   (imu_period[i] <= imu_period_counter[i])) {
				// Test if we are totally out of time (lost a whole
				// period), in this case we don't send the callback again.
				// This is needed for the wireless extensions
				if(imu_period[i]*2 <= imu_period_counter[i]) {
					imu_period_counter[i] = imu_period[i];
				}
				make_period_callback(i);
			}
		}
	}
}

void make_period_callback(const uint8_t type) {
	imu_period_counter[type] -= imu_period[type];

	switch(type) {
		case IMU_PERIOD_TYPE_ACC: {
			AccelerationCallback as;
			com_make_default_header(&as, com_info.uid, sizeof(AccelerationCallback), FID_ACCELERATION);
			as.x = imu_acc_x;
			as.y = imu_acc_y;
			as.z = imu_acc_z;

			send_blocking_with_timeout(&as,
			                           sizeof(AccelerationCallback),
			                           com_info.current);
			break;
		}

		case IMU_PERIOD_TYPE_MAG: {
			MagneticFieldCallback mfs;
			com_make_default_header(&mfs, com_info.uid, sizeof(MagneticFieldCallback), FID_MAGNETIC_FIELD);
			mfs.x = imu_mag_x;
			mfs.y = imu_mag_y;
			mfs.z = imu_mag_z;

			send_blocking_with_timeout(&mfs,
			                           sizeof(MagneticFieldCallback),
			                           com_info.current);
			break;
		}

		case IMU_PERIOD_TYPE_ANG: {
			AngularVelocityCallback avs;
			com_make_default_header(&avs, com_info.uid, sizeof(AngularVelocityCallback), FID_ANGULAR_VELOCITY);
			avs.x = imu_gyr_x;
			avs.y = imu_gyr_y;
			avs.z = imu_gyr_z;

			send_blocking_with_timeout(&avs,
			                           sizeof(AngularVelocityCallback),
			                           com_info.current);
			break;
		}

		case IMU_PERIOD_TYPE_ALL: {
			AllDataCallback ads;
			com_make_default_header(&ads, com_info.uid, sizeof(AllDataCallback), FID_ALL_DATA);
			ads.acc_x       = imu_acc_x;
			ads.acc_y       = imu_acc_y;
			ads.acc_z       = imu_acc_z;
			ads.mag_x       = imu_mag_x;
			ads.mag_y       = imu_mag_y;
			ads.mag_z       = imu_mag_z;
			ads.ang_x       = imu_gyr_x;
			ads.ang_y       = imu_gyr_y;
			ads.ang_z       = imu_gyr_z;
			ads.temperature = imu_gyr_temperature;

			send_blocking_with_timeout(&ads,
			                           sizeof(AllDataCallback),
			                           com_info.current);
			break;
		}

		case IMU_PERIOD_TYPE_ORI: {
			OrientationCallback os;
			com_make_default_header(&os, com_info.uid, sizeof(OrientationCallback), FID_ORIENTATION);
			os.roll  = imu_roll;
			os.pitch = imu_pitch;
			os.yaw   = imu_yaw;

			send_blocking_with_timeout(&os,
			                           sizeof(OrientationCallback),
			                           com_info.current);
			break;
		}

		case IMU_PERIOD_TYPE_QUA: {
			QuaternionCallback qs;
			com_make_default_header(&qs, com_info.uid, sizeof(QuaternionCallback), FID_QUATERNION);
			qs.x = imu_qua_x;
			qs.y = imu_qua_y;
			qs.z = imu_qua_z;
			qs.w = imu_qua_w;

			send_blocking_with_timeout(&qs,
			                           sizeof(QuaternionCallback),
			                           com_info.current);
			break;
		}
	}
}

/*
Python script to make the lookup table:

s = "{0"
for i in range(1, 21):
    s += ", " + str(0xffff/2 - ((1000-i**3/((20**3)/1000))*(0xFFFF/2)/1000))
for i in reversed(range(0, 20)):
    s += ", " + str(0xffff/2 + ((1000-i**3/((20**3)/1000))*(0xFFFF/2)/1000))
print s + "}"
*/
const uint16_t blink_lookup[41] = {1, 1, 33, 99, 263, 492, 885, 1377, 2098, 2982, 4096, 5440, 7078, 8979, 11240, 13795, 16777, 20119, 23888, 28082, 32767, 37452, 41646, 45415, 48757, 51739, 54294, 56555, 58456, 60094, 61438, 62552, 63436, 64157, 64649, 65042, 65271, 65435, 65501, 65534, 65534};

void imu_leds_on(const bool on) {
	if(on) {
		PMC->PMC_PCER0 = 1 << ID_PWM;
		for(uint8_t i = 0; i < 4; i++) {
			PWMC_ConfigureChannel(PWM, i, PWM_CMR_CPRE_MCK, 0, 0);
			PWMC_SetPeriod(PWM, i, 0xFFFF);
			PWMC_SetDutyCycle(PWM, i, 0);
			PWMC_EnableChannel(PWM, i);
		}

	    PMC->PMC_PCER0 = 1 << ID_TC0;
	    tc_channel_init(&TC0->TC_CHANNEL[0],
		                TC_CMR_WAVE |
		                TC_CMR_TCCLKS_TIMER_CLOCK1 |
		                TC_CMR_ACPA_CLEAR |
		                TC_CMR_ACPC_SET |
		                TC_CMR_WAVSEL_UP_RC);

	    TC0->TC_CHANNEL[0].TC_RA = 0;
	    TC0->TC_CHANNEL[0].TC_RC = 0xFFFF;
	    tc_channel_start(&TC0->TC_CHANNEL[0]);

	    PMC->PMC_PCER0 = 1 << ID_TC1;
		tc_channel_init(&TC0->TC_CHANNEL[1],
		                TC_CMR_WAVE |
		                TC_CMR_TCCLKS_TIMER_CLOCK1 |
		                TC_CMR_ACPA_CLEAR |
		                TC_CMR_ACPC_SET |
		                TC_CMR_WAVSEL_UP_RC);

	    TC0->TC_CHANNEL[1].TC_RA = 0;
	    TC0->TC_CHANNEL[1].TC_RC = 0xFFFF;
	    tc_channel_start(&TC0->TC_CHANNEL[1]);

	    PMC->PMC_PCER0 = 1 << ID_TC2;
		tc_channel_init(&TC0->TC_CHANNEL[2],
		                TC_CMR_WAVE |
		                TC_CMR_TCCLKS_TIMER_CLOCK1 |
		                TC_CMR_BCPB_CLEAR |
		                TC_CMR_BCPC_SET |
		                TC_CMR_EEVT_XC0 |
		                TC_CMR_WAVSEL_UP_RC);

	    TC0->TC_CHANNEL[2].TC_RB = 0;
	    TC0->TC_CHANNEL[2].TC_RC = 0xFFFF;
	    tc_channel_start(&TC0->TC_CHANNEL[2]);


		PIO_Configure(pins_imu_led, PIO_LISTSIZE(pins_imu_led));
	} else {
		PMC->PMC_PCER0 &= ~(1 << ID_PWM);
		PMC->PMC_PCER0 &= ~(1 << ID_TC0);
		PMC->PMC_PCER0 &= ~(1 << ID_TC1);
		PMC->PMC_PCER0 &= ~(1 << ID_TC2);

		Pin pins[] = {PINS_IMU_LED};
		for(uint8_t i = 0; i < PIO_LISTSIZE(pins); i++) {
			pins[i].type = PIO_OUTPUT_1;
		}

		PIO_Configure(pins, PIO_LISTSIZE(pins));
	}

	imu_use_leds = on;
}

void imu_blinkenlights(void) {
	if(!imu_use_leds) {
		return;
	}

	PWMC_SetDutyCycle(PWM, 0,
	                  blink_lookup[(BETWEEN(-1000, imu_acc_x, 1000) +
	                                1000)/50]);
	PWMC_SetDutyCycle(PWM, 1,
	                  blink_lookup[(BETWEEN(-1000, imu_acc_y, 1000) +
	                                1000)/50]);
	PWMC_SetDutyCycle(PWM, 2,
	                  blink_lookup[40 - (BETWEEN(-1000, imu_acc_z, 1000) +
	                               1000)/50]);

	int16_t degree = atan2(2.0*(imu_qua_x*imu_qua_y + imu_qua_w*imu_qua_z),
	                       1.0 - 2.0*(imu_qua_x*imu_qua_x + imu_qua_z*imu_qua_z))*180/M_PI + 45;
	if(degree < 0) {
		degree += 360;
	}

	if(degree > 315 || degree <= 45) {
		uint8_t index = ((degree + 45) % 360) * 40 / 90;
		TC0->TC_CHANNEL[0].TC_RA = 0;
		TC0->TC_CHANNEL[1].TC_RA = blink_lookup[index];
		TC0->TC_CHANNEL[2].TC_RB = 0;
		PWMC_SetDutyCycle(PWM, 3, blink_lookup[index]);
	} else if(degree < 135) {
		uint8_t index = (degree - 45) * 40 / 90;
		TC0->TC_CHANNEL[0].TC_RA = 0;
		TC0->TC_CHANNEL[1].TC_RA = 0;
		TC0->TC_CHANNEL[2].TC_RB = blink_lookup[40-index];
		PWMC_SetDutyCycle(PWM, 3, blink_lookup[40-index]);
	} else if(degree < 225) {
		uint8_t index = (degree - 135) * 40 / 90;
		TC0->TC_CHANNEL[0].TC_RA = blink_lookup[40-index];
		TC0->TC_CHANNEL[1].TC_RA = 0;
		TC0->TC_CHANNEL[2].TC_RB = blink_lookup[index];
		PWMC_SetDutyCycle(PWM, 3, 0);
	} else {
		uint8_t index = (degree - 225) * 40 / 90;
		TC0->TC_CHANNEL[0].TC_RA = blink_lookup[index];
		TC0->TC_CHANNEL[1].TC_RA = blink_lookup[40-index];
		TC0->TC_CHANNEL[2].TC_RB = 0;
		PWMC_SetDutyCycle(PWM, 3, 0);
	}
}

void update_sensors(void) {
	update_sensor_counter++;
	if(update_sensor_counter >= 100) {
		bmo_read_register(REG_ACC_DATA_X_LSB, (uint8_t*)&sensor_data, sizeof(SensorData));
		update_sensor_counter = 0;
	}
}

void bmo_write_register(const uint8_t reg, uint8_t const value) {
	mutex_take(mutex_twi_bricklet, MUTEX_BLOCKING);
    TWID_Write(&twid,
    		   BMO055_ADDRESS_HIGH,
    		   reg,
               1,
               (uint8_t *)&value,
               1,
               NULL);
	mutex_give(mutex_twi_bricklet);
}

void bmo_read_register(const uint8_t reg, uint8_t *data, const uint8_t length) {
	mutex_take(mutex_twi_bricklet, MUTEX_BLOCKING);
    TWID_Read(&twid,
    		   BMO055_ADDRESS_HIGH,
    		   reg,
               1,
               data,
               length,
               NULL);
	mutex_give(mutex_twi_bricklet);
}

void imu_init(void) {
	logimui("IMU init start\n\r");
	Pin pins_bno[] = {PINS_BNO};
	PIO_Configure(pins_bno, PIO_LISTSIZE(pins_bno));

	SLEEP_MS(IMU_STARTUP_TIME);

	bmo_write_register(REG_OPR_MODE, 0b00001100); // Enable NDOF, see Table 3-5

	// TODO: Init other stuff

#ifndef PROFILING
	imu_leds_on(true);
#endif

	logimui("IMU init done\n\r");
}
