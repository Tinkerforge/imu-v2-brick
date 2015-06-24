function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "6ww9bv"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    imu = java_new("com.tinkerforge.BrickIMUV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current quaternion
    q = imu.getQuaternion();
    fprintf("w: %.2f, x: %.2f, y: %.2f, z: %.2f\n",
            q.w/16383.0, q.x/16383.0, q.y/16383.0, q.z/16383.0);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end
