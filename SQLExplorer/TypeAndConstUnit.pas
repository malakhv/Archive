unit TypeAndConstUnit;
interface

uses SysUtils;

const defConnectString = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=';
const defConnectName = 'Microsoft  Jet  OLE  DB  4.0   Provider';
const ShablonFileName = 'Shablon.shl';
const ConnectStrFileName = 'Connection string.csl';

type TBDInfo = record
      ConnectString: string;
      FileName: string;       
     end;

type TNodeType = (ntNone = 0, ntBD = 1, ntTable = 2, ntField = 3);

type TNodeData = record
      NodeType: TNodeType;
      ID: integer;
     end;

var BDInfo : TBDInfo;
    AppDir : TFileName;
    BinDir : TFileName;

implementation


end.
