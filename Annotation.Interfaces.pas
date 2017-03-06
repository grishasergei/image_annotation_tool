unit Annotation.Interfaces;

interface

uses
  Generics.Collections, AnnotatedImage, System.Types, Vcl.Graphics, Annotation.Action;

type

  TImageInfo = record
    FileName: string;
    Width: integer;
    Height: integer;
  end;

  IImageAnnotationView = interface
    procedure RenderBitmap(const ABitmap: TBitmap);
    procedure ShowImageInfo(const ImageInfo: TImageInfo);
    procedure ShowImageCount(const ACurrentIndex, ACount: integer);
    procedure ShowHistory(const AnnotationActions: TList<IAnnotationAction>);
  end;

implementation

end.