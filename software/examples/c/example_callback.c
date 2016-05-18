#include <stdio.h>

#include "ip_connection.h"
#include "brick_imu_v2.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XXYYZZ" // Change to your UID

// Callback function for quaternion callback
void cb_quaternion(int16_t w, int16_t x, int16_t y, int16_t z, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("w: %.02f, x: %.02f, y: %.02f, z: %.02f\n",
	       w/16383.0, x/16383.0, y/16383.0, z/16383.0);
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
	// Note: The quaternion callback is only called every 0.1 seconds
	//       if the quaternion has changed since the last call!
	imu_v2_set_quaternion_period(&imu, 100);

	printf("Press key to exit\n");
	getchar();
	imu_v2_destroy(&imu);
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
