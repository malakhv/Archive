unit ConnectUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

type
  TConnectForm = class(TForm)
    ProvList: TListBox;
    Label1: TLabel;
    edPath: TEdit;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    OpenDialog: TOpenDialog;
    btnCancel: TBitBtn;
    Bevel: TBevel;
    btnOK: TBitBtn;
    edConnectStr: TEdit;
    Label3: TLabel;
    btnSaveStr: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure ProvListDblClick(Sender: TObject);
    procedure edConnectStrChange(Sender: TObject);
    procedure btnSaveStrClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConnectForm: TConnectForm;

implementation

uses TypeAndConstUnit;

{$R *.dfm}

procedure TConnectForm.SpeedButton1Click(Sender: TObject);
begin
 if OpenDialog.Execute then
 begin
   edPath.Text := OpenDialog.FileName; 
 end;
end;

procedure TConnectForm.btnOKClick(Sender: TObject);
var Provider: string;
begin
 Provider := defConnectString;
 //if ProvList.ItemIndex = 0 then Provider := defConnectString;
 BDInfo.FileName := ExtractFileName(OpenDialog.FileName); 
 BDInfo.ConnectString := Provider + edPath.Text;
 ConnectForm.ModalResult := mrOK;
end;
                
procedure TConnectForm.btnCancelClick(Sender: TObject);
begin
 ConnectForm.ModalResult := mrCancel;
end;

procedure TConnectForm.ProvListDblClick(Sender: TObject);
begin
 if ProvList.ItemIndex = 0 then EdConnectStr.Text := defConnectString
 else EdConnectStr.Text := ProvList.Items.Strings[ProvList.ItemIndex];
end;

procedure TConnectForm.edConnectStrChange(Sender: TObject);
begin
 btnOK.Enabled := edConnectStr.Text <> '';
 btnSaveStr.Enabled := edConnectStr.Text <> '';
end;

procedure TConnectForm.btnSaveStrClick(Sender: TObject);
begin
 ProvList.Items.Add(edConnectStr.Text);
 ProvList.Items.SaveToFile(BinDir + ConnectStrFileName);
end;

procedure TConnectForm.FormShow(Sender: TObject);
begin
 ProvList.Items.LoadFromFile(BinDir + ConnectStrFileName);
 if ProvList.Items.Count = 0 then
 begin
   ProvList.Items.Add(defConnectName);
 end;
end;

end.
