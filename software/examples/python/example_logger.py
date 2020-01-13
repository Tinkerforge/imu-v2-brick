#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Simple IMU V2 csv data logger

HOST = "localhost"
PORT = 4223
READ_PERIOD = 100 # in ms

CSV_TITLE = [
    'Time (unixtime)', 
    'Acc. X', 'Acc. Y', 'Acc. Z', 
    'Ang. Vel. X (o. pitch)', 'Ang. Vel. Y (o. roll)', 'Ang. Vel. Z (o. head)', 
    'Euler A. X', 'Euler A. Y', 'Euler A. Z', 
    'Lin. Acc. X', 'Lin. Acc. Y', 'Lin. Acc. Z', 
    'Grav. Vect. X', 'Grav. Vect. Y', 'Grav. Vect. Z', 
    'Temp'
]

from tinkerforge.ip_connection import IPConnection
from tinkerforge.brick_imu_v2 import BrickIMUV2
import time
import sys
import csv
from datetime import date

imu_uid = None

def cb_enumerate(uid, connected_uid, position, hardware_version, firmware_version,
                 device_identifier, enumeration_type):
    if enumeration_type == IPConnection.ENUMERATION_TYPE_DISCONNECTED:
        return

    # Set imu_uid if any IMU is discovered, we assume that there is only 
    if device_identifier == 18:
        global imu_uid
        imu_uid = uid

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    ipcon.connect(HOST, PORT) # Connect to brickd

    # Register Enumerate Callback
    ipcon.register_callback(IPConnection.CALLBACK_ENUMERATE, cb_enumerate)

    # Trigger Enumerate
    ipcon.enumerate()

    # Wait for 1 second enumeration
    time.sleep(1)

    if imu_uid == None:
        print("Did not find IMU Brick 2.0")
        sys.exit(1)


    imu = BrickIMUV2(imu_uid, ipcon) # Create device object

    csv_file = open('log_imu_{0}_{1}.csv'.format(imu_uid, date.today()), 'w')
    csv_writer = csv.writer(csv_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
    csv_writer.writerow(CSV_TITLE)

    print("Logger started. Use ctr+c to exit.")
    try:
        while True:
            time.sleep(1.0/(1000.0/READ_PERIOD))

            acceleration, magnetic_field, angular_velocity, \
            euler_angle, quaternion, linear_acceleration, gravity_vector, \
            temperature, calibration_status = imu.get_all_data()

            row = [
                str(time.time()), # Unix time
                str(acceleration[0]), str(acceleration[1]), str(acceleration[2]), 
                str(angular_velocity[0]), str(angular_velocity[1]), str(angular_velocity[2]), 
                str(euler_angle[0]), str(euler_angle[1]), str(euler_angle[2]), 
                str(linear_acceleration[0]), str(linear_acceleration[1]), str(linear_acceleration[2]), 
                str(gravity_vector[0]), str(gravity_vector[1]), str(gravity_vector[2]),
                str(temperature), 
            ]

            csv_writer.writerow(row)
    except KeyboardInterrupt:
        pass
        
    ipcon.disconnect()
