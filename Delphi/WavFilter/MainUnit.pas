unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

const coef = 32767 / 20000;

type
  TMainForm = class(TForm)
    Button1: TButton;
    OpenDialog: TOpenDialog;
    btnFMax: TButton;
    Edit1: TEdit;
    btnEffekt: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btnFMin: TButton;
    edSave: TEdit;
    SaveDialog: TSaveDialog;
    btnSavePath: TSpeedButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnFMaxClick(Sender: TObject);
    procedure btnFMinClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSavePathClick(Sender: TObject);
    procedure btnEffektClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  FileName: TFileName;

implementation

uses WAVUnit;

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
begin
 if OpenDialog.Execute then
 begin
   LoadFromFile(OpenDialog.FileName);
   Label8.Caption := IntToStr(Header.BytePerSec);
   Label5.Caption := IntToStr(Header.FileSize);
   Label6.Caption := IntToStr(Header.Chanel);
   Label7.Caption := IntToStr(Header.Hz);
   btnFMax.Enabled := true;
   btnFMin.Enabled := true;
   btnEffekt.Enabled := true;
 end;
end;

procedure TMainForm.btnFMaxClick(Sender: TObject);
var m,k: TDataElement;
begin
  k := StrToInt(Edit1.Text);
  if k < 20 then k := 0;
  m := Round(k * coef);
  if FileName  = '' then FileName := 'D:\Study\Filter.wav';
  Filter(m,FileName,true);
end;

procedure TMainForm.btnFMinClick(Sender: TObject);
var m,k: TDataElement;
begin
  k := StrToInt(Edit1.Text);
  if k < 20 then k := 0;
  m := Round(k * coef);
  if FileName  = '' then FileName := 'D:\Study\Filter.wav';
  Filter(m,FileName,false);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FileName := 'D:\Study\Filter.wav';
end;

procedure TMainForm.btnSavePathClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    edSave.Text := SaveDialog.FileName;
    FileName := SaveDialog.FileName;
  end;
end;

procedure TMainForm.btnEffektClick(Sender: TObject);
begin
  if FileName  = '' then FileName := 'D:\Study\Filter.wav';
  Effect(FileName);
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  if FileName  = '' then FileName := 'D:\Study\Filter.wav';
  Effect2(FileName);
end;

end.
