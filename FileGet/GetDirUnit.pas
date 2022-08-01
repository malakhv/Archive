unit GetDirUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl, ExtCtrls;

type
  TDirForm = class(TForm)
    DirList: TDirectoryListBox;
    btnPanel: TPanel;
    Drive: TDriveComboBox;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DirForm: TDirForm;

implementation

{$R *.dfm}

end.
