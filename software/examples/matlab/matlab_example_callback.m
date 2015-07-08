function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickIMUV2;

    HOST = 'localhost';
    PORT = 4223;
    UID = '6ww9bv'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    imu = BrickIMUV2(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set period for quaternion callback to 100ms
    imu.setQuaternionPeriod(100);

    % Register quaternion callback to function cb_quaternion
    set(imu, 'QuaternionCallback', @(h, e) cb_quaternion(e));

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for quaternion callback
function cb_quaternion(e)
    fprintf('x: %.2f, y: %.2f, z: %.2f, w: %.2f\n', ...
            e.x/16383.0, e.y/16383.0, e.z/16383.0, e.w/16383.0);
end
