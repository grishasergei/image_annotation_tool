unit Annotation.Interfaces;

interface

uses
  Generics.Collections, AnnotatedImage, System.Types, Vcl.Graphics,
  Annotation.Action, Classes, Vcl.Controls, Forms;

type

  TPresentMode = (prmdOriginal, prmdCombined, prmdMask);

  TImageInfo = record
    FileName: string;
    Width: integer;
    Height: integer;
  end;

  TLoadImageMethod = procedure(const FileName: TStrings) of object;

  IImageAnnotationView = interface
    procedure RenderBitmap(const ABitmap: TBitmap);
    procedure RenderZoomBox(const ABitmap: TBitmap);
    procedure ShowImageInfo(const ImageInfo: TImageInfo);
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

implementation

end.
