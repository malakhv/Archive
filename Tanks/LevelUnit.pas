unit LevelUnit;

interface

uses TypeConstUnit,Dialogs,sysutils;


type TLevel = class(TOpenDialog)
     public
        LevelInfo:TLevelInfo;
        procedure Init;
        procedure LoadLeve;
        procedure SaveLavel(fln:string);
      end;



implementation

procedure TLevel.Init;
var i,j:integer;
begin
 Self.LevelInfo.LeveName := '';
 for i:=0 to 19 do
  for j:=0 to 14 do
  begin
   Self.LevelInfo.ArSt[i,j].TypeNamber := 0;
   Self.LevelInfo.ArSt[i,j].Stat := false;
  end;
 Self.LevelInfo.Tank1.TankType := 0;
 Self.LevelInfo.Tank1.TankYron := 0;
 Self.LevelInfo.Tank1.TankLivs := 0;
 //Self.LevelInfo.Tank1.TankImageName := '';
 Self.LevelInfo.Tank1Crd.X := 0;
 Self.LevelInfo.Tank1Crd.Y := 0;

 Self.LevelInfo.Tank2.TankType := 0;
 Self.LevelInfo.Tank2.TankYron := 0;
 Self.LevelInfo.Tank2.TankLivs := 0;
 //Self.LevelInfo.Tank2.TankImageName := '';
 Self.LevelInfo.Tank2Crd.X := 0;
 Self.LevelInfo.Tank2Crd.Y := 0;
end;

procedure TLevel.LoadLeve;
var LF:File of TLevelInfo; pth:string; LI:TLevelInfo;
begin
 if Self.Execute then
 begin
  pth:=Self.FileName;
  pth := ChangeFileExt(pth,'.tnl');
  AssignFile(LF,pth);
   reset(LF);
   read(LF,LI);
  CloseFile(LF);
  Self.LevelInfo := LI;
 end;
end;

procedure TLevel.SaveLavel(fln:string);
var LF:File of TLevelInfo; pth:string; LI:TLevelInfo;
begin
 if fln<>'' then
 begin
  LI := Self.LevelInfo;
  pth := ChangeFileExt(fln,'.tnl');
  AssignFile(LF,pth);
   rewrite(LF);
   write(LF,LI);
  CloseFile(LF);
 end;
end;


end.
