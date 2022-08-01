unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses TCPThread;

{$R *.dfm}

var Srv: TTCPSrvr;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Srv := TTCPSrvr.Create(Self.Handle);
  Srv.Resume;
end;

end.
