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

    % Set Period for quaternion callback to 1s (1000ms)
    % Note: The callback is only called every second if the 
    %       quaternion has changed since the last call!
    imu.setQuaternionPeriod(100);

    % Register quaternion callback to function cb_quaternion
    set(imu, 'QuaternionCallback', @(h, e) cb_quaternion(e));

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for quaternion callback
function cb_quaternion(e)
    fprintf('x: %f\ny: %f\nz: %f\nw: %f\n\n', e.x, e.y, e.z, e.w);
end
