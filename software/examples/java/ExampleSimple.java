import com.tinkerforge.BrickIMUV2;
import com.tinkerforge.BrickIMUV2.Quaternion;
import com.tinkerforge.IPConnection;

public class ExampleSimple {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "6ww9bv"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickIMUV2 imu = new BrickIMUV2(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current quaternion
		Quaternion q = imu.getQuaternion(); // Can throw com.tinkerforge.TimeoutException
		String s = "w: %.02f, x: %.02f, y: %.02f, z: %.02f%n";
		System.out.format(s, q.w/16383.0, q.x/16383.0, q.y/16383.0, q.z/16383.0);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
