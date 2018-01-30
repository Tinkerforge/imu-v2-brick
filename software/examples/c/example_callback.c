#include <stdio.h>

#include "ip_connection.h"
#include "brick_imu_v2.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XXYYZZ" // Change XXYYZZ to the UID of your IMU Brick 2.0

// Callback function for quaternion callback
void cb_quaternion(int16_t w, int16_t x, int16_t y, int16_t z, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Quaternion [W]: %f\n", w/16383.0);
	printf("Quaternion [X]: %f\n", x/16383.0);
	printf("Quaternion [Y]: %f\n", y/16383.0);
	printf("Quaternion [Z]: %f\n", z/16383.0);
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

	// Register quaternion callback to function cb_quaternion
	imu_v2_register_callback(&imu,
	                         IMU_V2_CALLBACK_QUATERNION,
	                         (void *)cb_quaternion,
	                         NULL);

	// Set period for quaternion callback to 0.1s (100ms)
	imu_v2_set_quaternion_period(&imu, 100);

	printf("Press key to exit\n");
	getchar();
	imu_v2_destroy(&imu);
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
