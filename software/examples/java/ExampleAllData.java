import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickIMUV2;

public class ExampleAllData {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickIMUV2 imu = new BrickIMUV2(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set period for all data callback to 100ms
		imu.setAllDataPeriod(100);

		// Add and implement all data listener
		imu.addAllDataListener(new BrickIMUV2.AllDataListener() {
			public void allData(short[] acceleration, short[] magneticField,
			                    short[] angularVelocity, short[] eulerAngle,
			                    short[] quaternion, short[] linearAcceleration,
			                    short[] gravityVector, byte temperature,
			                    short calibrationStatus) {
				String s = "Acceleration        x: %.02f y: %.02f z: %.02f m/s²%n" +
				           "Magnetic Field      x: %.02f y: %.02f z: %.02f µT%n" +
				           "Angular Velocity    x: %.02f y: %.02f z: %.02f °/s%n" +
				           "Euler Angle         x: %.02f y: %.02f z: %.02f °%n" +
				           "Quaternion          x: %.02f y: %.02f z: %.02f w: %.02f%n" +
				           "Linear Acceleration x: %.02f y: %.02f z: %.02f m/s²%n" +
				           "Gravity Vector      x: %.02f y: %.02f z: %.02f m/s²%n" +
				           "Temperature         %d °C%n" +
				           "Calibration Status  %s%n%n";
				System.out.format(s,
				                  acceleration[0]/100.0,       acceleration[1]/100.0,       acceleration[2]/100.0,
				                  magneticField[0]/16.0,       magneticField[1]/16.0,       magneticField[2]/16.0,
				                  angularVelocity[0]/16.0,     angularVelocity[1]/16.0,     angularVelocity[2]/16.0,
				                  eulerAngle[0]/16.0,          eulerAngle[1]/16.0,          eulerAngle[2]/16.0,
				                  quaternion[1]/16383.0,       quaternion[2]/16383.0,       quaternion[3]/16383.0,       quaternion[0]/16383.0,
				                  linearAcceleration[0]/100.0, linearAcceleration[1]/100.0, linearAcceleration[2]/100.0,
				                  gravityVector[0]/100.0,      gravityVector[1]/100.0,      gravityVector[2]/100.0,
				                  temperature, Integer.toBinaryString(calibrationStatus));
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
