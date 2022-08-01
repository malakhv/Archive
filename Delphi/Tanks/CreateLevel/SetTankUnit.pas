unit SetTankUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, StdCtrls, Buttons, ExtCtrls,TypeConstUnit, Spin;

type
  TSTForm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    T1Image0: TImage;
    T2Image0: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpImageDialog: TOpenPictureDialog;
    T1LivEdit: TSpinEdit;
    T1YronEdit: TSpinEdit;
    T1TypeEdit: TSpinEdit;
    T2YronEdit: TSpinEdit;
    T2TypeEdit: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    T2LivEdit: TSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    T2NaprEdit: TSpinEdit;
    T1NaprEdit: TSpinEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure T1LivEditChange(Sender: TObject);
    procedure T2LivEditChange(Sender: TObject);
    procedure T1YronEditChange(Sender: TObject);
    procedure T2YronEditChange(Sender: TObject);
    procedure T1TypeEditChange(Sender: TObject);
    procedure T2TypeEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  STForm : TSTForm;
  Tnk1 : TTankType;
  Tnk2 : TTankType;
  TName:string;


implementation

uses MainUnit, ImTnUnit;

{$R *.dfm}

procedure TSTForm.BitBtn2Click(Sender: TObject);
begin
 Close;
end;

procedure TSTForm.SpeedButton1Click(Sender: TObject);
begin
 TName := '';
 ImTnForm.ShowModal;
 if TName <> '' then
 begin
  Tnk1.TImNapr0 := 'CreateLevel\Tanks\'+TName+'\'+'Napr0.bmp';
  Tnk1.TImNapr1 := 'CreateLevel\Tanks\'+TName+'\'+'Napr1.bmp';
  Tnk1.TImNapr2 := 'CreateLevel\Tanks\'+TName+'\'+'Napr2.bmp';
  Tnk1.TImNapr3 := 'CreateLevel\Tanks\'+TName+'\'+'Napr3.bmp';
  T1Image0.Picture.LoadFromFile(TanksDir+TName+'\'+'Napr1.bmp');
 end;
end;

procedure TSTForm.SpeedButton2Click(Sender: TObject);
begin
 TName := '';
 ImTnForm.ShowModal;
 if TName <> '' then
 begin
  Tnk2.TImNapr0 := 'CreateLevel\Tanks\'+TName+'\'+'Napr0.bmp';
  Tnk2.TImNapr1 := 'CreateLevel\Tanks\'+TName+'\'+'Napr1.bmp';
  Tnk2.TImNapr2 := 'CreateLevel\Tanks\'+TName+'\'+'Napr2.bmp';
  Tnk2.TImNapr3 := 'CreateLevel\Tanks\'+TName+'\'+'Napr3.bmp';
  T2Image0.Picture.LoadFromFile(TanksDir+TName+'\'+'Napr1.bmp');
 end;
end;

procedure TSTForm.T1LivEditChange(Sender: TObject);
begin
 Tnk1.TankLivs := byte(T1LivEdit.Value);
end;

procedure TSTForm.T2LivEditChange(Sender: TObject);
begin
 Tnk2.TankLivs := byte(T2LivEdit.Value);
end;

procedure TSTForm.T1YronEditChange(Sender: TObject);
begin
 Tnk1.TankYron := byte(T1YronEdit.Value);
end;

procedure TSTForm.T2YronEditChange(Sender: TObject);
begin
 Tnk2.TankYron := byte(T2YronEdit.Value);
end;

procedure TSTForm.T1TypeEditChange(Sender: TObject);
begin
 Tnk1.TankType := byte(T1TypeEdit.Value);
end;

procedure TSTForm.T2TypeEditChange(Sender: TObject);
begin
 Tnk2.TankType := byte(T2TypeEdit.Value);
end;

procedure TSTForm.FormCreate(Sender: TObject);
begin
 OpImageDialog.InitialDir := ExtractFilePath(Application.ExeName);
 Tnk1.TImNapr0 := '';
 Tnk1.TImNapr1 := '';
 Tnk1.TImNapr2 := '';
 Tnk1.TImNapr3 := '';

 Tnk2.TImNapr0 := '';
 Tnk2.TImNapr1 := '';
 Tnk2.TImNapr2 := '';
 Tnk2.TImNapr3 := '';
 TName := '';
end;

procedure TSTForm.BitBtn1Click(Sender: TObject);
begin
 Tnk1.TankSkor := 4;
 Tnk2.TankSkor := 4;
 Tnk1.TankLivs := byte(T1LivEdit.Value);
 Tnk2.TankLivs := byte(T2LivEdit.Value);
 Tnk1.TankYron := byte(T1YronEdit.Value);
 Tnk2.TankYron := byte(T2YronEdit.Value);
 Tnk1.TankType := byte(T1TypeEdit.Value);
 Tnk2.TankType := byte(T2TypeEdit.Value);
 Tnk1.TankNapr := byte(T1NaprEdit.Value);
 Tnk2.TankNapr := byte(T2NaprEdit.Value);
 
 if(Tnk1.TImNapr0='')or(Tnk1.TImNapr1='')or
   (Tnk1.TImNapr2='')or(Tnk1.TImNapr3='') then  exit;

  if(Tnk2.TImNapr0='')or(Tnk2.TImNapr1='')or
   (Tnk2.TImNapr2='')or(Tnk2.TImNapr3='') then  exit;

 Level.LevelInfo.Tank1 := Tnk1;
 Level.LevelInfo.Tank2 := Tnk2;
 Form1.Tnk1Btn.Enabled := true;
 Form1.Tnk2Btn.Enabled := true;
 TnkKolv := 0;
 Close;
end;

end.
