using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XXYYZZ"; // Change XXYYZZ to the UID of your IMU Brick 2.0

	// Callback function for all data callback
	static void AllDataCB(BrickIMUV2 sender, short[] acceleration, short[] magneticField,
	                      short[] angularVelocity, short[] eulerAngle, short[] quaternion,
	                      short[] linearAcceleration, short[] gravityVector,
	                      short temperature, byte calibrationStatus)
	{
		Console.WriteLine("Acceleration [X]: " + acceleration[0]/100.0 + " m/s²");
		Console.WriteLine("Acceleration [Y]: " + acceleration[1]/100.0 + " m/s²");
		Console.WriteLine("Acceleration [Z]: " + acceleration[2]/100.0 + " m/s²");
		Console.WriteLine("Magnetic Field [X]: " + magneticField[0]/16.0 + " µT");
		Console.WriteLine("Magnetic Field [Y]: " + magneticField[1]/16.0 + " µT");
		Console.WriteLine("Magnetic Field [Z]: " + magneticField[2]/16.0 + " µT");
		Console.WriteLine("Angular Velocity [X]: " + angularVelocity[0]/16.0 + " °/s");
		Console.WriteLine("Angular Velocity [Y]: " + angularVelocity[1]/16.0 + " °/s");
		Console.WriteLine("Angular Velocity [Z]: " + angularVelocity[2]/16.0 + " °/s");
		Console.WriteLine("Euler Angle [X]: " + eulerAngle[0]/16.0 + " °");
		Console.WriteLine("Euler Angle [Y]: " + eulerAngle[1]/16.0 + " °");
		Console.WriteLine("Euler Angle [Z]: " + eulerAngle[2]/16.0 + " °");
		Console.WriteLine("Quaternion [W]: " + quaternion[0]/16383.0);
		Console.WriteLine("Quaternion [X]: " + quaternion[1]/16383.0);
		Console.WriteLine("Quaternion [Y]: " + quaternion[2]/16383.0);
		Console.WriteLine("Quaternion [Z]: " + quaternion[3]/16383.0);
		Console.WriteLine("Linear Acceleration [X]: " + linearAcceleration[0]/100.0 + " m/s²");
		Console.WriteLine("Linear Acceleration [Y]: " + linearAcceleration[1]/100.0 + " m/s²");
		Console.WriteLine("Linear Acceleration [Z]: " + linearAcceleration[2]/100.0 + " m/s²");
		Console.WriteLine("Gravity Vector [X]: " + gravityVector[0]/100.0 + " m/s²");
		Console.WriteLine("Gravity Vector [Y]: " + gravityVector[1]/100.0 + " m/s²");
		Console.WriteLine("Gravity Vector [Z]: " + gravityVector[2]/100.0 + " m/s²");
		Console.WriteLine("Temperature: " + temperature + " °C");
		Console.WriteLine("Calibration Status: " + Convert.ToString(calibrationStatus, 2));
		Console.WriteLine("");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickIMUV2 imu = new BrickIMUV2(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register all data callback to function AllDataCB
		imu.AllDataCallback += AllDataCB;

		// Set period for all data callback to 0.1s (100ms)
		imu.SetAllDataPeriod(100);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
