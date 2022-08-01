unit ThrUnit;

interface

uses
  Classes;

type
  TEnumWnd = class(TThread)
  private
    FTxt: string;
  protected
    procedure AddItem;
    procedure AddList;
    procedure Execute; override;
    procedure OnTr(Sender: TObject);
  end;

var
  FList: TStringList;

implementation

uses Windows, SysUtils, MainUnit;

function EnumChildWnd(h: HWND): BOOL; stdcall;
var ClassName: PAnsiChar;
begin
  ClassName := AllocMem(50);
  GetClassName(h,ClassName,50);
  FList.Add('      ' + StrPas(ClassName));
  Result := true;
end;

function EnumWindowsWnd(h: hwnd): BOOL; stdcall;
var WndTxt: PAnsiChar;
begin
  WndTxt := AllocMem(20);
  GetWindowText(h,WndTxt,20);
  FList.Add('Main Window: ' + StrPas(WndTxt) + ' - ' + IntToStr(h));
  FreeMem(WndTxt);
  EnumChildWindows(h,@EnumChildWnd,0);
  Result := true;
end;

procedure TEnumWnd.AddList;
begin
  //Form1.LogBox.Items.AddStrings(FList);
end;

procedure TEnumWnd.Execute;
begin
  Self.OnTerminate := OnTr;
  FList := TStringList.Create;
  while not Self.Terminated do
  begin
    EnumWindows(@EnumWindowsWnd,0);
    Sleep(1000);
    FTxt := '------------------';
    Self.Synchronize(AddItem);
  end;
  FList.Free;
end;

procedure TEnumWnd.OnTr(Sender: TObject);
begin
  Self.Synchronize(AddList);
end;

procedure TEnumWnd.AddItem;
begin
  //Form1.ListBox1.Items.Add(FTxt);
end;

end.
