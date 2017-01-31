#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XXYYZZ # Change XXYYZZ to the UID of your IMU Brick 2.0

# Handle incoming all data callbacks
tinkerforge dispatch imu-v2-brick $uid all-data &

# Set period for all data callback to 0.1s (100ms)
tinkerforge call imu-v2-brick $uid set-all-data-period 100

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
