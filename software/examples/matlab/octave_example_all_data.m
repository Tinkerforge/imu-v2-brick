function octave_example_all_data()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XXYYZZ"; % Change XXYYZZ to the UID of your IMU Brick 2.0

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    imu = java_new("com.tinkerforge.BrickIMUV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register all data callback to function cb_all_data
    imu.addAllDataCallback(@cb_all_data);

    % Set period for all data callback to 0.1s (100ms)
    % Note: The all data callback is only called every 0.1 seconds
    %       if the all data has changed since the last call!
    imu.setAllDataPeriod(100);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for all data callback
function cb_all_data(e)
    acceleration = e.acceleration;
    magneticField = e.magneticField;
    angularVelocity = e.angularVelocity;
    eulerAngle = e.eulerAngle;
    quaternion = e.quaternion;
    linearAcceleration = e.linearAcceleration;
    gravityVector = e.gravityVector;

    fprintf(strcat("Acceleration        x: %.02f y: %.02f z: %.02f m/s²\n",
                   "Magnetic Field      x: %.02f y: %.02f z: %.02f µT\n",
                   "Angular Velocity    x: %.02f y: %.02f z: %.02f °/s\n",
                   "Euler Angle         x: %.02f y: %.02f z: %.02f °\n",
                   "Quaternion          x: %.02f y: %.02f z: %.02f w: %.02f\n",
                   "Linear Acceleration x: %.02f y: %.02f z: %.02f m/s²\n",
                   "Gravity Vector      x: %.02f y: %.02f z: %.02f m/s²\n",
                   "Temperature         %d °C\n",
                   "Calibration Status  %s\n\n"),
            java2int(acceleration(1))/100.0,       java2int(acceleration(2))/100.0,       java2int(acceleration(3))/100.0,
            java2int(magneticField(1))/16.0,       java2int(magneticField(2))/16.0,       java2int(magneticField(3))/16.0,
            java2int(angularVelocity(1))/16.0,     java2int(angularVelocity(2))/16.0,     java2int(angularVelocity(3))/16.0,
            java2int(eulerAngle(1))/16.0,          java2int(eulerAngle(2))/16.0,          java2int(eulerAngle(3))/16.0,
            java2int(quaternion(2))/16383.0,       java2int(quaternion(3))/16383.0,       java2int(quaternion(4))/16383.0,       java2int(quaternion(1))/16383.0,
            java2int(linearAcceleration(1))/100.0, java2int(linearAcceleration(2))/100.0, java2int(linearAcceleration(3))/100.0,
            java2int(gravityVector(1))/100.0,      java2int(gravityVector(2))/100.0,      java2int(gravityVector(3))/100.0,
            java2int(e.temperature),
            dec2bin(java2int(e.calibrationStatus)));
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
