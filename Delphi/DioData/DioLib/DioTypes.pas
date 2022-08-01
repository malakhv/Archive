{******************************************************************************}
{                                                                              }
{                           Dio Data Class Library                             }
{                                                                              }
{                       Copyright (c) 2008-2009 itProject                      }
{                                                                              }
{******************************************************************************}

unit DioTypes;

interface

type

  { ��� ������ ��������� �������� - ������� ����� �������� 4 ����� }

  TDioFloat = Single;

  { ��� ��� ������������� ��������� ������ }

  TDioStr = AnsiString;

  { ����������� ������ �������� 1 ���� }

  TDioChar = AnsiChar;

  { ������ �������� }

  TCharArray = array of TDioChar;

  { ������ �������� ��� �������� ������ ���� }

  TDateChar = array[0..11] of TDioChar;

  { ���� ������ ��� �������� ���������� ������� }

  TShortChar = array[0..199] of TDioChar;
  TLongChar = array[0..499] of TDioChar;

const

  { ���������� ����� ������ ������ }

  HDataCount = 13;                  // HData (��� ���� Date � ���� Hr)
  HDataExCount = HDataCount + 10;   // HDataEx (��� ���� Date � ���� Hr)
  ExHDataCount = 2;                 // ������ Data � Hr
  CSDataCount = 17;                 // CSData
  KDataCount = 5;                   // K

  {����� ���������� �����  ������}

  AllDataCount = HDataExCount + ExHDataCount + KDataCount;

type

  { ������ ������ }

  TDioFloatArray = array of TDioFloat;

  { ������ ������ HData }

  THDataArray = array[0..HDataCount - 1] of TDioFloat;

  { ������ ������ HDataEx }

  THDataExArray = array[0..HDataExCount - 1] of TDioFloat;

  { ������ ������ CSData }

  TCSDataArray = array[0..CSDataCount - 1] of TDioFloat;

  { ������ ������ � ��� ��������� CS}

  TCSKArray = array[0..KDataCount - 1] of TDioFloat;

type

  { ��� ��� ���������� � ������� ������ �� ����� }

  THDataFRec = record
    Date: TDateChar;
    Hr: byte;
    HData: THDataArray;
  end;

  { �������� �������� ������ ������ }

  THDataRec = record
    Date: TDioStr;
    Hr: byte;
    HData: THDataArray;
  end;

  { �������� �������������� ������ ������ }

  THDataExRec = record
    Date: TDioStr;
    Hr: byte;
    HDataEx: THDataExArray;
  end;

  { ��������� CS }

  TCSDataFRec = record
    SysCfg: byte;
    RefIndex: byte;
    CSData: TCSDataArray;
    Hrs: integer;
    SNum: integer;
    ErrorCode: byte;
    DioType: byte;
    KData: TCSKArray;
    ArchiveDate: TDateTime;
  end;

  { ��������� ��� �������� ���������� � �������, ����������� � ��������� ����� }

  TDioInfoRec = record
    Addr: TShortChar;
    Owner: TShortChar;
    Res01: TLongChar;
    Res02: TLongChar;
  end;

const

  { ������ �������� � ������ }

  ElementSize = SizeOf(TDioFloat);

  { ������� ��������� ������ THDataFRec � ������ }

  HDataFRecSize = SizeOf(THDataFRec);

  { ������� ��������� ������ THDataRec � ������ }

  HDataRecSize = SizeOf(THDataRec);

  { ������� ��������� ������ THDataExRec � ������ }

  HDataExRecSize = SizeOf(THDataExRec);

  { ������� ��������� ������ TDescriptRec � ������ }

  DescriptRecSize = SizeOf(TDioInfoRec);

  { ������� ��������� ������ TCSDataFRec � ������ }

  CSDataFRecSize = SizeOf(TCSDataFRec);

const

  { ��������� �������� �����������}

  TError = -273;

type

  { ��� ���������, ������������� ��� ������� }

  TDioViewType = (vtCurrent = 0, vtSavings = 1);

  { ��� ������ ������ (�������� ��� ������� �����) }

  TDioArcType = (atNone = 0, atDay = 1, atHour = 2);

const

  { �����, ���������� ��� ������ ������� }

  DioMaskAllData = 'n - a o 1 2';

implementation


end.
