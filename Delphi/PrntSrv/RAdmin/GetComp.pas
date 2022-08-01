unit GetComp;

interface

uses Windows, Classes; 

function FindComputers: DWORD;

var Computers: TStringList;

implementation

const
  MaxEntries = 255;


function FindComputers: DWORD;
var
  EnumWorkGroupHandle, EnumComputerHandle: THandle;
  EnumError: DWORD;
  Network: TNetResource;
  WorkGroupEntries, ComputerEntries: DWORD;
  EnumWorkGroupBuffer, EnumComputerBuffer: array[1..MaxEntries] of TNetResource;
  EnumBufferLength: DWORD;
  i, j: DWORD;
begin
  Computers.Clear;

  FillChar(Network, SizeOf(Network), 0);
  Network.dwScope := RESOURCE_GLOBALNET;
  Network.dwType  := RESOURCETYPE_ANY;
  Network.dwUsage := RESOURCEUSAGE_CONTAINER;

  EnumError := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_ANY, 0, @Network,
    EnumWorkGroupHandle);

  if EnumError = NO_ERROR then
  begin
    WorkGroupEntries := MaxEntries;
    EnumBufferLength := SizeOf(EnumWorkGroupBuffer);
    EnumError := WNetEnumResource(EnumWorkGroupHandle, WorkGroupEntries,
      @EnumWorkGroupBuffer, EnumBufferLength);

    if EnumError = NO_ERROR then
    begin
      for i := 0 to WorkGroupEntries do
      begin
        EnumError := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_ANY, 0,
          @EnumWorkGroupBuffer[I], EnumComputerHandle);
        if EnumError = NO_ERROR then
        begin
          ComputerEntries := MaxEntries;
          EnumBufferLength := SizeOf(EnumComputerBuffer);
          EnumError := WNetEnumResource(EnumComputerHandle, ComputerEntries,
            @EnumComputerBuffer, EnumBufferLength);
          if EnumError = NO_ERROR then
            for j := 1 to ComputerEntries do
              Computers.Add(String(EnumComputerBuffer[j].lpLocalName));
          WNetCloseEnum(EnumComputerHandle);
        end;
      end;
    end;
    WNetCloseEnum(EnumWorkGroupHandle);
  end;

  if EnumError = ERROR_NO_MORE_ITEMS then
    EnumError := NO_ERROR;
  Result := EnumError;
end;

initialization
begin
  Computers := TStringList.Create;
end;

finalization
begin
  Computers.Free;
end;

end.
