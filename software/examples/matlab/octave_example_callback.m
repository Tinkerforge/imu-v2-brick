function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XXYYZZ"; % Change XXYYZZ to the UID of your IMU Brick 2.0

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    imu = java_new("com.tinkerforge.BrickIMUV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register quaternion callback to function cb_quaternion
    imu.addQuaternionCallback(@cb_quaternion);

    % Set period for quaternion callback to 0.1s (100ms)
    imu.setQuaternionPeriod(100);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for quaternion callback
function cb_quaternion(e)
    fprintf("w: %.2f, x: %.2f, y: %.2f, z: %.2f\n",
            java2int(e.w)/16383.0, java2int(e.x)/16383.0,
            java2int(e.y)/16383.0, java2int(e.z)/16383.0);
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
