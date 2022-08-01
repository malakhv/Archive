unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, Buttons, FileCtrl,ShellAPI;

type TSendInfo = record
       CompCount: integer;
       SendOK: integer;
     end;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Panel2: TPanel;
    SendBox: TComboBox;
    SendMemo: TMemo;
    ExitBtn: TBitBtn;
    SendBtn: TBitBtn;
    SaveBtn: TBitBtn;
    FileList: TFileListBox;
    N2: TMenuItem;
    MenuExit: TMenuItem;
    MenuSave: TMenuItem;
    N6: TMenuItem;
    MenuNew: TMenuItem;
    MenuClear: TMenuItem;
    N5: TMenuItem;
    MenuSend: TMenuItem;
    N4: TMenuItem;
    RefreshList: TMenuItem;
    N7: TMenuItem;
    MenuDel: TMenuItem;
    N3: TMenuItem;
    N8: TMenuItem;
    procedure SendBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure SendBoxSelect(Sender: TObject);
    procedure MenuNewClick(Sender: TObject);
    procedure SendMemoChange(Sender: TObject);
    procedure SendBtnClick(Sender: TObject);               
    procedure MenuClearClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure MenuDelClick(Sender: TObject);
    procedure RefreshListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N8Click(Sender: TObject);
  private
    procedure RefreshSendBox;
    procedure ConvTextFileDosToWin(DosFileName:string;WinFileName:string);
    function FindSendBox(findstr:string):integer;
    function GetComp:boolean;
    function LoadComp:boolean;
    function GetStrNoSpase(StrSps:string):string;
    function DelPerenos(strper:string):string;
    function Send(CmpName:string;SString:string):boolean;
    function DelFileUndo(fln:TFileName):boolean;
    function TextDosToWin(DosString:string):string;
    function GetSendInfo:TSendInfo;


  public
    procedure SendTextProc;
  end;

var
  MainForm: TMainForm;
  MesDir: TFileName;
  ExDir: TFileName;
  FExt: string[5];
  CompList: TStringList;
  CompFileName: TFileName;
  CountSend:integer;
  Otchot: TStringList;
  Max:integer;
  EndSend:boolean;

implementation

uses ProgresUnit, OtchotUnit;

{$R *.dfm}

function TMainForm.Send(CmpName:string;SString:string):boolean;
var pi: TProcessInformation;si: TStartupInfo; List:TStringList;
begin
 List := TStringList.Create;
 List.Clear;

 ZeroMemory(@si,sizeof(si));
 si.cb:=SizeOf(si);
 si.dwFlags := STARTF_USESHOWWINDOW;
 si.wShowWindow := SW_MINIMIZE;
 if not CreateProcess(PChar(GetEnvironmentVariable('windir')+'\system32\cmd.exe'),PChar('/c net send '+CmpName+' '+SString+' >Snd.txt'),
          nil,nil,false,0,nil,PChar(ExDir),si,pi)  then
 begin
  Result:=false;
  RaiseLastWin32Error;
  Exit;
 end;
 WaitForSingleObject(pi.hProcess,INFINITE);
 CloseHandle(pi.hProcess);
 CloseHandle(pi.hThread);
 List.LoadFromFile(ExDir+'Snd.txt');
 Otchot.Add(List.Text);
 Result := true;
 List.Free;
end;

function TMainForm.TextDosToWin(DosString:string):string;
var WinStr:array[0..999]of Char;
begin
 OemToChar(PChar(DosString),WinStr);
 Result := WinStr;
end;

procedure TMainForm.ConvTextFileDosToWin(DosFileName:string;WinFileName:string);
var List:TStringList;DosStr,WinStr:string;
begin
 if FileExists(DosFileName)then
 begin
  DosStr:='';
  WinStr:='';
  List := TStringList.Create;
  List.Clear;
  List.LoadFromFile(DosFileName);
  DosStr := List.Text;
  WinStr := TextDosToWin(DosStr);
  List.Clear;
  List.Text := WinStr;
  List.SaveToFile(WinFileName);
  List.Clear;
  List.Free;
 end;
end;

function TMainForm.GetSendInfo:TSendInfo;
var List:TStringList; i:integer; SendInfo:TSendInfo;
begin
 List := TStringList.Create;
 List.Clear;
 List.LoadFromFile(ExDir+'Snd.txt');
 for i:=0 to List.Count - 1 do
 begin
  if List.Strings[i]<>'' then
  begin
   if (List.Strings[i][1]='с')or(List.Strings[i][1]='С') then SendInfo.SendOK := SendInfo.SendOK + 1;
   if (List.Strings[i][1]='с')or(List.Strings[i][1]='С')or
                (List.Strings[i][1]='О')or(List.Strings[i][1]='о') then SendInfo.CompCount := SendInfo.CompCount+1;
  end;
 end;
 List.Clear;
 List.Free;
 Result:=SendInfo;
end;

function TMainForm.GetComp:boolean;
var pi: TProcessInformation;si: TStartupInfo;
begin
 ZeroMemory(@si,sizeof(si));
 si.cb:=SizeOf(si);
 si.dwFlags := STARTF_USESHOWWINDOW;
 si.wShowWindow := SW_MINIMIZE;
 if not CreateProcess(PChar(GetEnvironmentVariable('windir')+'\system32\cmd.exe '),PChar('/c net view >Comp.txt'),
          nil,nil,false,0,nil,PChar(ExDir),si,pi)  then
 begin
  Result:=false;
  RaiseLastWin32Error;
  CloseHandle(pi.hProcess);
  CloseHandle(pi.hThread);
  Exit;
 end;
 WaitForSingleObject(pi.hProcess,8000); //INFINITE
 CloseHandle(pi.hProcess);
 CloseHandle(pi.hThread);
 Result:=true;
 CompFileName := ExDir + 'Comp.txt';
end;

function TMainForm.DelPerenos(strper:string):string;
const ent = #13;
var i:integer;  len:integer; st:string;
begin
 Result:='';
 st := strper;
 len := Length(strper);
 for i:=1 to len do
 begin
  if (strper[i] = #13)or(strper[i] = #10)then Result := Result + ' '
  else Result := Result + strper[i];
 end;
end;

function TMainForm.GetStrNoSpase(StrSps:string):string;
var i:integer;
begin
 Result := '';
 i:=1;
 while StrSps[i]<>' ' do
 begin
  Result := Result + StrSps[i];
  i:=i+1;
 end;
end;

procedure TMainForm.SendTextProc;
var k:integer; SendStr,s:string;len:integer; SndInf:TSendInfo;
begin
 EndSend:=false;
 CountSend:=0;
 Otchot.Clear;
 Otchot.Add('==================='+DateToStr(Date)+'|'+TimeToStr(Time)+'===================');
 if (SendMemo.Lines.Count >0)and(CompList.Count > 0) then
 begin
  { //-------------
   CompList.Clear;
   CompList.Add('gffgf');
   CompList.Add('B26IVC2');
   CompList.Add('gfr3322k');
   CompList.Add('B26IVC3');
   CompList.Add('hdfjks');
   CompList.Add('MyComp');
   CompList.Add('B26IVC1');
   //------------- }
   Max := CompList.Count;
   ProgresForm.SendProgres.MaxValue := max;
   SendStr := DelPerenos(SendMemo.Lines.Text);

   for k:=0 to CompList.Count-1 do
   begin
     if EndSend then
     begin
       ProgresForm.SendProgres.Progress := 0;
       ProgresForm.CompLabel.Caption := 'Отменено пользователем';
       ProgresForm.BitBtn1.Caption := 'Закрыть';
       Exit;
     end;
     ProgresForm.CompLabel.Caption := CompList.Strings[k];
     ProgresForm.Refresh;
     if Send(CompList.Strings[k],SendStr) then CountSend := CountSend + 1;
     ProgresForm.SendProgres.Progress :=  ProgresForm.SendProgres.Progress + 1;
     ProgresForm.Refresh;
     Application.ProcessMessages;
   end;
   ProgresForm.BitBtn1.Kind := bkOK;
   ProgresForm.BitBtn1.Caption := 'Готово';
   s:='';
   len:=Length(Otchot[0]);
   for k:=1 to len do
   begin
    s:=s+'=';
   end;
   Otchot.Add(s);
   Otchot.SaveToFile(ExDir+'Snd.txt');
   ConvTextFileDosToWin(ExDir+'Snd.txt',ExDir+'Snd.txt');
   SndInf := GetSendInfo;
   ProgresForm.CompLabel.Caption := 'Данные переданы на '+IntToStr(SndInf.SendOK)+' компьютера(ов) из '+IntToStr(CompList.Count);
 end;               
end;

function TMainForm.LoadComp:boolean;
var i:integer; List: TStringList; str:string;
begin
 Result:=false;
 if FileExists(CompFileName) then
 begin
  CompList := TStringList.Create;
  CompList.Clear;

  List := TStringList.Create;
  List.Clear;
  List.LoadFromFile(CompFileName);

  for i:=0 to List.Count - 1 do
  begin
   str := List.Strings[i];
   if str<>'' then
    if  str[1]='\'  then CompList.Add(str);
  end;

  str:='';
  List.Clear;
  List.AddStrings(CompList);
  CompList.Clear;
  for i:=0 to List.Count - 1 do
  begin
   str:= GetStrNoSpase(List.Strings[i]);
   Delete(str,1,2);
   CompList.Add(str);
  end;
  //CompList.SaveToFile(ExDir+'Cmp.txt');
  List.Free;
  Result:=true;
  if CompList.Count <= 0 then Result:=False;
 end;
end;

procedure TMainForm.RefreshSendBox;
var i:integer; str:string;
begin
 SendBox.Clear;
 FileList.Update;
 if FileList.Count >0 then
 begin
  for i:=0 to FileList.Count - 1 do
  begin
    str := ChangeFileExt(FileList.Items.Strings[i],'');
    SendBox.Items.Add(str);
  end;
 end;
 SendBox.Update;
end;

function TMainForm.FindSendBox(findstr:string):integer;
var i:integer;
begin
 Result := -1;
 for i:= 0 to SendBox.Items.Count - 1 do
 begin
  if SendBox.Items.Strings[i] = findstr then
  begin
   Result := i;
   Exit;
  end;
 end;
end;

procedure TMainForm.SendBoxChange(Sender: TObject);
begin
 if (SendBox.Text<>'')and(SendMemo.Lines.Text<>'') then
 begin
  SaveBtn.Enabled := true;
  MenuSave.Enabled := true;
  SendBtn.Enabled := true;
  MenuSend.Enabled := true;
  MenuDel.Enabled := true;
 end
 else
 begin
  SaveBtn.Enabled := false;
  MenuSave.Enabled := false;
  SendBtn.Enabled := false;
  MenuSend.Enabled := false;
  MenuDel.Enabled := false;
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 ExDir := ExtractFilePath(Application.ExeName);
 MesDir := ExDir+'Mes\';
 FileList.Directory := MesDir;
 FileList.Update;
 RefreshSendBox;
 FExt := '.txt';
 Otchot := TStringList.Create;
 Otchot.Clear;
end;

procedure TMainForm.ExitBtnClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TMainForm.SaveBtnClick(Sender: TObject);
var rslt:integer;
begin
 rslt := FindSendBox(SendBox.Text);
 if rslt>=0 then
 begin
  SendMemo.Lines.SaveToFile(MesDir+SendBox.Text+FExt);
  Exit;
 end;
 if rslt = -1 then
 begin
   SendMemo.Lines.SaveToFile(MesDir+SendBox.Text+FExt);
   SendMemo.Clear;
   RefreshSendBox;
 end;
end;

procedure TMainForm.SendBoxSelect(Sender: TObject);
begin
 SendMemo.Lines.LoadFromFile(MesDir+SendBox.Text+FExt);
 MenuDel.Enabled := true;
end;

procedure TMainForm.MenuNewClick(Sender: TObject);
begin
 SaveBtn.Enabled := False;
 MenuSave.Enabled := false;
 SendBtn.Enabled := false;
 MenuSend.Enabled := false;
 MenuDel.Enabled := false;
 SendMemo.Clear;
 SendBox.Text := '';
end;

procedure TMainForm.SendMemoChange(Sender: TObject);
begin
 if SendMemo.Lines.Text<>'' then MenuClear.Enabled := true
 else MenuClear.Enabled := false;
 if (SendMemo.Lines.Text<>'')and(SendBox.Text<>'')then
 begin
  SaveBtn.Enabled := true;
  MenuSave.Enabled := true;
  SendBtn.Enabled := true;
  MenuSend.Enabled := true;
 end
 else
 begin
  SaveBtn.Enabled := false;
  MenuSave.Enabled := false;
  SendBtn.Enabled := false;
  MenuSend.Enabled := false;
 end;
end;

procedure TMainForm.SendBtnClick(Sender: TObject);
begin
 if GetComp then
 begin
   ProgresForm.Show;
   ProgresForm.Refresh;
   if LoadComp then SendTextProc
   else
   begin
    ProgresForm.Close;
    ShowMessage('Ошибка отправки сообщения');
   end;
 end
 else ShowMessage('Ошибка отправки сообщения');
end;

procedure TMainForm.MenuClearClick(Sender: TObject);
begin
 SendMemo.Clear;
 MenuClear.Enabled := false;
end;

function TMainForm.DelFileUndo(fln:TFileName):boolean;
var fos : TSHFileOpStruct;
begin
 fln:= fln+#0;
  FillChar( fos, SizeOf( fos ), 0 );
  with fos do begin
    wFunc  := FO_DELETE;
    pFrom  := PChar(fln);
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
  end;
  Result := ( 0 = ShFileOperation( fos ) );
end;

procedure TMainForm.DelBtnClick(Sender: TObject);
var fn:TFileName;
begin
 fn:= MesDir + SendBox.Text + FExt;
 if FileExists(fn) then
 begin
   DelFileUndo(fn);
   RefreshSendBox;
   SendMemo.Clear;
 end;
end;

procedure TMainForm.MenuDelClick(Sender: TObject);
var fn:TFileName;
begin
 fn:= MesDir + SendBox.Text + FExt;
 if FileExists(fn) then
 begin
   DelFileUndo(fn);
   RefreshSendBox;
   SendMemo.Clear;
   SendBtn.Enabled := false;
   MenuSend.Enabled := false;
   SaveBtn.Enabled := false;
   MenuSave.Enabled := false;
 end;
end;

procedure TMainForm.RefreshListClick(Sender: TObject);
begin
 RefreshSendBox;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Otchot.Free;
 CompList.Free;
end;

procedure TMainForm.N8Click(Sender: TObject);
var SInf:TSendInfo;
begin
 if FileExists(ExDir+'Snd.txt') then
 begin
  OtchotForm.OtchotMemo.Lines.LoadFromFile(ExDir+'Snd.txt');
  SInf:=GetSendInfo;
  OtchotForm.Caption := 'Данные переданы на '+IntToStr(SInf.SendOK)+' компьютера(ов) из '+IntToStr(SInf.CompCount);
  OtchotForm.BitBtn2.Enabled := true;
 end
 else                     
 begin
  OtchotForm.Caption := 'Файл отчета не найден';
  OtchotForm.BitBtn2.Enabled := false;
 end;
 OtchotForm.ShowModal;
end;

end.        
