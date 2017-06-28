unit SettingsView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, System.Actions, Vcl.ActnList, Settings, Vcl.ComCtrls;

type

  ISettingsView = interface
    procedure ShowSettings(const Settings: ISettingsReader);
    function  GetDotMarkerColor: TColor;
    function  GetDotMarkerStrokeWidth: integer;
    function  GetDotMarkerStrokeLength: integer;
    function  GetSavePathMarkers: string;
    function  GetSavePathMasks: string;
    function  GetSavePathRelativeTo: integer;
    procedure SetOnCloseQueryEvent(Event: TCloseQueryEvent);
    function  ShowModal: integer;
  end;

  TFormSettings = class(TForm, ISettingsView)
    LabelDotMarkerColor: TLabel;
    LabelDotMarkerStrokeWidth: TLabel;
    LabelDotMarkerStrokeLength: TLabel;
    EditDotMarkerColor: TColorBox;
    EditDotMarkerStrokeWidth: TSpinEdit;
    EditDotMarkerStrokeLength: TSpinEdit;
    PanelDotMarker: TPanel;
    ActionList: TActionList;
    ActionShowSettings: TAction;
    ImageDotMarker: TImage;
    ActionDrawDotMarker: TAction;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    LabelMarkers: TLabel;
    EditSavePathMasks: TEdit;
    Masks: TLabel;
    RadioGroupRelativeTo: TRadioGroup;
    EditSavePathMarkers: TEdit;
    procedure ActionShowSettingsExecute(Sender: TObject);
    procedure ActionDrawDotMarkerExecute(Sender: TObject);
    procedure EditSavePathMarkersKeyPress(Sender: TObject; var Key: Char);
    procedure EditSavePathMasksKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FSavePathsAllowedChar: TArray<char>;
  public
    { Public declarations }
    procedure ShowSettings(const Settings: ISettingsReader);
    function  GetDotMarkerColor: TColor;
    function  GetDotMarkerStrokeWidth: integer;
    function  GetDotMarkerStrokeLength: integer;
    procedure SetOnCloseQueryEvent(Event: TCloseQueryEvent);
    function  GetSavePathMarkers: string;
    function  GetSavePathMasks: string;
    function  GetSavePathRelativeTo: integer;
  end;

var
  FormSettings: TFormSettings;

implementation

{$R *.dfm}

{ TFormSettings }

procedure TFormSettings.ActionDrawDotMarkerExecute(Sender: TObject);
var
  X, Y: integer;
  StrokeLength: integer;
begin
  ImageDotMarker.Canvas.Pen.Color:= clWhite;
  ImageDotMarker.Canvas.Rectangle(0, 0, ImageDotMarker.Picture.Bitmap.Width, ImageDotMarker.Picture.Bitmap.Height);

  ImageDotMarker.Canvas.Pen.Color:= EditDotMarkerColor.Selected;
  ImageDotMarker.Canvas.Pen.Width:= EditDotMarkerStrokeWidth.Value;

  X:= Trunc(ImageDotMarker.Picture.Bitmap.Width / 2);
  Y:= Trunc(ImageDotMarker.Picture.Bitmap.Height / 2);

  StrokeLength:= EditDotMarkerStrokeLength.Value;

  ImageDotMarker.Canvas.MoveTo(X, Y - StrokeLength);
  ImageDotMarker.Canvas.LineTo(X, Y + StrokeLength);

  ImageDotMarker.Canvas.MoveTo(X - StrokeLength, Y);
  ImageDotMarker.Canvas.LineTo(X +  StrokeLength, Y);
end;

procedure TFormSettings.ActionShowSettingsExecute(Sender: TObject);
begin
  //
end;

procedure TFormSettings.EditSavePathMarkersKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#8, #46, '\', '_', '-', '0'..'9', 'a'..'z', 'A'..'Z']) then
    Key := #0;
end;

procedure TFormSettings.EditSavePathMasksKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#8, #46, '\', '_', '-', '0'..'9', 'a'..'z', 'A'..'Z']) then
    Key := #0;
end;

function TFormSettings.GetDotMarkerColor: TColor;
begin
  Result:= EditDotMarkerColor.Selected;
end;

function TFormSettings.GetDotMarkerStrokeLength: integer;
begin
  Result:= EditDotMarkerStrokeLength.Value;
end;

function TFormSettings.GetDotMarkerStrokeWidth: integer;
begin
  Result:= EditDotMarkerStrokeWidth.Value;
end;

function TFormSettings.GetSavePathMarkers: string;
begin
  Result:= EditSavePathMarkers.Text;
end;

function TFormSettings.GetSavePathMasks: string;
begin
  Result:= EditSavePathMasks.Text;
end;

function TFormSettings.GetSavePathRelativeTo: integer;
begin
  Result:= RadioGroupRelativeTo.ItemIndex;
end;

procedure TFormSettings.SetOnCloseQueryEvent(Event: TCloseQueryEvent);
begin
  Self.OnCloseQuery:= Event;
end;

procedure TFormSettings.ShowSettings(const Settings: ISettingsReader);
begin
  EditDotMarkerColor.Selected:= Settings.GetDotMarkerColor;
  EditDotMarkerStrokeWidth.Value:= Settings.GetDotMarkerStrokeWidth;
  EditDotMarkerStrokeLength.Value:= Settings.GetDotMarkerStrokeLength;
  EditSavePathMarkers.Text:= Settings.GetSavePathForMarkers;
  EditSavePathMasks.Text:= Settings.GetSavePathForMasks;
  try
    RadioGroupRelativeTo.ItemIndex:= integer(Settings.GetSavepathRelativeTo);
  except
    RadioGroupRelativeTo.ItemIndex:= 0;
  end;
end;

end.
