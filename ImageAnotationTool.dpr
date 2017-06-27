program ImageAnotationTool;

uses
  Vcl.Forms,
  Main in 'Main.pas' {CrowdAnnotationForm},
  Annotation.Utils in 'Annotation.Utils.pas',
  AnnotatedImage in 'AnnotatedImage.pas',
  Vcl.Themes,
  Vcl.Styles,
  Main.Controller in 'Main.Controller.pas',
  Annotation.Interfaces in 'Annotation.Interfaces.pas',
  Annotation.Action in 'Annotation.Action.pas' {$R *.res},
  Settings in 'Settings\Settings.pas',
  SettingsController in 'Settings\SettingsController.pas',
  SettingsView in 'Settings\SettingsView.pas' {FormSettings},
  AnnotatedImages.Model in 'AnnotatedImages.Model.pas';

{$R *.res}
var
  MainController: TAnnotatedImageController;
begin
  System.ReportMemoryLeaksOnShutdown:= true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCrowdAnnotationForm, CrowdAnnotationForm);

  MainController:= TAnnotatedImageController.Create(CrowdAnnotationForm);

  Application.Run;

  MainController.Free;
end.
