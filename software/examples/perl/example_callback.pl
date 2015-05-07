#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickIMUV2;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '6ww9bv'; # Change to your UID

# Quaternion callback
sub cb_quaternion
{
    my ($w, $x, $y, $z) = @_;

	 my $qdiv = (1 << 14) - 1;
    printf("w: %.02f, x: %.02f, y: %.02f, z: %.02f\n", $w/$qdiv, $x/$qdiv, $y/$qdiv, $z/$qdiv);
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $imu = Tinkerforge::BrickIMUV2->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set period for quaternion callback to 100ms
$imu->set_quaternion_period(100);

# Register quaternion callback
$imu->register_callback($imu->CALLBACK_QUATERNION, 'cb_quaternion');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
