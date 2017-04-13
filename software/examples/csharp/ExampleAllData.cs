using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XXYYZZ"; // Change XXYYZZ to the UID of your IMU Brick 2.0

	// Callback function for all data callback
	static void AllDataCB(BrickIMUV2 sender, short[] acceleration,
	                      short[] magneticField, short[] angularVelocity,
	                      short[] eulerAngle, short[] quaternion,
	                      short[] linearAcceleration, short[] gravityVector,
	                      short temperature, byte calibrationStatus)
	{
		string s = "Acceleration        x: {0:F02} y: {1:F02} z: {2:F02} m/s²\n" +
		           "Magnetic Field      x: {3:F02} y: {4:F02} z: {5:F02} µT\n" +
		           "Angular Velocity    x: {6:F02} y: {7:F02} z: {8:F02} °/s\n" +
		           "Euler Angle         x: {9:F02} y: {10:F02} z: {11:F02} °\n" +
		           "Quaternion          x: {12:F02} y: {13:F02} z: {14:F02} w: {15:F02}\n" +
		           "Linear Acceleration x: {16:F02} y: {17:F02} z: {18:F02} m/s²\n" +
		           "Gravity Vector      x: {19:F02} y: {20:F02} z: {21:F02} m/s²\n" +
		           "Temperature         {22} °C\n" +
		           "Calibration Status  {23}\n";
		object[] o = {acceleration[0]/100.0,       acceleration[1]/100.0,       acceleration[2]/100.0,
		              magneticField[0]/16.0,       magneticField[1]/16.0,       magneticField[2]/16.0,
		              angularVelocity[0]/16.0,     angularVelocity[1]/16.0,     angularVelocity[2]/16.0,
		              eulerAngle[0]/16.0,          eulerAngle[1]/16.0,          eulerAngle[2]/16.0,
		              quaternion[1]/16383.0,       quaternion[2]/16383.0,       quaternion[3]/16383.0,       quaternion[0]/16383.0,
		              linearAcceleration[0]/100.0, linearAcceleration[1]/100.0, linearAcceleration[2]/100.0,
		              gravityVector[0]/100.0,      gravityVector[1]/100.0,      gravityVector[2]/100.0,
		              temperature,
		              Convert.ToString(calibrationStatus, 2)};
		Console.WriteLine(String.Format(s, o));
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
