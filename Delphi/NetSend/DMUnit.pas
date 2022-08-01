unit DMUnit;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM = class(TDataModule)
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
  private
    { Private declarations }
  public
    function Connection: boolean;
    function ExecSQL(SQLStr: string; flag: byte = 0): boolean;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

uses Dialogs, Global;

const
  DBName = 'NSnd.mdb';
  ConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source= ';

function TDM.Connection: boolean;
begin
  Result := true;
  ADOConnection.ConnectionString := ConnectionString +AppDir+'..\'+DBName;
  try
    ADOConnection.Open;
  except
    ShowMessage('Неудалось подключиться к базе данных');
    Result := false;
  end;
end;

function TDM.ExecSQL(SQLStr: string; flag: byte): boolean;
begin
  Result := true;
  try
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(SQLStr);
    case flag of
      0:  ADOQuery.Open;
      1:  ADOQuery.ExecSQL;
    end;
  except
    Result := false;
  end
end;

end.
