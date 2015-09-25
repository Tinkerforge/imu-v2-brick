import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickIMUV2;

public class ExampleCallback {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XXYYZZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickIMUV2 imu = new BrickIMUV2(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Add quaternion listener
		imu.addQuaternionListener(new BrickIMUV2.QuaternionListener() {
			public void quaternion(short w, short x, short y, short z) {
				String s = "w: %.02f, x: %.02f, y: %.02f, z: %.02f%n";
				System.out.format(s, w/16383.0, x/16383.0, y/16383.0, z/16383.0);
			}
		});

		// Set period for quaternion callback to 0.1s (100ms)
		// Note: The quaternion callback is only called every 0.1 seconds
		//       if the quaternion has changed since the last call!
		imu.setQuaternionPeriod(100);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
