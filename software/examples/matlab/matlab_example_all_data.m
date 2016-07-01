function matlab_example_all_data()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickIMUV2;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XXYYZZ'; % Change XXYYZZ to the UID of your IMU Brick 2.0

    ipcon = IPConnection(); % Create IP connection
    imu = handle(BrickIMUV2(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register all data callback to function cb_all_data
    set(imu, 'AllDataCallback', @(h, e) cb_all_data(e));

    % Set period for all data callback to 0.1s (100ms)
    % Note: The all data callback is only called every 0.1 seconds
    %       if the all data has changed since the last call!
    imu.setAllDataPeriod(100);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for all data callback
function cb_all_data(e)
    fprintf(strcat('Acceleration        x: %.02f y: %.02f z: %.02f m/s²\n', ...
                   'Magnetic Field      x: %.02f y: %.02f z: %.02f µT\n', ...
                   'Angular Velocity    x: %.02f y: %.02f z: %.02f °/s\n', ...
                   'Euler Angle         x: %.02f y: %.02f z: %.02f °\n', ...
                   'Quaternion          x: %.02f y: %.02f z: %.02f w: %.02f\n', ...
                   'Linear Acceleration x: %.02f y: %.02f z: %.02f m/s²\n', ...
                   'Gravity Vector      x: %.02f y: %.02f z: %.02f m/s²\n', ...
                   'Temperature         %d °C\n', ...
                   'Calibration Status  %s\n\n'), ...
            e.acceleration(1)/100.0,       e.acceleration(2)/100.0,       e.acceleration(3)/100.0, ...
            e.magneticField(1)/16.0,       e.magneticField(2)/16.0,       e.magneticField(3)/16.0, ...
            e.angularVelocity(1)/16.0,     e.angularVelocity(2)/16.0,     e.angularVelocity(3)/16.0, ...
            e.eulerAngle(1)/16.0,          e.eulerAngle(2)/16.0,          e.eulerAngle(3)/16.0, ...
            e.quaternion(2)/16383.0,       e.quaternion(3)/16383.0,       e.quaternion(4)/16383.0,       e.quaternion(1)/16383.0, ...
            e.linearAcceleration(1)/100.0, e.linearAcceleration(2)/100.0, e.linearAcceleration(3)/100.0, ...
            e.gravityVector(1)/100.0,      e.gravityVector(2)/100.0,      e.gravityVector(3)/100.0, ...
            e.temperature,
            dec2bin(e.calibrationStatus));
end
