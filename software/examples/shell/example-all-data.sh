#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=6ww9bv

# set period for all data callback to 100ms
tinkerforge call imu-v2-brick $uid set-all-data-period 100

# handle incoming all data callbacks
tinkerforge dispatch imu-v2-brick $uid all-data
