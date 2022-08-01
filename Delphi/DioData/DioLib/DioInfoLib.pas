
{******************************************************************************}
{                                                                              }
{                           Dio Data Class Library                             }
{                                                                              }
{                       Copyright (c) 2008-2009 itProject                      }
{                                                                              }
{******************************************************************************}

unit DioInfoLib;

interface

uses
  SysUtils, Classes, MyClasses;

type

  { Класс для работы с информацией о приборе }

  TDioInfo = class(TCustomFileObject)
  private
    FAddress: string;
    FOwner: string;
    FRes01: string;
    FRes02: string;
    FNumber: integer;
    FMask: string;
    FIndex: integer;
    function GetNumberStr: string;
    function GetCaption: string;
    procedure SetIndex(const Value: integer);
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
  public
    property Address: string read FAddress write FAddress;
    property Owner: string read FOwner write FOwner;
    property Res01: string read FRes01 write FRes01;
    property Res02: string read FRes02 write FRes02;
    property Number: integer read FNumber write FNumber;
    property Index: integer read FIndex  write SetIndex;
    property NumberAsStr: string read GetNumberStr;
    property Mask: string read FMask write FMask;
    property Caption: string read GetCaption;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetTextMask(AMask: string): string;
    constructor Create; override;
  end;

implementation

uses MyStrUtils, DioTypes;

const

  { Маска по умолчанию }

  DefMask = 'n';

{ TDioInfo }

procedure TDioInfo.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TDioInfo then
  begin
    FAddress := (Source as TDioInfo).Address;
    FOwner := (Source as TDioInfo).Owner;
    FRes01 := (Source as TDioInfo).Res01;
    FRes02 := (Source as TDioInfo).Res02;
    FNumber := (Source as TDioInfo).Number;
    FMask := (Source as TDioInfo).Mask;
    FIndex := (Source as TDioInfo).Index;
  end;
end;

procedure TDioInfo.Clear;
begin
  FAddress := '';
  FOwner := '';
  FRes01 := '';
  FRes02 := '';
  FNumber := -1;
  FIndex := -1;
end;

constructor TDioInfo.Create;
begin
  inherited;
  FMask := DefMask;
  Clear;
end;

function TDioInfo.DoLoadFromFile(const AFileName: TFileName): boolean;
var MyFile: integer;
    Descript: TDioInfoRec;
begin
  Result := false;
  try
    MyFile := FileOpen(AFileName,fmOpenRead);
    if MyFile = -1 then Exit;
    if FileRead(MyFile, Descript, DescriptRecSize) = DescriptRecSize then
    begin
      FAddress := CharArrayToString(Descript.Addr);
      FOwner := CharArrayToString(Descript.Owner);
      FRes01 := CharArrayToString(Descript.Res01);
      FRes02 := CharArrayToString(Descript.Res02);
      FNumber := StrToIntDef(ChangeFileExt(ExtractFileName(AFileName),''),-1);
      Result := true;
    end;
    SysUtils.FileClose(MyFile);
  except
    Clear;
  end;
end;

function TDioInfo.DoSaveToFile(const AFileName: TFileName): boolean;
var MyFile: integer;
    Descript: TDioInfoRec;
begin
  Result := false;
  try
    MyFile := FileCreate(AFileName);
    if MyFile = -1 then Exit;
    StringToCharArray(Address,Descript.Addr);
    StringToCharArray(Owner,Descript.Owner);
    StringToCharArray(Res01,Descript.Res01);
    StringToCharArray(Res02,Descript.Res02);
    if FileWrite(MyFile,Descript, DescriptRecSize) = DescriptRecSize then
      Result := true;
    SysUtils.FileClose(MyFile);
  except
    Result := false;
  end;
end;

function TDioInfo.GetTextMask(AMask: string): string;
var i: integer;
begin
  Result := '';
  for i := 1 to Length(AMask) do
    case AMask[i] of
      'n': Result := Result + String(NumberAsStr);
      'a': Result := Result + String(Address);
      'o': Result := Result + String(Owner);
      '1': Result := Result + String(Res01);
      '2': Result := Result + String(Res02);
    else
      Result := Result + AMask[i];
    end;
end;

function TDioInfo.GetNumberStr: string;
begin
  Result := IntToStr(FNumber);
end;

function TDioInfo.GetCaption: string;
begin
  Result := GetTextMask(FMask);
end;

procedure TDioInfo.SetIndex(const Value: integer);
begin
  if Value >= 0 then
    FIndex := Value
  else
    FIndex := -1;
end;

end.
