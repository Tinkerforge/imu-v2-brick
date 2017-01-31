#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XXYYZZ # Change XXYYZZ to the UID of your IMU Brick 2.0

# Handle incoming quaternion callbacks
tinkerforge dispatch imu-v2-brick $uid quaternion &

# Set period for quaternion callback to 0.1s (100ms)
tinkerforge call imu-v2-brick $uid set-quaternion-period 100

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
