unit Annotation.Interfaces;

interface

uses
  Generics.Collections, AnnotatedImage, System.Types, Vcl.Graphics;

type

  TImageInfo = record
    FileName: string;
    Width: integer;
    Height: integer;
  end;

  IImageAnnotationView = interface
    procedure RenderBitmap(const ABitmap: TBitmap);
    procedure ShowMarkersList(const Markers: TList<TPoint>);
    procedure ShowImageInfo(const ImageInfo: TImageInfo);
    procedure ShowImageCount(const ACurrentIndex, ACount: integer);
  end;

implementation

end.
