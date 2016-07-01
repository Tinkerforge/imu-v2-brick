Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XXYYZZ" ' Change XXYYZZ to the UID of your IMU Brick 2.0

    ' Callback subroutine for quaternion callback
    Sub QuaternionCB(ByVal sender As BrickIMUV2, _
                     ByVal w As Short, ByVal x As Short, ByVal y As Short, ByVal z As Short)
        Dim s As String = "w: {0:F02}, x: {1:F02}, y: {2:F02}, z: {3:F02}"
        Console.WriteLine(String.Format(s, w/16383.0, x/16383.0, y/16383.0, z/16383.0))
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim imu As New BrickIMUV2(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register quaternion callback to subroutine QuaternionCB
        AddHandler imu.Quaternion, AddressOf QuaternionCB

        ' Set period for quaternion callback to 0.1s (100ms)
        ' Note: The quaternion callback is only called every 0.1 seconds
        '       if the quaternion has changed since the last call!
        imu.SetQuaternionPeriod(100)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
