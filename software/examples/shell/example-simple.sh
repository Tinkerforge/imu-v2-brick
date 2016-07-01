#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XXYYZZ # Change XXYYZZ to the UID of your IMU Brick 2.0

# Get current quaternion
tinkerforge call imu-v2-brick $uid get-quaternion
