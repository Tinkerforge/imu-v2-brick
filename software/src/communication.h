/* imu-v2-brick
 * Copyright (C) 2015 Olaf Lüke <olaf@tinkerforge.com>
 *
 * communication.h: Implementation of IMU 2.0 Brick specific messages
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


#ifndef COMMUNICATION_H
#define COMMUNICATION_H

#include <stdint.h>
#include <stdbool.h>

#include "bricklib/com/com_common.h"

#define FID_GET_ACCELERATION 1
#define FID_GET_MAGNETIC_FIELD 2
#define FID_GET_ANGULAR_VELOCITY 3
#define FID_GET_ALL_DATA 4
#define FID_GET_ORIENTATION 5
#define FID_GET_QUATERNION 6
#define FID_GET_IMU_TEMPERATURE 7
#define FID_LEDS_ON 8
#define FID_LEDS_OFF 9
#define FID_ARE_LEDS_ON 10
#define FID_SET_CONFIGURATION 11
#define FID_GET_CONFIGURATION 12
#define FID_SET_ACCELERATION_PERIOD 13
#define FID_GET_ACCELERATION_PERIOD 14
#define FID_SET_MAGNETIC_FIELD_PERIOD 15
#define FID_GET_MAGNETIC_FIELD_PERIOD 16
#define FID_SET_ANGULAR_VELOCITY_PERIOD 17
#define FID_GET_ANGULAR_VELOCITY_PERIOD 18
#define FID_SET_ALL_DATA_PERIOD 19
#define FID_GET_ALL_DATA_PERIOD 20
#define FID_SET_ORIENTATION_PERIOD 21
#define FID_GET_ORIENTATION_PERIOD 22
#define FID_SET_QUATERNION_PERIOD 23
#define FID_GET_QUATERNION_PERIOD 24
#define FID_ACCELERATION 25
#define FID_MAGNETIC_FIELD 26
#define FID_ANGULAR_VELOCITY 27
#define FID_ALL_DATA 28
#define FID_ORIENTATION 29
#define FID_QUATERNION 30

#define COM_MESSAGES_USER \
	{FID_GET_ACCELERATION, (message_handler_func_t)get_acceleration}, \
	{FID_GET_MAGNETIC_FIELD, (message_handler_func_t)get_magnetic_field}, \
	{FID_GET_ANGULAR_VELOCITY, (message_handler_func_t)get_angular_velocity}, \
	{FID_GET_ALL_DATA, (message_handler_func_t)get_all_data}, \
	{FID_GET_ORIENTATION, (message_handler_func_t)get_orientation}, \
	{FID_GET_QUATERNION, (message_handler_func_t)get_quaternion}, \
	{FID_GET_IMU_TEMPERATURE, (message_handler_func_t)get_imu_temperature}, \
	{FID_LEDS_ON, (message_handler_func_t)leds_on}, \
	{FID_LEDS_OFF, (message_handler_func_t)leds_off}, \
	{FID_ARE_LEDS_ON, (message_handler_func_t)are_leds_on}, \
	{FID_SET_CONFIGURATION, (message_handler_func_t)set_configuration}, \
	{FID_GET_CONFIGURATION, (message_handler_func_t)get_configuration}, \
	{FID_SET_ACCELERATION_PERIOD, (message_handler_func_t)set_acceleration_period}, \
	{FID_GET_ACCELERATION_PERIOD, (message_handler_func_t)get_acceleration_period}, \
	{FID_SET_MAGNETIC_FIELD_PERIOD, (message_handler_func_t)set_magnetic_field_period}, \
	{FID_GET_MAGNETIC_FIELD_PERIOD, (message_handler_func_t)get_magnetic_field_period}, \
	{FID_SET_ANGULAR_VELOCITY_PERIOD, (message_handler_func_t)set_angular_velocity_period}, \
	{FID_GET_ANGULAR_VELOCITY_PERIOD, (message_handler_func_t)get_angular_velocity_period}, \
	{FID_SET_ALL_DATA_PERIOD, (message_handler_func_t)set_all_data_period}, \
	{FID_GET_ALL_DATA_PERIOD, (message_handler_func_t)get_all_data_period}, \
	{FID_SET_ORIENTATION_PERIOD, (message_handler_func_t)set_orientation_period}, \
	{FID_GET_ORIENTATION_PERIOD, (message_handler_func_t)get_orientation_period}, \
	{FID_SET_QUATERNION_PERIOD, (message_handler_func_t)set_quaternion_period}, \
	{FID_GET_QUATERNION_PERIOD, (message_handler_func_t)get_quaternion_period}, \
	{FID_ACCELERATION, (message_handler_func_t)NULL}, \
	{FID_MAGNETIC_FIELD, (message_handler_func_t)NULL}, \
	{FID_ANGULAR_VELOCITY, (message_handler_func_t)NULL}, \
	{FID_ALL_DATA, (message_handler_func_t)NULL}, \
	{FID_ORIENTATION, (message_handler_func_t)NULL},

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetAcceleration;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) GetAccelerationReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetMagneticField;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) GetMagneticFieldReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetAngularVelocity;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) GetAngularVelocityReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetAllData;

typedef struct {
	MessageHeader header;
	int16_t acc_x;
	int16_t acc_y;
	int16_t acc_z;
	int16_t mag_x;
	int16_t mag_y;
	int16_t mag_z;
	int16_t ang_x;
	int16_t ang_y;
	int16_t ang_z;
	int16_t temperature;
} __attribute__((__packed__)) GetAllDataReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetOrientation;

typedef struct {
	MessageHeader header;
	int16_t roll;
	int16_t pitch;
	int16_t yaw;
} __attribute__((__packed__)) GetOrientationReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetQuaternion;

typedef struct {
	MessageHeader header;
	float x;
	float y;
	float z;
	float w;
} __attribute__((__packed__)) GetQuaternionReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetIMUTemperature;

typedef struct {
	MessageHeader header;
	int16_t temperature;
} __attribute__((__packed__)) GetIMUTemperatureReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) LedsOn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) LedsOff;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) AreLedsOn;

typedef struct {
	MessageHeader header;
	bool leds;
} __attribute__((__packed__)) AreLedsOnReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) SetConfiguration;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetConfiguration;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetConfigurationReturn;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) SetAccelerationPeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetAccelerationPeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetAccelerationPeriodReturn;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) SetMagneticFieldPeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetMagneticFieldPeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetMagneticFieldPeriodReturn;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) SetAngularVelocityPeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetAngularVelocityPeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetAngularVelocityPeriodReturn;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) SetAllDataPeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetAllDataPeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetAllDataPeriodReturn;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) SetOrientationPeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetOrientationPeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetOrientationPeriodReturn;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) SetQuaternionPeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetQuaternionPeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetQuaternionPeriodReturn;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) AccelerationCallback;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) MagneticFieldCallback;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) AngularVelocityCallback;

typedef struct {
	MessageHeader header;
	int16_t acc_x;
	int16_t acc_y;
	int16_t acc_z;
	int16_t mag_x;
	int16_t mag_y;
	int16_t mag_z;
	int16_t ang_x;
	int16_t ang_y;
	int16_t ang_z;
	int16_t temperature;
} __attribute__((__packed__)) AllDataCallback;

typedef struct {
	MessageHeader header;
	int16_t roll;
	int16_t pitch;
	int16_t yaw;
} __attribute__((__packed__)) OrientationCallback;

typedef struct {
	MessageHeader header;
	float x;
	float y;
	float z;
	float w;
} __attribute__((__packed__)) QuaternionCallback;

void get_acceleration(const ComType com, const GetAcceleration *data);
void get_magnetic_field(const ComType com, const GetMagneticField *data);
void get_angular_velocity(const ComType com, const GetAngularVelocity *data);
void get_all_data(const ComType com, const GetAllData *data);
void get_orientation(const ComType com, const GetOrientation *data);
void get_quaternion(const ComType com, const GetQuaternion *data);
void get_imu_temperature(const ComType com, const GetIMUTemperature *data);
void leds_on(const ComType com, const LedsOn *data);
void leds_off(const ComType com, const LedsOff *data);
void are_leds_on(const ComType com, const AreLedsOn *data);
void set_configuration(const ComType com, const SetConfiguration *data);
void get_configuration(const ComType com, const GetConfiguration *data);
void set_acceleration_period(const ComType com, const SetAccelerationPeriod *data);
void get_acceleration_period(const ComType com, const GetAccelerationPeriod *data);
void set_magnetic_field_period(const ComType com, const SetMagneticFieldPeriod *data);
void get_magnetic_field_period(const ComType com, const GetMagneticFieldPeriod *data);
void set_angular_velocity_period(const ComType com, const SetAngularVelocityPeriod *data);
void get_angular_velocity_period(const ComType com, const GetAngularVelocityPeriod *data);
void set_all_data_period(const ComType com, const SetAllDataPeriod *data);
void get_all_data_period(const ComType com, const GetAllDataPeriod *data);
void set_orientation_period(const ComType com, const SetOrientationPeriod *data);
void get_orientation_period(const ComType com, const GetOrientationPeriod *data);
void set_quaternion_period(const ComType com, const SetQuaternionPeriod *data);
void get_quaternion_period(const ComType com, const GetQuaternionPeriod *data);

#endif
