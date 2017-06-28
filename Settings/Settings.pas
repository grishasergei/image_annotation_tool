unit Settings;

interface

uses
  Vcl.Graphics, System.Win.Registry, Generics.Defaults;

type

  TSavepathRelativeTo = (sprApplication, sprImage);

  ISettingsReader = interface
    function GetDotMarkerColor(const Deafult: TColor = clRed): TColor;
    function GetDotMarkerStrokeWidth(const Default: integer = 2): integer;
    function GetDotMarkerStrokeLength(const Deafult: integer = 10): integer;
    function GetSavepathRelativeTo(const Default: TSavepathRelativeTo = sprApplication): TSavepathRelativeTo;
    function GetSavePathForMarkers(const Default: string = 'markers\'): string;
    function GetSavePathForMasks(const Default: string = 'masks\'): string;
  end;

  ISettings = interface(ISettingsReader)
    procedure SetDotMarkerColor(const Value: TColor);
    procedure SetDotMarkerStrokeWidth(const Value: integer);
    procedure SetDotMarkerStrokeLength(const Value: integer);
    procedure SetSavepathRelativeTo(const Value: TSavepathRelativeTo);
    procedure SetSavePathForMarkers(const Value: string);
    procedure SetSavePathForMasks(const Value: string);
  end;

  TRegistryReadMethod<T> = function(const Name: string): T of object;
  TRegistryWriteMethod<T> = procedure(const Name: string; Value: T) of object;

  TSettingsRegistry = class(TInterfacedObject, ISettings)
  private
    FReg: TRegistry;
    FApplicationKey: string;
    function  ReadKeyValue<T>(const KeyName: string; const ValueName: string; const Default: T; ReadMethod: TRegistryReadMethod<T>): T;
    procedure WriteKeyValue<T>(const KeyName: string; const ValueName: string; const Value: T; WriteMethod: TRegistryWriteMethod<T>);
    //
    procedure WriteStringToReg(const Name: string; Value: string);
  public
    constructor Create(const ApplicationKey: string);
    destructor  Destroy; override;
    // Getters
    function GetDotMarkerColor(const Default: TColor): TColor;
    function GetDotMarkerStrokeWidth(const Default: integer): integer;
    function GetDotMarkerStrokeLength(const Default: integer): integer;
    function GetSavepathRelativeTo(const Default: TSavepathRelativeTo = sprApplication): TSavepathRelativeTo;
    function GetSavePathForMarkers(const Default: string = 'markers\'): string;
    function GetSavePathForMasks(const Default: string = 'masks\'): string;

    // Setters
    procedure SetDotMarkerColor(const Value: TColor);
    procedure SetDotMarkerStrokeWidth(const Value: integer);
    procedure SetDotMarkerStrokeLength(const Value: integer);
    procedure SetSavepathRelativeTo(const Value: TSavepathRelativeTo);
    procedure SetSavePathForMarkers(const Value: string);
    procedure SetSavePathForMasks(const Value: string);
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
  Result:= ReadKeyValue<integer>(FApplicationKey + 'DotMarker\',
                                 'Color',
                                 Default,
                                 FReg.ReadInteger);
end;

function TSettingsRegistry.GetDotMarkerStrokeLength(const Default: integer): integer;
begin
  Result:= ReadKeyValue<integer>(FApplicationKey + 'DotMarker\',
                                 'StrokeLength',
                                 Default,
                                 FReg.ReadInteger);
end;

function TSettingsRegistry.GetDotMarkerStrokeWidth(const Default: integer): integer;
begin
  Result:= ReadKeyValue<integer>(FApplicationKey + 'DotMarker\',
                                 'StrokeWidth',
                                 Default,
                                 FReg.ReadInteger);
end;

function TSettingsRegistry.GetSavePathForMarkers(const Default: string): string;
begin
  Result:= ReadKeyValue<string>(FApplicationKey + 'SavePaths\',
                                'Markers',
                                Default,
                                FReg.ReadString);
end;

function TSettingsRegistry.GetSavePathForMasks(const Default: string): string;
begin
  Result:= ReadKeyValue<string>(FApplicationKey + 'SavePaths\',
                                'Masks',
                                Default,
                                FReg.ReadString);
end;

function TSettingsRegistry.GetSavepathRelativeTo(
  const Default: TSavepathRelativeTo): TSavepathRelativeTo;
begin
  Result:= TSavepathRelativeTo(ReadKeyValue<integer>(FApplicationKey + 'SavePaths\',
                                                     'RelativeTo',
                                                     integer(Default),
                                                     FReg.ReadInteger));
end;

function TSettingsRegistry.ReadKeyValue<T>(const KeyName: string;
  const ValueName: string;
  const Default: T;
  ReadMethod: TRegistryReadMethod<T>): T;
var
  OpenResult: boolean;
begin
  Result:= Default;

  FReg.Access:= KEY_READ;

  OpenResult:= Freg.OpenKeyReadOnly(KeyName);

  if not OpenResult then
    Exit;

  try
    Result:= ReadMethod(ValueName);
  finally
    FReg.CloseKey;
  end;
end;

procedure TSettingsRegistry.SetDotMarkerStrokeLength(const Value: integer);
begin
  WriteKeyValue<integer>(FApplicationKey + 'DotMarker\', 'StrokeLength', Value, FReg.WriteInteger);
end;

procedure TSettingsRegistry.SetDotMarkerColor(const Value: TColor);
begin
  WriteKeyValue<integer>(FApplicationKey + 'DotMarker\', 'Color', Value, FReg.WriteInteger);
end;

procedure TSettingsRegistry.SetDotMarkerStrokeWidth(const Value: integer);
begin
  WriteKeyValue<integer>(FApplicationKey + 'DotMarker\', 'StrokeWidth', Value, FReg.WriteInteger);
end;

procedure TSettingsRegistry.SetSavePathForMarkers(const Value: string);
begin
  WriteKeyValue<string>(FApplicationKey + 'SavePaths\', 'Markers', Value, WriteStringToReg);
end;

procedure TSettingsRegistry.SetSavePathForMasks(const Value: string);
begin
  WriteKeyValue<string>(FApplicationKey + 'SavePaths\', 'Masks', Value, WriteStringToReg);
end;

procedure TSettingsRegistry.SetSavepathRelativeTo(
  const Value: TSavepathRelativeTo);
begin
  WriteKeyValue<integer>(FApplicationKey + 'SavePaths\', 'RelativeTo', integer(Value), FReg.WriteInteger);
end;

procedure TSettingsRegistry.WriteKeyValue<T>(const KeyName, ValueName: string;
  const Value: T;
  WriteMethod: TRegistryWriteMethod<T>);
var
  OpenResult: boolean;
begin
  FReg.Access:= KEY_WRITE;

  OpenResult:= Freg.OpenKey(KeyName, true);

  if not OpenResult then
    Exit;

  try
    WriteMethod(ValueName, Value);
  finally
    FReg.CloseKey;
  end;
end;

procedure TSettingsRegistry.WriteStringToReg(const Name: string; Value: string);
begin
  FReg.WriteString(Name, Value);
end;

end.
