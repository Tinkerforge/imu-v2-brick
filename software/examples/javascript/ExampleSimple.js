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
        // Get current quaternion
        imu.getQuaternion(
            function (w, x, y, z) {
                var s =   'w: ' + (w/16383.0).toFixed(2) +
                        ', x: ' + (x/16383.0).toFixed(2) +
                        ', y: ' + (y/16383.0).toFixed(2) +
                        ', z: ' + (z/16383.0).toFixed(2);
                console.log(s);
            },
            function (error) {
                console.log('Error: ' + error);
            }
        );
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
