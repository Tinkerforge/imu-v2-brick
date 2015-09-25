<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickIMUV2.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickIMUV2;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XXYYZZ'; // Change to your UID

// Callback function for quaternion callback
function cb_quaternion($w, $x, $y, $z)
{
    $s = sprintf("w: %.02f, x: %.02f, y: %.02f, z: %.02f\n",
                 $w/16383.0, $x/16383.0, $y/16383.0, $z/16383.0);

    echo "$s";
}

$ipcon = new IPConnection(); // Create IP connection
$imu = new BrickIMUV2(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Register quaternion callback to function cb_quaternion
$imu->registerCallback(BrickIMUV2::CALLBACK_QUATERNION, 'cb_quaternion');

// Set period for quaternion callback to 0.1s (100ms)
// Note: The quaternion callback is only called every 0.1 seconds
//       if the quaternion has changed since the last call!
$imu->setQuaternionPeriod(100);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
