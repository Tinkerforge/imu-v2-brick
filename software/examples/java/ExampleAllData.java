import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickIMUV2;

public class ExampleAllData {
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

		// Add all data listener
		imu.addAllDataListener(new BrickIMUV2.AllDataListener() {
			public void allData(short[] acceleration, short[] magneticField,
			                    short[] angularVelocity, short[] eulerAngle,
			                    short[] quaternion, short[] linearAcceleration,
			                    short[] gravityVector, byte temperature,
			                    short calibrationStatus) {
				System.out.println("Acceleration [X]: " + acceleration[0]/100.0 + " m/s²");
				System.out.println("Acceleration [Y]: " + acceleration[1]/100.0 + " m/s²");
				System.out.println("Acceleration [Z]: " + acceleration[2]/100.0 + " m/s²");
				System.out.println("Magnetic Field [X]: " + magneticField[0]/16.0 + " µT");
				System.out.println("Magnetic Field [Y]: " + magneticField[1]/16.0 + " µT");
				System.out.println("Magnetic Field [Z]: " + magneticField[2]/16.0 + " µT");
				System.out.println("Angular Velocity [X]: " + angularVelocity[0]/16.0 + " °/s");
				System.out.println("Angular Velocity [Y]: " + angularVelocity[1]/16.0 + " °/s");
				System.out.println("Angular Velocity [Z]: " + angularVelocity[2]/16.0 + " °/s");
				System.out.println("Euler Angle [X]: " + eulerAngle[0]/16.0 + " °");
				System.out.println("Euler Angle [Y]: " + eulerAngle[1]/16.0 + " °");
				System.out.println("Euler Angle [Z]: " + eulerAngle[2]/16.0 + " °");
				System.out.println("Quaternion [W]: " + quaternion[0]/16383.0);
				System.out.println("Quaternion [X]: " + quaternion[1]/16383.0);
				System.out.println("Quaternion [Y]: " + quaternion[2]/16383.0);
				System.out.println("Quaternion [Z]: " + quaternion[3]/16383.0);
				System.out.println("Linear Acceleration [X]: " + linearAcceleration[0]/100.0 + " m/s²");
				System.out.println("Linear Acceleration [Y]: " + linearAcceleration[1]/100.0 + " m/s²");
				System.out.println("Linear Acceleration [Z]: " + linearAcceleration[2]/100.0 + " m/s²");
				System.out.println("Gravity Vector [X]: " + gravityVector[0]/100.0 + " m/s²");
				System.out.println("Gravity Vector [Y]: " + gravityVector[1]/100.0 + " m/s²");
				System.out.println("Gravity Vector [Z]: " + gravityVector[2]/100.0 + " m/s²");
				System.out.println("Temperature: " + temperature + " °C");
				System.out.println("Calibration Status: " + Integer.toBinaryString(calibrationStatus));
				System.out.println("");
			}
		});

		// Set period for all data callback to 0.1s (100ms)
		imu.setAllDataPeriod(100);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
