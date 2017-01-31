program ExampleAllData;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickIMUV2;

type
  TExample = class
  private
    ipcon: TIPConnection;
    imu: TBrickIMUV2;
  public
    procedure AllDataCB(sender: TBrickIMUV2;
                        const acceleration: TArray0To2OfInt16;
                        const magneticField: TArray0To2OfInt16;
                        const angularVelocity: TArray0To2OfInt16;
                        const eulerAngle: TArray0To2OfInt16;
                        const quaternion: TArray0To3OfInt16;
                        const linearAcceleration: TArray0To2OfInt16;
                        const gravityVector: TArray0To2OfInt16;
                        const temperature: shortint;
                        const calibrationStatus: byte);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XXYYZZ'; { Change XXYYZZ to the UID of your IMU Brick 2.0 }

var
  e: TExample;

{ Callback procedure for all data callback }
procedure TExample.AllDataCB(sender: TBrickIMUV2;
                             const acceleration: TArray0To2OfInt16;
                             const magneticField: TArray0To2OfInt16;
                             const angularVelocity: TArray0To2OfInt16;
                             const eulerAngle: TArray0To2OfInt16;
                             const quaternion: TArray0To3OfInt16;
                             const linearAcceleration: TArray0To2OfInt16;
                             const gravityVector: TArray0To2OfInt16;
                             const temperature: shortint;
                             const calibrationStatus: byte);
begin
  WriteLn(Format('Acceleration        x: %.02f y: %.02f z: %.02f m/s²'#10 +
                 'Magnetic Field      x: %.02f y: %.02f z: %.02f µT'#10 +
                 'Angular Velocity    x: %.02f y: %.02f z: %.02f °/s'#10 +
                 'Euler Angle         x: %.02f y: %.02f z: %.02f °'#10 +
                 'Quaternion          x: %.02f y: %.02f z: %.02f w: %.02f'#10 +
                 'Linear Acceleration x: %.02f y: %.02f z: %.02f m/s²'#10 +
                 'Gravity Vector      x: %.02f y: %.02f z: %.02f m/s²'#10 +
                 'Temperature         %d °C'#10 +
                 'Calibration Status  %d'#10,
                 [acceleration[0]/100.0,       acceleration[1]/100.0,       acceleration[2]/100.0,
                  magneticField[0]/16.0,       magneticField[1]/16.0,       magneticField[2]/16.0,
                  angularVelocity[0]/16.0,     angularVelocity[1]/16.0,     angularVelocity[2]/16.0,
                  eulerAngle[0]/16.0,          eulerAngle[1]/16.0,          eulerAngle[2]/16.0,
                  quaternion[1]/16383.0,       quaternion[2]/16383.0,       quaternion[3]/16383.0,       quaternion[0]/16383.0,
                  linearAcceleration[0]/100.0, linearAcceleration[1]/100.0, linearAcceleration[2]/100.0,
                  gravityVector[0]/100.0,      gravityVector[1]/100.0,      gravityVector[2]/100.0,
                  temperature,
                  calibrationStatus]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  imu := TBrickIMUV2.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Register all data callback to procedure AllDataCB }
  imu.OnAllData := {$ifdef FPC}@{$endif}AllDataCB;

  { Set period for all data callback to 0.1s (100ms) }
  imu.SetAllDataPeriod(100);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
