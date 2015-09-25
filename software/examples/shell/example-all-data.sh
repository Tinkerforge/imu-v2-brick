#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XXYYZZ # Change to your UID

# Handle incoming all data callbacks
tinkerforge dispatch imu-v2-brick $uid all-data &

# Set period for all data callback to 0.1s (100ms)
# Note: The all data callback is only called every 0.1 seconds
#       if the all data has changed since the last call!
tinkerforge call imu-v2-brick $uid set-all-data-period 100

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
