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

    % Set period for all data callback to 100ms
    imu.setAllDataPeriod(100);

    % Register all data callback to function cb_all_data
    set(imu, 'AllDataCallback', @(h, e) cb_all_data(e));

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for all data callback
function cb_all_data(e)
    fprintf(strcat('Acceleration        x: %.02f y: %.02f z: %.02f m/s²\n',
                   'Magnetic Field      x: %.02f y: %.02f z: %.02f µT\n',
                   'Angular Velocity    x: %.02f y: %.02f z: %.02f °/s\n',
                   'Euler Angle         x: %.02f y: %.02f z: %.02f °\n',
                   'Quaternion          x: %.02f y: %.02f z: %.02f w: %.02f\n',
                   'Linear Acceleration x: %.02f y: %.02f z: %.02f m/s²\n',
                   'Gravity Vector      x: %.02f y: %.02f z: %.02f m/s²\n',
                   'Temperature         %d °C\n',
                   'Calibration Status  %u\n\n'),
            e.acceleration[0]/100.0,       e.acceleration[1]/100.0,       e.acceleration[2]/100.0,
            e.magneticField[0]/16.0,       e.magneticField[1]/16.0,       e.magneticField[2]/16.0,
            e.angularVelocity[0]/16.0,     e.angularVelocity[1]/16.0,     e.angularVelocity[2]/16.0,
            e.eulerAngle[0]/16.0,          e.eulerAngle[1]/16.0,          e.eulerAngle[2]/16.0,
            e.quaternion[1]/16383.0,       e.quaternion[2]/16383.0,       e.quaternion[3]/16383.0,       e.quaternion[0]/16383.0,
            e.linearAcceleration[0]/100.0, e.linearAcceleration[1]/100.0, e.linearAcceleration[2]/100.0,
            e.gravityVector[0]/100.0,      e.gravityVector[1]/100.0,      e.gravityVector[2]/100.0,
            e.temperature, e.calibrationStatus);
end
