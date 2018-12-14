package main

import (
	"fmt"
	"tinkerforge/imu_v2_brick"
	"tinkerforge/ipconnection"
)

const ADDR string = "localhost:4223"
const UID string = "XXYYZZ" // Change XXYYZZ to the UID of your IMU Brick 2.0.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	imu, _ := imu_v2_brick.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Get current quaternion.
	w, x, y, z, _ := imu.GetQuaternion()

	fmt.Printf("Quaternion [W]: %f\n", float64(w)/16383.0)
	fmt.Printf("Quaternion [X]: %f\n", float64(x)/16383.0)
	fmt.Printf("Quaternion [Y]: %f\n", float64(y)/16383.0)
	fmt.Printf("Quaternion [Z]: %f\n", float64(z)/16383.0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}