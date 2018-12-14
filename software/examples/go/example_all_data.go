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
		fmt.Printf("Acceleration [X]: %f m/s²\n", float64(acceleration[0])/100.0)
		fmt.Printf("Acceleration [Y]: %f m/s²\n", float64(acceleration[1])/100.0)
		fmt.Printf("Acceleration [Z]: %f m/s²\n", float64(acceleration[2])/100.0)
		fmt.Printf("Magnetic Field [X]: %f µT\n", float64(magneticField[0])/16.0)
		fmt.Printf("Magnetic Field [Y]: %f µT\n", float64(magneticField[1])/16.0)
		fmt.Printf("Magnetic Field [Z]: %f µT\n", float64(magneticField[2])/16.0)
		fmt.Printf("Angular Velocity [X]: %f °/s\n", float64(angularVelocity[0])/16.0)
		fmt.Printf("Angular Velocity [Y]: %f °/s\n", float64(angularVelocity[1])/16.0)
		fmt.Printf("Angular Velocity [Z]: %f °/s\n", float64(angularVelocity[2])/16.0)
		fmt.Printf("Euler Angle [X]: %f °\n", float64(eulerAngle[0])/16.0)
		fmt.Printf("Euler Angle [Y]: %f °\n", float64(eulerAngle[1])/16.0)
		fmt.Printf("Euler Angle [Z]: %f °\n", float64(eulerAngle[2])/16.0)
		fmt.Printf("Quaternion [W]: %f\n", float64(quaternion[0])/16383.0)
		fmt.Printf("Quaternion [X]: %f\n", float64(quaternion[1])/16383.0)
		fmt.Printf("Quaternion [Y]: %f\n", float64(quaternion[2])/16383.0)
		fmt.Printf("Quaternion [Z]: %f\n", float64(quaternion[3])/16383.0)
		fmt.Printf("Linear Acceleration [X]: %f m/s²\n", float64(linearAcceleration[0])/100.0)
		fmt.Printf("Linear Acceleration [Y]: %f m/s²\n", float64(linearAcceleration[1])/100.0)
		fmt.Printf("Linear Acceleration [Z]: %f m/s²\n", float64(linearAcceleration[2])/100.0)
		fmt.Printf("Gravity Vector [X]: %f m/s²\n", float64(gravityVector[0])/100.0)
		fmt.Printf("Gravity Vector [Y]: %f m/s²\n", float64(gravityVector[1])/100.0)
		fmt.Printf("Gravity Vector [Z]: %f m/s²\n", float64(gravityVector[2])/100.0)
		fmt.Printf("Temperature: %d °C\n", temperature)
		fmt.Printf("Calibration Status: %b\n", calibrationStatus)
		fmt.Println()
	})

	// Set period for all data receiver to 0.1s (100ms).
	imu.SetAllDataPeriod(100)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
