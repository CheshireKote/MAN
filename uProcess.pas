unit uProcess;

interface

uses ComCtrls, SysUtils, Classes, Forms;

procedure Kod(const SourceBitmap, Destination: string; GetSource:TStringStream;  BitsPerChannel: LongInt; ProgressBar: TProgressBar);
procedure DeKod(const SourceFile, DestFile: string; ProgressBar: TProgressBar);

implementation


uses JPEG, Windows, Graphics, uBits;


type pRGBArray= ^TRGBArray;
     TRGBArray= array [1..3] of Byte;
     TImageType = (ifUnknown, ifJPG, ifGIF, ifBMP, ifPNG, ifTIF);

var JPG_HEADER: array[0..2] of byte = ($FF, $D8, $FF);
GIF_HEADER: array[0..2] of byte = ($47, $49, $46);
BMP_HEADER: array[0..1] of byte = ($42, $4D);
PNG_HEADER: array[0..3] of byte = ($89, $50, $4E, $47);
TIF_HEADER: array[0..2] of byte = ($49, $49, $2A);

function TypeToStr(ImageType: TImageType): String;
begin
case ImageType of
ifJPG: Result := 'Image/JPEG';
ifGIF: Result := 'Image/GIF';
ifPNG: Result := 'Image/PNG';
ifBMP: Result := 'Image/BMP';
ifTIF: Result := 'Image/TIFF';
else
Result := 'Unknown Type';
end;
end;

function GetImageType(FileName: String): TImageType;
var
Stream: TFileStream;
MemStr: TMemoryStream;
begin
Result := ifUnknown;
Stream := TFileStream.Create(FileName, fmOpenRead);
MemStr := TMemoryStream.Create;
try
MemStr.CopyFrom(Stream, 5);
if MemStr.Size > 4 then
begin
if CompareMem(MemStr.Memory, @JPG_HEADER, SizeOf(JPG_HEADER)) then
Result := ifJPG
else if CompareMem(MemStr.Memory, @GIF_HEADER, SizeOf(GIF_HEADER)) then
Result := ifGIF
else if CompareMem(MemStr.Memory, @PNG_HEADER, SizeOf(PNG_HEADER)) then
Result := ifPNG
else if CompareMem(MemStr.Memory, @BMP_HEADER, SizeOf(BMP_HEADER)) then
Result := ifBMP
else if CompareMem(MemStr.Memory, @TIF_HEADER, SizeOf(TIF_HEADER)) then
Result := ifTIF
end;
finally
Stream.Free;
MemStr.Free;
end;
end;


procedure ProcessKod(Bitmap: TBitmap; Source: TStringStream; Destination: string; BPC: LongInt; ProgressBar: TProgressBar);
var SourceIndex, SourceSize: LongInt;
    BitIndex, PixelBitIndex: LongInt;
    SourceByte: Byte;
    PixelsRow: pRGBArray;
    RGBIndex: Integer;
    PixelsRowMax, PixelsRowIndex, CurrentRow: Integer;

procedure MoveTowardsNextPixel;
begin
  if (RGBIndex <= 3) and (PixelBitIndex + 1 < BPC) then
    Inc(PixelBitIndex)
  else if RGBIndex < 3 then
    begin
    Inc(RGBIndex);
    PixelBitIndex:= 0;
    end
  else if RGBIndex = 3 then
    begin
    PixelBitIndex:= 0;
    RGBIndex:= 1;
    if PixelsRowIndex = PixelsRowMax then
      begin
      Inc(CurrentRow);
      PixelsRow:= Bitmap.ScanLine[CurrentRow];
      PixelsRowIndex:= 1;
      end
    else
      begin
      Inc(PixelsRowIndex);
      Inc(PixelsRow);
      end;
    end;
end;

begin



  PixelsRow:= Bitmap.ScanLine[0];


  SetBitAt(PixelsRow^[1], 0, GetBitAt(BPC, 0));
  SetBitAt(PixelsRow^[1], 1, GetBitAt(BPC, 1));
  SetBitAt(PixelsRow^[2], 0, GetBitAt(BPC, 2));
  SetBitAt(PixelsRow^[3], 0, GetBitAt(BPC, 3));

  PixelsRowMax:= Bitmap.Width;
  CurrentRow:= 0;
  PixelBitIndex:= 0;
  PixelsRowIndex:= 2;
  RGBIndex:= 1;
  Inc(PixelsRow);

  SourceSize:= Source.Size;
  for BitIndex:= 0 to SizeOf(SourceSize) * 8 - 1 do
    begin
    SetBitAt(PixelsRow^[RGBIndex], PixelBitIndex, GetBitAt(SourceSize, BitIndex));
    MoveTowardsNextPixel;
    end;


  Source.Seek(0, soFromBeginning);
  for SourceIndex:= 0 to SourceSize - 1 do
    begin

    if (SourceIndex + 1) mod 10 = 0 then
      begin
      ProgressBar.StepIt;
      Application.ProcessMessages;
      end;

    Source.Read(SourceByte, 1);
    for BitIndex:= 0 to 7 do
      begin
      SetBitAt(PixelsRow^[RGBIndex], PixelBitIndex, GetBitAt(SourceByte, BitIndex));
      MoveTowardsNextPixel;
      end;

    end;// for SourceIndex
end;

procedure Kod(const SourceBitmap, Destination: string; GetSource:TStringStream;   BitsPerChannel: LongInt; ProgressBar: TProgressBar);
var Bitmap: TBitmap;
    Jpeg: TJPEGImage;
    sSource: TStringStream;
    it: TImageType;

begin
  ProgressBar.Position:= 0;
  ProgressBar.Step:= 1;

  Bitmap:= TBitmap.Create;
  Jpeg:= TJPEGImage.Create;
  sSource:= nil;
  try
    it := GetImageType(SourceBitmap);
    if (TypeToStr(it) = 'Image/JPEG') then
    begin
    Jpeg.LoadFromFile(SourceBitmap); Bitmap.Assign(Jpeg);
    end
    else if (TypeToStr(it) = 'Image/BMP') then
    begin
    Bitmap.LoadFromFile(SourceBitmap);
    end;

    if Bitmap.PixelFormat <> pf24bit then
      raise Exception.Create('Изображение должно быть 24-битной кодировки.');

    sSource:= GetSource;

    if sSource.Size = 0 then
    raise Exception.Create('Файл не содержит информации, нечего прятать.');

    if sSource.Size * 8 + SizeOf(LongInt) * 8  + 1 > Bitmap.Width * Bitmap.Height * 3 * BitsPerChannel then
    raise Exception.Create('Изображение слишком маленькое чтобы спрятать информацию.');

    ProgressBar.Max:= sSource.Size div 10;

    ProcessKod(Bitmap, sSource, Destination, BitsPerChannel, ProgressBar);

    Bitmap.SaveToFile(Destination);

  finally
    Bitmap.Free;
    Jpeg.Free;
    if Assigned(sSource) then sSource.Free;
  end;

end;


procedure ProcessDeKod(Bitmap: TBitmap; ProgressBar: TProgressBar; var Destination:TFileStream);
var DataSize, DataIndex: LongInt;
    Data, BitIndex: Byte;
    PixelsRow: pRGBArray;
    PixelsRowMax, PixelsRowIndex, CurrentRow, MaxRows: Integer;
    PixelBitIndex: LongInt;
    RGBIndex: Integer;
    BPC: LongInt;


procedure MoveTowardsNextPixel;
begin
  if (RGBIndex <= 3) and (PixelBitIndex  + 1 < BPC) then
    Inc(PixelBitIndex)
  else if RGBIndex < 3 then
    begin
    Inc(RGBIndex);
    PixelBitIndex:= 0;
    end
  else if RGBIndex = 3 then
    begin
    PixelBitIndex:= 0;
    RGBIndex:= 1;
    if PixelsRowIndex = PixelsRowMax then
      begin
      Inc(CurrentRow);
      if CurrentRow > MaxRows then
        raise Exception.Create('Изображение не содержит спрятаной информации!');

      PixelsRow:= Bitmap.ScanLine[CurrentRow];
      PixelsRowIndex:= 1;
      end
    else
      begin
      Inc(PixelsRowIndex);
      Inc(PixelsRow);
      end;
    end;
end;

begin



  PixelsRow:= Bitmap.ScanLine[0];
  BPC:= 0;
  SetBitAt(BPC, 0, GetBitAt(PixelsRow^[1], 0));
  SetBitAt(BPC, 1, GetBitAt(PixelsRow^[1], 1));
  SetBitAt(BPC, 2, GetBitAt(PixelsRow^[2], 0));
  SetBitAt(BPC, 3, GetBitAt(PixelsRow^[3], 0));

  if (BPC < 1 ) or (BPC > 8) then
    raise Exception.Create('Изображение не содержит спрятаной информации!');


  PixelsRowMax:= Bitmap.Width;
  MaxRows:= Bitmap.Height - 1;
  CurrentRow:= 0;
  PixelBitIndex:= 0;
  PixelsRowIndex:= 2;
  RGBIndex:= 1;
  Inc(PixelsRow);



  for BitIndex:= 0 to SizeOf(DataSize) * 8 - 1 do
    begin
    SetBitAt(DataSize, BitIndex, GetBitAt(PixelsRow^[RGBIndex], PixelBitIndex));
    MoveTowardsNextPixel;
    end;

  if DataSize <= 0 then
    raise Exception.Create('Изображение не содержит спрятаной информации');

  ProgressBar.Max:= DataSize div 10;


  for DataIndex:= 1 to DataSize do
    begin

    if DataIndex mod 10 = 0 then
      begin
      ProgressBar.StepIt;
      Application.ProcessMessages;
      end;

    for BitIndex:= 0 to 7 do
      begin
      SetBitAt(Data, BitIndex, GetBitAt(PixelsRow^[RGBIndex], PixelBitIndex));
      MoveTowardsNextPixel;
      end;

    Destination.Write(Data, 1);

    end;
end;

procedure DeKod(const SourceFile, DestFile: string; ProgressBar: TProgressBar);
var Bitmap: TBitmap;
    Destination: TFileStream;

begin
  ProgressBar.Position:= 0;
  ProgressBar.Step:= 1;

  Bitmap:= TBitmap.Create;
  Destination:= nil;
  try

    try
      if FileExists(DestFile) then DeleteFile(PAnsiChar(DestFile));

      Destination:= TFileStream.Create(DestFile, fmCreate);
      Bitmap.LoadFromFile(SourceFile);

      if Bitmap.PixelFormat <> pf24bit then
        raise Exception.Create('Изображение должно быть 24-битной кодировки.');

      ProcessDeKod(Bitmap, ProgressBar, Destination);

    finally
      Bitmap.Free;
      if Assigned(Destination) then Destination.Free;
    end;

  except
    if FileExists(DestFile) then
      DeleteFile(PChar(DestFile));
    raise;
  end;
end;

end.

