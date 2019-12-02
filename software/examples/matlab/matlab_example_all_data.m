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
    imu.setAllDataPeriod(100);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for all data callback
function cb_all_data(e)
    fprintf('Acceleration [X]: %g m/s²\n', e.acceleration(1)/100.0);
    fprintf('Acceleration [Y]: %g m/s²\n', e.acceleration(2)/100.0);
    fprintf('Acceleration [Z]: %g m/s²\n', e.acceleration(3)/100.0);
    fprintf('Magnetic Field [X]: %g µT\n', e.magneticField(1)/16.0);
    fprintf('Magnetic Field [Y]: %g µT\n', e.magneticField(2)/16.0);
    fprintf('Magnetic Field [Z]: %g µT\n', e.magneticField(3)/16.0);
    fprintf('Angular Velocity [X]: %g °/s\n', e.angularVelocity(1)/16.0);
    fprintf('Angular Velocity [Y]: %g °/s\n', e.angularVelocity(2)/16.0);
    fprintf('Angular Velocity [Z]: %g °/s\n', e.angularVelocity(3)/16.0);
    fprintf('Euler Angle [Heading]: %g °\n', e.eulerAngle(1)/16.0);
    fprintf('Euler Angle [Roll]: %g °\n', e.eulerAngle(2)/16.0);
    fprintf('Euler Angle [Pitch]: %g °\n', e.eulerAngle(3)/16.0);
    fprintf('Quaternion [W]: %g\n', e.quaternion(1)/16383.0);
    fprintf('Quaternion [X]: %g\n', e.quaternion(2)/16383.0);
    fprintf('Quaternion [Y]: %g\n', e.quaternion(3)/16383.0);
    fprintf('Quaternion [Z]: %g\n', e.quaternion(4)/16383.0);
    fprintf('Linear Acceleration [X]: %g m/s²\n', e.linearAcceleration(1)/100.0);
    fprintf('Linear Acceleration [Y]: %g m/s²\n', e.linearAcceleration(2)/100.0);
    fprintf('Linear Acceleration [Z]: %g m/s²\n', e.linearAcceleration(3)/100.0);
    fprintf('Gravity Vector [X]: %g m/s²\n', e.gravityVector(1)/100.0);
    fprintf('Gravity Vector [Y]: %g m/s²\n', e.gravityVector(2)/100.0);
    fprintf('Gravity Vector [Z]: %g m/s²\n', e.gravityVector(3)/100.0);
    fprintf('Temperature: %i °C\n', e.temperature);
    fprintf('Calibration Status: %s\n', dec2bin(e.calibrationStatus));
    fprintf('\n');
end
