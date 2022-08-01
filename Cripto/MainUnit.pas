unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus;

type
  TMainForm = class(TForm)
    btnExit: TButton;
    btnStart: TButton;
    MainMenu: TMainMenu;
    mnFile: TMenuItem;
    mnOpen: TMenuItem;
    N3: TMenuItem;
    mnCreate: TMenuItem;
    N5: TMenuItem;
    mnExit: TMenuItem;
    mnSaveOrig: TMenuItem;
    mnSaveShfr: TMenuItem;
    Original: TMemo;
    OriginalToShfr: TMemo;
    ShftToOriginal: TMemo;
    mnShfr: TMenuItem;
    mnMonoalf: TMenuItem;
    mnViginer: TMenuItem;
    mnMyAlgoritm: TMenuItem;
    mnGomofon: TMenuItem;
    SaveDialog: TSaveDialog;
    mnPlayfer: TMenuItem;
    StatusBar: TStatusBar;
    Bevel1: TBevel;
    OpenDialog: TOpenDialog;
    btnDeShfr: TButton;
    procedure btnDeShfrClick(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure mnSaveShfrClick(Sender: TObject);
    procedure mnSaveOrigClick(Sender: TObject);
    procedure mnOpenClick(Sender: TObject);
    procedure mnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShfrItemClick(Sender: TObject);
  private
    procedure ShfrMonoalf(Sender: TObject);
    procedure ShfrViginer(Sender: TObject);
    procedure ShfrGomofon(Sender: TObject);
    procedure ShfrPlayfer(Sender: TObject);
    procedure MyAlgoritm(Sender: TObject);
  public
    { Public declarations }
  end;

type
  TMethodShfr = procedure(Sender: TObject);

var
  MainForm: TMainForm;
  PMethod: ^TNotifyEvent;
  Mode: byte;

implementation

uses GetKeyUnit;

{$R *.dfm}

type
  TIntegerArray = array of Integer;

// Моноалфавитная
function ChangeText1(Str: string): string;
var i: integer;
begin
  for i := 1 to Length(str) do
  begin
    Result := Result + Char(Ord(Str[i]) - 1);
  end;
end;

function ChangeText2(Str: string): string;
var i: integer;
begin
  for i := 1 to Length(str) do
  begin
    Result := Result + Char(Ord(Str[i]) + 1);
  end;
end;

function Mn1(Str: string): string;
const k1 = 3;
      k2 = 2;
var i: integer;
begin
  for i := 1 to Length(Str) do
  begin
    Result := Result + Char((Ord(Str[i])*k1 + k2) mod 256);
  end;
end;

function Mn2(Str: string): string;
const k1 = 3;
      k2 = 2;
var i: integer;
begin
  for i := 1 to Length(Str) do
  begin
    //Result := Result + Char((Ord(Str[i])*k1 + k2) mod 256);
    Result := Result + Char( ((Ord(Str[i]) - k2) div k1 ) mod 256 );
  end;
end;

// Вижинера
function Viginer1(Str: string; const Key: string): string;
var i, ln: integer;
begin
  ln := Length(Key);
  for i := 1 to Length(Str) do
  begin
    Result := Result + Char((Ord(Str[i]) + Ord(Key[i mod ln])) mod 256);
  end;
end;

function Viginer2(Str: string; const Key: string): string;
var i, ln: integer;
begin
  ln := Length(Key);
  for i := 1 to Length(Str) do
  begin
    Result := Result + Char((Ord(Str[i]) - Ord(Key[i mod ln])) mod 256);
  end;
end;

// Свой алгоритм
function My1(Str: string): string;
var i: integer;
begin
  for i := 1 to Length(str) do
  begin
    Result := Result + Char(Ord(Str[i]) - (31 mod i));
  end;
end;

function My2(Str: string): string;
var i: integer;
begin
  for i := 1 to Length(str) do
  begin
    Result := Result + Char(Ord(Str[i]) + (31 mod i));
  end;
end;

// Гомофоническая
function Gomofon1(Str: string): TIntegerArray;
var i: integer;
begin
  SetLength(Result,Length(Str));
  for i := 1 to Length(Str) do
  begin
    Result[i-1] := Ord(Str[i]) + i;
  end;
end;

function Gomofon2(AArray: TIntegerArray): string;
var i: integer;
begin
  Result := '';
  for i := 1 to Length(AArray) do
  begin
    Result  := Result + Char(AArray[i-1] - i);
  end;
end;

function Playfer1(Str: string): string;

  function CharIfRow(ch: Char): Char;
  var i: byte;
  begin
    i := Ord(ch) div 16;
    if Ord(ch) <> i * 16 + 15 then Result := Char(Ord(ch) + 1)
    else Result := Char(i * 16);
  end;

  function CharIfCol(ch: Char): Char;
  begin
    if Ord(ch) <= 239 then Result := Char(Ord(ch) + 16)
    else Result := Char(Ord(ch) - 240);
  end;

  function ChngIJ(ch: Char): Char;
  var i,j: byte;
  begin
    i := Ord(ch) div 16;
    j := Ord(ch) - 16 * i;
    Result := Char(16*j + i);
  end;

var i, lngth: integer;
    MyStr: String; r: byte;
begin
  MyStr := Str[1];
  for i := 2 to Length(Str) do
  begin
    if MyStr[Length(MyStr)] <> Str[i] then MyStr := MyStr + Str[i]
    else MyStr := MyStr + '~' + Str[i];
  end;
  MyStr := Str;
  if (Length(MyStr) mod 2) <> 0 then  MyStr := MyStr + '~';
  i := 1;
  lngth := Length(MyStr);
  while i < lngth  do
  begin
    if (Ord(MyStr[i]) mod 16)=(Ord(MyStr[i+1]) mod 16) then  // в одном столбце
    begin
      Result := Result + CharIfCol(MyStr[i]);
      Result := Result + CharIfCol(MyStr[i+1]);
      Inc(i,2);
      Continue;
    end;
    if (Ord(MyStr[i]) div 16)=(Ord(MyStr[i+1]) div 16) then // в одной строке
    begin
      Result := Result + CharIfRow(MyStr[i]);
      Result := Result + CharIfRow(MyStr[i+1]);
      Inc(i,2);
      Continue;
    end;

    r := abs((Ord(MyStr[i]) div 16) - (Ord(MyStr[i+1]) div 16));
    if (Ord(MyStr[i]) div 16) > (Ord(MyStr[i+1]) div 16) then
    begin
      Result := Result + Char(Ord(MyStr[i]) - r * 16);
      Result := Result + Char(Ord(MyStr[i+1]) + r * 16);
    end
    else begin
      Result := Result + Char(Ord(MyStr[i]) + r * 16);
      Result := Result + Char(Ord(MyStr[i+1]) - r * 16);
    end;
    Inc(i,2);
  end;
end;

function Playfer2(Str: string): string;

  function CharIfRow(ch: Char): Char;
  var i: byte;
  begin
    i := Ord(ch) div 16;
    if Ord(ch) <> i * 16 then Result := Char(Ord(ch) - 1)
    else Result := Char(i * 16 + 15);
  end;

  function CharIfCol(ch: Char): Char;
  begin
    if Ord(ch) > 15 then Result := Char(Ord(ch) - 16)
    else Result := Char(Ord(ch) + 240);
  end;

  function ChngIJ(ch: Char): Char;
  var i,j: byte;
  begin
    i := Ord(ch) div 16;
    j := Ord(ch) - 16 * i;
    Result := Char(16*j + i);
  end;

var i, lngth: integer;
    r: byte;
begin
  i := 1;
  lngth := Length(Str);
  while i < lngth  do
  begin
    if (Ord(Str[i]) mod 16)=(Ord(Str[i+1]) mod 16) then  // в одном столбце
    begin
      Result := Result + CharIfCol(Str[i]);
      Result := Result + CharIfCol(Str[i+1]);
      Inc(i,2);
      Continue;
    end;
    if (Ord(Str[i]) div 16)=(Ord(Str[i+1]) div 16) then // в одной строке
    begin
      Result := Result + CharIfRow(Str[i]);
      Result := Result + CharIfRow(Str[i+1]);
      Inc(i,2);
      Continue;
    end;

    r := abs((Ord(Str[i]) div 16) - (Ord(Str[i+1]) div 16));
    if (Ord(Str[i]) div 16) > (Ord(Str[i+1]) div 16) then
    begin
      Result := Result + Char(Ord(Str[i]) - r * 16);
      Result := Result + Char(Ord(Str[i+1]) + r * 16);
    end
    else begin
      Result := Result + Char(Ord(Str[i]) + r * 16);
      Result := Result + Char(Ord(Str[i+1]) - r * 16);
    end;
    Inc(i,2);
  end;
end;


procedure TMainForm.MyAlgoritm(Sender: TObject);
begin
  if Sender <> btnDeShfr then
  begin
    OriginalToShfr.Text := ChangeText1(Original.Text);
    ShftToOriginal.Text := ChangeText2(OriginalToShfr.Text);
  end
  else begin
    OriginalToShfr.Text := ChangeText2(Original.Text);
  end;
end;

procedure TMainForm.ShfrGomofon(Sender: TObject);
var rs: TIntegerArray; i: integer;
begin
  if Sender <> btnDeShfr then
  begin
    rs := Copy(Gomofon1(Original.Lines.Text));
    for i := 0 to Length(rs) - 1 do
    begin
      OriginalToShfr.Text := OriginalToShfr.Text + IntToStr(rs[i]);
    end;
    ShftToOriginal.Text := Gomofon2(rs);
    SetLength(rs,0);
  end;
end;

procedure TMainForm.ShfrMonoalf(Sender: TObject);
begin
  if Sender <> btnDeShfr then
  begin
    OriginalToShfr.Text := ChangeText1(Original.Text);
    ShftToOriginal.Text := ChangeText2(OriginalToShfr.Text);
  end else
  begin
    OriginalToShfr.Text := ChangeText2(Original.Text);
  end;
end;

procedure TMainForm.ShfrViginer(Sender: TObject);
begin
  if Sender <> btnDeShfr then
  begin
    OriginalToShfr.Text := Viginer1(Original.Text,Trim(GetKeyForm.edKey.Text));
    ShftToOriginal.Text := Viginer2(OriginalToShfr.Text,Trim(GetKeyForm.edKey.Text));
  end else
  begin
    OriginalToShfr.Text := Viginer2(Original.Text,Trim(GetKeyForm.edKey.Text));
  end;
end;

procedure TMainForm.ShfrPlayfer(Sender: TObject);
var tmp: string; i: integer;
begin
  if Sender = btnDeShfr then Exit;
  tmp := Playfer1(Original.Text);
  OriginalToShfr.Text := tmp;
  tmp := Playfer2(tmp);
  for i := 1 to Length(tmp) do
    if tmp[i] <> '~' then ShftToOriginal.Text := ShftToOriginal.Text + tmp[i];
end;

procedure TMainForm.ShfrItemClick(Sender: TObject);
begin
  if Sender = mnViginer then
  begin
    if GetKeyForm.ShowModal <> mrOK then Exit;
  end;
  (Sender as TMenuItem).Checked := true;
  btnStart.OnClick := TNotifyEvent(Pointer((Sender as TMenuItem).Tag)^);
  StatusBar.Panels[0].Text := 'Метод шифрования: ' +
    (Sender as TMenuItem).Caption;
  OriginalToShfr.Clear;
  ShftToOriginal.Clear;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  New(PMethod);
  PMethod^ := ShfrMonoalf;
  mnMonoalf.Tag := Integer(PMethod);
  New(PMethod);
  PMethod^ := ShfrViginer;
  mnViginer.Tag := Integer(PMethod);
  New(PMethod);
  PMethod^ := ShfrGomofon;
  mnGomofon.Tag := Integer(PMethod);
  New(PMethod);
  PMethod^ := MyAlgoritm;
  mnMyAlgoritm.Tag := Integer(PMethod);
  PMethod^ := ShfrPlayfer;
  mnPlayfer.Tag := Integer(PMethod);
  btnStart.OnClick := ShfrMonoalf;
end;



procedure TMainForm.mnCreateClick(Sender: TObject);
begin
  Original.Clear;
  OriginalToShfr.Clear;
  ShftToOriginal.Clear;
end;

procedure TMainForm.mnOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Original.Lines.LoadFromFile(OpenDialog.FileName); 
  end;
end;

procedure TMainForm.mnSaveOrigClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    Original.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TMainForm.mnSaveShfrClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    OriginalToShfr.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TMainForm.mnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.btnDeShfrClick(Sender: TObject);
begin
  btnStart.OnClick(btnDeShfr);
end;

end.
