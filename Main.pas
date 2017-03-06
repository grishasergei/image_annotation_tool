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
  Vcl.WinXCtrls, Vcl.Buttons, Vcl.Grids, Generics.Collections, Annotation.Interfaces, Main.Controller,
  Annotation.Action;

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
    procedure ImageOpenAccept(Sender: TObject);
    procedure ImageContainer_MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ActionSaveCurrentAnnotationExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActionPreviousImageExecute(Sender: TObject);
    procedure ActionNextImageExecute(Sender: TObject);
    procedure ActionSaveAllAnnotationsExecute(Sender: TObject);
    procedure ActionClearMarkersExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ListBoxHistoryClick(Sender: TObject);
  private
    { Private declarations }
    FController: TAnnotatedImageController;
    procedure LoadImage(const FileName: TStrings);
    //procedure ViewportToImage(const X, Y: integer; const AImage: TcxImage; var XNew, YNew: integer);
  public
    { Public declarations }
    procedure ShowImageInfo(const ImageInfo: TImageInfo);
    procedure RenderBitmap(const ABitmap: TBitmap);
    procedure ShowImageCount(const ACurrentIndex, ACount: integer);
    procedure ShowHistory(const AnnotationActions: TList<IAnnotationAction>);
  end;

var
  CrowdAnnotationForm: TCrowdAnnotationForm;

implementation

uses
  Annotation.Utils, System.UITypes;

{$R *.dfm}

procedure TCrowdAnnotationForm.ActionSaveAllAnnotationsExecute(Sender: TObject);
begin
  FController.SaveAllAnnotations;
end;

procedure TCrowdAnnotationForm.ActionClearMarkersExecute(Sender: TObject);
begin
  if MessageDlg('Do you really want to delete all markers? This operation is irreversible.',
                 mtConfirmation, mbYesNo, 0) = mrYes then
    FController.ClearMarkersOnCurrentImage;
end;

procedure TCrowdAnnotationForm.ActionNextImageExecute(Sender: TObject);
begin
   FController.NextImage;
end;

procedure TCrowdAnnotationForm.ActionPreviousImageExecute(Sender: TObject);
begin
  FController.PreviousImage;
end;

procedure TCrowdAnnotationForm.ActionSaveCurrentAnnotationExecute(Sender: TObject);
begin
  FController.SaveCurrentAnnotations;
end;

procedure TCrowdAnnotationForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= True;

  if FController.HasUnsavedChanges then
    if MessageDlg('There are some unsaved changes. Do you really want to close?',
                  mtConfirmation, mbYesNo, 0) = mrNo then
      CanClose:= False;
end;

procedure TCrowdAnnotationForm.FormCreate(Sender: TObject);
begin
  FController:= TAnnotatedImageController.Create(Self);
end;

procedure TCrowdAnnotationForm.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TCrowdAnnotationForm.ImageContainer_MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FController.PutMarkerAt(X, Y, ImageContainer.Width, ImageContainer.Height);
end;

procedure TCrowdAnnotationForm.ImageOpenAccept(Sender: TObject);
begin
  LoadImage((Sender as TFileOpen).Dialog.Files);
end;

procedure TCrowdAnnotationForm.ListBoxHistoryClick(Sender: TObject);
begin
  FController.SetAnnotationActionIndex(ListBoxHistory.ItemIndex);
  ListBoxHistory.OnClick:= nil;
  ListBoxHistory.Selected[ListBoxHistory.ItemIndex]:= true;
  ListBoxHistory.OnClick:= ListBoxHistoryClick;
end;

procedure TCrowdAnnotationForm.LoadImage(const FileName: TStrings);
begin
  FController.OpenImages(FileName);
end;

procedure TCrowdAnnotationForm.RenderBitmap(const ABitmap: TBitmap);
begin
  ImageContainer.Picture.Bitmap.Assign(ABitmap);
  PanelImageContainer.ShowCaption:= false;
end;

procedure TCrowdAnnotationForm.ShowHistory(
  const AnnotationActions: TList<IAnnotationAction>);
var
  AnnotationAction: IAnnotationAction;
begin
  ListBoxHistory.Clear;
  for AnnotationAction in AnnotationActions do
    ListBoxHistory.Items.Add(AnnotationAction.HistoryCaption);
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

end.
