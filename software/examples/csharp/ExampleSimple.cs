using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "6ww9bv"; // Change to your UID

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickIMUV2 imu = new BrickIMUV2(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current quaternion
		short w, x, y, z;
		imu.GetQuaternion(out w, out x, out y, out z);

		string s = "w: {0:F02}, x: {1:F02}, y: {2:F02}, z: {3:F02}";
		string f = System.String.Format(s, w/16383.0, x/16383.0, y/16383.0, z/16383.0);
		System.Console.WriteLine(f);

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
