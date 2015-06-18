<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickIMUV2.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickIMUV2;

const HOST = 'localhost';
const PORT = 4223;
const UID = '6ww9bv'; // Change to your UID

// Quaternion callback
function cb_quaternion($w, $x, $y, $z)
{
    $qdiv = (1 << 14) - 1;
    $s = sprintf("w: %.02f, x: %.02f, y: %.02f, z: %.02f\n",
                 $w/$qdiv, $x/$qdiv, $y/$qdiv, $z/$qdiv);

    echo "$s";
}

$ipcon = new IPConnection(); // Create IP connection
$imu = new BrickIMUV2(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set period for quaternion callback to 100ms
$imu->setQuaternionPeriod(100);

// Register position callback to function cb_position
$imu->registerCallback(BrickIMUV2::CALLBACK_QUATERNION, 'cb_quaternion');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
