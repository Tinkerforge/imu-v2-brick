<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickIMUV2.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickIMUV2;

const HOST = 'localhost';
const PORT = 4223;
const UID = '6ww9bv'; // Change to your UID

// All data callback
function cb_all_data($acceleration, $magnetic_field, $angular_velocity,
                     $euler_angle, $quaternion, $linear_acceleration,
                     $gravity_vector, $temperature, $calibration_status)
{
    $s = sprintf("Acceleration        x: %.02f y: %.02f z: %.02f m/s²\n" .
                 "Magnetic Field      x: %.02f y: %.02f z: %.02f µT\n" .
                 "Angular Velocity    x: %.02f y: %.02f z: %.02f °/s\n" .
                 "Euler Angle         x: %.02f y: %.02f z: %.02f °\n" .
                 "Quaternion          x: %.02f y: %.02f z: %.02f w: %.02f\n" .
                 "Linear Acceleration x: %.02f y: %.02f z: %.02f m/s²\n" .
                 "Gravity Vector      x: %.02f y: %.02f z: %.02f m/s²\n" .
                 "Temperature         %d °C\n" .
                 "Calibration Status  %u\n\n",
                 $acceleration[0]/100.0,        $acceleration[1]/100.0,        $acceleration[2]/100.0,
                 $magnetic_field[0]/16.0,       $magnetic_field[1]/16.0,       $magnetic_field[2]/16.0,
                 $angular_velocity[0]/16.0,     $angular_velocity[1]/16.0,     $angular_velocity[2]/16.0,
                 $euler_angle[0]/16.0,          $euler_angle[1]/16.0,          $euler_angle[2]/16.0,
                 $quaternion[1]/16383.0,        $quaternion[2]/16383.0,        $quaternion[3]/16383.0,        $quaternion[0]/16383.0,
                 $linear_acceleration[0]/100.0, $linear_acceleration[1]/100.0, $linear_acceleration[2]/100.0,
                 $gravity_vector[0]/100.0,      $gravity_vector[1]/100.0,      $gravity_vector[2]/100.0,
                 $temperature, $calibration_status);

    echo "$s";
}

$ipcon = new IPConnection(); // Create IP connection
$imu = new BrickIMUV2(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set period for All data callback to 100ms
$imu->setAllDataPeriod(100);

// Register all data callback to function cb_quaternion
$imu->registerCallback(BrickIMUV2::CALLBACK_ALL_DATA, 'cb_all_data');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
