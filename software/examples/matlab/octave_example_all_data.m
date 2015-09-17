function octave_example_all_data()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "6ww9bv"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    imu = java_new("com.tinkerforge.BrickIMUV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don"t use device before ipcon is connected

    % Set period for all data callback to 100ms
    imu.setAllDataPeriod(100);

    % Register all data callback to function cb_all_data
    imu.addAllDataCallback(@cb_all_data);

    input("Press any key to exit...\n", "s");
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
            short2int(acceleration(1))/100.0,       short2int(acceleration(2))/100.0,       short2int(acceleration(3))/100.0,
            short2int(magneticField(1))/16.0,       short2int(magneticField(2))/16.0,       short2int(magneticField(3))/16.0,
            short2int(angularVelocity(1))/16.0,     short2int(angularVelocity(2))/16.0,     short2int(angularVelocity(3))/16.0,
            short2int(eulerAngle(1))/16.0,          short2int(eulerAngle(2))/16.0,          short2int(eulerAngle(3))/16.0,
            short2int(quaternion(2))/16383.0,       short2int(quaternion(3))/16383.0,       short2int(quaternion(4))/16383.0,       short2int(quaternion(1))/16383.0,
            short2int(linearAcceleration(1))/100.0, short2int(linearAcceleration(2))/100.0, short2int(linearAcceleration(3))/100.0,
            short2int(gravityVector(1))/100.0,      short2int(gravityVector(2))/100.0,      short2int(gravityVector(3))/100.0,
            byte2int(e.temperature), dec2bin(short2int(e.calibrationStatus)));
end

function int = short2int(short)
    if compare_versions(version(), "3.8", "<=")
        int = short.intValue();
    else
        int = short;
    end
end

function int = byte2int(byte)
    if compare_versions(version(), "3.8", "<=")
        int = byte.intValue();
    else
        int = byte;
    end
end
