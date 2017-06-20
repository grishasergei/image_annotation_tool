unit Annotation.Action;

interface

uses
  SuperObject, Vcl.Graphics, System.Types;

type

  IAnnotationAction = interface
    function    ToJSON(): ISuperObject;
    procedure   AddToJSONArray(var JSON: ISuperObject; const ArrayName: string);
    procedure   RenderOnMask(var MaskBitmap: TBitmap);
    procedure   RenderOnView(var ViewBitmap: TBitmap);
    function    GetJOSNTypeName: string;
    function    HistoryCaption: string;
  end;

  TEmptyAction = class(TInterfacedObject, IAnnotationAction)
    function    ToJSON(): ISuperObject;
    procedure   AddToJSONArray(var JSON: ISuperObject; const ArrayName: string); virtual;
    procedure   RenderOnMask(var MaskBitmap: TBitmap); virtual;
    procedure   RenderOnView(var ViewBitmap: TBitmap); virtual;
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
    procedure   RenderOnView(var ViewBitmap: TBitmap);
    function    GetJOSNTypeName: string;
    function    HistoryCaption: string;
  end;

  TAnnotationClear = class(TEmptyAction, IAnnotationAction)
  public
    procedure   AddToJSONArray(var JSON: ISuperObject; const ArrayName: string);  override;
    procedure   RenderOnMask(var MaskBitmap: TBitmap); override;
    procedure   RenderOnView(var ViewBitmap: TBitmap); override;
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

procedure TDotMarker.RenderOnView(var ViewBitmap: TBitmap);
var
  PenWidth,
  StrokeLength: integer;
begin
  PenWidth:= 2;
  StrokeLength:= 10;

  ViewBitmap.Canvas.Pen.Color:= clRed;
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

procedure TEmptyAction.RenderOnView(var ViewBitmap: TBitmap);
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

procedure TAnnotationClear.RenderOnView(var ViewBitmap: TBitmap);
begin
  ViewBitmap.Canvas.Brush.Color:= clBlack;
  ViewBitmap.Canvas.FillRect(Rect(0, 0, ViewBitmap.Width, ViewBitmap.Height));
end;

end.
