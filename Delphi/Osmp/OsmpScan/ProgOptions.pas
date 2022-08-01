unit ProgOptions;

interface

uses SysUtils, MyIniFile;

const

  { Имя файла с настройками }

  nOptFile = 'options.ini';

type

  TProgOptions = class(TMyIniFile)
  private
    function GetAutoUpdate: boolean;
    function GetAutoWait: boolean;
    function GetSiteDir: TFileName;
    function GetUpdateInterval: integer;
    procedure SetAutoUpdate(const Value: boolean);
    procedure SetAutoWait(const Value: boolean);
    procedure SetSiteDir(const Value: TFileName);
    procedure SetUpdateInterval(const Value: integer);
    function GetHost: string;
    function GetPassword: string;
    function GetPort: integer;
    function GetUserName: string;
    procedure SetHost(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPort(const Value: integer);
    procedure SetUserName(const Value: string);
    function GetUpdateVer: integer;
    procedure SetUpdateVer(const Value: integer);
    function GetCopyInterval: integer;
  public
    property AutoWait: boolean read GetAutoWait write SetAutoWait;
    property AutoUpdate: boolean read GetAutoUpdate write SetAutoUpdate;
    property SiteDir: TFileName read GetSiteDir write SetSiteDir;
    property UpdateInterval: integer read GetUpdateInterval write SetUpdateInterval;
    property CopyInterval: integer read GetCopyInterval;
    property Host: string read GetHost write SetHost;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property Port: integer read GetPort write SetPort;
    property UpdateVer: integer read GetUpdateVer write SetUpdateVer;
  end;

var
  Options: TProgOptions;

implementation

const

 { Имена настроек }

  nAutoWait = 'AutoWait';
  nAutoUpdate = 'AutoUpdate';
  nSiteDir = 'SiteDir';
  nUpdateInterval = 'UpdateInterval';
  nCopyInterval = 'CopyInterval';
  nHost = 'Host';
  nUserName = 'UserName';
  nPassword = 'Password';
  nPort = 'Port';
  nUpdateVer = 'UpdateVer';

 { TProgOptions }

function TProgOptions.GetAutoUpdate: boolean;
begin
  Result := StrToBoolDef( Values[nAutoUpdate],true );
end;

function TProgOptions.GetAutoWait: boolean;
begin
  Result := StrToBoolDef( Values[nAutoWait],true );
end;

function TProgOptions.GetCopyInterval: integer;
const
  DefVal = 5;
begin
  Result := StrToIntDef(Values[nCopyInterval],DefVal) * 60000;
end;

function TProgOptions.GetHost: string;
begin
  Result := Values[nHost];
end;

function TProgOptions.GetPassword: string;
begin
  Result := Values[nPassword];
end;

function TProgOptions.GetPort: integer;
begin
  Result := StrToIntDef( Values[nPort], 21);
end;

function TProgOptions.GetSiteDir: TFileName;
begin
  Result := Values[nSiteDir];
end;

function TProgOptions.GetUpdateInterval: integer;
begin
  Result := StrToIntDef( Values[nUpdateInterval], High(Integer) );
end;

function TProgOptions.GetUpdateVer: integer;
begin
  Result := StrToIntDef( Values[nUpdateVer],0);
end;

function TProgOptions.GetUserName: string;
begin
  Result := Values[nUserName];
end;

procedure TProgOptions.SetAutoUpdate(const Value: boolean);
begin
  Values[nAutoUpdate] := IntToStr( Integer(Value) );
end;

procedure TProgOptions.SetAutoWait(const Value: boolean);
begin
  Values[nAutoWait] := IntToStr( Integer(Value) );
end;

procedure TProgOptions.SetHost(const Value: string);
begin
  Values[nHost] := Value;
end;

procedure TProgOptions.SetPassword(const Value: string);
begin
  Values[nPassword] := Value;
end;

procedure TProgOptions.SetPort(const Value: integer);
begin
  Values[nPassword] := IntToStr(Value);
end;

procedure TProgOptions.SetSiteDir(const Value: TFileName);
begin
  Values[nSiteDir] := Value;
end;

procedure TProgOptions.SetUpdateInterval(const Value: integer);
begin
  Values[nUpdateInterval] := IntToStr(Value);
end;

procedure TProgOptions.SetUpdateVer(const Value: integer);
begin
  Values[nUpdateVer] := IntToStr(Value);
end;

procedure TProgOptions.SetUserName(const Value: string);
begin
  Values[nUserName] := Value;
end;

initialization
begin
  Options := TProgOptions.Create;
end;

finalization
begin
  if Options <> nil then Options.Free;
end;

end.
