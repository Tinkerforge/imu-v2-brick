#include <stdio.h>

#include "ip_connection.h"
#include "brick_imu_v2.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XXYYZZ" // Change to your UID

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

	// Get current quaternion
	int16_t w, x, y, z;
	if(imu_v2_get_quaternion(&imu, &w, &x, &y, &z) < 0) {
		fprintf(stderr, "Could not get quaternion, probably timeout\n");
		return 1;
	}

	printf("w: %.2f, x: %.2f, y: %.2f, z: %.2f\n",
	       w/16383.0, x/16383.0, y/16383.0, z/16383.0);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
