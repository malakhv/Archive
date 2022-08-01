unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    ServerName: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses netapi32;

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var inf: PWKSTA_USER_INFO_1; tmp: LPBYTE;
    res: DWORD;
begin
  res := NetWkstaUserGetInfo(nil,1,tmp);
  inf := PWKSTA_USER_INFO_1(tmp);
  if inf = nil then Exit;
  ListBox1.Items.Add('User Name     : ' + inf^.wkui1_username);
  ListBox1.Items.Add('Logon Domain  : ' +inf^.wkui1_logon_domain);
  ListBox1.Items.Add('Other domains : ' +inf^.wkui1_oth_domains);
  ListBox1.Items.Add('Logon Server  : ' +inf^.wkui1_logon_server);
  ListBox1.Items.Add('=============================');
end;

procedure TForm1.Button3Click(Sender: TObject);
var inf: PWKSTA_INFO_100; tmp: LPBYTE;
    res: DWORD;
begin
  if ServerName.Text = '' then res := NetWkstaGetInfo(nil,100,tmp)
  else res := NetWkstaGetInfo(PAnsiChar(ServerName.Text),100,tmp);
  //res := NetWkstaGetInfo(nil,100,tmp);
  inf := PWKSTA_INFO_100(tmp);
  if inf = nil then Exit;
  ListBox1.Items.Add('Computer Name : ' + inf^.wki100_computername);
  ListBox1.Items.Add('Lan Group     : ' + inf^.wki100_langroup);
  ListBox1.Items.Add('============================='); 
end;

end.
