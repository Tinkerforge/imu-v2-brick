/* imu-v2-brick
 * Copyright (C) 2015 Olaf Lüke <olaf@tinkerforge.com>
 *
 * communication.c: Implementation of IMU 2.0 Brick specific messages
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

#include "communication.h"

#include "imu.h"

#include "bricklib/logging/logging.h"
#include "bricklib/com/com_common.h"
#include "bricklib/drivers/pwmc/pwmc.h"
#include "bricklib/drivers/adc/adc.h"

#include "bricklib/utility/util_definitions.h"

#include <stdint.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

extern uint32_t imu_period[IMU_PERIOD_NUM];
extern uint32_t imu_period_counter[IMU_PERIOD_NUM];

extern SensorData sensor_data;
extern uint8_t accelerometer_range;
extern uint8_t gyroscope_range;
extern bool imu_use_leds;

void get_acceleration(const ComType com, const GetAcceleration *data) {
	GetAccelerationReturn gar;

	gar.header        = data->header;
	gar.header.length = sizeof(GetAccelerationReturn);
	gar.x             = sensor_data.acc_x;
	gar.y             = sensor_data.acc_y;
	gar.z             = sensor_data.acc_z;

	send_blocking_with_timeout(&gar, sizeof(GetAccelerationReturn), com);
}

void get_magnetic_field(const ComType com, const GetMagneticField *data) {
	GetMagneticFieldReturn gmfr;

	gmfr.header        = data->header;
	gmfr.header.length = sizeof(GetMagneticFieldReturn);
	gmfr.x             = sensor_data.mag_x;
	gmfr.y             = sensor_data.mag_y;
	gmfr.z             = sensor_data.mag_z;

	send_blocking_with_timeout(&gmfr, sizeof(GetMagneticFieldReturn), com);
}

void get_angular_velocity(const ComType com, const GetAngularVelocity *data) {
	GetAngularVelocityReturn gavr;

	gavr.header        = data->header;
	gavr.header.length = sizeof(GetAngularVelocityReturn);
	gavr.x             = sensor_data.gyr_x;
	gavr.y             = sensor_data.gyr_y;
	gavr.z             = sensor_data.gyr_z;

	send_blocking_with_timeout(&gavr, sizeof(GetAngularVelocityReturn), com);
}

void get_temperature(const ComType com, const GetTemperature *data) {
	GetTemperatureReturn gtr;

	gtr.header        = data->header;
	gtr.header.length = sizeof(GetTemperatureReturn);
	gtr.temperature   = sensor_data.temperature;

	send_blocking_with_timeout(&gtr, sizeof(GetTemperatureReturn), com);
}

void get_orientation(const ComType com, const GetOrientation *data) {
	GetOrientationReturn gor;

	gor.header        = data->header;
	gor.header.length = sizeof(GetOrientationReturn);
	gor.roll          = sensor_data.eul_roll;
	gor.pitch         = sensor_data.eul_pitch;
	gor.heading       = sensor_data.eul_heading;

	send_blocking_with_timeout(&gor, sizeof(GetOrientationReturn), com);
}

void get_linear_acceleration(const ComType com, const GetLinearAcceleration *data) {
	GetLinearAccelerationReturn glar;

	glar.header        = data->header;
	glar.header.length = sizeof(GetLinearAccelerationReturn);
	glar.x             = sensor_data.lia_x;
	glar.y             = sensor_data.lia_y;
	glar.z             = sensor_data.lia_z;

	send_blocking_with_timeout(&glar, sizeof(GetLinearAccelerationReturn), com);
}

void get_gravity_vector(const ComType com, const GetGravityVector *data) {
	GetGravityVectorReturn ggvr;

	ggvr.header        = data->header;
	ggvr.header.length = sizeof(GetGravityVectorReturn);
	ggvr.x             = sensor_data.grv_x;
	ggvr.y             = sensor_data.grv_y;
	ggvr.z             = sensor_data.grv_z;

	send_blocking_with_timeout(&ggvr, sizeof(GetGravityVectorReturn), com);
}

void get_quaternion(const ComType com, const GetQuaternion *data) {
	GetQuaternionReturn gqr;

	gqr.header        = data->header;
	gqr.header.length = sizeof(GetQuaternionReturn);
	gqr.x             = sensor_data.qua_x;
	gqr.y             = sensor_data.qua_y;
	gqr.z             = sensor_data.qua_z;
	gqr.w             = sensor_data.qua_w;

	send_blocking_with_timeout(&gqr, sizeof(GetQuaternionReturn), com);
}

void get_all_data(const ComType com, const GetAllData *data) {
	sensor_data.acc_x++;
	if(sensor_data.acc_x > 100) {
		sensor_data.acc_x = 0;
	}

	sensor_data.acc_y = rand();
	sensor_data.acc_z = rand();
	sensor_data.mag_x = rand(); // 1µT = 16 LSB
	sensor_data.mag_y = rand();
	sensor_data.mag_z = rand();
	sensor_data.gyr_x = rand(); // 1dps (degree-per-second) = 16 LSB
	sensor_data.gyr_y = rand();
	sensor_data.gyr_z = rand();
	sensor_data.eul_heading = rand(); // 1° = 16 LSB
	sensor_data.eul_roll = rand();
	sensor_data.eul_pitch = rand();
	sensor_data.qua_w = rand(); // 1 Quaternion = 2^14 LSB
	sensor_data.qua_x = rand();
	sensor_data.qua_y = rand();
	sensor_data.qua_z = rand();
	sensor_data.lia_x = rand(); // 1m/s^2 = 100 LSB
	sensor_data.lia_y = rand();
	sensor_data.lia_z = rand();
	sensor_data.grv_x = rand(); // 1m/s^2 = 100 LSB
	sensor_data.grv_y = rand();
	sensor_data.grv_z = rand();
	sensor_data.temperature = rand(); // 1°C = 1 LSB

	GetAllDataReturn gadr;

	gadr.header        = data->header;
	gadr.header.length = sizeof(GetAllDataReturn);
	memcpy(&gadr.acceleration, &sensor_data, sizeof(SensorData));

	send_blocking_with_timeout(&gadr, sizeof(GetAllDataReturn), com);
}



void leds_on(const ComType com, const LedsOn *data) {
	imu_leds_on(true);

	com_return_setter(com, data);
}

void leds_off(const ComType com, const LedsOff *data) {
	imu_leds_on(false);

	com_return_setter(com, data);
}

void are_leds_on(const ComType com, const AreLedsOn *data) {
	AreLedsOnReturn alor;

	alor.header        = data->header;
	alor.header.length = sizeof(AreLedsOnReturn);
	alor.leds          = imu_use_leds;

	send_blocking_with_timeout(&alor, sizeof(AreLedsOnReturn), com);
}

void set_configuration(const ComType com, const SetConfiguration *data) {
	if(data->accelerometer_range > RANGE_ACCELEROMETER_16G || data->gyroscope_range > RANGE_GYROSCOPE_125DPS) {
		com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_INVALID_PARAMETER, com);
		return;
	}

	accelerometer_range = data->accelerometer_range;
	gyroscope_range     = data->gyroscope_range;

	update_configuration();

	com_return_setter(com, data);
}

void get_configuration(const ComType com, const GetConfiguration *data) {
	GetConfigurationReturn gcr;

	gcr.header              = data->header;
	gcr.header.length       = sizeof(GetConfigurationReturn);
	gcr.gyroscope_range     = gyroscope_range;
	gcr.accelerometer_range = accelerometer_range;

	send_blocking_with_timeout(&gcr, sizeof(GetConfigurationReturn), com);
}

void set_acceleration_period(const ComType com, const SetAccelerationPeriod *data) {
	imu_period[IMU_PERIOD_TYPE_ACC] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_ACC] = 0;
	logimui("set_acceleration_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ACC]);

	com_return_setter(com, data);
}

void get_acceleration_period(const ComType com, const GetAccelerationPeriod *data) {
	GetAccelerationPeriodReturn gapr;

	gapr.header        = data->header;
	gapr.header.length = sizeof(GetAccelerationPeriodReturn);
	gapr.period        = imu_period[IMU_PERIOD_TYPE_ACC];

	send_blocking_with_timeout(&gapr, sizeof(GetAccelerationPeriodReturn), com);
	logimui("get_acceleration_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ACC]);
}

void set_magnetic_field_period(const ComType com, const SetMagneticFieldPeriod *data) {
	imu_period[IMU_PERIOD_TYPE_MAG] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_MAG] = 0;
	logimui("set_magnetic_field_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_MAG]);

	com_return_setter(com, data);
}

void get_magnetic_field_period(const ComType com, const GetMagneticFieldPeriod *data) {
	GetMagneticFieldPeriodReturn gmfpr;

	gmfpr.header        = data->header;
	gmfpr.header.length = sizeof(GetMagneticFieldPeriodReturn);
	gmfpr.period        = imu_period[IMU_PERIOD_TYPE_MAG];

	send_blocking_with_timeout(&gmfpr, sizeof(GetMagneticFieldPeriodReturn), com);
	logimui("get_magnetic_field_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_MAG]);
}

void set_angular_velocity_period(const ComType com, const SetAngularVelocityPeriod *data) {
	imu_period[IMU_PERIOD_TYPE_ANG] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_ANG] = 0;
	logimui("set_angular_velocity_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ANG]);

	com_return_setter(com, data);
}

void get_angular_velocity_period(const ComType com, const GetAngularVelocityPeriod *data) {
	GetAngularVelocityPeriodReturn gavpr;

	gavpr.header        = data->header;
	gavpr.header.length = sizeof(GetAngularVelocityPeriodReturn);
	gavpr.period        = imu_period[IMU_PERIOD_TYPE_ANG];

	send_blocking_with_timeout(&gavpr, sizeof(GetAngularVelocityPeriodReturn), com);
	logimui("get_angular_velocity_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ANG]);
}

void set_temperature_period(const ComType com, const SetTemperaturePeriod *data) {
	imu_period[IMU_PERIOD_TYPE_TMP] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_TMP] = 0;
	logimui("set_temperature_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_TMP]);

	com_return_setter(com, data);
}

void get_temperature_period(const ComType com, const GetTemperaturePeriod *data) {
	GetTemperaturePeriodReturn gtpr;

	gtpr.header        = data->header;
	gtpr.header.length = sizeof(GetTemperaturePeriodReturn);
	gtpr.period        = imu_period[IMU_PERIOD_TYPE_TMP];

	send_blocking_with_timeout(&gtpr, sizeof(GetTemperaturePeriodReturn), com);
	logimui("get_temperature_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ANG]);
}

void set_orientation_period(const ComType com, const SetOrientationPeriod *data) {
	imu_period[IMU_PERIOD_TYPE_ORI] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_ORI] = 0;
	logimui("set_orientation_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ORI]);

	com_return_setter(com, data);
}

void get_orientation_period(const ComType com, const GetOrientationPeriod *data) {
	GetOrientationPeriodReturn gopr;

	gopr.header        = data->header;
	gopr.header.length = sizeof(GetAllDataPeriodReturn);
	gopr.period        = imu_period[IMU_PERIOD_TYPE_ORI];

	send_blocking_with_timeout(&gopr, sizeof(GetOrientationPeriodReturn), com);
	logimui("get_orientation_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ORI]);
}

void set_linear_acceleration_period(const ComType com, const SetLinearAccelerationPeriod *data) {
	imu_period[IMU_PERIOD_TYPE_LIA] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_LIA] = 0;
	logimui("set_linear_acceleration_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_LIA]);

	com_return_setter(com, data);
}

void get_linear_acceleration_period(const ComType com, const GetLinearAccelerationPeriod *data) {
	GetLinearAccelerationPeriodReturn glapr;

	glapr.header        = data->header;
	glapr.header.length = sizeof(GetLinearAccelerationPeriodReturn);
	glapr.period        = imu_period[IMU_PERIOD_TYPE_LIA];

	send_blocking_with_timeout(&glapr, sizeof(GetLinearAccelerationPeriodReturn), com);
	logimui("get_linear_acceleration_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_LIA]);
}

void set_gravity_vector_period(const ComType com, const SetGravityVectorPeriod *data) {
	imu_period[IMU_PERIOD_TYPE_GRV] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_GRV] = 0;
	logimui("set_gravity_vector_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_GRV]);

	com_return_setter(com, data);
}

void get_gravity_vector_period(const ComType com, const GetGravityVectorPeriod *data) {
	GetGravityVectorPeriodReturn ggvpr;

	ggvpr.header        = data->header;
	ggvpr.header.length = sizeof(GetGravityVectorPeriodReturn);
	ggvpr.period        = imu_period[IMU_PERIOD_TYPE_GRV];

	send_blocking_with_timeout(&ggvpr, sizeof(GetGravityVectorPeriodReturn), com);
	logimui("get_gravity_vector_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_GRV]);
}

void set_quaternion_period(const ComType com, const SetQuaternionPeriod *data) {
	imu_period[IMU_PERIOD_TYPE_QUA] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_QUA] = 0;
	logimui("set_quaternion_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_QUA]);

	com_return_setter(com, data);
}

void get_quaternion_period(const ComType com, const GetQuaternionPeriod *data) {
	GetQuaternionPeriodReturn gqpr;

	gqpr.header        = data->header;
	gqpr.header.length = sizeof(GetQuaternionPeriodReturn);
	gqpr.period        = imu_period[IMU_PERIOD_TYPE_QUA];

	send_blocking_with_timeout(&gqpr, sizeof(GetQuaternionPeriodReturn), com);
	logimui("get_quaternion_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_QUA]);
}

void set_all_data_period(const ComType com, const SetAllDataPeriod *data) {
	imu_period[IMU_PERIOD_TYPE_ALL] = data->period;
	imu_period_counter[IMU_PERIOD_TYPE_ALL] = 0;
	logimui("set_all_data_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ALL]);

	com_return_setter(com, data);
}

void get_all_data_period(const ComType com, const GetAllDataPeriod *data) {
	GetAllDataPeriodReturn gadpr;

	gadpr.header        = data->header;
	gadpr.header.length = sizeof(GetAllDataPeriodReturn);
	gadpr.period        = imu_period[IMU_PERIOD_TYPE_ALL];

	send_blocking_with_timeout(&gadpr, sizeof(GetAllDataPeriodReturn), com);
	logimui("get_all_data_period: %d\n\r", imu_period[IMU_PERIOD_TYPE_ALL]);
}

