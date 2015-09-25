#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XXYYZZ # Change to your UID

# Get current quaternion
tinkerforge call imu-v2-brick $uid get-quaternion
