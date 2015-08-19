<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickIMUV2.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickIMUV2;

const HOST = 'localhost';
const PORT = 4223;
const UID = '6ww9bv'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$imu = new BrickIMUV2(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current quaternion
$q = $imu->getquaternion();
$s = sprintf("w: %.02f, x: %.02f, y: %.02f, z: %.02f\n",
             $q['w']/16383.0, $q['x']/16383.0, $q['y']/16383.0, $q['z']/16383.0);

echo "$s";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
