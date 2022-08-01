unit NtPrntSrvcUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TNetService = class(TService)
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  NetService: TNetService;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  NetService.Controller(CtrlCode);
end;

function TNetService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

end.
