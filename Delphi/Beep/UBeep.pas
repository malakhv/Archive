unit UBeep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TFormIOPortDemo = class(TForm)
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormIOPortDemo: TFormIOPortDemo;

implementation

{$R *.DFM}

// ----- low level access to ports interface -----

const
  IOPortDLL = 'IOPort.DLL';

procedure OpenIOPort; stdcall; external IOPortDLL;
procedure CloseIOPort; stdcall; external IOPortDLL;

function ReadByte(Port: DWord): Byte; stdcall; external IOPortDLL;
function ReadWord(Port: DWord): Word; stdcall; external IOPortDLL;
function ReadDWord(Port: DWord): DWord; stdcall; external IOPortDLL;
procedure WriteByte(Port: DWord; Value: Byte); stdcall; external IOPortDLL;
procedure WriteWord(Port: DWord; Value: Word); stdcall; external IOPortDLL;
procedure WriteDWord(Port: DWord; Value: DWord); stdcall; external IOPortDLL;

procedure ReadByteBuf(Port, Count: DWord; Buffer: PByte); stdcall; external IOPortDLL;
procedure ReadWordBuf(Port, Count: DWord; Buffer: PWord); stdcall; external IOPortDLL;
procedure ReadDWordBuf(Port, Count: DWord; Buffer: PDWord); stdcall; external IOPortDLL;
procedure WriteByteBuf(Port, Count: DWord; Buffer: PByte); stdcall; external IOPortDLL;
procedure WriteWordBuf(Port, Count: DWord; Buffer: PWord); stdcall; external IOPortDLL;
procedure WriteDWordBuf(Port, Count: DWord; Buffer: PDWord); stdcall; external IOPortDLL;

procedure TFormIOPortDemo.SpeedButton1Click(Sender: TObject);
var Value: Byte;
begin
  try
    OpenIOPort;

    Value := ReadByte($61);
    WriteByte($43, 182);
    WriteByte($42, $30); // set frequency
    WriteByte($42, $8);  // set frequency
    WriteByte($61, Value or 3);
    Sleep(100);
  finally
    WriteByte($61, Value);
    CloseIOPort;
  end;
end;

procedure TFormIOPortDemo.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
