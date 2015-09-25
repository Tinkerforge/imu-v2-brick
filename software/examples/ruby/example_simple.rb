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

# Get current quaternion (returned as [w, x, y, z])
q = imu.get_quaternion
puts "w: %.02f, x: %.02f, y: %.02f, z: %.02f\n" %
     [q[0]/16383.0, q[1]/16383.0, q[2]/16383.0, q[3]/16383.0]

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
