unit NewFilterUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons;

type
  TNewFilterForm = class(TForm)
    btnPanel: TPanel;
    Label1: TLabel;
    UserList: TListBox;
    Label2: TLabel;
    PrList: TListBox;
    Label3: TLabel;
    CompList: TListBox;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    Label5: TLabel;
    FNameEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewFilterForm: TNewFilterForm;
  NewFilter: string;

implementation

uses MainUnit;

{$R *.dfm}

procedure TNewFilterForm.FormCreate(Sender: TObject);
begin
  MainForm.UpdateLists;
end;

procedure TNewFilterForm.btnOkClick(Sender: TObject);

  function GetSQL(FName: string; ListBox: TListBox): string;
  var i: integer; fl: string;
  begin
    fl := '';
    for i := 0 to ListBox.Count - 1 do
    begin
      if ListBox.Selected[i] then
      begin
        if fl <> '' then fl := fl + ' or ';
        fl := fl + ' rp.' + FName +' = ' +''''+ ListBox.Items.Strings[i] +'''';
      end;
    end;
    if fl <> '' then
      Result := ' ( ' + fl + ' ) '
    else Result := '';
  end;
  
var u,p,c, nf: string;
begin
  nf := '';
  u := GetSQL('UName',UserList);
  p := GetSQL('PName',PrList);
  c := GetSQL('Machine',CompList);

  if (u <> '')or(p <> '')or(c <> '') then nf :=  nf + 'where ';

  if u <> '' then
    nf :=  nf + u;
  if p <> '' then
  begin
    if u <> '' then nf :=  nf + ' and ';
    nf :=  nf + p;
  end;

  if c <> '' then
  begin
    if (u <> '')or(p <> '') then nf :=  nf + ' and ';
    nf :=  nf + c;
  end;

  if nf <> '' then NewFilter := 'Select * from Report rp ' + nf;

  Self.ModalResult := mrOk;
end;

procedure TNewFilterForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

end.
