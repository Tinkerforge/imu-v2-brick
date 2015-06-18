#include <stdio.h>

#include "ip_connection.h"
#include "brick_imu_v2.h"

#define HOST "localhost"
#define PORT 4223
#define UID "6ww9bv" // Change to your UID

// Quaternion callback
void cb_quaternion(int16_t w, int16_t x, int16_t y, int16_t z, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	float qdiv = (1 << 14) - 1;

	printf("w: %.02f, x: %.02f, y: %.02f, z: %.02f\n", w/qdiv, x/qdiv, y/qdiv, z/qdiv);
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

	// Set period for quaternion callback to 100ms
	imu_v2_set_quaternion_period(&imu, 100);

	// Register "quaternion callback" to cb_quaternion
	imu_v2_register_callback(&imu,
	                         IMU_V2_CALLBACK_QUATERNION,
	                         (void *)cb_quaternion,
	                         NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
