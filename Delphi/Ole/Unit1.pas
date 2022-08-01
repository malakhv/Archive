unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.ValEdit, Vcl.ToolWin, Vcl.WinXPickers,
  Vcl.ActnColorMaps, Vcl.ActnMan, System.Win.ComObj, Vcl.OleCtnrs;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses OLE;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  //IE: Variant;
  Ole: TOleComponent;
begin
  //IE := CreateOleObject('Word.Application');
  //IE.Visible := true;
  Ole := TOleComponent.Create('Word.Application');
  if Ole.Attach then
    Ole.Visible := True;
  if Ole.HasError then ShowMessage(Ole.Name);


end;

end.
