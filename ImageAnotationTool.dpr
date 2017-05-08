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
  Annotation.Action in 'Annotation.Action.pas';

{$R *.res}

begin
  System.ReportMemoryLeaksOnShutdown:= true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCrowdAnnotationForm, CrowdAnnotationForm);
  Application.Run;
end.
