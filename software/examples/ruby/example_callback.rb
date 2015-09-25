#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/brick_imu_v2'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XXYYZZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
imu = BrickIMUV2.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Register quaternion callback
imu.register_callback(BrickIMUV2::CALLBACK_QUATERNION) do |w, x, y, z|
  puts "w: %.02f, x: %.02f, y: %.02f, z: %.02f\n" %
       [w/16383.0, x/16383.0, y/16383.0, z/16383.0]
end

# Set period for quaternion callback to 0.1s (100ms)
# Note: The quaternion callback is only called every 0.1 seconds
#       if the quaternion has changed since the last call!
imu.set_quaternion_period 100

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
