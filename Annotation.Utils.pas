unit Annotation.Utils;

interface

uses
  System.Types;

  function ViewportToImage(const ViewportPoint: TPoint;
                           const ViewportWidth, ViewportHeight, ImageWidth, ImageHeight: integer) :TPoint;
  function IsOnImage(const Point: TPoint;
                     const ViewportWidth, ViewportHeight, ImageWidth, ImageHeight: integer): boolean;

  procedure GetOffset(const ViewportWidth, ViewportHeight, ImageWidth, ImageHeight: integer; var XOffset, YOffset: integer);
implementation

uses
  Math;

function ViewportToImage(const ViewportPoint: TPoint;
                         const ViewportWidth, ViewportHeight, ImageWidth, ImageHeight: integer) :TPoint;
var
  XOffset, YOffset: integer;
  X, Y: integer;
begin

  Result:= TPoint.Create(0, 0);

  GetOffset(ViewportWidth, ViewportHeight, ImageWidth, ImageHeight, XOffset, YOffset);

  X:= ViewportPoint.X - XOffset;
  Y:= ViewportPoint.Y - YOffset;

  Result.X:= Round(ImageWidth * (X / (ViewportWidth - 2 * XOffset)));
  Result.Y:= Round(ImageHeight * (Y / (ViewportHeight - 2 * YOffset)));
end;

function IsOnImage(const Point: TPoint;
                   const ViewportWidth, ViewportHeight, ImageWidth, ImageHeight: integer): boolean;
var
  XOffset, YOffset: integer;
begin

  GetOffset(ViewportWidth, ViewportHeight, ImageWidth, ImageHeight, XOffset, YOffset);

  Result:= true;

  if (Point.X < XOffset) or (Point.X > ImageWidth + XOffset) then
  begin
    Result:= false;
    Exit;
  end;

  if (Point.Y < YOffset) or (Point.Y > ImageHeight + YOffset) then
  begin
    Result:= false;
    Exit;
  end;
end;

procedure GetOffset(const ViewportWidth, ViewportHeight, ImageWidth, ImageHeight: integer; var XOffset, YOffset: integer);
var
  WidthRatio, HeightRatio: double;
  ScaledImageWidth, ScaledImageHeight: integer;
begin

  WidthRatio:= ImageWidth / ViewportWidth;
  HeightRatio:= ImageHeight / ViewportHeight;

  if Max(WidthRatio, HeightRatio) < 1 then
  begin
    XOffset:= (ViewportWidth - ImageWidth) div 2;
    YOffset:= (ViewportHeight - ImageHeight) div 2;
    Exit;
  end;

  ScaledImageWidth:= Round(ImageWidth / Max(WidthRatio, HeightRatio));
  ScaledImageHeight:= Round(ImageHeight / Max(WidthRatio, HeightRatio));

  XOffset:= (ViewportWidth - ScaledImageWidth) div 2;
  YOffset:= (ViewportHeight - ScaledImageHeight) div 2;
end;

end.
