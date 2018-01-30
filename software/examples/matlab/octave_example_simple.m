function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XXYYZZ"; % Change XXYYZZ to the UID of your IMU Brick 2.0

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    imu = javaObject("com.tinkerforge.BrickIMUV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current quaternion
    quaternion = imu.getQuaternion();

    fprintf("Quaternion [W]: %g\n", java2int(quaternion.w)/16383.0);
    fprintf("Quaternion [X]: %g\n", java2int(quaternion.x)/16383.0);
    fprintf("Quaternion [Y]: %g\n", java2int(quaternion.y)/16383.0);
    fprintf("Quaternion [Z]: %g\n", java2int(quaternion.z)/16383.0);

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
