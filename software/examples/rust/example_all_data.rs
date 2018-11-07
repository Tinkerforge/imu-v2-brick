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

    // Create receiver for all data events.
    let all_data_receiver = imu.get_all_data_receiver();

    // Spawn thread to handle received events. This thread ends when the `imu` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for all_data in all_data_receiver {
            println!("Acceleration [X]: {} m/s²", all_data.acceleration[0] as f32 / 100.0);
            println!("Acceleration [Y]: {} m/s²", all_data.acceleration[1] as f32 / 100.0);
            println!("Acceleration [Z]: {} m/s²", all_data.acceleration[2] as f32 / 100.0);
            println!("Magnetic Field [X]: {} µT", all_data.magnetic_field[0] as f32 / 16.0);
            println!("Magnetic Field [Y]: {} µT", all_data.magnetic_field[1] as f32 / 16.0);
            println!("Magnetic Field [Z]: {} µT", all_data.magnetic_field[2] as f32 / 16.0);
            println!("Angular Velocity [X]: {} °/s", all_data.angular_velocity[0] as f32 / 16.0);
            println!("Angular Velocity [Y]: {} °/s", all_data.angular_velocity[1] as f32 / 16.0);
            println!("Angular Velocity [Z]: {} °/s", all_data.angular_velocity[2] as f32 / 16.0);
            println!("Euler Angle [X]: {} °", all_data.euler_angle[0] as f32 / 16.0);
            println!("Euler Angle [Y]: {} °", all_data.euler_angle[1] as f32 / 16.0);
            println!("Euler Angle [Z]: {} °", all_data.euler_angle[2] as f32 / 16.0);
            println!("Quaternion [W]: {}", all_data.quaternion[0] as f32 / 16383.0);
            println!("Quaternion [X]: {}", all_data.quaternion[1] as f32 / 16383.0);
            println!("Quaternion [Y]: {}", all_data.quaternion[2] as f32 / 16383.0);
            println!("Quaternion [Z]: {}", all_data.quaternion[3] as f32 / 16383.0);
            println!("Linear Acceleration [X]: {} m/s²", all_data.linear_acceleration[0] as f32 / 100.0);
            println!("Linear Acceleration [Y]: {} m/s²", all_data.linear_acceleration[1] as f32 / 100.0);
            println!("Linear Acceleration [Z]: {} m/s²", all_data.linear_acceleration[2] as f32 / 100.0);
            println!("Gravity Vector [X]: {} m/s²", all_data.gravity_vector[0] as f32 / 100.0);
            println!("Gravity Vector [Y]: {} m/s²", all_data.gravity_vector[1] as f32 / 100.0);
            println!("Gravity Vector [Z]: {} m/s²", all_data.gravity_vector[2] as f32 / 100.0);
            println!("Temperature: {} °C", all_data.temperature);
            println!("Calibration Status: {:b}", all_data.calibration_status);
            println!();
        }
    });

    // Set period for all data receiver to 0.1s (100ms).
    imu.set_all_data_period(100);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
