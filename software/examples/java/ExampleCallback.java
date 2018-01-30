import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickIMUV2;

public class ExampleCallback {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XXYYZZ to the UID of your IMU Brick 2.0
	private static final String UID = "XXYYZZ";

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
				System.out.println("Quaternion [W]: " + w/16383.0);
				System.out.println("Quaternion [X]: " + x/16383.0);
				System.out.println("Quaternion [Y]: " + y/16383.0);
				System.out.println("Quaternion [Z]: " + z/16383.0);
				System.out.println("");
			}
		});

		// Set period for quaternion callback to 0.1s (100ms)
		imu.setQuaternionPeriod(100);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
