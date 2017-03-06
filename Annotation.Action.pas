unit Annotation.Action;

interface

uses
  SuperObject, Vcl.Graphics, System.Types;

type

  IAnnotationAction = interface
    function    ToJSON(): ISuperObject;
    procedure   RenderOnMask(var MaskBitmap: TBitmap);
    procedure   RenderOnView(var ViewBitmap: TBitmap);
    function    GetJOSNTypeName: string;
    function    HistoryCaption: string;
  end;

  TEmptyAction = class(TInterfacedObject, IAnnotationAction)
    function    ToJSON(): ISuperObject;
    procedure   RenderOnMask(var MaskBitmap: TBitmap);
    procedure   RenderOnView(var ViewBitmap: TBitmap);
    function    GetJOSNTypeName: string;
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
    procedure   RenderOnMask(var MaskBitmap: TBitmap);
    procedure   RenderOnView(var ViewBitmap: TBitmap);
    function    GetJOSNTypeName: string;
    function    HistoryCaption: string;
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
begin
  ViewBitmap.Canvas.Pen.Color:= clRed;
  ViewBitmap.Canvas.Pen.Width:= 2;

  ViewBitmap.Canvas.MoveTo(X, Y - 10);
  ViewBitmap.Canvas.LineTo(X, Y + 10);

  ViewBitmap.Canvas.MoveTo(X - 10, Y);
  ViewBitmap.Canvas.LineTo(X +  10, Y);
end;

function TDotMarker.ToJSON(): ISuperObject;
begin
  Result:= SO;
  Result.S['type']:= GetJOSNTypeName;
  Result.I['x']:= X;
  Result.I['y']:= Y;
end;

{ TEmptyAction }

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

end.
