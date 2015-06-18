Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "6ww9bv" ' Change to your UID

    ' Quaternion callback
    Sub QuaternionCB(ByVal sender As BrickIMUV2, _
                     ByVal w As Short, ByVal x As Short, ByVal y As Short, ByVal z As Short)
        Dim qdiv As Single
        qdiv = (1 << 14) - 1

        Dim s As String
        s = "w: {0:F02}, x: {1:F02}, y: {2:F02}, z: {3:F02}"

        System.Console.WriteLine(System.String.Format(s, w/qdiv, x/qdiv, y/qdiv, z/qdiv))
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim imu As New BrickIMUV2(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set period for quaternion callback to 100ms
        imu.SetQuaternionPeriod(100)

        ' Register quaternion callback to QuaternionCB
        AddHandler imu.Quaternion, AddressOf QuaternionCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
