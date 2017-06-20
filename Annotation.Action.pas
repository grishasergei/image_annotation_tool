unit Annotation.Action;

interface

uses
  SuperObject, Vcl.Graphics, System.Types, Settings;

type

  IAnnotationAction = interface
    function    ToJSON(): ISuperObject;
    procedure   AddToJSONArray(var JSON: ISuperObject; const ArrayName: string);
    procedure   RenderOnMask(var MaskBitmap: TBitmap);
    procedure   RenderOnView(var ViewBitmap: TBitmap; const Settings: ISettingsReader);
    function    GetJOSNTypeName: string;
    function    HistoryCaption: string;
  end;

  TEmptyAction = class(TInterfacedObject, IAnnotationAction)
    function    ToJSON(): ISuperObject;
    procedure   AddToJSONArray(var JSON: ISuperObject; const ArrayName: string); virtual;
    procedure   RenderOnMask(var MaskBitmap: TBitmap); virtual;
    procedure   RenderOnView(var ViewBitmap: TBitmap; const Settings: ISettingsReader); virtual;
    function    GetJOSNTypeName: string; virtual;
    function    HistoryCaption: string; virtual;
  end;

  TOriginalImageAction = class(TEmptyAction)
  public
    function    HistoryCaption: string; override;
  end;

  TDotMarker = class(TInterfacedObject, IAnnotationAction)
  private
    FX: integer;
    FY: integer;
  public
    constructor Create(const X, Y: integer); overload;
    constructor Create(const APoint: TPoint); overload;
    destructor  Destroy; override;

    property    X: integer read FX;
    property    Y: integer read FY;

    function    ToJSON(): ISuperObject;
    procedure   AddToJSONArray(var JSON: ISuperObject; const ArrayName: string);
    procedure   RenderOnMask(var MaskBitmap: TBitmap);
    procedure   RenderOnView(var ViewBitmap: TBitmap; const Settings: ISettingsReader);
    function    GetJOSNTypeName: string;
    function    HistoryCaption: string;
  end;

  TAnnotationClear = class(TEmptyAction, IAnnotationAction)
  public
    procedure   AddToJSONArray(var JSON: ISuperObject; const ArrayName: string);  override;
    procedure   RenderOnMask(var MaskBitmap: TBitmap); override;
    procedure   RenderOnView(var ViewBitmap: TBitmap; const Settings: ISettingsReader); override;
    function    HistoryCaption: string; override;
  end;

implementation

uses
  SysUtils;

{ TDotMarker }

constructor TDotMarker.Create(const X, Y: integer);
begin
  inherited Create;
  FX:= X;
  FY:= Y;
end;

procedure TDotMarker.AddToJSONArray(var JSON: ISuperObject; const ArrayName: string);
begin
  JSON.A[ArrayName].Add(ToJSON);
end;

constructor TDotMarker.Create(const APoint: TPoint);
begin
  Create(APoint.X, APoint.Y);
end;

destructor TDotMarker.Destroy;
begin

  inherited;
end;

function TDotMarker.GetJOSNTypeName: string;
begin
  Result:= 'dot_marker';
end;

function TDotMarker.HistoryCaption: string;
begin
  Result:= 'Dot marker at [' + IntToStr(X) + ', ' + IntToStr(Y) + ']';
end;

procedure TDotMarker.RenderOnMask(var MaskBitmap: TBitmap);
begin
  MaskBitmap.Canvas.Pixels[X, Y]:= clWhite;
end;

procedure TDotMarker.RenderOnView(var ViewBitmap: TBitmap; const Settings: ISettingsReader);
var
  PenWidth,
  StrokeLength: integer;
begin
  PenWidth:= Settings.GetDotMarkerStrokeWidth;
  StrokeLength:= Settings.GetDotMarkerStrokeLength;
  ViewBitmap.Canvas.Pen.Color:= Settings.GetDotMarkerColor;

  ViewBitmap.Canvas.Pen.Width:= PenWidth;

  ViewBitmap.Canvas.MoveTo(X, Y - StrokeLength);
  ViewBitmap.Canvas.LineTo(X, Y + StrokeLength);

  ViewBitmap.Canvas.MoveTo(X - StrokeLength, Y);
  ViewBitmap.Canvas.LineTo(X +  StrokeLength, Y);
end;

function TDotMarker.ToJSON(): ISuperObject;
begin
  Result:= SO;
  Result.S['type']:= GetJOSNTypeName;
  Result.I['x']:= X;
  Result.I['y']:= Y;
end;

{ TEmptyAction }

procedure TEmptyAction.AddToJSONArray(var JSON: ISuperObject; const ArrayName: string);
begin
  //
end;

function TEmptyAction.GetJOSNTypeName: string;
begin
  //
end;

function TEmptyAction.HistoryCaption: string;
begin
  Result:= 'Empty action';
end;

procedure TEmptyAction.RenderOnMask(var MaskBitmap: TBitmap);
begin
  //
end;

procedure TEmptyAction.RenderOnView(var ViewBitmap: TBitmap; const Settings: ISettingsReader);
begin
  //
end;

function TEmptyAction.ToJSON: ISuperObject;
begin
  Result:= SO;
end;

{ TOriginalImageAction }

function TOriginalImageAction.HistoryCaption: string;
begin
  Result:= 'Original image';
end;

{ TAnnotationClear }

procedure TAnnotationClear.AddToJSONArray(var JSON: ISuperObject;
  const ArrayName: string);
begin
  JSON.A[ArrayName].Clear(true);
end;

function TAnnotationClear.HistoryCaption: string;
begin
  Result:= 'Clear';
end;

procedure TAnnotationClear.RenderOnMask(var MaskBitmap: TBitmap);
begin
  MaskBitmap.Canvas.Brush.Color:= clBlack;
  MaskBitmap.Canvas.FillRect(Rect(0, 0, MaskBitmap.Width, MaskBitmap.Height));
end;

procedure TAnnotationClear.RenderOnView(var ViewBitmap: TBitmap; const Settings: ISettingsReader);
begin
  ViewBitmap.Canvas.Brush.Color:= clBlack;
  ViewBitmap.Canvas.FillRect(Rect(0, 0, ViewBitmap.Width, ViewBitmap.Height));
end;

end.
