unit Settings;

interface

uses
  Vcl.Graphics, System.Win.Registry;

type
  ISettingsReader = interface
    function GetDotMarkerColor(const Deafult: TColor = clRed): TColor;
    function GetDotMarkerStrokeWidth(const Default: integer = 2): integer;
    function GetDotMarkerStrokeLength(const Deafult: integer = 10): integer;
  end;

  ISettings = interface(ISettingsReader)
    procedure SetDotMarkerColor(const Value: TColor);
    procedure SetDotMarkerStrokeWidth(const Value: integer);
    procedure SetDotMarkerStrokeLength(const Value: integer);
  end;

  TSettingsRegistry = class(TInterfacedObject, ISettings)
  private
    FReg: TRegistry;
    FApplicationKey: string;
    function  ReadKeyValue(const KeyName: string; const ValueName: string; const Default: integer): integer;
    procedure WriteKeyValue(const KeyName: string; const ValueName: string; const Value: integer);
    //
  public
    constructor Create(const ApplicationKey: string);
    destructor  Destroy; override;
    //
    function GetDotMarkerColor(const Default: TColor): TColor;
    function GetDotMarkerStrokeWidth(const Default: integer): integer;
    function GetDotMarkerStrokeLength(const Default: integer): integer;
    //
    procedure SetDotMarkerColor(const Value: TColor);
    procedure SetDotMarkerStrokeWidth(const Value: integer);
    procedure SetDotMarkerStrokeLength(const Value: integer);
  end;

implementation

uses
  Windows;

{ TSettingsRegistry }

constructor TSettingsRegistry.Create(const ApplicationKey: string);
begin
  inherited Create;
  FApplicationKey:= ApplicationKey;
  FReg:= TRegistry.Create;
  // Default values
end;

destructor TSettingsRegistry.Destroy;
begin
  FReg.Free;
  inherited;
end;

function TSettingsRegistry.GetDotMarkerColor(const Default: TColor): TColor;
begin
  Result:= ReadKeyValue(FApplicationKey + 'DotMarker\', 'Color', Default);
end;

function TSettingsRegistry.GetDotMarkerStrokeLength(const Default: integer): integer;
begin
  Result:= ReadKeyValue(FApplicationKey + 'DotMarker\', 'StrokeLength', Default);
end;

function TSettingsRegistry.GetDotMarkerStrokeWidth(const Default: integer): integer;
begin
  Result:= ReadKeyValue(FApplicationKey + 'DotMarker\', 'StrokeWidth', Default);
end;

function TSettingsRegistry.ReadKeyValue(const KeyName: string;
  const ValueName: string;
  const Default: integer): integer;
var
  OpenResult: boolean;
begin
  Result:= Default;

  FReg.Access:= KEY_READ;

  OpenResult:= Freg.OpenKey(KeyName, False);

  if not OpenResult then
    Exit;

  try
    if FReg.KeyExists(ValueName) then
      Result:= FReg.ReadInteger(ValueName);
  finally
    FReg.CloseKey;
  end;
end;

procedure TSettingsRegistry.SetDotMarkerStrokeLength(const Value: integer);
begin
  WriteKeyValue(FApplicationKey + 'DotMarker\', 'StrokeLength', Value);
end;

procedure TSettingsRegistry.SetDotMarkerColor(const Value: TColor);
begin
  WriteKeyValue(FApplicationKey + 'DotMarker\', 'Color', Value);
end;

procedure TSettingsRegistry.SetDotMarkerStrokeWidth(const Value: integer);
begin
  WriteKeyValue(FApplicationKey + 'DotMarker\', 'StrokeWidth', Value);
end;

procedure TSettingsRegistry.WriteKeyValue(const KeyName, ValueName: string;
  const Value: integer);
var
  OpenResult: boolean;
begin
  FReg.Access:= KEY_WRITE;

  OpenResult:= Freg.OpenKey(KeyName, true);

  if not OpenResult then
    Exit;

  try
    FReg.WriteInteger(ValueName, Value);
  finally
    FReg.CloseKey;
  end;
end;

end.
