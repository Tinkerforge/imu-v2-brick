Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XXYYZZ" ' Change XXYYZZ to the UID of your IMU Brick 2.0

    ' Callback subroutine for quaternion callback
    Sub QuaternionCB(ByVal sender As BrickIMUV2, ByVal w As Short, ByVal x As Short, _
                     ByVal y As Short, ByVal z As Short)
        Console.WriteLine("Quaternion [W]: " + (w/16383.0).ToString())
        Console.WriteLine("Quaternion [X]: " + (x/16383.0).ToString())
        Console.WriteLine("Quaternion [Y]: " + (y/16383.0).ToString())
        Console.WriteLine("Quaternion [Z]: " + (z/16383.0).ToString())
        Console.WriteLine("")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim imu As New BrickIMUV2(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register quaternion callback to subroutine QuaternionCB
        AddHandler imu.QuaternionCallback, AddressOf QuaternionCB

        ' Set period for quaternion callback to 0.1s (100ms)
        imu.SetQuaternionPeriod(100)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
