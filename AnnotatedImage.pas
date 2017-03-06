unit AnnotatedImage;

interface

uses
  Vcl.Graphics, System.Types, Generics.Collections,
  Superobject, Annotation.Action;

type

  TAnnotatedImage = class(TObject)
  private
    FBitmapImage: TBitmap;
    FBitmapAnnotationActions: TBitmap;
    FAnnotationActions: TList<IAnnotationAction>;
    FName:      string;
    FIsChanged: boolean;
    function    GetCombinedBitmap: TBitmap;
    procedure   CreateAnnotationActionsBitmap;
    function    GetHeight: integer;
    function    GetWidth: integer;
    function    GetMaskBitmap: TBitmap;
    function    GetAnnotationActionsJSON: ISuperObject;
  public
    constructor Create(const ImageBitmap: TBitmap; const Name: string); overload;
    constructor Create(const ImageGraphic: TGraphic; const Name: string); overload;
    destructor  Destroy; override;
    // properties
    property    ImageBitmap: TBitmap read FBitmapImage;
    property    AnnotationActionsBitmap: TBitmap read FBitmapAnnotationActions;
    property    CombinedBitmap: TBitmap read GetCombinedBitmap;
    property    MaskBitmap: TBitmap read GetMaskBitmap;
    property    AnnotationActions: TList<IAnnotationAction> read FAnnotationActions;
    property    Width: integer read GetWidth;
    property    Height: integer read GetHeight;
    property    Name: string read FName;
    property    AnnotationActionsJSON: ISuperObject read GetAnnotationActionsJSON;
    property    IsChanged: boolean read FIsChanged;
    // methods
    procedure   PutDotMarkerAt(const X, Y, ViewportWidth, ViewportHeight: integer);
    procedure   ClearAnnotationActions;
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
  CreateAnnotationActionsBitmap;
  FAnnotationActions:= Tlist<IAnnotationAction>.Create;
  FName:= Name;
  FIsChanged:= True;
end;

procedure TAnnotatedImage.ClearAnnotationActions;
begin
  FAnnotationActions.Clear;
  CreateAnnotationActionsBitmap;
end;

constructor TAnnotatedImage.Create(const ImageGraphic: TGraphic; const Name: string);
begin
  FBitmapImage:= TBitmap.Create;
  FBitmapImage.Assign(ImageGraphic);
  CreateAnnotationActionsBitmap;
  FAnnotationActions:= TList<IAnnotationAction>.Create;
  FName:= Name;
  FIsChanged:= True;
end;

procedure TAnnotatedImage.CreateAnnotationActionsBitmap;
begin
  FBitmapAnnotationActions:= TBitmap.Create;
  FBitmapAnnotationActions.Assign(FBitmapImage);

  FBitmapAnnotationActions.Transparent:= true;
  FBitmapAnnotationActions.TransparentMode:= tmFixed;
  FBitmapAnnotationActions.TransparentColor:= clBlack;

  FBitmapAnnotationActions.Canvas.Brush.Color:= clBlack;
  FBitmapAnnotationActions.Canvas.Brush.Style:= bsSolid;
  FBitmapAnnotationActions.Canvas.FillRect(Rect(0, 0, FBitmapAnnotationActions.Width, FBitmapAnnotationActions.Height));
end;

destructor TAnnotatedImage.Destroy;
begin
  FBitmapImage.Free;
  FBitmapAnnotationActions.Free;
  FAnnotationActions.Free;
  inherited;
end;

function TAnnotatedImage.GetCombinedBitmap: TBitmap;
begin
  Result:= TBitmap.Create;
  Result.Assign(FBitmapImage);
  Result.Canvas.Draw(0, 0, FBitmapAnnotationActions);
end;

function TAnnotatedImage.GetHeight: integer;
begin
  Result:= FBitmapImage.Width;
end;

function TAnnotatedImage.GetAnnotationActionsJSON: ISuperObject;
var
  AnnotationAction: IAnnotationAction;
begin
  Result:= SO;
  Result.O['annotations']:= SA([]);

  for AnnotationAction in FAnnotationActions do
    Result.A['annotations'].Add(AnnotationAction.ToJSON);
end;

function TAnnotatedImage.GetMaskBitmap: TBitmap;
var
  AnnotationAction: IAnnotationAction;
begin
  Result:= TBitmap.Create;
  Result.PixelFormat:= pf1bit;

  Result.Assign(FBitmapImage);
  Result.Canvas.Brush.Color:= clBlack;
  Result.Canvas.FillRect(Rect(0, 0, FBitmapImage.Width, FBitmapImage.Height));

  for AnnotationAction in FAnnotationActions do
    AnnotationAction.RenderOnMask(Result);
end;

function TAnnotatedImage.GetWidth: integer;
begin
  Result:= FBitmapImage.Height;
end;

procedure TAnnotatedImage.OnSaved;
begin
  FIsChanged:= False;
end;

procedure TAnnotatedImage.PutDotMarkerAt(const X, Y, ViewportWidth,
  ViewportHeight: integer);
var
  PointOnImage: TPoint;
  AnnotationAction: IAnnotationAction;
begin
  if IsOnImage(TPoint.Create(X, Y), ViewportWidth, ViewportHeight, FBitmapImage.Width, FBitmapImage.Height) then
  begin
    PointOnImage:= ViewportToImage(TPoint.Create(X, Y),
                                   ViewportWidth, ViewportHeight,
                                   FBitmapImage.Width, FBitmapImage.Height);

    AnnotationAction:= TDotMarker.Create(PointOnImage);
    FAnnotationActions.Add(AnnotationAction);
    AnnotationAction.RenderOnView(FBitmapAnnotationActions);
    FIsChanged:= True;
  end;

end;

end.
