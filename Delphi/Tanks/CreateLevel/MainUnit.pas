unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons,LevelUnit,TypeConstUnit, StdCtrls;

type
  TForm1 = class(TForm)
    Pole: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Edit1: TEdit;
    Bevel1: TBevel;
    Tnk1Btn: TSpeedButton;
    Tnk2Btn: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SaveLevelDialog: TSaveDialog;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Tnk1BtnClick(Sender: TObject);
    procedure Tnk2BtnClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
  private
    procedure SetIm(Sender:TObject);
    function DelCrLev(nst:string):string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Cur:   byte;
  TnkKolv : byte;
  Level: TLevel;
  ImDir: TFileName;
  TanksDir :TFileName;
  Dir :TFileName;
  Shtab: byte;


implementation

uses SetTankUnit;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var Im:TImage;  i,j:integer;
begin
 ImDir := ExtractFilePath(Application.ExeName)+'Image\';
 TanksDir := ExtractFilePath(Application.ExeName)+'Tanks\';
 Dir := ExtractFilePath(Application.ExeName);
 for i:=0 to 19 do
  for j:=0 to 14 do              
  begin
   Im := TImage.Create(Pole);
   Im.Name := 'S'+IntToStr(i)+'A'+IntToStr(j);
   Im.Tag := j;
   Im.Parent := Pole;
   Im.Width := 32;
   Im.Height := 32;
   Im.Top := j*32;
   Im.Left := i*32;
   Im.Visible := true;
   Im.OnClick := SetIm;
   Im.Picture.LoadFromFile(ImDir+'S0'+'.bmp')
  end;

 Level := TLevel.Create(Pole);
 Level.Init;
 Shtab := 0;
 TnkKolv := 0;
end;

procedure TForm1.SetIm(Sender:TObject);
var x,y:integer;  st:string;
begin
 if (Cur>=10)and(Cur<20)then
 begin
  case Level.LevelInfo.Tank1.TankNapr of
   0:(Sender as TImage).Picture.LoadFromFile(Dir+DelCrLev(Level.LevelInfo.Tank1.TImNapr0));
   1:(Sender as TImage).Picture.LoadFromFile(Dir+DelCrLev(Level.LevelInfo.Tank1.TImNapr1));
   2:(Sender as TImage).Picture.LoadFromFile(Dir+DelCrLev(Level.LevelInfo.Tank1.TImNapr2));
   3:(Sender as TImage).Picture.LoadFromFile(Dir+DelCrLev(Level.LevelInfo.Tank1.TImNapr3));
  end;
  x := (Sender as TImage).Left div 32;
  y := (Sender as TImage).Top div 32;
  Level.LevelInfo.ArSt[x,y].TypeNamber := Level.LevelInfo.Tank1.TankType;
  Level.LevelInfo.ArSt[x,y].Stat := true;
  Level.LevelInfo.Tank1Crd.X := x;
  Level.LevelInfo.Tank1Crd.Y := y;
  Tnk1Btn.Enabled := false;
  Cur := 0;
  exit;
 end;
 if (Cur>=20)and(Cur<30) then
 begin
  case Level.LevelInfo.Tank2.TankNapr of
   0:(Sender as TImage).Picture.LoadFromFile(Dir+DelCrLev(Level.LevelInfo.Tank2.TImNapr0));
   1:(Sender as TImage).Picture.LoadFromFile(Dir+DelCrLev(Level.LevelInfo.Tank2.TImNapr1));
   2:(Sender as TImage).Picture.LoadFromFile(Dir+DelCrLev(Level.LevelInfo.Tank2.TImNapr2));
   3:(Sender as TImage).Picture.LoadFromFile(Dir+DelCrLev(Level.LevelInfo.Tank2.TImNapr3));
  end;
  x := (Sender as TImage).Left div 32;
  y := (Sender as TImage).Top div 32;
  Level.LevelInfo.ArSt[x,y].TypeNamber := Level.LevelInfo.Tank2.TankType;
  Level.LevelInfo.ArSt[x,y].Stat := true;
  Level.LevelInfo.Tank2Crd.X := x;
  Level.LevelInfo.Tank2Crd.Y := y;
  Tnk2Btn.Enabled := false;
  Cur := 0;
  exit;
 end;
 if (Cur>=0)and(Cur<10) then
 begin
  (Sender as TImage).Picture.LoadFromFile(ImDir+'S'+IntToStr(Cur)+'.bmp');
   x := (Sender as TImage).Left div 32;
   y := (Sender as TImage).Top div 32;
   Level.LevelInfo.ArSt[x,y].TypeNamber := Cur;
   Level.LevelInfo.ArSt[x,y].Stat := false;
   if cur = 3 then SpeedButton7.Enabled := false;
   if cur = 4 then SpeedButton8.Enabled := false;
   exit;
 end;

end;
procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 Cur := 1;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 Cur := 2;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
 Cur := 0;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
 StForm.ShowModal;
end;

procedure TForm1.Tnk1BtnClick(Sender: TObject);
begin
 Cur := Level.LevelInfo.Tank1.TankType;
end;

procedure TForm1.Tnk2BtnClick(Sender: TObject);
begin
 Cur := Level.LevelInfo.Tank2.TankType;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
 Level.LevelInfo.LeveName := Edit1.Text;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
 Level.LevelInfo.LeveName := Edit1.Text;
 Level.LevelInfo.Tank1Napr :=1;
 Level.LevelInfo.Tank2Napr := 2;
 if SaveLevelDialog.Execute then
 begin
   Level.SaveLavel(SaveLevelDialog.FileName);
 end;
end;

function TForm1.DelCrLev(nst:string):string;
begin
 Result := nst;
 Delete(Result,1,12);
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
 cur := 3;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
 cur := 4;
end;

end.
