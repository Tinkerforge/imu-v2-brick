function octave_example_all_data()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XXYYZZ"; % Change XXYYZZ to the UID of your IMU Brick 2.0

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    imu = javaObject("com.tinkerforge.BrickIMUV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register all data callback to function cb_all_data
    imu.addAllDataCallback(@cb_all_data);

    % Set period for all data callback to 0.1s (100ms)
    imu.setAllDataPeriod(100);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for all data callback
function cb_all_data(e)
    fprintf("Acceleration [X]: %g m/s²\n", java2int(e.acceleration(1))/100.0);
    fprintf("Acceleration [Y]: %g m/s²\n", java2int(e.acceleration(2))/100.0);
    fprintf("Acceleration [Z]: %g m/s²\n", java2int(e.acceleration(3))/100.0);
    fprintf("Magnetic Field [X]: %g µT\n", java2int(e.magneticField(1))/16.0);
    fprintf("Magnetic Field [Y]: %g µT\n", java2int(e.magneticField(2))/16.0);
    fprintf("Magnetic Field [Z]: %g µT\n", java2int(e.magneticField(3))/16.0);
    fprintf("Angular Velocity [X]: %g °/s\n", java2int(e.angularVelocity(1))/16.0);
    fprintf("Angular Velocity [Y]: %g °/s\n", java2int(e.angularVelocity(2))/16.0);
    fprintf("Angular Velocity [Z]: %g °/s\n", java2int(e.angularVelocity(3))/16.0);
    fprintf("Euler Angle [X]: %g °\n", java2int(e.eulerAngle(1))/16.0);
    fprintf("Euler Angle [Y]: %g °\n", java2int(e.eulerAngle(2))/16.0);
    fprintf("Euler Angle [Z]: %g °\n", java2int(e.eulerAngle(3))/16.0);
    fprintf("Quaternion [W]: %g\n", java2int(e.quaternion(1))/16383.0);
    fprintf("Quaternion [X]: %g\n", java2int(e.quaternion(2))/16383.0);
    fprintf("Quaternion [Y]: %g\n", java2int(e.quaternion(3))/16383.0);
    fprintf("Quaternion [Z]: %g\n", java2int(e.quaternion(4))/16383.0);
    fprintf("Linear Acceleration [X]: %g m/s²\n", java2int(e.linearAcceleration(1))/100.0);
    fprintf("Linear Acceleration [Y]: %g m/s²\n", java2int(e.linearAcceleration(2))/100.0);
    fprintf("Linear Acceleration [Z]: %g m/s²\n", java2int(e.linearAcceleration(3))/100.0);
    fprintf("Gravity Vector [X]: %g m/s²\n", java2int(e.gravityVector(1))/100.0);
    fprintf("Gravity Vector [Y]: %g m/s²\n", java2int(e.gravityVector(2))/100.0);
    fprintf("Gravity Vector [Z]: %g m/s²\n", java2int(e.gravityVector(3))/100.0);
    fprintf("Temperature: %d °C\n", java2int(e.temperature));
    fprintf("Calibration Status: %s\n", dec2bin(java2int(e.calibrationStatus)));
    fprintf("\n");
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
