Imports System
Imports Tinkerforge

Module ExampleAllData
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XXYYZZ" ' Change XXYYZZ to the UID of your IMU Brick 2.0

    ' Callback subroutine for all data callback
    Sub AllDataCB(ByVal sender As BrickIMUV2, ByVal acceleration As Short(), _
                  ByVal magneticField As Short(), ByVal angularVelocity As Short(), _
                  ByVal eulerAngle As Short(), ByVal quaternion As Short(), _
                  ByVal linearAcceleration As Short(), ByVal gravityVector As Short(), _
                  ByVal temperature As Short, ByVal calibrationStatus As Byte)
        Console.WriteLine("Acceleration [X]: " + (acceleration(0)/100.0).ToString() + " m/s²")
        Console.WriteLine("Acceleration [Y]: " + (acceleration(1)/100.0).ToString() + " m/s²")
        Console.WriteLine("Acceleration [Z]: " + (acceleration(2)/100.0).ToString() + " m/s²")
        Console.WriteLine("Magnetic Field [X]: " + (magneticField(0)/16.0).ToString() + " µT")
        Console.WriteLine("Magnetic Field [Y]: " + (magneticField(1)/16.0).ToString() + " µT")
        Console.WriteLine("Magnetic Field [Z]: " + (magneticField(2)/16.0).ToString() + " µT")
        Console.WriteLine("Angular Velocity [X]: " + (angularVelocity(0)/16.0).ToString() + " °/s")
        Console.WriteLine("Angular Velocity [Y]: " + (angularVelocity(1)/16.0).ToString() + " °/s")
        Console.WriteLine("Angular Velocity [Z]: " + (angularVelocity(2)/16.0).ToString() + " °/s")
        Console.WriteLine("Euler Angle [X]: " + (eulerAngle(0)/16.0).ToString() + " °")
        Console.WriteLine("Euler Angle [Y]: " + (eulerAngle(1)/16.0).ToString() + " °")
        Console.WriteLine("Euler Angle [Z]: " + (eulerAngle(2)/16.0).ToString() + " °")
        Console.WriteLine("Quaternion [W]: " + (quaternion(0)/16383.0).ToString())
        Console.WriteLine("Quaternion [X]: " + (quaternion(1)/16383.0).ToString())
        Console.WriteLine("Quaternion [Y]: " + (quaternion(2)/16383.0).ToString())
        Console.WriteLine("Quaternion [Z]: " + (quaternion(3)/16383.0).ToString())
        Console.WriteLine("Linear Acceleration [X]: " + (linearAcceleration(0)/100.0).ToString() + " m/s²")
        Console.WriteLine("Linear Acceleration [Y]: " + (linearAcceleration(1)/100.0).ToString() + " m/s²")
        Console.WriteLine("Linear Acceleration [Z]: " + (linearAcceleration(2)/100.0).ToString() + " m/s²")
        Console.WriteLine("Gravity Vector [X]: " + (gravityVector(0)/100.0).ToString() + " m/s²")
        Console.WriteLine("Gravity Vector [Y]: " + (gravityVector(1)/100.0).ToString() + " m/s²")
        Console.WriteLine("Gravity Vector [Z]: " + (gravityVector(2)/100.0).ToString() + " m/s²")
        Console.WriteLine("Temperature: " + temperature.ToString() + " °C")
        Console.WriteLine("Calibration Status: " + Convert.ToString(calibrationStatus, 2))
        Console.WriteLine("")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim imu As New BrickIMUV2(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register all data callback to subroutine AllDataCB
        AddHandler imu.AllDataCallback, AddressOf AllDataCB

        ' Set period for all data callback to 0.1s (100ms)
        imu.SetAllDataPeriod(100)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
