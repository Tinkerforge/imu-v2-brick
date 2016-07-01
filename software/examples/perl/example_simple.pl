#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickIMUV2;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XXYYZZ'; # Change XXYYZZ to the UID of your IMU Brick 2.0

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $imu = Tinkerforge::BrickIMUV2->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current quaternion
my ($w, $x, $y, $z) = $imu->get_quaternion();
printf("w: %.02f, x: %.02f, y: %.02f, z: %.02f\n",
       $w/16383.0, $x/16383.0, $y/16383.0, $z/16383.0);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
