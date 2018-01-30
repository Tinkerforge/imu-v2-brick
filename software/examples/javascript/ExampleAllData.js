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
        console.log('Acceleration [X]: ' + acceleration[0]/100.0 + ' m/s²');
        console.log('Acceleration [Y]: ' + acceleration[1]/100.0 + ' m/s²');
        console.log('Acceleration [Z]: ' + acceleration[2]/100.0 + ' m/s²');
        console.log('Magnetic Field [X]: ' + magneticField[0]/16.0 + ' µT');
        console.log('Magnetic Field [Y]: ' + magneticField[1]/16.0 + ' µT');
        console.log('Magnetic Field [Z]: ' + magneticField[2]/16.0 + ' µT');
        console.log('Angular Velocity [X]: ' + angularVelocity[0]/16.0 + ' °/s');
        console.log('Angular Velocity [Y]: ' + angularVelocity[1]/16.0 + ' °/s');
        console.log('Angular Velocity [Z]: ' + angularVelocity[2]/16.0 + ' °/s');
        console.log('Euler Angle [X]: ' + eulerAngle[0]/16.0 + ' °');
        console.log('Euler Angle [Y]: ' + eulerAngle[1]/16.0 + ' °');
        console.log('Euler Angle [Z]: ' + eulerAngle[2]/16.0 + ' °');
        console.log('Quaternion [W]: ' + quaternion[0]/16383.0);
        console.log('Quaternion [X]: ' + quaternion[1]/16383.0);
        console.log('Quaternion [Y]: ' + quaternion[2]/16383.0);
        console.log('Quaternion [Z]: ' + quaternion[3]/16383.0);
        console.log('Linear Acceleration [X]: ' + linearAcceleration[0]/100.0 + ' m/s²');
        console.log('Linear Acceleration [Y]: ' + linearAcceleration[1]/100.0 + ' m/s²');
        console.log('Linear Acceleration [Z]: ' + linearAcceleration[2]/100.0 + ' m/s²');
        console.log('Gravity Vector [X]: ' + gravityVector[0]/100.0 + ' m/s²');
        console.log('Gravity Vector [Y]: ' + gravityVector[1]/100.0 + ' m/s²');
        console.log('Gravity Vector [Z]: ' + gravityVector[2]/100.0 + ' m/s²');
        console.log('Temperature: ' + temperature + ' °C');
        console.log('Calibration Status: ' + calibrationStatus.toString(2));
        console.log();
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
