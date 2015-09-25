#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickIMUV2;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XXYYZZ'; # Change to your UID

# Callback subroutine for all data callback
sub cb_all_data
{
    my ($acceleration, $magnetic_field, $angular_velocity, $euler_angle,
        $quaternion, $linear_acceleration, $gravity_vector, $temperature,
        $calibration_status) = @_;

    printf("Acceleration        x: %.02f y: %.02f z: %.02f m/s²\n" .
           "Magnetic Field      x: %.02f y: %.02f z: %.02f µT\n" .
           "Angular Velocity    x: %.02f y: %.02f z: %.02f °/s\n" .
           "Euler Angle         x: %.02f y: %.02f z: %.02f °\n" .
           "Quaternion          x: %.02f y: %.02f z: %.02f w: %.02f\n" .
           "Linear Acceleration x: %.02f y: %.02f z: %.02f m/s²\n" .
           "Gravity Vector      x: %.02f y: %.02f z: %.02f m/s²\n" .
           "Temperature         %d °C\n" .
           "Calibration Status  %08b\n\n",
           @{$acceleration}[0]/100.0,        @{$acceleration}[1]/100.0,        @{$acceleration}[2]/100.0,
           @{$magnetic_field}[0]/16.0,       @{$magnetic_field}[1]/16.0,       @{$magnetic_field}[2]/16.0,
           @{$angular_velocity}[0]/16.0,     @{$angular_velocity}[1]/16.0,     @{$angular_velocity}[2]/16.0,
           @{$euler_angle}[0]/16.0,          @{$euler_angle}[1]/16.0,          @{$euler_angle}[2]/16.0,
           @{$quaternion}[1]/16383.0,        @{$quaternion}[2]/16383.0,        @{$quaternion}[3]/16383.0,        @{$quaternion}[0]/16383.0,
           @{$linear_acceleration}[0]/100.0, @{$linear_acceleration}[1]/100.0, @{$linear_acceleration}[2]/100.0,
           @{$gravity_vector}[0]/100.0,      @{$gravity_vector}[1]/100.0,      @{$gravity_vector}[2]/100.0,
           $temperature,
           $calibration_status);
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $imu = Tinkerforge::BrickIMUV2->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Register all data callback to subroutine cb_all_data
$imu->register_callback($imu->CALLBACK_ALL_DATA, 'cb_all_data');

# Set period for all data callback to 0.1s (100ms)
# Note: The all data callback is only called every 0.1 seconds
#       if the all data has changed since the last call!
$imu->set_all_data_period(100);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
