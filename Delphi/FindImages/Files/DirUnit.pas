unit DirUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, Buttons, ExtCtrls;

type
  TDirForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DirList: TDirectoryListBox;
    DriveComboBox: TDriveComboBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DirForm: TDirForm;

implementation

uses MainUnit;

{$R *.dfm}

procedure TDirForm.BitBtn2Click(Sender: TObject);
begin
 Close;
end;

procedure TDirForm.BitBtn1Click(Sender: TObject);
begin
 MainUnit.FindDir := DirList.Directory;
 MainUnit.MainForm.edDir.Text := DirList.Directory;
 Close;
end;

end.
