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

	imu.RegisterAllDataCallback(func(acceleration [3]int16, magneticField [3]int16, angularVelocity [3]int16, eulerAngle [3]int16, quaternion [4]int16, linearAcceleration [3]int16, gravityVector [3]int16, temperature int8, calibrationStatus uint8) {
		fmt.Printf("Acceleration [X]: %d m/s²\n", float64(acceleration[0])/100.0)
		fmt.Printf("Acceleration [Y]: %d m/s²\n", float64(acceleration[1])/100.0)
		fmt.Printf("Acceleration [Z]: %d m/s²\n", float64(acceleration[2])/100.0)
		fmt.Printf("Magnetic Field [X]: %d µT\n", float64(magneticField[0])/16.0)
		fmt.Printf("Magnetic Field [Y]: %d µT\n", float64(magneticField[1])/16.0)
		fmt.Printf("Magnetic Field [Z]: %d µT\n", float64(magneticField[2])/16.0)
		fmt.Printf("Angular Velocity [X]: %d °/s\n", float64(angularVelocity[0])/16.0)
		fmt.Printf("Angular Velocity [Y]: %d °/s\n", float64(angularVelocity[1])/16.0)
		fmt.Printf("Angular Velocity [Z]: %d °/s\n", float64(angularVelocity[2])/16.0)
		fmt.Printf("Euler Angle [X]: %d °\n", float64(eulerAngle[0])/16.0)
		fmt.Printf("Euler Angle [Y]: %d °\n", float64(eulerAngle[1])/16.0)
		fmt.Printf("Euler Angle [Z]: %d °\n", float64(eulerAngle[2])/16.0)
		fmt.Printf("Quaternion [W]: %d\n", float64(quaternion[0])/16383.0)
		fmt.Printf("Quaternion [X]: %d\n", float64(quaternion[1])/16383.0)
		fmt.Printf("Quaternion [Y]: %d\n", float64(quaternion[2])/16383.0)
		fmt.Printf("Quaternion [Z]: %d\n", float64(quaternion[3])/16383.0)
		fmt.Printf("Linear Acceleration [X]: %d m/s²\n", float64(linearAcceleration[0])/100.0)
		fmt.Printf("Linear Acceleration [Y]: %d m/s²\n", float64(linearAcceleration[1])/100.0)
		fmt.Printf("Linear Acceleration [Z]: %d m/s²\n", float64(linearAcceleration[2])/100.0)
		fmt.Printf("Gravity Vector [X]: %d m/s²\n", float64(gravityVector[0])/100.0)
		fmt.Printf("Gravity Vector [Y]: %d m/s²\n", float64(gravityVector[1])/100.0)
		fmt.Printf("Gravity Vector [Z]: %d m/s²\n", float64(gravityVector[2])/100.0)
		fmt.Printf("Temperature: %d °C\n", temperature)
		fmt.Printf("Calibration Status: %b\n", calibrationStatus)
		fmt.Println()
	})

	// Set period for all data receiver to 0.1s (100ms).
	imu.SetAllDataPeriod(100)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
