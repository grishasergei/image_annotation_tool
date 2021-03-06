{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdActns, System.Actions,
  Vcl.ActnList, Vcl.ExtDlgs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXCtrls, Vcl.Buttons, Vcl.Grids, Generics.Collections, Annotation.Interfaces,
  Annotation.Action, Vcl.ButtonGroup, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Menus;

type
  TCrowdAnnotationForm = class(TForm, IImageAnnotationView)
    PanelTop: TPanel;
    PanelLeft: TPanel;
    PanelCenter: TPanel;
    PanelRight: TPanel;
    PanelBottom: TPanel;
    ButtonOpenImage: TButton;
    ActionList: TActionList;
    ImageOpen: TFileOpen;
    ButtonSave: TButton;
    ActionToggleMarkers: TAction;
    PanelImageInfo: TPanel;
    PanelCaptions: TPanel;
    PanelValues: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelImageHeight: TLabel;
    LabelImageWidth: TLabel;
    LabelImageName: TLabel;
    ActionSaveCurrentAnnotation: TAction;
    ButtonPrevImage: TButton;
    ButtonNextImage: TButton;
    ActionPreviousImage: TAction;
    ActionNextImage: TAction;
    GridPanelCenterBottom: TGridPanel;
    LabelImageCount: TLabel;
    ButtonSaveAll: TButton;
    ActionSaveAllAnnotations: TAction;
    GridPanelCenterTop: TGridPanel;
    LabelCurrentImageFullName: TLabel;
    LabelHistoryCaption: TLabel;
    ButtonClearMarkers: TButton;
    ActionClearMarkers: TAction;
    ImageContainer: TImage;
    PanelImageContainer: TPanel;
    ListBoxHistory: TListBox;
    ButtonCombinedMode: TSpeedButton;
    ButtonOriginalMode: TSpeedButton;
    ButtonMaskMode: TSpeedButton;
    ActionPresentationModeCombined: TAction;
    ActionPresentationModeOriginal: TAction;
    ActionPresentationModeMask: TAction;
    PanelModeButtons: TPanel;
    ButtonCloseCurrentImage: TButton;
    ActionCloseCurrentImage: TAction;
    ButtonLoadAnnotations: TButton;
    ActionLoadAnnotations: TFileOpen;
    PanelZoomBox: TPanel;
    ImageZoomBox: TImage;
    PanelMagnifier: TPanel;
    ImageMagnifier: TImage;
    TrackBarZoomFactor: TTrackBar;
    ActionZoomFactorChange: TAction;
    ToolBar1: TToolBar;
    MainMenu: TMainMenu;
    Settings1: TMenuItem;
    ActionShowSettings: TAction;
    Settings2: TMenuItem;
    procedure ListBoxHistoryDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ImageOpenAccept(Sender: TObject);
    procedure FormCreate(Sender: TObject); // refactor this!
  private
    { Private declarations }
    LoadImage: TLoadImageMethod;
    //procedure ViewportToImage(const X, Y: integer; const AImage: TcxImage; var XNew, YNew: integer);
  public
    { Public declarations }
    procedure ShowImageInfo(const ImageInfo: TImageInfo);
    procedure RenderBitmap(const ABitmap: TBitmap);
    procedure RenderZoomBox(const ABitmap: TBitmap);
    procedure ShowImageCount(const ACurrentIndex, ACount: integer);
    procedure ShowHistory(const AnnotationActions: TList<IAnnotationAction>; const ACurrentActionIndex: integer);
    procedure Clear;
    function  GetZoomFactor: integer;
    procedure SetMagnifierTopLeft(const Top, Left: integer);
    function  GetZoomBoxWidth: integer;
    function  GetZoomBoxHeight: integer;
    procedure ToggleMagnifier;

    // View actions
    procedure SetActionSaveAllAnnotationsExecute(Event: TNotifyEvent);
    procedure SetActionClearMarkersExecute(Event: TNotifyEvent);
    procedure SetActionCloseCurrentImageExecute(Event: TNotifyEvent);
    procedure SetActionLoadAnnotationsAccept(Event: TNotifyEvent);
    procedure SetActionNextImageExecute(Event: TNotifyEvent);
    procedure SetActionPresentationModeCombinedExecute(Event: TNotifyEvent);
    procedure SetActionPresentationModeMaskExecute(Event: TNotifyEvent);
    procedure SetActionPresentationModeOriginalExecute(Event: TNotifyEvent);
    procedure SetActionPreviousImageExecute(Event: TNotifyEvent);
    procedure SetActionSaveCurrentAnnotationExecute(Event: TNotifyEvent);
    procedure SetActionZoomFactorChangeExecute(Event: TNotifyEvent);
    procedure SetFormCloseQuery(Event: TCloseQueryEvent);
    procedure SetImageContainerMouseMoveEvent(Event: TMouseMoveEvent);
    procedure SetImageCOntainerMouseDownEvent(Event: TMouseEvent);
    procedure SetHistoryBoxOnclickEvent(Event: TNotifyEvent);
    procedure SetLoadImageMethod(Method: TLoadImageMethod);
    procedure SetShowSettingsExecute(Event: TNotifyEvent);
  end;

var
  CrowdAnnotationForm: TCrowdAnnotationForm;

implementation

uses
  Annotation.Utils, System.UITypes;

{$R *.dfm}

procedure TCrowdAnnotationForm.Clear;
begin
  ListBoxHistory.Clear;
  LabelImageHeight.Caption:= '';
  LabelImageWidth.Caption:= '';
  LabelImageName.Caption:= '';
  LabelImageCount.Caption:= '';
  LabelCurrentImageFullName.Caption:= '';
  ImageContainer.Picture.Bitmap:= nil;
  PanelImageContainer.ShowCaption:= true;
end;

procedure TCrowdAnnotationForm.FormCreate(Sender: TObject);
begin
  PanelMagnifier.Top:= Top;
  PanelMagnifier.Left:= Left;
end;

procedure TCrowdAnnotationForm.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  TrackBarZoomFactor.Position:= TrackBarZoomFactor.Position - 1;
end;

procedure TCrowdAnnotationForm.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  TrackBarZoomFactor.Position:= TrackBarZoomFactor.Position + 1;
end;

function TCrowdAnnotationForm.GetZoomBoxHeight: integer;
begin
  Result:= ImageZoomBox.Height;
end;

function TCrowdAnnotationForm.GetZoomBoxWidth: integer;
begin
  Result:= ImageZoomBox.Width;
end;

function TCrowdAnnotationForm.GetZoomFactor: integer;
begin
  Result:= Byte(TrackBarZoomFactor.Position);
end;

procedure TCrowdAnnotationForm.ImageOpenAccept(Sender: TObject);
begin
  LoadImage((Sender as TFileOpen).Dialog.Files);
end;

procedure TCrowdAnnotationForm.ListBoxHistoryDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TListBox do
  begin
    Canvas.FillRect(Rect);
    Canvas.Font.Color := TColor(Items.Objects[Index]);
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
  end;
end;

procedure TCrowdAnnotationForm.RenderBitmap(const ABitmap: TBitmap);
begin
  ImageContainer.Picture.Bitmap.Assign(ABitmap);
  PanelImageContainer.ShowCaption:= false;
end;

procedure TCrowdAnnotationForm.RenderZoomBox(const ABitmap: TBitmap);
begin
  ImageZoomBox.Picture.Bitmap.SetSize(ABitmap.Width, ABitmap.Height);
  ImageZoomBox.Picture.Bitmap.Canvas.Draw(0, 0, ABitmap);

  ImageMagnifier.Picture.Bitmap.SetSize(ABitmap.Width, ABitmap.Height);
  ImageMagnifier.Picture.Bitmap.Canvas.Draw(0, 0, ABitmap);
end;

procedure TCrowdAnnotationForm.SetActionClearMarkersExecute(
  Event: TNotifyEvent);
begin
  ActionClearMarkers.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionCloseCurrentImageExecute(
  Event: TNotifyEvent);
begin
  ActionCloseCurrentImage.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionLoadAnnotationsAccept(
  Event: TNotifyEvent);
begin
  ActionLoadAnnotations.OnAccept:= Event;
end;

procedure TCrowdAnnotationForm.SetActionNextImageExecute(Event: TNotifyEvent);
begin
  ActionNextImage.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionPresentationModeCombinedExecute(
  Event: TNotifyEvent);
begin
  ActionPresentationModeCombined.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionPresentationModeMaskExecute(
  Event: TNotifyEvent);
begin
  ActionPresentationModeMask.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionPresentationModeOriginalExecute(
  Event: TNotifyEvent);
begin
  ActionPresentationModeOriginal.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionPreviousImageExecute(
  Event: TNotifyEvent);
begin
  ActionPreviousImage.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionSaveAllAnnotationsExecute(
  Event: TNotifyEvent);
begin
  ActionSaveAllAnnotations.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionSaveCurrentAnnotationExecute(
  Event: TNotifyEvent);
begin
  ActionSaveCurrentAnnotation.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.SetActionZoomFactorChangeExecute(
  Event: TNotifyEvent);
begin
  ActionZoomFactorChange.OnExecute:= Event;
  TrackBarZoomFactor.OnChange:= Event;
end;

procedure TCrowdAnnotationForm.SetFormCloseQuery(Event: TCloseQueryEvent);
begin
  Self.OnCLoseQuery:= Event;
end;

procedure TCrowdAnnotationForm.SetHistoryBoxOnclickEvent(Event: TNotifyEvent);
begin
  ListBoxHistory.OnClick:= Event;
end;

procedure TCrowdAnnotationForm.SetImageCOntainerMouseDownEvent(
  Event: TMouseEvent);
begin
  ImageContainer.OnMouseDown:= Event;
end;

procedure TCrowdAnnotationForm.SetImageContainerMouseMoveEvent(
  Event: TMouseMoveEvent);
begin
  ImageCOntainer.OnMouseMove:= Event;
end;

procedure TCrowdAnnotationForm.SetLoadImageMethod(Method: TLoadImageMethod);
begin
  LoadImage:= Method;
end;

procedure TCrowdAnnotationForm.SetMagnifierTopLeft(const Top, Left: integer);
begin
  PanelMagnifier.Top:= Top;
  PanelMagnifier.Left:= Left;
end;

procedure TCrowdAnnotationForm.SetShowSettingsExecute(Event: TNotifyEvent);
begin
  ActionShowSettings.OnExecute:= Event;
end;

procedure TCrowdAnnotationForm.ShowHistory(
  const AnnotationActions: TList<IAnnotationAction>; const ACurrentActionIndex: integer);
var
  AnnotationAction: IAnnotationAction;
  var i: integer;
begin
  ListBoxHistory.Clear;

  for i := 0 to ACurrentActionIndex do
  begin
    AnnotationAction:= AnnotationActions[i];
    ListBoxHistory.Items.AddObject(AnnotationAction.HistoryCaption, pointer(clBlack));
  end;

  for i := ACurrentActionIndex + 1 to AnnotationActions.Count - 1 do
  begin
    AnnotationAction:= AnnotationActions[i];
    ListBoxHistory.Items.AddObject(AnnotationAction.HistoryCaption, pointer(clGray));
  end;

  ListBoxHistory.ItemIndex:= ACurrentActionIndex;
end;

procedure TCrowdAnnotationForm.ShowImageCount(const ACurrentIndex, ACount: integer);
begin
  LabelImageCount.Caption:= IntToStr(ACurrentIndex) +  ' of ' + IntToStr(ACount);
end;

procedure TCrowdAnnotationForm.ShowImageInfo(const ImageInfo: TImageInfo);
begin
  LabelImageName.Caption:= ExtractFileName(ImageInfo.FileName);
  LabelCurrentImageFullName.Caption:= ImageInfo.FileName;
  LabelImageWidth.Caption:= IntToStr(ImageInfo.Width);
  LabelImageHeight.Caption:= IntToStr(ImageInfo.Height);
end;

procedure TCrowdAnnotationForm.ToggleMagnifier;
begin
  PanelMagnifier.Visible:= not PanelMagnifier.Visible;
end;

end.
