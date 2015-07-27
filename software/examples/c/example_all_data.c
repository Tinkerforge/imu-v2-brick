#include <stdio.h>

#include "ip_connection.h"
#include "brick_imu_v2.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// All data callback
void cb_all_data(int16_t acceleration[3], int16_t magnetic_field[3],
                 int16_t angular_velocity[3], int16_t euler_angle[3],
                 int16_t quaternion[4], int16_t linear_acceleration[3],
                 int16_t gravity_vector[3], int8_t temperature,
                 uint8_t calibration_status, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Acceleration        x: %.02f y: %.02f z: %.02f m/s²\n"
	       "Magnetic Field      x: %.02f y: %.02f z: %.02f µT\n"
	       "Angular Velocity    x: %.02f y: %.02f z: %.02f °/s\n"
	       "Euler Angle         x: %.02f y: %.02f z: %.02f °\n"
	       "Quaternion          x: %.02f y: %.02f z: %.02f w: %.02f\n"
	       "Linear Acceleration x: %.02f y: %.02f z: %.02f m/s²\n"
	       "Gravity Vector      x: %.02f y: %.02f z: %.02f m/s²\n"
	       "Temperature         %d °C\n"
	       "Calibration Status  %u\n\n",
	       acceleration[0]/100.0,        acceleration[1]/100.0,        acceleration[2]/100.0,
	       magnetic_field[0]/16.0,       magnetic_field[1]/16.0,       magnetic_field[2]/16.0,
	       angular_velocity[0]/16.0,     angular_velocity[1]/16.0,     angular_velocity[2]/16.0,
	       euler_angle[0]/16.0,          euler_angle[1]/16.0,          euler_angle[2]/16.0,
	       quaternion[1]/16383.0,        quaternion[2]/16383.0,        quaternion[3]/16383.0,        quaternion[0]/16383.0,
	       linear_acceleration[0]/100.0, linear_acceleration[1]/100.0, linear_acceleration[2]/100.0,
	       gravity_vector[0]/100.0,      gravity_vector[1]/100.0,      gravity_vector[2]/100.0,
	       temperature, calibration_status);
}

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	IMUV2 imu;
	imu_v2_create(&imu, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Set period for all data callback to 100ms
	imu_v2_set_all_data_period(&imu, 100);

	// Register "all callback" to cb_all_data
	imu_v2_register_callback(&imu,
	                         IMU_V2_CALLBACK_ALL_DATA,
	                         (void *)cb_all_data,
	                         NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
