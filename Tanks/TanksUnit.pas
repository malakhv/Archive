unit TanksUnit;
interface
  uses ExtCtrls,Classes, Controls,SysUtils,TypeConstUnit,Dialogs;

const interval  = 10;
      intervpyl = 5;
      TSkor     = 4;
      PSkor     = 8;
      ext       ='.bmp';





//=============================================================================

type TPyl = class(TImage)
     private
      Yron:byte;
      Napr:byte;
      Coord:TCrd;
      shag:byte;
      TnkNum:byte;
      dead:boolean;
      Skorost:byte;
      Timer:TTimer;

      function PylEnd:boolean;
     public
      constructor CreatePylya(AOwnr:TComponent;Pr:TWinControl;
                          ImDr:string;PCrd:TCrd;PNapr:byte;TnkNumber:byte);
      procedure DestroyPyl;
      procedure OnTime(Sender:TObject);
     end;


//=============================================================================
                           
type TTank = class(TImage)
     private
      Livs:byte;
      Stat:TTankState;
      Yron:byte;
      Napr:byte;
      Skorost:byte;
      Coord:TCrd;
      Timer:TTimer;
      ColvoPyl:byte;
      Pyl:TPyl;
      ImageDir:string;
      TN0 : string;
      TN1 : string;
      TN2 : string;
      TN3 : string;
      shag:byte;
     public
      Schot : integer;
      constructor CreateTank(AOwnr:TComponent;Pr:TWinControl;ImDir:string;
                                                    crd:TCrd;TnkTyp:TTankType);
      procedure Smert;
      procedure Dest;
      procedure OnTime(Sender:TObject);
      procedure ChengNapr(nnap:byte);
      procedure Go(n:byte);
      procedure SpeedSkor;
      procedure NormalSkor;
      procedure Vistrel;
      procedure Attak(pov:byte);

      function GetNapravl:byte;
      function GetStat:TTankState;
     end;


implementation
                                         
uses MainUnit;

//========================Svoi Tank============================================

constructor TTank.CreateTank(AOwnr:TComponent;Pr:TWinControl;ImDir:string;
                                                    crd:TCrd;TnkTyp:TTankType);
begin
 Self.Create(AOwnr);
 Self.Parent := pr;
 Self.Top  := crd.Y * 32;
 Self.Left := crd.X * 32;
 Self.Coord.X := crd.X;
 Self.Coord.Y := crd.Y;

 TN0 := TnkTyp.TImNapr0;
 TN1 := TnkTyp.TImNapr1;
 TN2 := TnkTyp.TImNapr2;
 TN3 := TnkTyp.TImNapr3;
 Self.Napr := TnkTyp.TankNapr;

 case Self.Napr of
  0: begin  Self.Picture.LoadFromFile(Self.TN0); end;
  1: begin  Self.Picture.LoadFromFile(Self.TN1); end;
  2: begin  Self.Picture.LoadFromFile(Self.TN2); end;
  3: begin  Self.Picture.LoadFromFile(Self.TN3); end;
 end;

 ArStStat[crd.X,crd.Y].TypeNamber := TnkTyp.TankType;

 ImageDir := ImDir;
 Self.Height := 32;
 Self.Width := 32;

 Self.Livs := TnkTyp.TankLivs;
 Self.Yron := TnkTyp.TankYron;
 Self.Skorost := TSkor;
 Timer := TTimer.Create(Self);
 Timer.Enabled := false;
 Timer.Interval := interval;
 Timer.OnTimer := OnTime;
 Self.Stat.go := false;
 Self.Stat.fir := false;
 Self.Stat.chn := false;
 Self.Stat.smr := false;
 Self.Stat.TankType := TnkTyp.TankType;
 Self.shag := 0;
 Self.Schot := 0;
 Self.ColvoPyl := 0;
 Self.Visible := true;
end;

procedure TTank.Smert;
begin
 if Self.Stat.smr <> true then
 begin
  Self.Stat.smr := true;
  ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber := 0;
  if (Self.Stat.TankType>=10)and(Self.Stat.TankType<20) then
  begin
   Pobeda := 2;
  end;
  if (Self.Stat.TankType>=20)and(Self.Stat.TankType<30) then
  begin
    Pobeda := 1;
  end;
  Self.Visible := false;
  MainForm.Caption := 'Выйграл Игрок '+IntToStr(pobeda)+'  !!!';
  Self.Dest;
 end;
end;

procedure TTank.Dest;
begin
  Self.Timer.Enabled := false;
  Self.Timer.Free;
  Self.Free;
  //Self := nil;
end;

procedure TTank.Attak(pov:byte);
begin
 if Self.Stat.smr <> true then
 begin
  if Self.Livs<=pov then Self.Smert
  else Self.Livs := Self.Livs - pov;
 end;
end;

function TTank.GetNapravl:byte;
begin
 Result := Self.Napr;
end;

function TTank.GetStat:TTankState;
begin
 Result.go  := Self.Stat.go;
 Result.fir := Self.Stat.fir;
 Result.chn := Self.Stat.chn;
 Result.smr := Self.Stat.smr;
end;

procedure TTank.ChengNapr(nnap:byte);
begin
 if (Self.Stat.go=false)and(Self.Stat.fir=false) then
 begin
  Self.Stat.chn := true;
  Self.Napr := nnap;
  case Self.Napr of
   0: begin  Self.Picture.LoadFromFile(Self.TN0); end;
   1: begin  Self.Picture.LoadFromFile(Self.TN1); end;
   2: begin  Self.Picture.LoadFromFile(Self.TN2); end;
   3: begin  Self.Picture.LoadFromFile(Self.TN3); end;
  end;
 end;
 Self.Stat.go := false;
 Self.Stat.fir := false;
 Self.Stat.chn := false;
end;

procedure TTank.OnTime;
begin
  Self.Stat.go := true;
  if Self.shag < 32 then
  begin
   if Self.Napr = 1 then Self.Top := Self.Top    - Self.Skorost;
   if Self.Napr = 2 then Self.Left := Self.Left  - Self.Skorost;
   if Self.Napr = 3 then Self.Left := Self.Left  + Self.Skorost;
   if Self.Napr = 0 then Self.Top := Self.Top    + Self.Skorost;
   if Self.shag = 16 then ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber := 0;
   Self.shag := Self.shag + Self.Skorost;
  end
  else
  begin
   Self.shag := 0;
   Self.Stat.go := false;
   Self.Coord.X := Self.Left div 32;
   Self.Coord.Y := Self.Top div 32;
   ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber := Self.Stat.TankType;
   Self.Timer.Enabled := false;
  end;
end;

procedure TTank.Go(n:byte);
var  x,y:integer;
begin
if (Self.Stat.go = false) then
begin
 if Self.Napr = n then
 begin
   x := Self.Left div 32;
   y := Self.Top div 32;

   if (Self.Napr = 1)and(Self.Top>=32) then
   begin
    if (ArStStat[x,y-1].TypeNamber=0)or(ArStStat[x,y-1].TypeNamber=30)then
    begin
      Self.shag := 0;
      Self.Timer.Enabled := true;
      exit;
    end else exit;
   end;

   if (Self.Napr = 2)and(Self.Left>=32) then
   begin
    if (ArStStat[x-1,y].TypeNamber=0)or(ArStStat[x-1,y].TypeNamber=30)then
    begin
      Self.shag := 0;
      Self.Timer.Enabled := true;
      exit;
    end else exit;
   end;

   if (Self.Napr = 3)and(Self.Left<=576) then
   begin
    if (ArStStat[x+1,y].TypeNamber=0)or(ArStStat[x+1,y].TypeNamber=30)then
    begin
      Self.shag := 0;
      Self.Timer.Enabled := true;
      exit;
    end else exit;
   end;

   if (Self.Napr = 0)and(Self.Top<=416) then
   begin
    if (ArStStat[x,y+1].TypeNamber=0)or(ArStStat[x,y+1].TypeNamber=30)then
    begin
      Self.shag:=0;
      Self.Timer.Enabled := true;
      exit;
    end else exit;
   end;
 end else Self.ChengNapr(n);
end;
end;

procedure TTank.SpeedSkor;
begin
 if not Self.Stat.go then Self.Timer.Interval := interval div 10;
end;

procedure TTank.NormalSkor;
begin
 if not Self.Stat.go then Self.Timer.Interval := interval;
end;

procedure TTank.Vistrel;
begin
 Pyl:=TPyl.CreatePylya(Self.GetParentComponent,Self.Parent,Self.ImageDir,Self.Coord,Self.Napr,Self.Stat.TankType);
end;

//=============================================================================

constructor TPyl.CreatePylya(AOwnr:TComponent;Pr:TWinControl;
                         ImDr:string; PCrd:TCrd;PNapr:byte;TnkNumber:byte);
begin
 Self.Create(AOwnr);
 Self.Parent := Pr;
 Self.Top := PCrd.Y * 32;
 Self.Left := PCrd.X * 32;
 Self.Coord.X := PCrd.X;
 Self.Coord.Y := PCrd.Y;
 Self.Picture.LoadFromFile(ImDr+'Pyl'+IntToStr(PNapr)+'.bmp');
 Self.Height := 32;
 Self.Width := 32;
 Self.Napr := PNapr;
 Self.Skorost := PSkor;
 Self.shag := 0;
 Self.TnkNum := TnkNumber;
 Self.dead := false;
 Self.Yron := TYron;
 Self.Timer := TTimer.Create(Self);
 Self.Timer.Enabled := false;
 Self.Timer.OnTimer := OnTime;
 Self.Timer.Interval := intervpyl;
 Self.Visible := true;
 Self.Timer.Enabled := true;
end;

procedure TPyl.DestroyPyl;
begin
 if Self.dead then ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber := 0;
 Self.Timer.Enabled := false;
 Self.Timer.Free;
 Self.Free;
end;

function TPyl.PylEnd:boolean;
begin
 Result := true;
 if (Self.Top >= 0)and(Self.Top <= 448)and(Self.Left>= 0)and(Self.Left<= 608)then Result := false;
end;

procedure TPyl.OnTime(Sender:TObject);
begin
 if (Svoi<>nil)and(Vrag<>nil) then
 begin
   if Self.Napr = 1 then Self.Top := Self.Top    - Self.Skorost;
   if Self.Napr = 2 then Self.Left := Self.Left  - Self.Skorost;
   if Self.Napr = 3 then Self.Left := Self.Left  + Self.Skorost;
   if Self.Napr = 0 then Self.Top := Self.Top    + Self.Skorost;
   Self.shag := Self.shag + Self.Skorost;

   if Self.shag = 16 then
   begin
     ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber := 0;
     case Self.Napr of
       0: begin Self.Coord.Y := Self.Coord.Y + 1; end;
       1: begin Self.Coord.Y := Self.Coord.Y - 1; end;
       2: begin Self.Coord.X := Self.Coord.X - 1; end;
       3: begin Self.Coord.X := Self.Coord.X + 1; end;
     end;
   end;
   if Self.shag >= 32 then Self.shag := 0;

   if (ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber>0)and
                    (ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber<10) then
   begin
    if ArStena[Self.Coord.X,Self.Coord.Y].GetLiv<=Self.Yron then
    begin
      if ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber = 3 then Svoi.Smert;
      if ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber = 4 then Vrag.Smert;
      ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber := 0;
      Self.dead := true;
    end;
    ArStena[Self.Coord.X,Self.Coord.Y].Attak(Self.Yron);
    Self.DestroyPyl;        
    exit;
   end;
//------------------------------------------------------------------------
 if Vrag.Stat.smr <> true then
 begin
  if(Vrag.Coord.X = Self.Coord.X)and(Vrag.Coord.Y = Self.Coord.Y)then
  begin
   if Self.TnkNum = Svoi.Stat.TankType then
   begin
    if Vrag.Livs <=Self.Yron then
    begin
      ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber := 0;
      Self.dead := true;
    end;
    Vrag.Attak(Self.Yron);
    Self.DestroyPyl;
    exit;
   end;
   exit;
  end;
 end;

 if Svoi.Stat.smr <> true then
 begin
   if(Svoi.Coord.X = Self.Coord.X)and(Svoi.Coord.Y = Self.Coord.Y)then
   begin
   if Self.TnkNum = Vrag.Stat.TankType then
   begin
    if Svoi.Livs <=Self.Yron then
    begin
      ArStStat[Self.Coord.X,Self.Coord.Y].TypeNamber := 0;
      Self.dead := true;
    end;
    Svoi.Attak(Self.Yron);
    Self.DestroyPyl;
    exit;
   end;
   exit;
  end;
 end;
 //-------------------------------------------------------------------------
   if Self.PylEnd then Self.DestroyPyl;
 end;
end;

end.
