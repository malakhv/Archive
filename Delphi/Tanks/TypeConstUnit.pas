unit TypeConstUnit;

interface

const
      TLiv      = 2;
      TYron     = 1;

type TCrd = record             
        X:integer;
        Y:integer;
      end;

type TType_Object = record
        TypeNamber:byte;
        Stat:boolean;
      end;

type TTankState = record
      TankType:byte;
      go:boolean;
      fir:boolean;
      chn:boolean;
      smr:boolean;
     end;

type TArrayStenaStat = array[0..19,0..14] of TType_Object;

type TTankType = record
       TankType  : byte;
       TankYron  : byte;
       TankLivs  : byte;
       TankSkor  : byte;
       TankNapr  : byte;
       TImNapr0  : string[250];
       TImNapr1  : string[250];
       TImNapr2  : string[250];
       TImNapr3  : string[250];
     end;

type TLevelInfo = record
      LeveName:string[20];
      ArSt:TArrayStenaStat;
      Tank1:TTankType;
      Tank2:TTankType;
      Tank1Crd:TCrd;
      Tank2Crd:TCrd;
      Tank1Napr:byte;
      Tank2Napr:byte;
     end;


implementation

end.
