var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XXYYZZ'; // Change XXYYZZ to the UID of your IMU Brick 2.0

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var imu = new Tinkerforge.BrickIMUV2(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Set period for all data callback to 0.1s (100ms)
        imu.setAllDataPeriod(100);
    }
);

// Register all data callback
imu.on(Tinkerforge.BrickIMUV2.CALLBACK_ALL_DATA,
    // Callback function for all data callback
    function (acceleration, magneticField, angularVelocity, eulerAngle, quaternion,
              linearAcceleration, gravityVector, temperature, calibrationStatus) {
        var s = 'Acceleration        x: ' + (acceleration[0]/100.0).toFixed(2) +
                                   ' y: ' + (acceleration[1]/100.0).toFixed(2) +
                                   ' z: ' + (acceleration[2]/100.0).toFixed(2) + ' m/s²\n' +
                'Magnetic Field      x: ' + (magneticField[0]/16.0).toFixed(2) +
                                   ' y: ' + (magneticField[1]/16.0).toFixed(2) +
                                   ' z: ' + (magneticField[2]/16.0).toFixed(2) + ' µT\n' +
                'Angular Velocity    x: ' + (angularVelocity[0]/16.0).toFixed(2) +
                                   ' y: ' + (angularVelocity[1]/16.0).toFixed(2) +
                                   ' z: ' + (angularVelocity[2]/16.0).toFixed(2) + ' °/s\n' +
                'Euler Angle         x: ' + (eulerAngle[0]/16.0).toFixed(2) +
                                   ' y: ' + (eulerAngle[1]/16.0).toFixed(2) +
                                   ' z: ' + (eulerAngle[2]/16.0).toFixed(2) + ' °\n' +
                'Quaternion          x: ' + (quaternion[1]/16383.0).toFixed(2) +
                                   ' y: ' + (quaternion[2]/16383.0).toFixed(2) +
                                   ' z: ' + (quaternion[3]/16383.0).toFixed(2) +
                                   ' w: ' + (quaternion[0]/16383.0).toFixed(2) + '\n' +
                'Linear Acceleration x: ' + (linearAcceleration[0]/100.0).toFixed(2) +
                                   ' y: ' + (linearAcceleration[1]/100.0).toFixed(2) +
                                   ' z: ' + (linearAcceleration[2]/100.0).toFixed(2) + ' m/s²\n' +
                'Gravity Vector      x: ' + (gravityVector[0]/100.0).toFixed(2) +
                                   ' y: ' + (gravityVector[1]/100.0).toFixed(2) +
                                   ' z: ' + (gravityVector[2]/100.0).toFixed(2) + ' m/s²\n' +
                'Temperature         ' + temperature + ' °C\n' +
                'Calibration Status  ' + calibrationStatus.toString(2) + '\n';
        console.log(s);
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
