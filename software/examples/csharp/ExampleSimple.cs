using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XXYYZZ"; // Change XXYYZZ to the UID of your IMU Brick 2.0

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickIMUV2 imu = new BrickIMUV2(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current quaternion
		short w, x, y, z;
		imu.GetQuaternion(out w, out x, out y, out z);

		Console.WriteLine("Quaternion [W]: " + w/16383.0);
		Console.WriteLine("Quaternion [X]: " + x/16383.0);
		Console.WriteLine("Quaternion [Y]: " + y/16383.0);
		Console.WriteLine("Quaternion [Z]: " + z/16383.0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
