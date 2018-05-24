#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickIMUV2;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XXYYZZ'; # Change XXYYZZ to the UID of your IMU Brick 2.0

# Callback subroutine for all data callback
sub cb_all_data
{
    my ($acceleration, $magnetic_field, $angular_velocity, $euler_angle, $quaternion,
        $linear_acceleration, $gravity_vector, $temperature, $calibration_status) = @_;

    print "Acceleration [X]: " . @{$acceleration}[0]/100.0 . " m/s²\n";
    print "Acceleration [Y]: " . @{$acceleration}[1]/100.0 . " m/s²\n";
    print "Acceleration [Z]: " . @{$acceleration}[2]/100.0 . " m/s²\n";
    print "Magnetic Field [X]: " . @{$magnetic_field}[0]/16.0 . " µT\n";
    print "Magnetic Field [Y]: " . @{$magnetic_field}[1]/16.0 . " µT\n";
    print "Magnetic Field [Z]: " . @{$magnetic_field}[2]/16.0 . " µT\n";
    print "Angular Velocity [X]: " . @{$angular_velocity}[0]/16.0 . " °/s\n";
    print "Angular Velocity [Y]: " . @{$angular_velocity}[1]/16.0 . " °/s\n";
    print "Angular Velocity [Z]: " . @{$angular_velocity}[2]/16.0 . " °/s\n";
    print "Euler Angle [X]: " . @{$euler_angle}[0]/16.0 . " °\n";
    print "Euler Angle [Y]: " . @{$euler_angle}[1]/16.0 . " °\n";
    print "Euler Angle [Z]: " . @{$euler_angle}[2]/16.0 . " °\n";
    print "Quaternion [W]: " . @{$quaternion}[0]/16383.0 . "\n";
    print "Quaternion [X]: " . @{$quaternion}[1]/16383.0 . "\n";
    print "Quaternion [Y]: " . @{$quaternion}[2]/16383.0 . "\n";
    print "Quaternion [Z]: " . @{$quaternion}[3]/16383.0 . "\n";
    print "Linear Acceleration [X]: " . @{$linear_acceleration}[0]/100.0 . " m/s²\n";
    print "Linear Acceleration [Y]: " . @{$linear_acceleration}[1]/100.0 . " m/s²\n";
    print "Linear Acceleration [Z]: " . @{$linear_acceleration}[2]/100.0 . " m/s²\n";
    print "Gravity Vector [X]: " . @{$gravity_vector}[0]/100.0 . " m/s²\n";
    print "Gravity Vector [Y]: " . @{$gravity_vector}[1]/100.0 . " m/s²\n";
    print "Gravity Vector [Z]: " . @{$gravity_vector}[2]/100.0 . " m/s²\n";
    print "Temperature: $temperature °C\n";
    print "Calibration Status: " . sprintf('%08b', $calibration_status) . "\n";
    print "\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $imu = Tinkerforge::BrickIMUV2->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Register all data callback to subroutine cb_all_data
$imu->register_callback($imu->CALLBACK_ALL_DATA, 'cb_all_data');

# Set period for all data callback to 0.1s (100ms)
$imu->set_all_data_period(100);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
