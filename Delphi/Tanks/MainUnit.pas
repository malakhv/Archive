unit MainUnit;

interface            

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,StenaUnit,TanksUnit,TypeConstUnit,LevelUnit,
  StdCtrls, AppEvnts;

type TArrayStena = array[0..19,0..14] of TStena;

type              
  TMainForm = class(TForm)
    Pole: TPanel;
    OpLDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure GetImageDir;
    procedure CreateStens(mas:TArrayStenaStat);
    procedure InitLevel(LevelNumber:byte);
  public
    //Declared
  end;

const
      FX = 648;
      FY = 507;
      Shag = 16;
var
  MainForm: TMainForm;
  ImageDir:TFileName;
  Dir:TFileName;
  ArStena : TArrayStena;
  ArStStat: TArrayStenaStat;
  Stena:TStena;
  Svoi:TTank;
  Vrag:TTank;
  Level:TLevel;
  LInf:TLevelInfo;
  Pobeda : byte;

implementation

{$R *.dfm}                    

procedure TMainForm.GetImageDir;
begin
 ImageDir := ExtractFilePath(Application.ExeName) + 'Image\';
end;

procedure TMainForm.CreateStens(mas:TArrayStenaStat);
var i,j:integer; Cr:TCrd;
begin                        
 for i:= 0 to 19 do
 for j:=0 to 14 do
 begin
  ArStena[i,j]:=nil;
  if (mas[i,j].TypeNamber>0)and(mas[i,j].TypeNamber<10) then
  begin
    Cr.X := i*32;
    Cr.Y := j*32;
    ArStena[i,j]:=TStena.CreateStena(Pole,Pole,cr,mas[i,j].TypeNamber,ImageDir);
  end
  else ArStena[i,j]:=nil;
 end;
end;

procedure TMainForm.InitLevel(LevelNumber:byte);
var i,j:integer;  cr:TCrd;  t1,t2:TTankType;
begin
 for i:=0 to 19 do
  for j:=0 to 14 do
  begin
   ArStStat[i,j].TypeNamber   := 0;
  end;
    Level := TLevel.Create(Pole);
    Level.Init;
    Level.LoadLeve;
    ArStStat := Level.LevelInfo.ArSt;
    CreateStens(ArStStat);
    t1 := Level.LevelInfo.Tank1;
    t1.TImNapr0 := Dir + t1.TImNapr0;
    t1.TImNapr1 := Dir + t1.TImNapr1;
    t1.TImNapr2 := Dir + t1.TImNapr2;
    t1.TImNapr3 := Dir + t1.TImNapr3;
    t2 := Level.LevelInfo.Tank2;
    t2.TImNapr0 := Dir + t2.TImNapr0;
    t2.TImNapr1 := Dir + t2.TImNapr1;
    t2.TImNapr2 := Dir + t2.TImNapr2;
    t2.TImNapr3 := Dir + t2.TImNapr3;
    cr.X := Level.LevelInfo.Tank1Crd.X;
    cr.Y := Level.LevelInfo.Tank1Crd.Y;
    Svoi := TTank.CreateTank(Pole,Pole,ImageDir,cr,t1);
    cr.X  := Level.LevelInfo.Tank2Crd.X;
    cr.Y  := Level.LevelInfo.Tank2Crd.Y;
    Vrag := TTank.CreateTank(Pole,Pole,ImageDir,cr,t2);
    Pobeda := 0;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 GetImageDir;
 Dir := ExtractFilePath(Application.ExeName);
 MainForm.Width := FX;
 MainForm.Height := FY;
 InitLevel(1);
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
var tst1,tst2:TTankState;
begin
 tst1 := Svoi.GetStat;
 if (Svoi<>nil)and(tst1.smr<>true) then
 begin
   if (key='a')or(key='ô')then
   begin
    Svoi.Go(2);
    exit;
   end;
   if (key='w')or(key='ö')then
   begin
    Svoi.Go(1);
    exit;
   end;
   if (key='d')or(key='â')then
   begin
    Svoi.Go(3);
    exit;
   end;
   if (key='s')or(key='û')then
   begin
    Svoi.Go(0);
    exit;
   end;
 end;
 tst2 := Vrag.GetStat;
 if (Vrag<>nil)and(tst2.smr<>true) then
 begin
   if (key='l')or(key='ä')then
   begin
    Vrag.Go(2);
    exit;
   end;
   if (key='p')or(key='ç')then
   begin
    Vrag.Go(1);
    exit;
   end;
   if (key='''')or(key='ý')then
   begin
    Vrag.Go(3);
    exit;
   end;
   if (key=';')or(key='æ')then
   begin
    Vrag.Go(0);
    exit;
   end;
 end;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var tst:TTankState;
begin
 if (Svoi<>nil)and(Vrag<>nil)then
 begin
   if (key=Ord('2'))or(key=Ord('é'))or(key=Ord('z'))or(key=Ord('ÿ')) then
   begin
    tst := Svoi.GetStat;
    if tst.smr <> true then Svoi.Vistrel;
   end;

   if (key=Ord('0'))or(key=Ord('õ'))or(key=Ord('/'))or(key=Ord('.')) then
   begin
    tst := Vrag.GetStat;
    if tst.smr <> true then Vrag.Vistrel;
   end;
 end;
end;

end.
