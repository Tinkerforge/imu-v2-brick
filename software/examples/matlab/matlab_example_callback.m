function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickIMUV2;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XXYYZZ'; % Change XXYYZZ to the UID of your IMU Brick 2.0

    ipcon = IPConnection(); % Create IP connection
    imu = handle(BrickIMUV2(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register quaternion callback to function cb_quaternion
    set(imu, 'QuaternionCallback', @(h, e) cb_quaternion(e));

    % Set period for quaternion callback to 0.1s (100ms)
    imu.setQuaternionPeriod(100);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for quaternion callback
function cb_quaternion(e)
    fprintf('Quaternion [W]: %g\n', e.w/16383.0);
    fprintf('Quaternion [X]: %g\n', e.x/16383.0);
    fprintf('Quaternion [Y]: %g\n', e.y/16383.0);
    fprintf('Quaternion [Z]: %g\n', e.z/16383.0);
    fprintf('\n');
end
