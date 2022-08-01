unit StenaUnit;
interface
 uses ExtCtrls,Classes, Controls,TypeConstUnit;

const
      S1_Liv = 1;
      S2_Liv = 25;
      SH_Liv = 3;
       

type TStena = class(TImage)
      private
        SLiv:byte;
        TNamber:byte;
        Coord:TCrd;
      public
        constructor CreateStena(AOwnr:TComponent;Pr:TWinControl;Cr:TCrd;
                                      TypeStena:byte;ImDr:string);
        procedure DestroyStena;
        procedure Attak(povr:byte);
        function GetLiv:byte;
      end;

implementation

uses MainUnit;


constructor TStena.CreateStena(AOwnr:TComponent;Pr:TWinControl;Cr:TCrd;
                                     TypeStena:byte;ImDr:string);
begin
 Self.Create(AOwnr);
 Self.Parent := pr;
 Self.Left := Cr.X;
 Self.Top := Cr.Y;
 Self.Coord := Cr;
 if TypeStena = 1 then
 begin
  Self.SLiv := S1_Liv;
  Self.TNamber := 1;
  Self.Picture.LoadFromFile(ImDr+'Stena1.ico');
  Self.Height := 32;
  Self.Width := 32;
 end;
 if TypeStena = 2 then
 begin
  Self.SLiv := S2_Liv;
  Self.TNamber := 2;
  Self.Picture.LoadFromFile(ImDr+'Stena2.ico');
  Self.Height := 32;
  Self.Width := 32;
 end;
 if (TypeStena = 3)or(TypeStena = 4) then
 begin
  Self.SLiv := SH_Liv;
  Self.TNamber := 3;
  Self.Picture.LoadFromFile(ImDr+'Shtab.ico');
  Self.Height := 32;
  Self.Width := 32;
 end;
 Self.Visible := true;
end;

procedure TStena.DestroyStena;
begin
 Self.Visible := false;
 Self.Free;
end;

procedure TStena.Attak(povr:byte);
begin
 if Self.SLiv <=povr then Self.DestroyStena
 else Self.SLiv := Self.SLiv - povr;
end;

function TStena.GetLiv:byte;
begin
 Result:=Self.SLiv; 
end;

end.
