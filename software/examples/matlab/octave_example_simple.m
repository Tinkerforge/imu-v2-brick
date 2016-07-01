function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XXYYZZ"; % Change XXYYZZ to the UID of your IMU Brick 2.0

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    imu = java_new("com.tinkerforge.BrickIMUV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current quaternion
    q = imu.getQuaternion();
    fprintf("w: %.2f, x: %.2f, y: %.2f, z: %.2f\n",
            java2int(q.w)/16383.0, java2int(q.x)/16383.0,
            java2int(q.y)/16383.0, java2int(q.z)/16383.0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
