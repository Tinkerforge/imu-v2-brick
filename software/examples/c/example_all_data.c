#include <stdio.h>

#include "ip_connection.h"
#include "brick_imu_v2.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XXYYZZ" // Change XXYYZZ to the UID of your IMU Brick 2.0

// Callback function for all data callback
void cb_all_data(int16_t acceleration[3], int16_t magnetic_field[3],
                 int16_t angular_velocity[3], int16_t euler_angle[3],
                 int16_t quaternion[4], int16_t linear_acceleration[3],
                 int16_t gravity_vector[3], int8_t temperature,
                 uint8_t calibration_status, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Acceleration [X]: %f m/s²\n", acceleration[0]/100.0);
	printf("Acceleration [Y]: %f m/s²\n", acceleration[1]/100.0);
	printf("Acceleration [Z]: %f m/s²\n", acceleration[2]/100.0);
	printf("Magnetic Field [X]: %f µT\n", magnetic_field[0]/16.0);
	printf("Magnetic Field [Y]: %f µT\n", magnetic_field[1]/16.0);
	printf("Magnetic Field [Z]: %f µT\n", magnetic_field[2]/16.0);
	printf("Angular Velocity [X]: %f °/s\n", angular_velocity[0]/16.0);
	printf("Angular Velocity [Y]: %f °/s\n", angular_velocity[1]/16.0);
	printf("Angular Velocity [Z]: %f °/s\n", angular_velocity[2]/16.0);
	printf("Euler Angle [Heading]: %f °\n", euler_angle[0]/16.0);
	printf("Euler Angle [Roll]: %f °\n", euler_angle[1]/16.0);
	printf("Euler Angle [Pitch]: %f °\n", euler_angle[2]/16.0);
	printf("Quaternion [W]: %f\n", quaternion[0]/16383.0);
	printf("Quaternion [X]: %f\n", quaternion[1]/16383.0);
	printf("Quaternion [Y]: %f\n", quaternion[2]/16383.0);
	printf("Quaternion [Z]: %f\n", quaternion[3]/16383.0);
	printf("Linear Acceleration [X]: %f m/s²\n", linear_acceleration[0]/100.0);
	printf("Linear Acceleration [Y]: %f m/s²\n", linear_acceleration[1]/100.0);
	printf("Linear Acceleration [Z]: %f m/s²\n", linear_acceleration[2]/100.0);
	printf("Gravity Vector [X]: %f m/s²\n", gravity_vector[0]/100.0);
	printf("Gravity Vector [Y]: %f m/s²\n", gravity_vector[1]/100.0);
	printf("Gravity Vector [Z]: %f m/s²\n", gravity_vector[2]/100.0);
	printf("Temperature: %d °C\n", temperature);
	printf("Calibration Status: %u\n", calibration_status);
	printf("\n");
}

int main(void) {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	IMUV2 imu;
	imu_v2_create(&imu, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		return 1;
	}
	// Don't use device before ipcon is connected

	// Register all data callback to function cb_all_data
	imu_v2_register_callback(&imu,
	                         IMU_V2_CALLBACK_ALL_DATA,
	                         (void (*)(void))cb_all_data,
	                         NULL);

	// Set period for all data callback to 0.1s (100ms)
	imu_v2_set_all_data_period(&imu, 100);

	printf("Press key to exit\n");
	getchar();
	imu_v2_destroy(&imu);
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
