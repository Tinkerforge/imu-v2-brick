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

# Register quaternion callback
imu.register_callback(BrickIMUV2::CALLBACK_QUATERNION) do |w, x, y, z|
  puts "Quaternion [W]: #{w/16383.0}"
  puts "Quaternion [X]: #{x/16383.0}"
  puts "Quaternion [Y]: #{y/16383.0}"
  puts "Quaternion [Z]: #{z/16383.0}"
  puts ''
end

# Set period for quaternion callback to 0.1s (100ms)
imu.set_quaternion_period 100

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
