unit StpUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TStpForm = class(TForm)
    btnPanel: TPanel;
    Image1: TImage;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btnCancel: TSpeedButton;
    btnOk: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StpForm: TStpForm;

implementation

uses RegUnit, ShellApi;

{$R *.dfm}

var
  AppDir: TFileName;

function Run(AppPath: TFileName): Cardinal;
begin
  Result := ShellExecute(0,'open',PAnsiChar(AppPath),nil,nil,SW_HIDE);
end;

procedure TStpForm.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TStpForm.FormCreate(Sender: TObject);
begin
  AppDir := ExtractFilePath(Application.ExeName);
end;

procedure TStpForm.btnOkClick(Sender: TObject);
var Rg: TMyReg;
begin
  Rg := TMyReg.Create(rmReadOrWrite,false);
  Rg.DBPath := AppDir;
  Rg.DBFileName := AppDir + 'Limits.mdb';
  Rg.UDBDate := Date;
  Rg.SaveOptions;
  Run(AppDir+'Stp.bat');
  Rg.Free;
  Close;
end;

end.
