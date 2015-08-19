#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=6ww9bv

# get current quaternion
tinkerforge call imu-v2-brick $uid get-quaternion
