unit InfoWayUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TWayForm = class(TForm)
    btnPanel: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MainPanel: TPanel;
    Label1: TLabel;
    lblNumber: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NodeBox: TComboBox;
    WayEdit: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WayForm: TWayForm;

implementation

{$R *.dfm}

end.
