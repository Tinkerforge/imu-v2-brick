use std::{error::Error, io};

use tinkerforge::{imu_v2_brick::*, ip_connection::IpConnection};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XXYYZZ"; // Change XXYYZZ to the UID of your IMU Brick 2.0.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let imu = ImuV2Brick::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Get current quaternion.
    let get_quaternion_result = imu.get_quaternion().recv()?;

    println!("Quaternion [W]: {}", get_quaternion_result.w as f32 / 16383.0);
    println!("Quaternion [X]: {}", get_quaternion_result.x as f32 / 16383.0);
    println!("Quaternion [Y]: {}", get_quaternion_result.y as f32 / 16383.0);
    println!("Quaternion [Z]: {}", get_quaternion_result.z as f32 / 16383.0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
