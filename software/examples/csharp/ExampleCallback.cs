using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "6ww9bv"; // Change to your UID

	// Quaternion callback
	static void QuaternionCB(BrickIMUV2 sender, short w, short x, short y, short z)
	{
		float qdiv = (1 << 14) - 1;
		string s = "w: {0:F02}, x: {1:F02}, y: {2:F02}, z: {3:F02}";
		System.Console.WriteLine(System.String.Format(s, w/qdiv, x/qdiv, y/qdiv, z/qdiv));
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickIMUV2 imu = new BrickIMUV2(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set period for quaternion callback to 100ms
		imu.SetQuaternionPeriod(100);

		// Register quaternion callback to QuaternionCB
		imu.Quaternion += QuaternionCB;

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
