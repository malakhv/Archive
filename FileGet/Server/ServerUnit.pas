unit ServerUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, tcpUnit,WinSock;

type
  TServerForm = class(TForm)
    MainMenu1: TMainMenu;
    mnServer: TMenuItem;
    mnStart: TMenuItem;
    mnStop: TMenuItem;
    N4: TMenuItem;
    mnExit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure mnStartClick(Sender: TObject);
    procedure mnStopClick(Sender: TObject);
  private
    
  public
    { Public declarations }
  end;

var
  ServerForm: TServerForm;
  tcpThread : TtcpClientWait;

implementation

uses Global;

{$R *.dfm}

procedure TServerForm.FormCreate(Sender: TObject);
var str: string;
begin
  StartWSA;
  str := GetLocalIP;
  Self.Caption := Self.Caption + str +'  '+ IPAddrToName(str);
end;

procedure TServerForm.mnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TServerForm.mnStartClick(Sender: TObject);
begin
  tcpThread := TtcpClientWait.Create(false);
end;

procedure TServerForm.mnStopClick(Sender: TObject);
begin
  tcpThread.StopSocket; 
end;

end.
