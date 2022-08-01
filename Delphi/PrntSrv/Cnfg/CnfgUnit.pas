unit CnfgUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ToolWin, ComCtrls, Buttons, ExtCtrls, ImgList, StdCtrls,
  ActnList, ActnMan, ActnCtrls, ActnMenus, XPStyleActnCtrls;

type
  TCnfgForm = class(TForm)
    ActionManager: TActionManager;
    Images28: TImageList;
    ActionMainMenuBar: TActionMainMenuBar;
    actExit: TAction;
    actStOnTop: TAction;
    actPrinter: TAction;
    actLimits: TAction;
    actReport: TAction;
    actRAdmin: TAction;
    ActionToolBar: TActionToolBar;
    Images16: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actExitExecute(Sender: TObject);
    procedure actPrinterExecute(Sender: TObject);
    procedure actLimitsExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure actRAdminExecute(Sender: TObject);
    procedure actStOnTopExecute(Sender: TObject);
  private
    procedure SetSize;
  public
  
  end;

var
  CnfgForm: TCnfgForm;
  AppLimit, AppReport, AppPrinter, AppRAdmin: TProcessInformation;
  App:TApplication;

implementation

uses GlCnfg, ShellApi;

{$R *.dfm}

var
  AppDir: TFileName;

function Run(AppPath: TFileName): Cardinal;
begin
  Result := ShellExecute(0,nil,PAnsiChar(AppPath),nil,nil,SW_SHOWNORMAL);
end;

function RunProg(ExeFileName: TFileName):TProcessInformation;
var si: TStartupInfo;
begin
  FillChar(si,SizeOf(si),0); // заполняем нулями si
  si.cb := sizeof(si);
  si.dwFlags := startf_UseShowWindow;
  si.wShowWindow := 4;

  CreateProcess(nil,PAnsiChar(ExeFileName),nil,nil,
    false,Create_default_error_mode,nil,nil,si,Result);
end;

{ TForm1 }

procedure TCnfgForm.SetSize;
begin
  Self.Align := alTop;
  Self.AutoSize := true;
  //Self.Top   := 0;
  //Self.Left  := 0;
  Self.Width := Screen.Width;
end;

procedure TCnfgForm.FormCreate(Sender: TObject);
begin
  SetSize;
  AppDir := ExtractFilePath(Application.ExeName);
end;

procedure TCnfgForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TerminateProcess(AppLimit.hProcess,0);
  TerminateProcess(AppReport.hProcess,0);
  TerminateProcess(AppPrinter.hProcess,0);
  TerminateProcess(AppRAdmin.hProcess,0);
end;

procedure TCnfgForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TCnfgForm.actPrinterExecute(Sender: TObject);
begin
  AppPrinter := RunProg(AppDir + PrinterPath);
end;

procedure TCnfgForm.actLimitsExecute(Sender: TObject);
begin
  AppLimit := RunProg(AppDir + LimitPath);
end;

procedure TCnfgForm.actReportExecute(Sender: TObject);
begin
  AppReport := RunProg(AppDir + ReportPath);
end;

procedure TCnfgForm.actRAdminExecute(Sender: TObject);
begin
  AppRAdmin := RunProg(AppDir + RAdminPath);
end;

procedure TCnfgForm.actStOnTopExecute(Sender: TObject);
begin
  if actStOnTop.Checked then
    Self.FormStyle := fsStayOnTop
  else
    Self.FormStyle := fsNormal;
end;

end.
