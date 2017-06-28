unit SettingsController;

interface

uses
  Settings, SettingsView;

type

  TSettingsController = class
  private
    FModel: ISettings;
    FView: ISettingsView;
    procedure   OnViewCloseQuery(Sender: TObject; var CanClose: Boolean);
  public
    constructor Create(const Model: ISettings; const View: ISettingsView);
    destructor  Destroy; override;
    procedure   ShowSettings;
  end;

implementation

{ TSettingsController }

constructor TSettingsController.Create(const Model: ISettings; const View: ISettingsView);
begin
  FModel:= Model;
  FView:= View;
  FView.ShowSettings(FModel);
  FView.SetOnCloseQueryEvent(OnViewCloseQuery);
end;

destructor TSettingsController.Destroy;
begin
  FView.SetOnCloseQueryEvent(nil);
  inherited;
end;

procedure TSettingsController.OnViewCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= true;
  try
    FModel.SetDotMarkerColor(FView.GetDotMarkerColor);
    FModel.SetDotMarkerStrokeWidth(FView.GetDotMarkerStrokeWidth);
    FModel.SetDotMarkerStrokeLength(FView.GetDotMarkerStrokeLength);
    FModel.SetSavepathRelativeTo(TSavepathRelativeTo(FView.GetSavePathRelativeTo));
    FModel.SetSavePathForMarkers(FView.GetSavePathMarkers);
    FModel.SetSavePathForMasks(FView.GetSavePathMasks);
  except
    CanClose:= false;
  end;
end;

procedure TSettingsController.ShowSettings;
begin
  FView.ShowModal;
end;

end.
