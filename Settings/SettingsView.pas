unit SettingsView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, System.Actions, Vcl.ActnList, Settings;

type

  ISettingsView = interface
    procedure ShowSettings(const Settings: ISettingsReader);
    function  GetDotMarkerColor: TColor;
    function  GetDotMarkerStrokeWidth: integer;
    function  GetDotMarkerStrokeLength: integer;
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
    LabelDotMarker: TLabel;
    ActionList: TActionList;
    ActionShowSettings: TAction;
    procedure ActionShowSettingsExecute(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure ShowSettings(const Settings: ISettingsReader);
    function  GetDotMarkerColor: TColor;
    function  GetDotMarkerStrokeWidth: integer;
    function  GetDotMarkerStrokeLength: integer;
    procedure SetOnCloseQueryEvent(Event: TCloseQueryEvent);
  end;

var
  FormSettings: TFormSettings;

implementation

{$R *.dfm}

{ TFormSettings }

procedure TFormSettings.ActionShowSettingsExecute(Sender: TObject);
begin
  //
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

procedure TFormSettings.SetOnCloseQueryEvent(Event: TCloseQueryEvent);
begin
  Self.OnCloseQuery:= Event;
end;

procedure TFormSettings.ShowSettings(const Settings: ISettingsReader);
begin
  EditDotMarkerColor.Selected:= Settings.GetDotMarkerColor;
  EditDotMarkerStrokeWidth.Value:= Settings.GetDotMarkerStrokeWidth;
  EditDotMarkerStrokeLength.Value:= Settings.GetDotMarkerStrokeLength;
end;

end.
