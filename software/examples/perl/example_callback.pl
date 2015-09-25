#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickIMUV2;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XXYYZZ'; # Change to your UID

# Callback subroutine for quaternion callback
sub cb_quaternion
{
    my ($w, $x, $y, $z) = @_;

    printf("w: %.02f, x: %.02f, y: %.02f, z: %.02f\n",
           $w/16383.0, $x/16383.0, $y/16383.0, $z/16383.0);
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $imu = Tinkerforge::BrickIMUV2->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Register quaternion callback to subroutine cb_quaternion
$imu->register_callback($imu->CALLBACK_QUATERNION, 'cb_quaternion');

# Set period for quaternion callback to 0.1s (100ms)
# Note: The quaternion callback is only called every 0.1 seconds
#       if the quaternion has changed since the last call!
$imu->set_quaternion_period(100);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
