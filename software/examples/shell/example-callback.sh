#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XXYYZZ # Change to your UID

# Handle incoming quaternion callbacks
tinkerforge dispatch imu-v2-brick $uid quaternion &

# Set period for quaternion callback to 0.1s (100ms)
# Note: The quaternion callback is only called every 0.1 seconds
#       if the quaternion has changed since the last call!
tinkerforge call imu-v2-brick $uid set-quaternion-period 100

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
