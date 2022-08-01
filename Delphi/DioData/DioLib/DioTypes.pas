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

  { Тип данных показаний приборов - дробное число размером 4 байта }

  TDioFloat = Single;

  { Тип для представления строковых данных }

  TDioStr = AnsiString;

  { Стандартный символ размером 1 байт }

  TDioChar = AnsiChar;

  { Массив вимволов }

  TCharArray = array of TDioChar;

  { Массив символов для хранения данных даты }

  TDateChar = array[0..11] of TDioChar;

  { Типы данных для описания информации прибора }

  TShortChar = array[0..199] of TDioChar;
  TLongChar = array[0..499] of TDioChar;

const

  { Количество полей группы данных }

  HDataCount = 13;                  // HData (без поля Date и поля Hr)
  HDataExCount = HDataCount + 10;   // HDataEx (без поля Date и поля Hr)
  ExHDataCount = 2;                 // Данные Data и Hr
  CSDataCount = 17;                 // CSData
  KDataCount = 5;                   // K

  {Общее количество полей  данных}

  AllDataCount = HDataExCount + ExHDataCount + KDataCount;

type

  { Массив данных }

  TDioFloatArray = array of TDioFloat;

  { Массив данных HData }

  THDataArray = array[0..HDataCount - 1] of TDioFloat;

  { Массив данных HDataEx }

  THDataExArray = array[0..HDataExCount - 1] of TDioFloat;

  { Массив данных CSData }

  TCSDataArray = array[0..CSDataCount - 1] of TDioFloat;

  { Массив данных К для структуры CS}

  TCSKArray = array[0..KDataCount - 1] of TDioFloat;

type

  { Тип для сохранения и загузки данных из файла }

  THDataFRec = record
    Date: TDateChar;
    Hr: byte;
    HData: THDataArray;
  end;

  { Описание основной группы данных }

  THDataRec = record
    Date: TDioStr;
    Hr: byte;
    HData: THDataArray;
  end;

  { Описание дополнительной группы данных }

  THDataExRec = record
    Date: TDioStr;
    Hr: byte;
    HDataEx: THDataExArray;
  end;

  { Структура CS }

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

  { Структура для описания информации о приборе, сохраняется в отдельном файле }

  TDioInfoRec = record
    Addr: TShortChar;
    Owner: TShortChar;
    Res01: TLongChar;
    Res02: TLongChar;
  end;

const

  { Размер элемента в байтах }

  ElementSize = SizeOf(TDioFloat);

  { Размеры структуры данных THDataFRec в байтах }

  HDataFRecSize = SizeOf(THDataFRec);

  { Размеры структуры данных THDataRec в байтах }

  HDataRecSize = SizeOf(THDataRec);

  { Размеры структуры данных THDataExRec в байтах }

  HDataExRecSize = SizeOf(THDataExRec);

  { Размеры структуры данных TDescriptRec в байтах }

  DescriptRecSize = SizeOf(TDioInfoRec);

  { Размеры структуры данных TCSDataFRec в байтах }

  CSDataFRecSize = SizeOf(TCSDataFRec);

const

  { Ошибочное значение температуры}

  TError = -273;

type

  { Тип показаний, накопительные или текущие }

  TDioViewType = (vtCurrent = 0, vtSavings = 1);

  { Тип архива данных (суточный или часовой архив) }

  TDioArcType = (atNone = 0, atDay = 1, atHour = 2);

const

  { Маска, содержащая все данные прибора }

  DioMaskAllData = 'n - a o 1 2';

implementation


end.
