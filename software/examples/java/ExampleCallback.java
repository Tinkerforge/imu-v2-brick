import com.tinkerforge.BrickIMUV2;
import com.tinkerforge.IPConnection;

public class ExampleCallback {
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

		// Set period for quaternion callback to 100ms
		imu.setQuaternionPeriod(100);

		// Add and implement quaternion listener 
		imu.addQuaternionListener(new BrickIMUV2.QuaternionListener() {
			public void quaternion(short w, short x, short y, short z) {
				String s = new String("w: %.02f, x: %.02f, y: %.02f, z: %.02f%n");
				float qdiv = (1 << 14) - 1;
				System.out.format(s, w/qdiv, x/qdiv, y/qdiv, z/qdiv);
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
