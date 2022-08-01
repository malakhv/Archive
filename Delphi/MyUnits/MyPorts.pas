unit MyPorts;

interface

uses Windows, Classes;

type

  TCustomPort = class(TPersistent)
  public
    class function PortReadByte(PortAddress: Word): Byte;
    class function PortReadWord(PortAddress: Word): Word;
    class function PortReadDWord(PortAddress: Word): DWord;
    class function PortGetBit(PortAddress: Word; Bit: Byte): WordBool;
    class function PortRightShift(PortAddress: Word; Val: WordBool): WordBool;
    class function PortLeftShift(PortAddress: Word; Val: WordBool): WordBool;
    class function IsDriverInstalled: Boolean;
    class procedure PortWriteByte(PortAddress: Word; Data: Byte);
    class procedure PortWriteWord(PortAddress: Word; Data: Word);
    class procedure PortWriteDWord(PortAddress: Word; Data: DWord);
    class procedure PortSetBit(PortAddress: Word; Bit: Byte);
    class procedure PortClrBit(PortAddress: Word; Bit: Byte);
    class procedure PortNotBit(PortAddress: Word; Bit: Byte);
  end;

  TPort = class(TCustomPort)
  private
    FPort: Word;
  public
    property Port: Word read FPort write FPort;
    function GetBit(Bit: Byte): boolean;
    function RightShift(Val: WordBool): WordBool;
    function LeftShift(Val: WordBool): WordBool;
    function ReadByte: Byte;
    function ReadWord: Word;
    function ReadDWord: DWord;
    procedure WriteByte(Data: Byte);
    procedure WriteWord(Data: Word);
    procedure WriteDWord(Data: DWord);
    procedure SetBit(Bit: Byte);
    procedure ClrBit(Bit: Byte);
    procedure NotBit(Bit: Byte);
    constructor Create(APort: Word); reintroduce;
  end;

implementation

uses IOLib;

{ TCustomPort }

class procedure TCustomPort.PortClrBit(PortAddress: Word; Bit: Byte);
begin
  IOLib.ClrPortBit(PortAddress,Bit);
end;

class function TCustomPort.PortGetBit(PortAddress: Word; Bit: Byte): WordBool;
begin
  Result := IOLib.GetPortBit(PortAddress,Bit)
end;

class function TCustomPort.IsDriverInstalled: Boolean;
begin
  Result := IOLib.IsDriverInstalled;
end;

class function TCustomPort.PortLeftShift(PortAddress: Word; Val: WordBool): WordBool;
begin
  Result := IOLib.LeftPortShift(PortAddress,Val);
end;

class procedure TCustomPort.PortNotBit(PortAddress: Word; Bit: Byte);
begin
  IOLib.NotPortBit(PortAddress, Bit);
end;

class function TCustomPort.PortReadByte(PortAddress: Word): byte;
begin
  Result := IOLib.PortIn(PortAddress);
end;

class function TCustomPort.PortReadDWord(PortAddress: Word): DWord;
begin
  Result := IOLib.PortDWordIn(PortAddress);
end;

class function TCustomPort.PortReadWord(PortAddress: Word): Word;
begin
  Result := IOLib.PortWordIn(PortAddress);
end;

class procedure TCustomPort.PortWriteByte(PortAddress: Word; Data: byte);
begin
  IOLib.PortOut(PortAddress,Data);
end;

class procedure TCustomPort.PortWriteDWord(PortAddress: Word; Data: DWord);
begin
  IOLib.PortDWordOut(PortAddress,Data);
end;

class procedure TCustomPort.PortWriteWord(PortAddress, Data: Word);
begin
  IOLib.PortWordOut(PortAddress, Data);
end;

class function TCustomPort.PortRightShift(PortAddress: Word; Val: WordBool): WordBool;
begin
  Result := IOLib.RightPortShift(PortAddress, Val);
end;

class procedure TCustomPort.PortSetBit(PortAddress: Word; Bit: Byte);
begin
  IOLib.SetPortBit(PortAddress, Bit);
end;

{ TPort }

procedure TPort.ClrBit(Bit: Byte);
begin
  PortClrBit(FPort,Bit);
end;

constructor TPort.Create(APort: Word);
begin
  inherited Create;
  FPort := APort;
end;

function TPort.GetBit(Bit: Byte): boolean;
begin
  Result := Boolean(PortGetBit(FPort,Bit));
end;

function TPort.LeftShift(Val: WordBool): WordBool;
begin
  Result := PortLeftShift(FPort, Val);
end;

procedure TPort.NotBit(Bit: Byte);
begin
  PortNotBit(FPort,Bit);
end;

function TPort.ReadByte: Byte;
begin
  Result := PortReadByte(FPort);
end;

function TPort.ReadDWord: DWord;
begin
  Result := PortReadDWord(FPort);
end;

function TPort.ReadWord: Word;
begin
  Result := PortReadWord(FPort);
end;

function TPort.RightShift(Val: WordBool): WordBool;
begin
  Result := PortRightShift(FPort, Val);
end;

procedure TPort.SetBit(Bit: Byte);
begin
  PortSetBit(FPort, Bit);
end;

procedure TPort.WriteByte(Data: Byte);
begin
  PortWriteByte(FPort, Data);
end;

procedure TPort.WriteDWord(Data: DWord);
begin
  PortWriteDWord(FPort, Data);
end;

procedure TPort.WriteWord(Data: Word);
begin
  PortWriteWord(FPort, Data);
end;

end.
