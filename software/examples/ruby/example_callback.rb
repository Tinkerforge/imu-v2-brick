#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/brick_imu_v2'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = '6ww9bv' # Change to your UID

ipcon = IPConnection.new # Create IP connection
imu = BrickIMUV2.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Set period for quaternion callback to 100ms
imu.set_quaternion_period 100

# Register quaternion callback
imu.register_callback(BrickIMUV2::CALLBACK_QUATERNION) do |w, x, y, z|
  qdiv = (1 << 14) - 1
  puts "w: %.02f, x: %.02f, y: %.02f, z: %.02f\n" % [w.fdiv(qdiv),
                                                     x.fdiv(qdiv),
                                                     y.fdiv(qdiv),
                                                     z.fdiv(qdiv)]
end

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
