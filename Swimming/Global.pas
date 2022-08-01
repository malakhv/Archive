unit Global;

interface

uses SysUtils, Messages, Controls, Classes, SwimmingDB;

const
  ID_ERROR = -1;

const
  DBDir = 'Data';
  DBFileName = 'DB.mdb';

const
  WM_RELOADDATA   = WM_USER + 10;
  WM_UPDATEBRWSR  = WM_USER + 20;


var
  AppDir: TFileName;
  MainFormHandle: THandle;
  SwDB: TSwmDB;

function GetConnectionString: string;

function ShowDlg(AOwner: TComponent; Caption, Text: TCaption): TModalResult;

implementation

uses DlgUnit;

function GetConnectionString: string;
begin
  Result := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
    AppDir + DbDir + '\' + DBFileName + ';Persist Security Info=False';
end;

function ShowDlg(AOwner: TComponent; Caption, Text: TCaption): TModalResult;
var Dlg: TDlgFrm;
begin
  Dlg := TDlgFrm.Create(AOwner);
  try
    Dlg.Caption := Caption;
    Dlg.Text.Caption := Text;
    Result := Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;


end.
