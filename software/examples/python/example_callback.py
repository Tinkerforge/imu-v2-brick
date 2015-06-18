#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "6ww9bv" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.brick_imu_v2 import IMUV2

# Quaternion callback
def cb_quaternion(w, x, y, z):
    qdiv = float(2**14-1)
    string = "w: {:.02f}, x: {:.02f}, y: {:.02f}, z: {:.02f}"
    print(string.format(w/qdiv, x/qdiv, y/qdiv, z/qdiv))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    imu = IMUV2(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set period for quaternion callback to 100ms
    imu.set_quaternion_period(100)

    # Register quaternion callback
    imu.register_callback(imu.CALLBACK_QUATERNION, cb_quaternion)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
