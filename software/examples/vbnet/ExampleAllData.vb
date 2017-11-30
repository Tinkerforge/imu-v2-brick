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
        Dim s As String = "Acceleration        x: {0:F02} y: {1:F02} z: {2:F02} m/s²" + CHR(10) + _
                          "Magnetic Field      x: {3:F02} y: {4:F02} z: {5:F02} µT" + CHR(10) + _
                          "Angular Velocity    x: {6:F02} y: {7:F02} z: {8:F02} °/s" + CHR(10) + _
                          "Euler Angle         x: {9:F02} y: {10:F02} z: {11:F02} °" + CHR(10) + _
                          "Quaternion          x: {12:F02} y: {13:F02} z: {14:F02} w: {15:F02}" + CHR(10) + _
                          "Linear Acceleration x: {16:F02} y: {17:F02} z: {18:F02} m/s²" + CHR(10) + _
                          "Gravity Vector      x: {19:F02} y: {20:F02} z: {21:F02} m/s²" + CHR(10) + _
                          "Temperature         {22} °C" + CHR(10) + _
                          "Calibration Status  {23}" + CHR(10)
        Dim o As Object() = {acceleration(0)/100.0,       acceleration(1)/100.0,       acceleration(2)/100.0, _
                             magneticField(0)/16.0,       magneticField(1)/16.0,       magneticField(2)/16.0, _
                             angularVelocity(0)/16.0,     angularVelocity(1)/16.0,     angularVelocity(2)/16.0, _
                             eulerAngle(0)/16.0,          eulerAngle(1)/16.0,          eulerAngle(2)/16.0, _
                             quaternion(1)/16383.0,       quaternion(2)/16383.0,       quaternion(3)/16383.0,       quaternion(0)/16383.0, _
                             linearAcceleration(0)/100.0, linearAcceleration(1)/100.0, linearAcceleration(2)/100.0, _
                             gravityVector(0)/100.0,      gravityVector(1)/100.0,      gravityVector(2)/100.0, _
                             temperature,
                             Convert.ToString(calibrationStatus, 2)}
        Console.WriteLine(String.Format(s, o))
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
