#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/brick_imu_v2'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XXYYZZ' # Change XXYYZZ to the UID of your IMU Brick 2.0

ipcon = IPConnection.new # Create IP connection
imu = BrickIMUV2.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Register all data callback
imu.register_callback(BrickIMUV2::CALLBACK_ALL_DATA) do |acceleration, magnetic_field,
                                                         angular_velocity, euler_angle,
                                                         quaternion, linear_acceleration,
                                                         gravity_vector, temperature,
                                                         calibration_status|
  puts "Acceleration [X]: #{acceleration[0]/100.0} m/s²"
  puts "Acceleration [Y]: #{acceleration[1]/100.0} m/s²"
  puts "Acceleration [Z]: #{acceleration[2]/100.0} m/s²"
  puts "Magnetic Field [X]: #{magnetic_field[0]/16.0} µT"
  puts "Magnetic Field [Y]: #{magnetic_field[1]/16.0} µT"
  puts "Magnetic Field [Z]: #{magnetic_field[2]/16.0} µT"
  puts "Angular Velocity [X]: #{angular_velocity[0]/16.0} °/s"
  puts "Angular Velocity [Y]: #{angular_velocity[1]/16.0} °/s"
  puts "Angular Velocity [Z]: #{angular_velocity[2]/16.0} °/s"
  puts "Euler Angle [X]: #{euler_angle[0]/16.0} °"
  puts "Euler Angle [Y]: #{euler_angle[1]/16.0} °"
  puts "Euler Angle [Z]: #{euler_angle[2]/16.0} °"
  puts "Quaternion [W]: #{quaternion[0]/16383.0}"
  puts "Quaternion [X]: #{quaternion[1]/16383.0}"
  puts "Quaternion [Y]: #{quaternion[2]/16383.0}"
  puts "Quaternion [Z]: #{quaternion[3]/16383.0}"
  puts "Linear Acceleration [X]: #{linear_acceleration[0]/100.0} m/s²"
  puts "Linear Acceleration [Y]: #{linear_acceleration[1]/100.0} m/s²"
  puts "Linear Acceleration [Z]: #{linear_acceleration[2]/100.0} m/s²"
  puts "Gravity Vector [X]: #{gravity_vector[0]/100.0} m/s²"
  puts "Gravity Vector [Y]: #{gravity_vector[1]/100.0} m/s²"
  puts "Gravity Vector [Z]: #{gravity_vector[2]/100.0} m/s²"
  puts "Temperature: #{temperature} °C"
  puts "Calibration Status: #{'%08b' % calibration_status}"
  puts ''
end

# Set period for all data callback to 0.1s (100ms)
imu.set_all_data_period 100

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
