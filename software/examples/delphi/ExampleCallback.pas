program ExampleCallback;

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
    procedure QuaternionCB(sender: TBrickIMUV2;
                           const w: smallint; const x: smallint;
                           const y: smallint; const z: smallint);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '6ww9bv'; { Change to your UID }

var
  e: TExample;
  qdiv: single;

{ Quaternion callback }
procedure TExample.QuaternionCB(sender: TBrickIMUV2;
                                const w: smallint; const x: smallint;
                                const y: smallint; const z: smallint);
begin
  qdiv := 16383;
  WriteLn(Format('w: %.2f, x: %.2f, y: %.2f, z: %.2f',
                 [w/qdiv, x/qdiv, y/qdiv, z/qdiv]));
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

  { Set period for quaternion callback to 100ms }
  imu.SetQuaternionPeriod(100);

  { Register "quaternion callback" to procedure QuaternionCB }
  imu.OnQuaternion := {$ifdef FPC}@{$endif}QuaternionCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
