#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "6ww9bv" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.brick_imu_v2 import IMUV2

# All Data callback
def cb_all_data(acceleration, magnetic_field, angular_velocity, 
                euler_angle, quaternion, linear_acceleration, 
                gravity_vector, temperature, calibration_status):
    qdiv = float(2**14-1)
    print u'''
Acceleration        x: {:.2f} y: {:.2f} z: {:.2f} m/s²
Magnetic Field      x: {:.2f} y: {:.2f} z: {:.2f} µT
Angular Velocity    x: {:.2f} y: {:.2f} z: {:.2f} °/s
Euler Angles        x: {:.2f} y: {:.2f} z: {:.2f} °
Quaternion          x: {:.2f} y: {:.2f} z: {:.2f} w: {:.2f}
Linear Acceleration x: {:.2f} y: {:.2f} z: {:.2f} m/s²
Gravity Vector      x: {:.2f} y: {:.2f} z: {:.2f} m/s²
Temperature:        {} °C
calibration Status: {}
'''.format(acceleration[0]/100.0,        acceleration[1]/100.0,        acceleration[2]/100.0,
           magnetic_field[0]/16.0,       magnetic_field[1]/16.0,       magnetic_field[2]/16.0, 
           angular_velocity[0]/16.0,     angular_velocity[1]/16.0,     angular_velocity[2]/16.0,
           euler_angle[0]/16.0,          euler_angle[1]/16.0,          euler_angle[2]/16.0, 
           quaternion[1]/qdiv,           quaternion[2]/qdiv,           quaternion[3]/qdiv,           quaternion[0]/qdiv,
           linear_acceleration[0]/100.0, linear_acceleration[1]/100.0, linear_acceleration[2]/100.0, 
           gravity_vector[0]/100.0,      gravity_vector[1]/100.0,      gravity_vector[2]/100.0, 
           temperature, calibration_status)

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    imu = IMUV2(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set period for quaternion callback to 100ms
    imu.set_all_data_period(100)

    # Register All Data callback
    imu.register_callback(imu.CALLBACK_ALL_DATA, cb_all_data)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
