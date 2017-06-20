unit AnnotatedImage;

interface

uses
  Vcl.Graphics, System.Types, Generics.Collections,
  Superobject, Annotation.Action;

type

  TAnnotatedImage = class(TObject)
  private
    FBitmapImage: TBitmap;
    FAnnotationActions: TList<IAnnotationAction>;
    FName:      string;
    FIsChanged: boolean;
    FCurrentAnnotationActionIndex: integer;
    function    GetCombinedBitmap: TBitmap;
    function    GetHeight: integer;
    function    GetWidth: integer;
    function    GetMaskBitmap: TBitmap;
    function    GetAnnotationActionsJSON: ISuperObject;
    procedure   PushAnnotationAction(const AnnotationAction: IAnnotationAction);
  public
    constructor Create(const ImageBitmap: TBitmap; const Name: string); overload;
    constructor Create(const ImageGraphic: TGraphic; const Name: string); overload;
    destructor  Destroy; override;
    // properties
    property    ImageBitmap: TBitmap read FBitmapImage;
    property    CombinedBitmap: TBitmap read GetCombinedBitmap;
    property    MaskBitmap: TBitmap read GetMaskBitmap;
    property    AnnotationActions: TList<IAnnotationAction> read FAnnotationActions;
    property    Width: integer read GetWidth;
    property    Height: integer read GetHeight;
    property    Name: string read FName;
    property    AnnotationActionsJSON: ISuperObject read GetAnnotationActionsJSON;
    property    IsChanged: boolean read FIsChanged;
    property    CurrentAnnotationActionIndex: integer read FCurrentAnnotationActionIndex;
    // methods
    procedure   PutDotMarkerAt(const X, Y, ViewportWidth, ViewportHeight: integer);
    procedure   ClearAnnotationActions;
    procedure   OnSaved;
    procedure   SetAnnotationActionIndex(const Value: integer);
    procedure   LoadAnnotationsFromJSON(const AnnotationsArray: TSuperArray);
    class function    GetPatch(const X, Y, Width, Height,
                          ViewPortWidth, ViewPortHeight: integer;
                          const ZoomFactor: Byte;
                          SourceBitmap: TBitmap): TBitmap; // refactor this method
  end;

implementation

uses
  Annotation.Utils, SysUtils, Math, Settings;

{ TAnnotatedImage }

constructor TAnnotatedImage.Create(const ImageBitmap: TBitmap; const Name: string);
begin
  FBitmapImage:= TBitmap.Create;
  FBitmapImage.Assign(ImageBitmap);
  FAnnotationActions:= Tlist<IAnnotationAction>.Create;
  FName:= Name;
  FCurrentAnnotationActionIndex:= -1;
  PushAnnotationAction(TOriginalImageAction.Create);
  FIsChanged:= False;
end;

procedure TAnnotatedImage.ClearAnnotationActions;
begin
  //FAnnotationActions.Clear;
  //FCurrentAnnotationActionIndex:= -1;
  PushAnnotationAction(TAnnotationClear.Create);
end;

constructor TAnnotatedImage.Create(const ImageGraphic: TGraphic; const Name: string);
begin
  FBitmapImage:= TBitmap.Create;
  FBitmapImage.Assign(ImageGraphic);
  FAnnotationActions:= TList<IAnnotationAction>.Create;
  FName:= Name;
  FCurrentAnnotationActionIndex:= -1;
  PushAnnotationAction(TOriginalImageAction.Create);
  FIsChanged:= False;
end;

destructor TAnnotatedImage.Destroy;
begin
  FBitmapImage.Free;
  FAnnotationActions.Free;
  inherited;
end;

function TAnnotatedImage.GetCombinedBitmap: TBitmap;
var
  i: integer;
  AnnotationAction: IAnnotationAction;
  BitmapAnnotationActions: TBitmap;
  Settings: ISettings;
begin
  Result:= TBitmap.Create;
  Result.Assign(FBitmapImage);

  BitmapAnnotationActions:= TBitmap.Create;
  try
    BitmapAnnotationActions.Assign(FBitmapImage);

    BitmapAnnotationActions.Transparent:= true;
    BitmapAnnotationActions.TransparentMode:= tmFixed;
    BitmapAnnotationActions.TransparentColor:= clBlack;

    BitmapAnnotationActions.Canvas.Brush.Color:= clBlack;
    BitmapAnnotationActions.Canvas.Brush.Style:= bsSolid;
    BitmapAnnotationActions.Canvas.FillRect(Rect(0, 0, BitmapAnnotationActions.Width, BitmapAnnotationActions.Height));

    Settings:= TSettingsRegistry.Create('Software\ImageAnnotationTool\');

    for i := 0 to FCurrentAnnotationActionIndex do
    begin
      AnnotationAction:= FAnnotationActions[i];
      AnnotationAction.RenderOnView(BitmapAnnotationActions, Settings);
    end;

    Result.Canvas.Draw(0, 0, BitmapAnnotationActions);
  finally
    BitmapAnnotationActions.Free;
  end;
end;

function TAnnotatedImage.GetHeight: integer;
begin
  Result:= FBitmapImage.Width;
end;

function TAnnotatedImage.GetAnnotationActionsJSON: ISuperObject;
var
  AnnotationAction: IAnnotationAction;
  i: integer;
begin
  Result:= SO;
  Result.O['annotations']:= SA([]);

  for i := 0 to FCurrentAnnotationActionIndex do
  begin
    AnnotationAction:= FAnnotationActions[i];
    AnnotationAction.AddToJSONArray(Result, 'annotations');
    //Result.A['annotations'].Add(AnnotationAction.ToJSON);
  end;
end;

function TAnnotatedImage.GetMaskBitmap: TBitmap;
var
  AnnotationAction: IAnnotationAction;
  i: integer;
begin
  Result:= TBitmap.Create;
  Result.PixelFormat:= pf1bit;

  Result.Assign(FBitmapImage);
  Result.Canvas.Brush.Color:= clBlack;
  Result.Canvas.FillRect(Rect(0, 0, FBitmapImage.Width, FBitmapImage.Height));

  for i := 0 to FCurrentAnnotationActionIndex do
  begin
    AnnotationAction:= FAnnotationActions[i];
    AnnotationAction.RenderOnMask(Result);
  end;
end;

class function TAnnotatedImage.GetPatch(const X, Y, Width, Height,
  ViewPortWidth, ViewPortHeight: integer; const ZoomFactor: Byte;
  SourceBitmap: TBitmap): TBitmap;
var
  PointOnImage: TPoint;
  DestRect, SourceRect: TRect;
  XOffset, YOffset: integer;
  CenterPoint: TPoint;
begin
  Result:= TBitmap.Create;
  Result.SetSize(Width, Height);
  Result.Canvas.Brush.Color:= clBtnHighlight;
  Result.Canvas.FillRect(Rect(0, 0, Width, Height));

  if not IsOnImage(TPoint.Create(X, Y), ViewportWidth, ViewportHeight, SourceBitmap.Width, SourceBitmap.Height) then
    exit;

  PointOnImage:= ViewportToImage(TPoint.Create(X, Y),
                                 ViewportWidth, ViewportHeight,
                                 SourceBitmap.Width, SourceBitmap.Height);

  XOffset:= Width div (2 * ZoomFactor);
  YOffset:= Height div (2 * ZoomFactor);

  DestRect:= TRect.Create(TPoint.Zero, TPoint.Create(Width, Height));
  SourceRect:= TRect.Create(TPoint.Create(PointOnImage.X - XOffset,
                                          PointOnImage.Y - YOffset),
                            TPoint.Create(PointOnImage.X + XOffset,
                                          PointOnImage.Y + YOffset));

  Result.Canvas.CopyRect(DestRect, SourceBitmap.Canvas, SourceRect);

  CenterPoint:= TPoint.Zero;
  CenterPoint.X:= Width div 2;
  CenterPoint.Y:= Height div 2;

  Result.Canvas.Pen.Color:= $0EF729;
  Result.Canvas.Pen.Width:= 2;

  Result.Canvas.MoveTo(CenterPoint.X, CenterPoint.Y - 15);
  Result.Canvas.LineTo(CenterPoint.X, CenterPoint.Y + 15);

  Result.Canvas.MoveTo(CenterPoint.X - 15, CenterPoint.Y);
  Result.Canvas.LineTo(CenterPoint.X +  15, CenterPoint.Y);

end;

function TAnnotatedImage.GetWidth: integer;
begin
  Result:= FBitmapImage.Height;
end;

procedure TAnnotatedImage.LoadAnnotationsFromJSON(
  const AnnotationsArray: TSuperArray);
var
  i: integer;
begin
  FAnnotationActions.Clear;
  FCurrentAnnotationActionIndex:= -1;
  PushAnnotationAction(TOriginalImageAction.Create);
  for i := 0 to AnnotationsArray.Length - 1 do
    if CompareText(AnnotationsArray[i].S['type'], 'dot_marker') = 0 then
      PushAnnotationAction(TDotMarker.Create(AnnotationsArray[i].I['x'], AnnotationsArray[i].I['y']));
end;

procedure TAnnotatedImage.OnSaved;
begin
  FIsChanged:= False;
end;

procedure TAnnotatedImage.PushAnnotationAction(const AnnotationAction: IAnnotationAction);
begin
  if FCurrentAnnotationActionIndex > -1 then
    while FCurrentAnnotationActionIndex < (FAnnotationActions.Count - 1) do
      FAnnotationActions.Delete(FAnnotationActions.Count - 1);

  FAnnotationActions.Add(AnnotationAction);
  Inc(FCurrentAnnotationActionIndex);
  FIsChanged:= True;
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
    PushAnnotationAction(AnnotationAction);
  end;
end;

procedure TAnnotatedImage.SetAnnotationActionIndex(const Value: integer);
begin
  if (Value > -1) and (Value < FAnnotationActions.Count) then
  begin
    FCurrentAnnotationActionIndex:= Value;
    FIsChanged:= FCurrentAnnotationActionIndex > 0;
  end;
end;

end.
