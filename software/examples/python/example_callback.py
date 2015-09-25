#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XXYYZZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.brick_imu_v2 import BrickIMUV2

# Callback function for quaternion callback
def cb_quaternion(w, x, y, z):
    print("w: {:.02f}, x: {:.02f}, y: {:.02f}, z: {:.02f}"
          .format(w/16383.0, x/16383.0, y/16383.0, z/16383.0))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    imu = BrickIMUV2(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Register quaternion callback to function cb_quaternion
    imu.register_callback(imu.CALLBACK_QUATERNION, cb_quaternion)

    # Set period for quaternion callback to 0.1s (100ms)
    # Note: The quaternion callback is only called every 0.1 seconds
    #       if the quaternion has changed since the last call!
    imu.set_quaternion_period(100)

    raw_input("Press key to exit\n") # Use input() in Python 3
    ipcon.disconnect()
