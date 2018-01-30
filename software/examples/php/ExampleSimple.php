<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickIMUV2.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickIMUV2;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XXYYZZ'; // Change XXYYZZ to the UID of your IMU Brick 2.0

$ipcon = new IPConnection(); // Create IP connection
$imu = new BrickIMUV2(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current quaternion
$quaternion = $imu->getQuaternion();

echo "Quaternion [W]: " . $quaternion['w']/16383.0 . "\n";
echo "Quaternion [X]: " . $quaternion['x']/16383.0 . "\n";
echo "Quaternion [Y]: " . $quaternion['y']/16383.0 . "\n";
echo "Quaternion [Z]: " . $quaternion['z']/16383.0 . "\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
