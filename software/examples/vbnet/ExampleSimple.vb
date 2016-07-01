Imports System
Imports Tinkerforge

Module ExampleSimple
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XXYYZZ" ' Change XXYYZZ to the UID of your IMU Brick 2.0

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim imu As New BrickIMUV2(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get current quaternion
        Dim w As Short
        Dim x As Short
        Dim y As Short
        Dim z As Short

        imu.GetQuaternion(w, x, y, z)

        Dim s As String = "w: {0:F02}, x: {1:F02}, y: {2:F02}, z: {3:F02}"
        Console.WriteLine(String.Format(s, w/16383.0, x/16383.0, y/16383.0, z/16383.0))

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
