////////////////////////////////////////////////////////////////////////////////
// Misha. 2006.                                                               //
// Модуль для работы с wav файлами                                            //
////////////////////////////////////////////////////////////////////////////////
unit WAVUnit;
interface
uses Windows, SysUtils, Ap;

type IDRiff = record
      id: array[0..3] of char;
      end;

type TDataElement = SmallInt;


type TDataArray = array of TDataElement;
type PDataArray = ^TDataArray;

type TDataUse = (duData = 0, dutmpData = 1);

type THeader = record
       Riff      : DWord; //Заголовок файла
       FileSize  : DWord; //Размер файла
       WaveHeader: DWord; //WAV заголовок
       FormatName: DWord; //Описание формата
       FormatSize: DWord; //Размер описания формата
       TypeWave  : Word;  //Тип WAVE файла Заголовок PCM = $01
       Chanel    : Word;  //Количество каналов mono ($01) или stereo ($02)
       Hz        : DWord; //Частота дискретизации обычно 44100 Hz, 22050 Hz, ...
       BytePerSec: DWord; //байт в секунду
       Aligment  : Word;  // Выравнивание
       Capacity  : Word;  //Разрядность
       DataHeader: DWord; //Заголовок данных
       DataSize  : DWord; //Размер данных
     end;

const  header_size = SizeOf(THeader);
const  data_el_size = SizeOf(TDataElement);

var Header    : THeader;
    Data      : TDataArray;
    DoubleData: TReal1DArray;
    tmpData   : TDataArray;
    tmpHeader : THeader;
    FileName  : TFileName = '';


procedure AddData(const El: TDataElement); overload;
procedure AddData(const El: TDataElement; var DataArray: TDataArray); overload;

procedure FreeData; overload;
procedure FreeData(var DataArray: TDataArray); overload;

procedure LoadFromFile(WavFile: TFileName); overload;
procedure LoadFromFile(WavFile: TFileName;var DataArray: TDataArray); overload;

procedure SaveToFile(WavFile: TFileName); overload;
procedure SaveToFile(WavFile: TFileName; DataArray: TDataArray); overload;

procedure GetInfoWAV(WavFile: TFileName);

procedure Filter(max: TDataElement); overload
procedure Filter(max: TDataElement;DataArray: TDataArray;
                                               var dRes: TDataArray); overload;
procedure Filter(max: TDataElement; FilterFileName: TFileName;flag: boolean); overload;

procedure FilterMMX(max: TDataElement; FilterFileName: TFileName;flag: boolean);
procedure MMXFilter(dt: PDataArray;kol: integer; max: TDataElement);

procedure FilterFR(max: TDataElement; FilterFileName: TFileName);

procedure Effect(FilterFileName: TFileName);
procedure Effect2(FilterFileName: TFileName);

function CmpZer(X: TDataElement): SmallInt;


implementation

uses realfft;

//Добавление элементов в динамический массив звуковых данных
procedure AddData(const El: TDataElement);
begin
  SetLength(Data,Length(Data) + 1);
  if Length(Data) > 1 then
     Data[Length(Data) - 1] := Data[Length(Data) - 2] + El
  else Data[Length(Data) - 1] := El;
end;

procedure AddData(const El: TDataElement; var DataArray: TDataArray);
begin
  SetLength(DataArray,Length(DataArray) + 1);
  if Length(DataArray) > 1 then
     DataArray[Length(DataArray) - 1] := DataArray[Length(DataArray) - 2] + El
  else DataArray[Length(DataArray) - 1] := El;
end;
//Очистка массива звуковых данных
procedure FreeData;
begin
  SetLength(Data,0);
end;

procedure FreeData(var DataArray: TDataArray); overload;
begin
  SetLength(DataArray,0);
end;
//Загрузка звуковых данных в динамические массивы
procedure LoadFromFile(WavFile: TFileName);
var fl,ln: integer; tmp: TDataElement;
begin
  FreeData;
  if not FileExists(WavFile) then  Exit;
  try
    fl := FileOpen(WavFile,fmOpenRead);
    ln := FileRead(fl,Header,header_size);
    if ln < header_size then Exit;
    ln := FileRead(fl,tmp,data_el_size);
    while ln > 0 do
    begin
      AddData(tmp);
      ln := FileRead(fl,tmp,data_el_size);
    end;
  finally
    FileClose(fl);
  end;
end;

procedure LoadFromFile(WavFile: TFileName;var DataArray: TDataArray);
var fl,ln: integer; tmp: TDataElement;
begin
  FreeData(DataArray);
  if not FileExists(WavFile) then  Exit;
  try
    fl := FileOpen(WavFile,fmOpenRead);
    ln := FileRead(fl,Header,header_size);
    if ln < header_size then Exit;
    ln := FileRead(fl,tmp,data_el_size);
    while ln > 0 do
    begin
      AddData(tmp,DataArray);
      ln := FileRead(fl,tmp,data_el_size);
    end;
  finally
    FileClose(fl);
  end;
end;
//Сохранение звукового файла
procedure SaveToFile(WavFile: TFileName);
var fl,i: integer; tmp: TDataElement;
begin
  if WavFile = '' then Exit;
  fl := FileCreate(WavFile);
  if fl = -1 then Exit;
  FileClose(fl);
  fl := FileOpen(WavFile,fmOpenWrite);
  try
    Header.DataSize := Length(tmpData) * data_el_size;
    FileWrite(fl,Header,header_size);
    FileWrite(fl,tmpData[0],data_el_size);
    for i := 1 to Length(tmpData) - 1 do
    begin
      tmp := tmpData[i] - tmpData[i-1];
      FileWrite(fl,tmp,data_el_size);
    end;
  finally
    FileClose(fl);
  end;
end;

procedure SaveToFile(WavFile: TFileName; DataArray: TDataArray);
var fl,i: integer; tmp: TDataElement;
begin
  if WavFile = '' then Exit;
  fl := FileCreate(WavFile);
  if fl = -1 then Exit;
  FileClose(fl);
  fl := FileOpen(WavFile,fmOpenWrite);
  try
    Header.DataSize := Length(DataArray) * data_el_size;
    FileWrite(fl,Header,header_size);
    FileWrite(fl,DataArray[0],data_el_size);


    for i := 0 to Length(tmpData) - 1 do
    begin
      if i > 0 then
      begin
        tmp := tmpData[i] - tmpData[i-1];
        FileWrite(fl,tmp,data_el_size);
      end
      else FileWrite(fl,Data[i],data_el_size);
    end;

    {for i := 1 to Length(DataArray) - 1 do
    begin
      tmp := DataArray[i] - DataArray[i-1];
      FileWrite(fl,tmp,data_el_size);
    end;}
  finally
    FileClose(fl);
  end;
end;
//Чтение заголовка звукового файла
procedure GetInfoWAV(WavFile: TFileName);
var fl: integer;
begin
  if not FileExists(WavFile) then Exit;
  try
    fl := FileOpen(WavFile,fmOpenRead);
    FileRead(fl,Header,header_size);
  finally
    FileClose(fl);
  end;
end;

procedure Filter(max: TDataElement);
var i: integer; tmp: TDataElement;
begin
  FreeData(tmpData);
  for i := 0 to Length(Data) - 1 do
  begin
    if abs(Data[i]) < max then  tmp := Data[i]
    else tmp := CmpZer(Data[i]) * max;
    AddData(tmp,tmpData);
  end;
end;

procedure Filter(max: TDataElement; DataArray: TDataArray; var dRes: TDataArray);
var i: integer; tmp: TDataElement;
begin
  FreeData(dRes);
  for i := 0 to Length(DataArray) - 1 do
  begin
    if abs(DataArray[i]) < max then  tmp := DataArray[i]
    else tmp := CmpZer(DataArray[i]) * max;
    AddData(tmp,dRes);
  end;
end;

procedure Filter(max: TDataElement; FilterFileName: TFileName;flag: boolean);
var fl,i: integer; tmp: TDataElement;
begin
  if Length(tmpData) > 0 then SetLength(tmpData,0);
  if flag = true then
  begin
    for i:=0 to Length(Data) - 1 do
    begin
      if abs(Data[i]) > max then  tmp := Data[i]
      else tmp := CmpZer(Data[i]) * max;
      SetLength(tmpData,Length(tmpData) + 1);
      tmpData[Length(tmpData) - 1] := tmp;
    end;
  end else
  begin
    for i:=0 to Length(Data) - 1 do
    begin
      if abs(Data[i]) < max then  tmp := Data[i]
      else tmp := CmpZer(Data[i]) * max;
      SetLength(tmpData,Length(tmpData) + 1);
      tmpData[Length(tmpData) - 1] := tmp;
    end;
  end;

  fl := FileCreate(FilterFileName);
  if fl = -1 then Exit;
  FileClose(fl);
  fl := FileOpen(FilterFileName,fmOpenWrite);
  try
    Header.DataSize := Length(tmpData)*data_el_size;
    FileWrite(fl,Header,header_size);
    for i := 0 to Length(tmpData) - 1 do
    begin
      if i > 0 then
      begin
        tmp := tmpData[i] - tmpData[i-1];
        FileWrite(fl,tmp,data_el_size);
      end
      else FileWrite(fl,Data[i],data_el_size);
    end;
  finally
    FileClose(fl);
  end;
end;

procedure Effect(FilterFileName: TFileName);
var fl,i: integer; tmp: TDataElement;
begin
  if Length(tmpData) > 0 then SetLength(tmpData,0);
  for i := 0 to Length(Data) - 1 do
  begin
    SetLength(tmpData,Length(tmpData) + 1);
    tmpData[Length(tmpData) - 1] := Data[i];
    SetLength(tmpData,Length(tmpData) + 1);
    tmpData[Length(tmpData) - 1] := Data[i];
  end;

  fl := FileCreate(FilterFileName);
  if fl = -1 then Exit;
  FileClose(fl);
  fl := FileOpen(FilterFileName,fmOpenWrite);
  try
    Header.DataSize := Length(tmpData)*data_el_size;
    FileWrite(fl,Header,header_size);
    for i := 0 to Length(tmpData) - 1 do
    begin
      if i > 0 then
      begin
        tmp := tmpData[i] - tmpData[i-1];
        FileWrite(fl,tmp,data_el_size);
      end
      else FileWrite(fl,Data[i],data_el_size);
    end;
  finally
    FileClose(fl);
  end;
end;

procedure Effect2(FilterFileName: TFileName);
var fl,i: integer; tmp: TDataElement;
begin
  if Length(tmpData) > 0 then SetLength(tmpData,0);
  for i := 0 to Length(Data) - 1 do
  begin
    if i mod 2 = 0 then
    begin
      SetLength(tmpData,Length(tmpData) + 1);
      tmpData[Length(tmpData) - 1] := Data[i];
    end;
  end;

  fl := FileCreate(FilterFileName);
  if fl = -1 then Exit;
  FileClose(fl);
  fl := FileOpen(FilterFileName,fmOpenWrite);
  try
    Header.DataSize := Length(tmpData)*data_el_size;
    FileWrite(fl,Header,header_size);
    for i := 0 to Length(tmpData) - 1 do
    begin
      if i > 0 then
      begin
        tmp := tmpData[i] - tmpData[i-1];
        FileWrite(fl,tmp,data_el_size);
      end
      else FileWrite(fl,Data[i],data_el_size);
    end;
  finally
    FileClose(fl);
  end;
end;
//==============================================================================
procedure MMXFilter(dt: PDataArray;kol: integer; max: TDataElement);
label for1,finish,for2,finish2,next;
var tmpmin,tmpmax,tmpfilt,tmpmask: array[0..3] of word;
begin
  tmpmin[0] := max;tmpmin[1] := max;tmpmin[2] := max;tmpmin[3] := max;
  tmpmax[0] := 32767;tmpmax[1] := 32767;tmpmax[2] := 32767;tmpmax[3] := 32767;
  tmpfilt[0] := max;tmpfilt[1] := max;tmpfilt[2] := max;tmpfilt[3] := max;
  tmpmask[0] := $FFFF;tmpmask[1] := $FFFF;tmpmask[2] := $FFFF;tmpmask[3] := $FFFF;
  asm
    emms
	 	movq mm7,tmpmin;  //mm7=min
		movq mm6,tmpmax;  //mm6=max
		movq mm4,tmpfilt;  //filter
		movq mm3,tmpmask;  //mm3=FFFF

		mov	esi,tmpData;
		mov	edi,esi; //edi=mas+i
		add	esi,kol; //esi=mas+kol
		add	esi,kol; //esi=mas+kol*2
		for1:
		   cmp	edi,esi; //for1
		   jnb	finish;
			movq mm5,[edi];  //mm5=mas[i]
			movq mm0,mm7;
			PCMPGTW mm0,mm5; //mm0=(min>mas[i])
			movq mm1,mm5;
			PCMPGTW mm1,mm6; //mm1=(mas[i]>max)
			por	 mm0,mm1;    //mm0=(min>mas[i]||mas[i]>max)
			PAND mm5,mm0;

			pxor mm0,mm3;    //mm0=!(min>mas[i]||mas[i]>max)
			PAND mm0,mm4;

			por  mm5,mm0
			movq [edi],mm5;
			add edi,8;
			jmp	for1;
		finish:
		emms;
		sub edi,8;
		mov dx,max;   //dx=0
		for2:
		   cmp	edi,esi; //for2
		   jnb	finish2;
			mov ax,[edi];
			cmp ax,bx;
			jb next
			cmp ax,cx;
			ja next
				mov	[edi],dx;
			next:
			inc	edi;
			inc	edi;
			jmp	for2;
		finish2:
  end;
end;

procedure FilterMMX(max: TDataElement; FilterFileName: TFileName; flag: boolean);
label for1,finish,for2,finish2,next;
var fl,i,kol: integer; tmp,min,mx: TDataElement;
    tmpmin,tmpmax,tmpfilt,tmpmask: array[0..3] of word;
begin
  SetLength(tmpData,0);
  SetLength(tmpData,Length(Data));
  for i := 0 to Length(Data) - 1 do
  begin
    tmpData[i] := abs(Data[i]);
  end;
  kol := Length(tmpData) - 1;
  //MMXFilter(@tmpData,kol,max);
  ///--------------------------------------------------------------------------
  kol := Length(tmpData) - 1;
  mx := 32767;
  if flag = true then
  begin
    tmpmin[0] := max;tmpmin[1] := max;tmpmin[2] := max;tmpmin[3] := max;
    tmpmax[0] := 32767;tmpmax[1] := 32767;tmpmax[2] := 32767;tmpmax[3] := 32767;
  end else
  begin
    tmpmin[0] := 0;tmpmin[1] := 0;tmpmin[2] := 0;tmpmin[3] := 0;
    tmpmax[0] := max;tmpmax[1] := max;tmpmax[2] := max;tmpmax[3] := max;
  end;
  tmpfilt[0] := max;tmpfilt[1] := max;tmpfilt[2] := max;tmpfilt[3] := max;
  tmpmask[0] := $FFFF;tmpmask[1] := $FFFF;tmpmask[2] := $FFFF;tmpmask[3] := $FFFF;
  asm
    emms
	 	movq mm7,tmpmin;  //mm7=min
		movq mm6,tmpmax;  //mm6=max
		movq mm4,tmpfilt;  //filter
		movq mm3,tmpmask;  //mm3=FFFF

		mov	esi,tmpData;
		mov	edi,esi; //edi=mas+i
		add	esi,kol; //esi=mas+kol
		add	esi,kol; //esi=mas+kol*2
		for1:
		   cmp	edi,esi; //for1
		   jnb	finish;
			movq mm5,[edi];  //mm5=mas[i]
			movq mm0,mm7;
			PCMPGTW mm0,mm5; //mm0=(min>mas[i])
			movq mm1,mm5;
			PCMPGTW mm1,mm6; //mm1=(mas[i]>max)
			por	 mm0,mm1;    //mm0=(min>mas[i]||mas[i]>max)
			PAND mm5,mm0;

			pxor mm0,mm3;    //mm0=!(min>mas[i]||mas[i]>max)
			PAND mm0,mm4;

			por  mm5,mm0
			movq [edi],mm5;
			add edi,8;
			jmp	for1;
		finish:
		emms;
		sub edi,8;  //
		mov dx,max;   //dx=0
		for2:
		   cmp	edi,esi; //for2
		   jnb	finish2;
			mov ax,[edi];
			cmp ax,bx;
			jb next
			cmp ax,cx;
			ja next
				mov	[edi],dx;
			next:
			inc	edi;
			inc	edi;
			jmp	for2;
		finish2:
    emms;
  end;
  ///--------------------------------------------------------------------------
  for i := 0 to Length(Data) - 1 do
  begin
    tmpData[i] := CmpZer(Data[i]) * tmpData[i];
  end;

  fl := FileCreate(FilterFileName);
  if fl = -1 then Exit;
  FileClose(fl);
  fl := FileOpen(FilterFileName,fmOpenWrite);
  try
    Header.DataSize := Length(tmpData)*data_el_size;
    FileWrite(fl,Header,header_size);
    for i := 0 to Length(tmpData) - 1 do
    begin
      if i > 0 then
      begin
        tmp := tmpData[i] - tmpData[i-1];
        FileWrite(fl,tmp,data_el_size);
      end
      else FileWrite(fl,Data[i],data_el_size);
    end;
  finally
    FileClose(fl);
  end;
end;
//==============================================================================
procedure FilterFR(max: TDataElement; FilterFileName: TFileName);
var fl,i: integer; tmp: TDataElement;
begin
  //ConvertDataFromDouble;
  RealFastFourierTransform(DoubleData,16384,false);
  //DoubleToWORD;

  for i:=0 to Length(tmpData) - 1 do
  begin
    if tmpData[i] > max then  tmpData[i] := max;
    DoubleData[i] := tmpData[i];
  end;

  RealFastFourierTransform(DoubleData,16384,true);

  for i := 0 to Length(DoubleData) - 1 do
  begin
    tmpData[i] := round(DoubleData[i]);
  end;

  fl := FileCreate(FilterFileName);
  if fl = -1 then Exit;
  FileClose(fl);
  fl := FileOpen(FilterFileName,fmOpenWrite);
  try
    Header.DataSize := Length(tmpData)*data_el_size;
    FileWrite(fl,Header,header_size);
    for i := 0 to Length(tmpData) do
    begin
      if i > 0 then
      begin
        tmp := tmpData[i] - tmpData[i-1];
        FileWrite(fl,tmp,data_el_size);
      end
      else FileWrite(fl,Data[i],data_el_size);
    end;
  finally
    FileClose(fl);
  end;
end;

function CmpZer(X: TDataElement): SmallInt;
begin
  if X >= 0 then Result := 1 else
  Result := -1;
end;



end.
