use std::{error::Error, io, thread};
use tinkerforge::{imu_v2_brick::*, ip_connection::IpConnection};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XXYYZZ"; // Change XXYYZZ to the UID of your IMU Brick 2.0.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let imu = ImuV2Brick::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Create receiver for quaternion events.
    let quaternion_receiver = imu.get_quaternion_receiver();

    // Spawn thread to handle received events. This thread ends when the `imu` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for quaternion in quaternion_receiver {
            println!("Quaternion [W]: {}", quaternion.w as f32 / 16383.0);
            println!("Quaternion [X]: {}", quaternion.x as f32 / 16383.0);
            println!("Quaternion [Y]: {}", quaternion.y as f32 / 16383.0);
            println!("Quaternion [Z]: {}", quaternion.z as f32 / 16383.0);
            println!();
        }
    });

    // Set period for quaternion receiver to 0.1s (100ms).
    imu.set_quaternion_period(100);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
