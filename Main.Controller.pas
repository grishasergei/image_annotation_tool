unit Main.Controller;

interface

uses
  AnnotatedImage, Annotation.Interfaces, SysUtils, Classes, Generics.Collections;

type

  TAnnotatedImageController = class(TObject)
  private
    FView: IImageAnnotationView;
    FPresentMode: TPresentMode;
    FAnnotatedImages: TObjectList<TAnnotatedImage>;
    FCurrentIndex: integer;
    procedure   AddImage(const AFileName: TFileName);
    function    GetCurrentImage: TAnnotatedImage;
    procedure   SetCurrentImageIndex(const Value: integer);
    procedure   ShowCurrentImage;
    procedure   ShowImageAt(const Index: integer);
    procedure   SaveImageAnnotation(const AnnotatedImage: TAnnotatedImage);
    procedure   SetPresentMode(const Value: TPresentMode);
    procedure   CloseImageAt(const AIndex: integer);
  public
    constructor Create(const AView: IImageAnnotationView);
    destructor  Destroy; override;
    // properties
    property    CurrentImage: TAnnotatedImage read GetCurrentImage;
    property    PresentMode: TPresentMode read FPresentMode write SetPresentMode;
    // methods
    procedure   OpenImages(const AFiles: TStrings);
    procedure   PutMarkerAt(const X, Y, ViewportWidth, ViewportHeight: integer);
    procedure   SaveCurrentAnnotations;
    procedure   NextImage;
    procedure   PreviousImage;
    procedure   SaveAllAnnotations;
    procedure   ClearMarkersOnCurrentImage;
    function    HasUnsavedChanges: boolean;
    procedure   SetAnnotationActionIndex(const AValue: integer);
    procedure   CloseCurrentImage;
    procedure   LoadAnnotationsToCurrentImage(const AFileName: TFileName);
  end;

implementation

uses
  Vcl.Graphics, superobject, JPeg, math, IOUtils;

{ TAnnotatedImageController }

procedure TAnnotatedImageController.AddImage(const AFileName: TFileName);
var
  Picture: TPicture;
begin
  Picture:= TPicture.Create;
  try
    Picture.LoadFromFile(AFileName);
    FAnnotatedImages.Add(TAnnotatedImage.Create(Picture.Graphic, AFileName))
  finally
    Picture.Free;
  end;
end;

procedure TAnnotatedImageController.ClearMarkersOnCurrentImage;
begin
  if not Assigned(CurrentImage) then
    Exit;

  CurrentImage.ClearAnnotationActions;
  ShowCurrentImage;
end;

procedure TAnnotatedImageController.CloseCurrentImage;
begin
  CloseImageAt(FCurrentIndex);
end;

procedure TAnnotatedImageController.CloseImageAt(const AIndex: integer);
begin
  if (AIndex < 0) and (AIndex >= FAnnotatedImages.Count) then
    Exit;

  FAnnotatedImages.Delete(AIndex);
  SetCurrentImageIndex(AIndex - 1);
end;

constructor TAnnotatedImageController.Create(const AView: IImageAnnotationView);
begin
  FAnnotatedImages:= TObjectList<TAnnotatedImage>.Create(True);
  FView:= AView;
  FCurrentIndex:= -1;
  FPresentMode:= prmdCombined;
end;

destructor TAnnotatedImageController.Destroy;
begin
  FAnnotatedImages.Free;
  inherited;
end;

function TAnnotatedImageController.GetCurrentImage: TAnnotatedImage;
begin
  Result:= nil;
  if (FCurrentIndex > -1) and (FCurrentIndex < FAnnotatedImages.Count) then
    Result:= FAnnotatedImages[FCurrentIndex];
end;

function TAnnotatedImageController.HasUnsavedChanges: boolean;
var
  AnnotatedImage: TAnnotatedImage;
begin
  Result:= false;
  for AnnotatedImage in FAnnotatedImages do
    if AnnotatedImage.IsChanged then
    begin
      Result:= True;
      Exit;
    end;
end;

procedure TAnnotatedImageController.LoadAnnotationsToCurrentImage(
  const AFileName: TFileName);
var
  AnnotationsJSON: ISuperObject;
begin
  if not Assigned(CurrentImage) then
    exit;

  AnnotationsJSON:= SO(TFile.ReadAllText(AFileName));
  CurrentImage.LoadAnnotationsFromJSON(AnnotationsJSON.A['annotations']);
  ShowCurrentImage;
end;

procedure TAnnotatedImageController.NextImage;
begin
  SetCurrentImageIndex(FCurrentIndex + 1);
end;

procedure TAnnotatedImageController.OpenImages(const AFiles: TStrings);
var
  FileName: string;
begin
  for FileName in AFiles do
    AddImage(FileName);

  FCurrentIndex:= 0;
  ShowCurrentImage;
end;

procedure TAnnotatedImageController.PreviousImage;
begin
  SetCurrentImageIndex(FCurrentIndex - 1);
end;

procedure TAnnotatedImageController.PutMarkerAt(const X, Y, ViewportWidth, ViewportHeight: integer);
begin
  if not Assigned(CurrentImage) then
    Exit;

  CurrentImage.PutDotMarkerAt(X, Y, ViewportWidth, ViewportHeight);
  ShowCurrentImage;
end;

procedure TAnnotatedImageController.SaveAllAnnotations;
var
  AnnotatedImage: TAnnotatedImage;
begin
  for AnnotatedImage in FAnnotatedImages do
    SaveImageAnnotation(AnnotatedImage);
end;

procedure TAnnotatedImageController.SaveCurrentAnnotations;
begin
  SaveImageAnnotation(CurrentImage);
end;

procedure TAnnotatedImageController.SaveImageAnnotation(
  const AnnotatedImage: TAnnotatedImage);
var
  Mask: TJPEGImage;
  MaskJSON: ISuperObject;
  FileName: TFileName;
begin
  if not Assigned(AnnotatedImage) then
    Exit;

  // save mask
  Mask:= TJPEGImage.Create;
  try
    Mask.Assign(AnnotatedImage.MaskBitmap);
    FileName:= ExtractFilePath(AnnotatedImage.Name) +
                    'masks\' +
                    ExtractFileName(ChangeFileExt(AnnotatedImage.Name, '')) + '_mask' +
                    '.jpg';
    if ForceDirectories(ExtractFileDir(FileName)) then
      Mask.SaveToFile(FileName);
  finally
    Mask.Free;
  end;

  // save JSON
  MaskJSON:= AnnotatedImage.AnnotationActionsJSON;
  MaskJSON.AsJSon(True);
  FileName:= ExtractFilePath(AnnotatedImage.Name) +
                  'markers\' +
                  ExtractFileName(ChangeFileExt(AnnotatedImage.Name, '')) + '_markers' +
                  '.txt';
  if ForceDirectories(ExtractFileDir(FileName)) then
    MaskJSON.SaveTo(FileName, true, true);

  AnnotatedImage.OnSaved;
end;

procedure TAnnotatedImageController.SetAnnotationActionIndex(
  const AValue: integer);
begin
  CurrentImage.SetAnnotationActionIndex(AValue);
  ShowCurrentImage;
end;

procedure TAnnotatedImageController.SetCurrentImageIndex(const Value: integer);
begin
  if FAnnotatedImages.Count = 0 then
  begin
    FCurrentIndex:= -1;
    FView.Clear;
    Exit;
  end;

  if Value >= FAnnotatedImages.Count then
    FCurrentIndex:= FAnnotatedImages.Count - 1
  else if Value < 0 then
    FCurrentIndex:= 0
  else
    FCurrentIndex:= Value;

  ShowCurrentImage;
end;

procedure TAnnotatedImageController.SetPresentMode(const Value: TPresentMode);
begin
  if Value <> FPresentMode then
  begin
    FPresentMode:= Value;
    ShowCurrentImage;
  end else
    FPresentMode := Value;
end;

procedure TAnnotatedImageController.ShowCurrentImage;
begin
  ShowImageAt(FCurrentIndex);
end;

procedure TAnnotatedImageController.ShowImageAt(const Index: integer);
var
  ImageInfo: TImageInfo;
begin
  if (Index >= FAnnotatedImages.Count) or (Index < 0) then
    Exit;

  case FPresentMode of
    prmdOriginal: FView.RenderBitmap(FAnnotatedImages[Index].ImageBitmap);
    prmdCombined: FView.RenderBitmap(FAnnotatedImages[Index].CombinedBitmap);
    prmdMask: FView.RenderBitmap(FAnnotatedImages[Index].MaskBitmap);
  end;

  ImageInfo.FileName:= FAnnotatedImages[Index].Name;
  ImageInfo.Width:= FAnnotatedImages[Index].Width;
  ImageInfo.Height:= FAnnotatedImages[Index].Height;
  FView.ShowImageInfo(ImageInfo);

  FView.ShowHistory(CurrentImage.AnnotationActions, CurrentImage.CurrentAnnotationActionIndex);

  FView.ShowImageCount(Index + 1, FAnnotatedImages.Count);
end;

end.
