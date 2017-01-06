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
#define FID_GET_TEMPERATURE 4
#define FID_GET_ORIENTATION 5
#define FID_GET_LINEAR_ACCELERATION 6
#define FID_GET_GRAVITY_VECTOR 7
#define FID_GET_QUATERNION 8
#define FID_GET_ALL_DATA 9
#define FID_LEDS_ON 10
#define FID_LEDS_OFF 11
#define FID_ARE_LEDS_ON 12
#define FID_SAVE_CALIBRATION 13
#define FID_SET_ACCELERATION_PERIOD 14
#define FID_GET_ACCELERATION_PERIOD 15
#define FID_SET_MAGNETIC_FIELD_PERIOD 16
#define FID_GET_MAGNETIC_FIELD_PERIOD 17
#define FID_SET_ANGULAR_VELOCITY_PERIOD 18
#define FID_GET_ANGULAR_VELOCITY_PERIOD 19
#define FID_SET_TEMPERATURE_PERIOD 20
#define FID_GET_TEMPERATURE_PERIOD 21
#define FID_SET_ORIENTATION_PERIOD 22
#define FID_GET_ORIENTATION_PERIOD 23
#define FID_SET_LINEAR_ACCELERATION_PERIOD 24
#define FID_GET_LINEAR_ACCELERATION_PERIOD 25
#define FID_SET_GRAVITY_VECTOR_PERIOD 26
#define FID_GET_GRAVITY_VECTOR_PERIOD 27
#define FID_SET_QUATERNION_PERIOD 28
#define FID_GET_QUATERNION_PERIOD 29
#define FID_SET_ALL_DATA_PERIOD 30
#define FID_GET_ALL_DATA_PERIOD 31
#define FID_ACCELERATION 32
#define FID_MAGNETIC_FIELD 33
#define FID_ANGULAR_VELOCITY 34
#define FID_TEMPERATURE 35
#define FID_LINEAR_ACCELERATION 36
#define FID_GRAVITY_VECTOR 37
#define FID_ORIENTATION 38
#define FID_QUATERNION 39
#define FID_ALL_DATA 40

#define COM_MESSAGE_USER_LAST_FID 40

#define COM_MESSAGES_USER \
	{FID_GET_ACCELERATION, (message_handler_func_t)get_acceleration}, \
	{FID_GET_MAGNETIC_FIELD, (message_handler_func_t)get_magnetic_field}, \
	{FID_GET_ANGULAR_VELOCITY, (message_handler_func_t)get_angular_velocity}, \
	{FID_GET_TEMPERATURE, (message_handler_func_t)get_temperature}, \
	{FID_GET_ORIENTATION, (message_handler_func_t)get_orientation}, \
	{FID_GET_LINEAR_ACCELERATION, (message_handler_func_t)get_linear_acceleration}, \
	{FID_GET_GRAVITY_VECTOR, (message_handler_func_t)get_gravity_vector}, \
	{FID_GET_QUATERNION, (message_handler_func_t)get_quaternion}, \
	{FID_GET_ALL_DATA, (message_handler_func_t)get_all_data}, \
	{FID_LEDS_ON, (message_handler_func_t)leds_on}, \
	{FID_LEDS_OFF, (message_handler_func_t)leds_off}, \
	{FID_ARE_LEDS_ON, (message_handler_func_t)are_leds_on}, \
	{FID_SAVE_CALIBRATION, (message_handler_func_t)save_calibration}, \
	{FID_SET_ACCELERATION_PERIOD, (message_handler_func_t)set_acceleration_period}, \
	{FID_GET_ACCELERATION_PERIOD, (message_handler_func_t)get_acceleration_period}, \
	{FID_SET_MAGNETIC_FIELD_PERIOD, (message_handler_func_t)set_magnetic_field_period}, \
	{FID_GET_MAGNETIC_FIELD_PERIOD, (message_handler_func_t)get_magnetic_field_period}, \
	{FID_SET_ANGULAR_VELOCITY_PERIOD, (message_handler_func_t)set_angular_velocity_period}, \
	{FID_GET_ANGULAR_VELOCITY_PERIOD, (message_handler_func_t)get_angular_velocity_period}, \
	{FID_SET_TEMPERATURE_PERIOD, (message_handler_func_t)set_temperature_period}, \
	{FID_GET_TEMPERATURE_PERIOD, (message_handler_func_t)get_temperature_period}, \
	{FID_SET_ORIENTATION_PERIOD, (message_handler_func_t)set_orientation_period}, \
	{FID_GET_ORIENTATION_PERIOD, (message_handler_func_t)get_orientation_period}, \
	{FID_SET_LINEAR_ACCELERATION_PERIOD, (message_handler_func_t)set_linear_acceleration_period}, \
	{FID_GET_LINEAR_ACCELERATION_PERIOD, (message_handler_func_t)get_linear_acceleration_period}, \
	{FID_SET_GRAVITY_VECTOR_PERIOD, (message_handler_func_t)set_gravity_vector_period}, \
	{FID_GET_GRAVITY_VECTOR_PERIOD, (message_handler_func_t)get_gravity_vector_period}, \
	{FID_SET_QUATERNION_PERIOD, (message_handler_func_t)set_quaternion_period}, \
	{FID_GET_QUATERNION_PERIOD, (message_handler_func_t)get_quaternion_period}, \
	{FID_SET_ALL_DATA_PERIOD, (message_handler_func_t)set_all_data_period}, \
	{FID_GET_ALL_DATA_PERIOD, (message_handler_func_t)get_all_data_period}, \
	{FID_ACCELERATION, (message_handler_func_t)NULL}, \
	{FID_MAGNETIC_FIELD, (message_handler_func_t)NULL}, \
	{FID_ANGULAR_VELOCITY, (message_handler_func_t)NULL}, \
	{FID_TEMPERATURE, (message_handler_func_t)NULL}, \
	{FID_LINEAR_ACCELERATION, (message_handler_func_t)NULL}, \
	{FID_GRAVITY_VECTOR, (message_handler_func_t)NULL}, \
	{FID_ORIENTATION, (message_handler_func_t)NULL}, \
	{FID_QUATERNION, (message_handler_func_t)NULL}, \
	{FID_ALL_DATA, (message_handler_func_t)NULL},

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
} __attribute__((__packed__)) GetTemperature;

typedef struct {
	MessageHeader header;
	int8_t temperature;
} __attribute__((__packed__)) GetTemperatureReturn;


typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetOrientation;

typedef struct {
	MessageHeader header;
	int16_t heading;
	int16_t roll;
	int16_t pitch;
} __attribute__((__packed__)) GetOrientationReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetLinearAcceleration;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) GetLinearAccelerationReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetGravityVector;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) GetGravityVectorReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetQuaternion;

typedef struct {
	MessageHeader header;
	int16_t w;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) GetQuaternionReturn;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetAllData;

typedef struct {
	MessageHeader header;
	int16_t acceleration[3];        // 1m/s^2 = 100 LSB
	int16_t magnetic_field[3];      // 1µT = 16 LSB
	int16_t angular_velocity[3];    // 1dps (degree-per-second) = 16 LSB
	int16_t euler_angle[3];         // 1° = 16 LSB
	int16_t quaternion[4];         // 1 Quaternion = 2^14 LSB
	int16_t linear_acceleration[3]; // 1m/s^2 = 100 LSB
	int16_t gravity_vector[3];      // 1m/s^2 = 100 LSB
	int8_t temperature;             // 1°C = 1 LSB
	uint8_t calibration_status;
} __attribute__((__packed__)) GetAllDataReturn;

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
} __attribute__((__packed__)) SaveCalibration;

typedef struct {
	MessageHeader header;
	bool calibration_done;
} __attribute__((__packed__)) SaveCalibrationReturn;

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
} __attribute__((__packed__)) SetTemperaturePeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetTemperaturePeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetTemperaturePeriodReturn;

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
} __attribute__((__packed__)) SetLinearAccelerationPeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetLinearAccelerationPeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetLinearAccelerationPeriodReturn;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) SetGravityVectorPeriod;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) GetGravityVectorPeriod;

typedef struct {
	MessageHeader header;
	uint32_t period;
} __attribute__((__packed__)) GetGravityVectorPeriodReturn;

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
	int8_t temperature;
} __attribute__((__packed__)) TemperatureCallback;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) LinearAccelerationCallback;

typedef struct {
	MessageHeader header;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) GravityVectorCallback;

typedef struct {
	MessageHeader header;
	int16_t heading;
	int16_t roll;
	int16_t pitch;
} __attribute__((__packed__)) OrientationCallback;

typedef struct {
	MessageHeader header;
	int16_t w;
	int16_t x;
	int16_t y;
	int16_t z;
} __attribute__((__packed__)) QuaternionCallback;

typedef struct {
	MessageHeader header;
	int16_t acceleration[3];        // 1m/s^2 = 100 LSB
	int16_t magnetic_field[3];      // 1µT = 16 LSB
	int16_t angular_velocity[3];    // 1dps (degree-per-second) = 16 LSB
	int16_t euler_angle[3];         // 1° = 16 LSB
	int16_t quaternion[4];         // 1 Quaternion = 2^14 LSB
	int16_t linear_acceleration[3]; // 1m/s^2 = 100 LSB
	int16_t gravity_vector[3];      // 1m/s^2 = 100 LSB
	int8_t temperature;             // 1°C = 1 LSB
	uint8_t calibration_status;
} __attribute__((__packed__)) AllDataCallback;

void get_acceleration(const ComType com, const GetAcceleration *data);
void get_magnetic_field(const ComType com, const GetMagneticField *data);
void get_angular_velocity(const ComType com, const GetAngularVelocity *data);
void get_temperature(const ComType com, const GetTemperature *data);
void get_orientation(const ComType com, const GetOrientation *data);
void get_linear_acceleration(const ComType com, const GetLinearAcceleration *data);
void get_gravity_vector(const ComType com, const GetGravityVector *data);
void get_quaternion(const ComType com, const GetQuaternion *data);
void get_all_data(const ComType com, const GetAllData *data);
void leds_on(const ComType com, const LedsOn *data);
void leds_off(const ComType com, const LedsOff *data);
void are_leds_on(const ComType com, const AreLedsOn *data);
void save_calibration(const ComType com, const SaveCalibration *data);
void set_acceleration_period(const ComType com, const SetAccelerationPeriod *data);
void get_acceleration_period(const ComType com, const GetAccelerationPeriod *data);
void set_magnetic_field_period(const ComType com, const SetMagneticFieldPeriod *data);
void get_magnetic_field_period(const ComType com, const GetMagneticFieldPeriod *data);
void set_angular_velocity_period(const ComType com, const SetAngularVelocityPeriod *data);
void get_angular_velocity_period(const ComType com, const GetAngularVelocityPeriod *data);
void set_temperature_period(const ComType com, const SetTemperaturePeriod *data);
void get_temperature_period(const ComType com, const GetTemperaturePeriod *data);
void set_orientation_period(const ComType com, const SetOrientationPeriod *data);
void get_orientation_period(const ComType com, const GetOrientationPeriod *data);
void set_linear_acceleration_period(const ComType com, const SetLinearAccelerationPeriod *data);
void get_linear_acceleration_period(const ComType com, const GetLinearAccelerationPeriod *data);
void set_gravity_vector_period(const ComType com, const SetGravityVectorPeriod *data);
void get_gravity_vector_period(const ComType com, const GetGravityVectorPeriod *data);
void set_quaternion_period(const ComType com, const SetQuaternionPeriod *data);
void get_quaternion_period(const ComType com, const GetQuaternionPeriod *data);
void set_all_data_period(const ComType com, const SetAllDataPeriod *data);
void get_all_data_period(const ComType com, const GetAllDataPeriod *data);

#endif
