unit Main.Controller;

interface

uses
  AnnotatedImage, Annotation.Interfaces, SysUtils, Classes, Generics.Collections,
  Vcl.Graphics, Controls, Vcl.StdActns, Vcl.ExtCtrls, StdCtrls, Settings;

type

  TAnnotatedImageController = class(TObject)
  private
    FView: IImageAnnotationView;
    FPresentMode: TPresentMode;
    FAnnotatedImages: TObjectList<TAnnotatedImage>;
    FCurrentIndex: integer;
    FZoomFactor:  Byte;
    FApplicationSettings: ISettings;
    procedure   AddImage(const AFileName: TFileName);
    function    GetCurrentImage: TAnnotatedImage;
    procedure   SetCurrentImageIndex(const Value: integer);
    procedure   ShowCurrentImage;
    procedure   ShowImageAt(const Index: integer);
    procedure   SaveImageAnnotation(const AnnotatedImage: TAnnotatedImage);
    procedure   SetPresentMode(const Value: TPresentMode);
    procedure   CloseImageAt(const AIndex: integer);
    procedure   SetPresentationModeCombined(Sender: TObject);
    procedure   SetPresentationModeMask(Sender: TObject);
    procedure   SetPresentationModeOriginal(Sender: TObject);
    procedure   ViewImageMouseDown(Sender: TObject; Button: TMouseButton;
                                   Shift: TShiftState; X, Y: Integer);
    procedure   ShowApplicationSettings(Sender: TObject);
  public
    constructor Create(const AView: IImageAnnotationView);
    destructor  Destroy; override;
    // properties
    property    CurrentImage: TAnnotatedImage read GetCurrentImage;
    property    PresentMode: TPresentMode read FPresentMode write SetPresentMode;
    property    ZoomFactor: Byte read FZoomFactor;
    // methods
    procedure   OpenImages(const AFiles: TStrings);
    procedure   PutMarkerAt(const X, Y, ViewportWidth, ViewportHeight: integer);
    procedure   SaveCurrentAnnotations(Sender: TObject = nil);
    procedure   NextImage(Sender: TObject = nil);
    procedure   PreviousImage(Sender: TObject = nil);
    procedure   SaveAllAnnotations(Sender: TObject = nil);
    procedure   ClearMarkersOnCurrentImage(Sender: TObject = nil);
    function    HasUnsavedChanges: boolean;
    procedure   SetAnnotationActionIndex(const AValue: integer); overload;
    procedure   SetAnnotationActionIndex(Sender: TObject); overload;
    procedure   CloseCurrentImage(Sender: TObject = nil);
    procedure   LoadAnnotationsToCurrentImage(const AFileName: TFileName); overload;
    procedure   LoadAnnotationsToCurrentImage(Sender: TObject); overload;
    procedure   ShowZoomPatch(const X, Y, Width, Height, ViewPortWidth, ViewPortHeight: integer; SourceBitmap: TBitmap);
    procedure   SetZoomFactor(const Value: Byte); overload;
    procedure   SetZoomFactor(Sender: TObject); overload;
    procedure   ViewCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure   ViewImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
  end;

implementation

uses
  superobject, JPeg, math, IOUtils, Windows, Dialogs, System.UITypes,
  SettingsView, SettingsController, Vcl.Forms;

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

procedure TAnnotatedImageController.ClearMarkersOnCurrentImage(Sender: TObject = nil);
begin
  if not Assigned(CurrentImage) then
    Exit;

  CurrentImage.ClearAnnotationActions;
  ShowCurrentImage;
end;

procedure TAnnotatedImageController.CloseCurrentImage(Sender: TObject = nil);
begin
  if Assigned(CurrentImage) and (FCurrentIndex > -1) then
    if CurrentImage.IsChanged then
    begin
      if MessageDlg('There are some unsaved changes. Do you really want to close this image?',
                    mtConfirmation, mbYesNo, 0) = mrYes then
        CloseImageAt(FCurrentIndex);
    end else
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
  FZoomFactor:= 2;

  FView.SetActionSaveAllAnnotationsExecute(SaveAllAnnotations);
  FView.SetActionClearMarkersExecute(ClearMarkersOnCurrentImage);
  FView.SetActionCloseCurrentImageExecute(CloseCurrentImage);
  FView.SetActionLoadAnnotationsAccept(LoadAnnotationsToCurrentImage);
  FView.SetActionNextImageExecute(NextImage);
  FView.SetActionPresentationModeCombinedExecute(SetPresentationModeCombined);
  FView.SetActionPresentationModeMaskExecute(SetPresentationModeMask);
  FView.SetActionPresentationModeOriginalExecute(SetPresentationModeOriginal);
  FView.SetActionPreviousImageExecute(PreviousImage);
  FView.SetActionSaveCurrentAnnotationExecute(SaveCurrentAnnotations);
  FView.SetActionZoomFactorChangeExecute(SetZoomFactor);
  FView.SetFormCloseQuery(ViewCloseQuery);
  FView.SetImageContainerMouseMoveEvent(ViewImageMouseMove);
  FView.SetImageCOntainerMouseDownEvent(ViewImageMouseDown);
  FView.SetHistoryBoxOnclickEvent(SetAnnotationActionIndex);
  FView.SetLoadImageMethod(OpenImages);
  FView.SetShowSettingsExecute(ShowApplicationSettings);

  FApplicationSettings:= TSettingsRegistry.Create('Software\ImageAnnotationTool\');

end;

destructor TAnnotatedImageController.Destroy;
begin
  FApplicationSettings:= nil;
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
  Sender: TObject);
begin
  LoadAnnotationsToCurrentImage((Sender as TFileOpen).Dialog.FileName);
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

procedure TAnnotatedImageController.NextImage(Sender: TObject = nil);
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

procedure TAnnotatedImageController.PreviousImage(Sender: TObject = nil);
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

procedure TAnnotatedImageController.SaveAllAnnotations(Sender: TObject = nil);
var
  AnnotatedImage: TAnnotatedImage;
begin
  for AnnotatedImage in FAnnotatedImages do
    SaveImageAnnotation(AnnotatedImage);
end;

procedure TAnnotatedImageController.SaveCurrentAnnotations(Sender: TObject = nil);
begin
  SaveImageAnnotation(CurrentImage);
end;

procedure TAnnotatedImageController.SaveImageAnnotation(
  const AnnotatedImage: TAnnotatedImage);
var
  Mask: TJPEGImage;
  MaskBitmap: Vcl.Graphics.TBitmap;
  MaskJSON: ISuperObject;
  FileName, BaseName: TFileName;
begin
  if not Assigned(AnnotatedImage) then
    Exit;

  case FApplicationSettings.GetSavepathRelativeTo of
    sprApplication: BaseName:= ExtractFilePath(Application.ExeName);
    sprImage:       BaseName:= ExtractFilePath(AnnotatedImage.Name);
  else
    BaseName:= ExtractFilePath(Application.ExeName);
  end;

  // save mask
  Mask:= TJPEGImage.Create;
  try
    MaskBitmap:= AnnotatedImage.MaskBitmap;
    Mask.Assign(MaskBitmap);
    FileName:= BaseName +
                    IncludeTrailingPathDelimiter(FApplicationSettings.GetSavePathForMasks) +
                    ExtractFileName(ChangeFileExt(AnnotatedImage.Name, '')) + '_mask' +
                    '.jpg';
    if ForceDirectories(ExtractFileDir(FileName)) then
      Mask.SaveToFile(FileName);
  finally
    Mask.Free;
    MaskBitmap.Free;
  end;

  // save JSON
  MaskJSON:= AnnotatedImage.AnnotationActionsJSON;
  MaskJSON.AsJSon(True);
  FileName:= BaseName +
                  IncludeTrailingPathDelimiter(FApplicationSettings.GetSavePathForMarkers) +
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

procedure TAnnotatedImageController.SetAnnotationActionIndex(Sender: TObject);
begin
  SetAnnotationActionIndex(TListBox(Sender).ItemIndex);
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

procedure TAnnotatedImageController.SetPresentationModeCombined(
  Sender: TObject);
begin
  PresentMode:= prmdCombined;
end;

procedure TAnnotatedImageController.SetPresentationModeMask(Sender: TObject);
begin
  PresentMode:= prmdMask;
end;

procedure TAnnotatedImageController.SetPresentationModeOriginal(
  Sender: TObject);
begin
  PresentMode:= prmdOriginal;
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

procedure TAnnotatedImageController.SetZoomFactor(Sender: TObject);
begin
  SetZoomFactor(FView.GetZoomFactor);
end;

procedure TAnnotatedImageController.SetZoomFactor(const Value: Byte);
begin
  if (Value >= 1) and (Value <= 10) then
    FZoomFactor := Value;
end;

procedure TAnnotatedImageController.ShowApplicationSettings(Sender: TObject);
var
  SettingsController: TSettingsController;
  SettingsView: TFormSettings;
begin
  SettingsView:= TFormSettings.Create(nil);
  SettingsController:= TSettingsController.Create(FApplicationSettings, SettingsView);
  try
    SettingsController.ShowSettings;
  finally
    SettingsController.Free;
    SettingsView.Free;
  end;

  ShowCurrentImage;
end;

procedure TAnnotatedImageController.ShowCurrentImage;
begin
  ShowImageAt(FCurrentIndex);
end;

procedure TAnnotatedImageController.ShowImageAt(const Index: integer);
var
  ImageInfo: TImageInfo;
  BitmapToRender: Vcl.Graphics.TBitmap;
begin
  if (Index >= FAnnotatedImages.Count) or (Index < 0) then
    Exit;

  case FPresentMode of
    prmdOriginal: BitmapToRender:= FAnnotatedImages[Index].ImageBitmap;
    prmdCombined: BitmapToRender:= FAnnotatedImages[Index].CombinedBitmap;
    prmdMask:     BitmapToRender:= FAnnotatedImages[Index].MaskBitmap;
  end;

  try
    FView.RenderBitmap(BitmapToRender);
  finally
    BitmapToRender.Free;
  end;

  ImageInfo.FileName:= FAnnotatedImages[Index].Name;
  ImageInfo.Width:= FAnnotatedImages[Index].Width;
  ImageInfo.Height:= FAnnotatedImages[Index].Height;
  FView.ShowImageInfo(ImageInfo);

  FView.ShowHistory(CurrentImage.AnnotationActions, CurrentImage.CurrentAnnotationActionIndex);

  FView.ShowImageCount(Index + 1, FAnnotatedImages.Count);
end;

procedure TAnnotatedImageController.ShowZoomPatch(const X, Y, Width,
  Height, ViewPortWidth, ViewPortHeight: integer; SourceBitmap: Vcl.Graphics.TBitmap);
var
  Bitmap: Vcl.Graphics.TBitmap;
begin
  if Assigned(CurrentImage) then
  begin
    Bitmap:= TAnnotatedImage.GetPatch(X, Y, Width, Height,
                                      ViewPortWidth, ViewPortHeight,
                                      ZoomFactor,
                                      SourceBitmap);
    try
      FView.RenderZoomBox(Bitmap);
    finally
      Bitmap.Free;
    end;
  end;
end;

procedure TAnnotatedImageController.ViewCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True;

  if HasUnsavedChanges then
    if MessageDlg('There are some unsaved changes. Do you really want to close?',
                  mtConfirmation, mbYesNo, 0) = mrNo then
      CanClose:= False;
end;

procedure TAnnotatedImageController.ViewImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  case Button of
    TMouseButton.mbLeft: PutMarkerAt(X, Y, TImage(Sender).Width, TImage(Sender).Height);
    TMouseButton.mbRight: FView.ToggleMagnifier;
    TMouseButton.mbMiddle: Exit;
  end;
end;

procedure TAnnotatedImageController.ViewImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: integer);
begin
  FView.SetMagnifierTopLeft(Y + 5, X + 5);
  ShowZoomPatch(X, Y, FView.GetZoomBoxWidth, FView.GetZoomBoxHeight,
                TImage(Sender).Width, TImage(Sender).Height,
                TImage(Sender).Picture.Bitmap);
end;

end.
