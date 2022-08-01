
{*******************************************************}
{                                                       }
{       TThreadCollection Class                         }
{       Unit                                            }
{                                                       }
{       Copyright (c) Малахов Михаил 2006               }
{                                                       }
{*******************************************************}

unit ThrClct;

interface

uses
  Classes, PrntNtfcThr, GlPrSrv;

type
  TThreadArray = array of TPrinterNotificationThread;

type
  TPrintersArray = array of TPrinterInfo;

type
  TThreadCollection = class(TObject)
  private
    FThreads: TThreadArray;
    FPrinters: TPrintersArray;
    FMHandle: THandle;
    function GetCount: integer;
  public
    property Count: integer read GetCount;
    constructor Create(AMHandle: THandle);
    destructor Destroy;override;
    procedure Add(APrinter: TPrinterInfo);
    procedure Clear;
    procedure Suspend;
    procedure Resume;
    function GetInfo(Index: integer): TPrinterInfo;
  end;

implementation

{ TThreadCollection }

procedure TThreadCollection.Add(APrinter: TPrinterInfo);
begin
  SetLength(FThreads,Length(FThreads) + 1);
  FThreads[Length(FThreads) - 1] :=
    TPrinterNotificationThread.Create(APrinter, FMHandle);
  SetLength(FPrinters,Length(FPrinters) + 1);
  FPrinters[Length(FPrinters) - 1] := APrinter;
end;

procedure TThreadCollection.Clear;
var i: integer;
begin
  for i := 0 to Length(FThreads) - 1 do
  begin
    if FThreads[i] = nil then Continue;
    FThreads[i].StopWait;
  end;
  SetLength(FThreads,0);
  SetLength(FPrinters,0);
end;

constructor TThreadCollection.Create(AMHandle: THandle);
begin
  inherited Create;
  FMHandle := AMHandle;
  SetLength(FThreads,0);
  SetLength(FPrinters,0);
end;

destructor TThreadCollection.Destroy;
begin
  Clear;
  inherited;
end;

procedure TThreadCollection.Resume;
var i: integer;
begin
  for i := 0 to Length(FThreads) - 1 do
  begin
    if FThreads[i] = nil then Continue;
    FThreads[i].Resume;
  end;
end;

procedure TThreadCollection.Suspend;
var i: integer;
begin
  for i := 0 to Length(FThreads) - 1 do
  begin
    if FThreads[i] = nil then Continue;
    FThreads[i].Suspend;
  end;
end;

function TThreadCollection.GetCount: integer;
begin
  Result := Length(FThreads);
end;

function TThreadCollection.GetInfo(Index: integer): TPrinterInfo;
begin
  Result := FPrinters[Index];
end;

end.
