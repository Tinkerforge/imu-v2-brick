function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickIMUV2;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XXYYZZ'; % Change XXYYZZ to the UID of your IMU Brick 2.0

    ipcon = IPConnection(); % Create IP connection
    imu = handle(BrickIMUV2(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current quaternion
    q = imu.getQuaternion();
    fprintf('w: %.2f, x: %.2f, y: %.2f, z: %.2f\n', ...
            q.w/16383.0, q.x/16383.0, q.y/16383.0, q.z/16383.0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
