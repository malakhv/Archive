unit ImTnUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, FileCtrl, Buttons;

type
  TImTnForm = class(TForm)
    TankListBox: TFileListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TankListBoxChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TankListBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImTnForm: TImTnForm;
  tek : integer;

implementation

uses MainUnit, SetTankUnit;

{$R *.dfm}

procedure TImTnForm.FormCreate(Sender: TObject);
begin
 TankListBox.Directory :=  TanksDir;
 TankListBox.Items.Delete(0);
 TankListBox.Items.Delete(0);
 tek := 0;
end;

procedure TImTnForm.BitBtn2Click(Sender: TObject);
begin
 Close;
end;

procedure TImTnForm.TankListBoxChange(Sender: TObject);
begin
 //Image1.Picture.LoadFromFile(TankListBox.FileName+'\Napr1.bmp');  
end;

procedure TImTnForm.BitBtn1Click(Sender: TObject);
var str:string;l:byte;
begin
 str := TankListBox.Items.Strings[tek];
 Delete(str,1,1);
 l := Length(str);
 Delete(str,l,1);
 TName := str;
 Close;
end;

procedure TImTnForm.TankListBoxClick(Sender: TObject);
var str,pth:string; l:byte;
begin
 tek := TankListBox.ItemIndex;
 str := TankListBox.Items.Strings[tek];
 Delete(str,1,1);
 l := Length(str);
 Delete(str,l,1);
 pth := TankListBox.Directory+'\'+str+'\'+'Napr1.bmp';
 if FileExists(pth) then
 begin
  Image1.Picture.LoadFromFile(pth);
  BitBtn1.Enabled := true;
 end;
end;

end.
