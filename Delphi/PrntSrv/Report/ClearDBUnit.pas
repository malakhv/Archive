unit ClearDBUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TClearDBForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClearDBForm: TClearDBForm;

implementation

{$R *.dfm}

procedure TClearDBForm.Button1Click(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TClearDBForm.Button2Click(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

end.
