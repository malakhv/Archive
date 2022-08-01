unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, ImgList, MImage;

type
  TStatus = (stNone = 0, stStop = 1, stRun = 2);

type
  TMainForm = class(TForm)
    HeadPanel: TPanel;
    MainPanel: TPanel;
    imgHeadStart: TImage;
    imgHead: TImage;
    imgHeadEnd: TImage;
    ImagesHead: TImageList;
    imgMin: TMImage;
    imgEx: TMImage;
    ImagesBtn: TImageList;
    imgOK: TMImage;
    imgAbort: TMImage;
    NameEdit: TEdit;
    MesEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    StatEdit: TEdit;
    imgStart: TMImage;
    Timer: TTimer;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure imgExClick(Sender: TObject);
    procedure imgMinClick(Sender: TObject);
    procedure imgHeadMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMinMouseEnter(Sender: TObject);
    procedure imgMinMouseLeave(Sender: TObject);
    procedure imgExMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOKMouseEnter(Sender: TObject);
    procedure imgOKMouseLeave(Sender: TObject);
    procedure imgOKMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOKMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMinMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgAbortClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure imgStartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NameEditChange(Sender: TObject);
  private
    FStatus: TStatus;
    function GetStatus: TStatus;
    procedure SetStatus(const Value: TStatus);

  public
    property Status: TStatus read GetStatus write SetStatus;
  end;

var
  MainForm: TMainForm;

implementation

uses ColorUnit, DlgUnit;

{$R *.dfm}

const
  Stat: array[1..2] of string = ('Stop', 'Run');

procedure SendString(h: hwnd; Str: string);
var i: integer;
begin
  for i := 0 to Length(Str) do
  begin
    SendMessage(h,WM_CHAR,Integer(Ord(Str[i])),0);
  end;
end;

function EnumChildWnd(h: HWND): BOOL; stdcall;
var ClsName, WndText: PAnsiChar;
    SendStr: string;
begin
  Result := true;

  ClsName := AllocMem(50);
  WndText := AllocMem(20);

  GetWindowText(h,WndText,20);
  GetClassName(h,ClsName,50);
  if (Trim(StrPas(ClsName)) = 'TEdit') and (Trim(StrPas(WndText)) = '') then
  begin
    SendStr := MainForm.MesEdit.Text;
    SendString(h,SendStr);
    SendMessage(h,WM_KEYDOWN,13,0);
    Result := false;
  end;

  FreeMem(WndText);
  FreeMem(ClsName);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var List: TStringList;
begin
  Status := stStop;
  MainPanel.Color := BgColor;
  NameEdit.Color  := BgColor;
  MesEdit.Color   := BgColor;
  StatEdit.Color  := BgColor;
  Label1.Font.Color := FontColor;
  Label2.Font.Color := FontColor;
  Label3.Font.Color := FontColor;

  if FileExists('Opt.ini') then
  begin
    List := TStringList.Create;
    try
      List.LoadFromFile('Opt.ini');
      NameEdit.Text := List.Values['Name'];
      MesEdit.Text  := List.Values['Mes'];
    finally
      List.Free;
    end;
  end;
end;

procedure TMainForm.imgExClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.imgMinClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.imgHeadMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DragMove = $F012;
begin
  ReleaseCapture;
  perform(WM_SysCommand, SC_DragMove, 0);
end;

procedure TMainForm.imgMinMouseEnter(Sender: TObject);
begin
  ImagesHead.GetBitmap((Sender as TImage).Tag + 1,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TMainForm.imgMinMouseLeave(Sender: TObject);
begin
  ImagesHead.GetBitmap((Sender as TImage).Tag,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TMainForm.imgExMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImagesHead.GetBitmap((Sender as TImage).Tag + 2,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TMainForm.imgOKMouseEnter(Sender: TObject);
begin
  ImagesBtn.GetBitmap((Sender as TImage).Tag + 1 -
    Integer(not(Sender as TControl).Enabled),(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TMainForm.imgOKMouseLeave(Sender: TObject);
begin
  ImagesBtn.GetBitmap((Sender as TImage).Tag,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TMainForm.imgOKMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImagesBtn.GetBitmap((Sender as TImage).Tag + 2,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TMainForm.imgOKMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var flag: byte; cPoint: TPoint;
begin
  cPoint := Mouse.CursorPos;
  cPoint := (Sender as TControl).ScreenToClient(cPoint);
  flag := byte(((cPoint.X = X)and(cPoint.Y = Y)) and
    ((X >= 0) and (Y >= 0) and (X <= (Sender as TControl).Width)
    and (Y <= (Sender as TControl).Height)));
  ImagesBtn.GetBitmap((Sender as TImage).Tag + flag,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TMainForm.imgMinMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var flag: byte;
begin
  flag := byte((X >= 0) and (Y >= 0) and (X <= (Sender as TControl).Width)
    and (Y <= (Sender as TControl).Height));
  ImagesHead.GetBitmap((Sender as TImage).Tag + flag,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TMainForm.imgAbortClick(Sender: TObject);
begin
  {DlgForm.ShowModal;
  (Sender as TImage).Invalidate;
  imgOKMouseLeave(imgOK);   }
  Status := stStop;
end;

function TMainForm.GetStatus: TStatus;
begin
  Result := FStatus;
end;

procedure TMainForm.SetStatus(const Value: TStatus);
begin
  if FStatus <> Value then
  begin
    FStatus := Value;
    imgStart.Enabled := Value <> stRun;
    imgAbort.Enabled := Value = stRun;
    Timer.Enabled := Value = stRun;
    StatEdit.Text := Stat[Integer(Value)];
  end;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
var WText: String; h: HWND;
begin
  WText := 'LT [' + Trim(NameEdit.Text) + ']';
  h := FindWindow(nil,PAnsiChar(WText));
  if h > 0 then
  begin
    EnumChildWindows(h,@EnumChildWnd,0);
  end;
end;

procedure TMainForm.imgStartClick(Sender: TObject);
begin
  Status := stRun;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var List: TStringList;
begin
  List := TStringList.Create;
  try
    List.Add('Name='+Trim(NameEdit.Text));
    List.Add('Mes='+Trim(MesEdit.Text));
    List.SaveToFile('Opt.ini');
  finally
    List.Free;
  end;
end;

procedure TMainForm.NameEditChange(Sender: TObject);
begin
  Status := stStop;
end;

end.
