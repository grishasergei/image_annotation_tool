unit AnnotatedImage;

interface

uses
  Vcl.Graphics, System.Types, Generics.Collections,
  Superobject;

type

  TAnnotatedImage = class(TObject)
  private
    FBitmapImage: TBitmap;
    FBitmapMarkers: TBitmap;
    FMarkers:   TList<TPoint>;
    FName:      string;
    FIsChanged: boolean;
    procedure   DrawMarkerAt(const Point: TPoint);
    function    GetCombinedBitmap: TBitmap;
    procedure   CreateMarkersBitmap;
    function    GetHeight: integer;
    function    GetWidth: integer;
    function    GetMaskBitmap: TBitmap;
    function    GetMarkersJSON: ISuperObject;
  public
    constructor Create(const ImageBitmap: TBitmap; const Name: string); overload;
    constructor Create(const ImageGraphic: TGraphic; const Name: string); overload;
    destructor  Destroy; override;
    // properties
    property    ImageBitmap: TBitmap read FBitmapImage;
    property    MarkersBitmap: TBitmap read FBitmapMarkers;
    property    CombinedBitmap: TBitmap read GetCombinedBitmap;
    property    MaskBitmap: TBitmap read GetMaskBitmap;
    property    Markers: TList<TPoint> read FMarkers;
    property    Width: integer read GetWidth;
    property    Height: integer read GetHeight;
    property    Name: string read FName;
    property    MarkersJSON: ISuperObject read GetMarkersJSON;
    property    IsChanged: boolean read FIsChanged;
    // methods
    procedure   PutMarkerAt(const X, Y, ViewportWidth, ViewportHeight: integer);
    procedure   ClearMarkers;
    procedure   OnSaved;
  end;

implementation

uses
  Annotation.Utils, SysUtils;

{ TAnnotatedImage }

constructor TAnnotatedImage.Create(const ImageBitmap: TBitmap; const Name: string);
begin
  FBitmapImage:= TBitmap.Create;
  FBitmapImage.Assign(ImageBitmap);
  CreateMarkersBitmap;
  FMarkers:= TList<TPoint>.Create;
  FName:= Name;
  FIsChanged:= True;
end;

procedure TAnnotatedImage.ClearMarkers;
begin
  FMarkers.Clear;
  CreateMarkersBitmap;
end;

constructor TAnnotatedImage.Create(const ImageGraphic: TGraphic; const Name: string);
begin
  FBitmapImage:= TBitmap.Create;
  FBitmapImage.Assign(ImageGraphic);
  CreateMarkersBitmap;
  FMarkers:= TList<TPoint>.Create;
  FName:= Name;
  FIsChanged:= True;
end;

procedure TAnnotatedImage.CreateMarkersBitmap;
begin
  FBitmapMarkers:= TBitmap.Create;
  FBitmapMarkers.Assign(FBitmapImage);

  FBitmapMarkers.Transparent:= true;
  FBitmapMarkers.TransparentMode:= tmFixed;
  FBitmapMarkers.TransparentColor:= clBlack;

  FBitmapMarkers.Canvas.Brush.Color:= clBlack;
  FBitmapMarkers.Canvas.Brush.Style:= bsSolid;
  FBitmapMarkers.Canvas.FillRect(Rect(0, 0, FBitmapMarkers.Width, FBitmapMarkers.Height));
end;

destructor TAnnotatedImage.Destroy;
begin
  FBitmapImage.Free;
  FBitmapMarkers.Free;
  FMarkers.Free;
  inherited;
end;

procedure TAnnotatedImage.DrawMarkerAt(const Point: TPoint);
begin
  FBitmapMarkers.Canvas.Pen.Color:= clRed;
  FBitmapMarkers.Canvas.Pen.Width:= 2;

  FBitmapMarkers.Canvas.MoveTo(Point.X, Point.Y - 10);
  FBitmapMarkers.Canvas.LineTo(Point.X, Point.Y + 10);

  FBitmapMarkers.Canvas.MoveTo(Point.X - 10, Point.Y);
  FBitmapMarkers.Canvas.LineTo(Point.X +  10, Point.Y);
end;

function TAnnotatedImage.GetCombinedBitmap: TBitmap;
begin
  Result:= TBitmap.Create;
  Result.Assign(FBitmapImage);
  Result.Canvas.Draw(0, 0, FBitmapMarkers);
end;

function TAnnotatedImage.GetHeight: integer;
begin
  Result:= FBitmapImage.Width;
end;

function TAnnotatedImage.GetMarkersJSON: ISuperObject;
var
  Point: TPoint;
  PointJSON: ISuperObject;
begin

  Result:= SO;

  Result.O['markers']:= SA([]);

  for Point in FMarkers do
  begin
    PointJSON:= SO;
    PointJSON.I['x']:= Point.X;
    PointJSON.I['y']:= Point.Y;
    Result.A['markers'].Add(PointJSON);
  end;
end;

function TAnnotatedImage.GetMaskBitmap: TBitmap;
var
  Point: TPoint;
begin
  Result:= TBitmap.Create;
  Result.PixelFormat:= pf1bit;

  Result.Assign(FBitmapImage);
  Result.Canvas.Brush.Color:= clBlack;
  Result.Canvas.FillRect(Rect(0, 0, FBitmapImage.Width, FBitmapImage.Height));

  for Point in FMarkers do
    Result.Canvas.Pixels[Point.X, Point.Y]:= clWhite;
end;

function TAnnotatedImage.GetWidth: integer;
begin
  Result:= FBitmapImage.Height;
end;

procedure TAnnotatedImage.OnSaved;
begin
  FIsChanged:= False;
end;

procedure TAnnotatedImage.PutMarkerAt(const X, Y, ViewportWidth,
  ViewportHeight: integer);
var
  PointOnImage: TPoint;
begin
  if IsOnImage(TPoint.Create(X, Y), ViewportWidth, ViewportHeight, FBitmapImage.Width, FBitmapImage.Height) then
  begin
    PointOnImage:= ViewportToImage(TPoint.Create(X, Y),
                                   ViewportWidth, ViewportHeight,
                                   FBitmapImage.Width, FBitmapImage.Height);
    FMarkers.Add(PointOnImage);
    DrawMarkerAt(PointOnImage);
    FIsChanged:= True;
  end;

end;

end.
