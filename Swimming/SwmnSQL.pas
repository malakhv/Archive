unit SwmnSQL;

interface

uses
  Classes, Query, SwmnTables;

const
  ID_ERROR = -1;

type
  TCustomSQL = class(TPersistent)
  public
    class function SelectByField(Table,Field: TSQLStr; Value: Variant;
      OrderBy: TSQLStr = ''): TSQLStr;
    class function SelectByID(Table: TSQLStr; ID: integer;
      OrderBy: TSQLStr = ''): TSQLStr;
  end;

type
  TSwmnSQL = class(TCustomSQL)
  public const
    // Таблицы
    tSwTp = 'SwTp'; tCmpt = 'Cmpt'; tPlTp = 'PlTp'; tPtrc = 'Ptrc';   tSwmn = 'Swmn';
    tCtgr = 'Ctgr'; tRslt = 'Rslt'; tPnts = 'Pnts'; tHeats = 'Heats'; tTrnr = 'Trnr';
    tSchl = 'Schl'; tCity = 'City'; tCtNm = 'CtNm';
    // Представления
    vCmpt = 'CmptView'; vSwmn = 'SwmnView'; vHeats = 'HeatsView'; vCity = 'CityView';
    vPlTp = 'PlTpView'; vSwTp = 'SwTpView'; vSchl = 'SchlView';   vTrnr = 'TrnrView';
    vEnd = 'EndView';  
    // Процедуры
    pHeatByCmpt = 'HeatByCmpt'; pHeatBySwmn = 'HeatBySwmn';
  public
    //--Соревнования--
    class function CmptView(OrderBy: TSQLStr = ''): TSQLStr;
    class function CmptInfo(Cmpt_id: integer): TSQLStr;
    //--Группы заплывов--
    class function SwmnView(OrderBy: TSQLStr = ''): TSQLStr;
    class function SwmnInfo(Swmn_id: integer): TSQLStr;
    class function SwmnByCmpt(Cmpt_id: integer): TSQLStr;
    //--Заплывы--
    class function HeatsView(OrderBy: TSQLStr = ''): TSQLStr;
    class function HeatsInfo(Heats_id: integer): TSQLStr;
    class function HeatByCmpt(Cmpt_id: integer; OrderBy: TSQLStr = ''): TSQLStr;
    class function HeatBySwmn(Swmn_id: integer; OrderBy: TSQLStr = ''): TSQLStr;
    class function HeatPEnd(Cmpt_id: integer): TSQLStr;
    class function DeleteHeatBySwmn(Swmn_id: integer): TSQLStr;
    // Общие функции
  end;

var
  SwSQL: TSwmnSQL;

//--Соревнования--
function CmptView(OrderBy: TSQLStr = ''): TSQLStr;
function CmptInfo(Cmpt_id: integer): TSQLStr;

//--Группы заплывов--
function SwmnView(OrderBy: TSQLStr = fSwTp_Name): TSQLStr;
function SwmnInfo(Swmn_id: integer): TSQLStr;
function SwmnByCmpt(Cmpt_id: integer): TSQLStr;

//--Заплывы--
function HeatsView(OrderBy: TSQLStr = ''): TSQLStr;
function HeatsViewBySwmn(Swmn_id: integer; OrderBy: TSQLStr = fPtrc_FName): TSQLStr;
function HeatsViewByCmpt(Cmpt_id: integer; OrderBy: TSQLStr =
  fHeat_SwmnID + ', ' + fSwTp_Name + ', ' + fHeat_Heat + ', ' + fHeat_Path): TSQLStr;
function HeatsViewPEnd(Cmpt_id: integer): TSQLStr;
function GetHeatInfo(Heat_id: integer): TSQLStr;
// Формирование запроса на выбор заплывов
function HeatsByHeat(Heat_id: integer; OrderBy: TSQLStr = fHeat_PTime): TSQLStr;
function HeatsBySwmn(Swmn_id: integer;  OrderBy: TSQLStr = fHeat_PTime): TSQLStr;
//

implementation

uses SysUtils, Variants;

// Формирование предложения where для для таблиц,
// где записть с id = 1 является системной
function NotFirstField(TableName: TSQLStr): TSQLStr;
begin
  Result := ' ' + TableName + '.id <> 1 ';
end;

//--Соревнования--
function CmptView(OrderBy: TSQLStr = ''): TSQLStr;
begin
  Result := TSQL.Select(vCmpt,OrderBy);
end;

function CmptInfo(Cmpt_id: integer): TSQLStr;
begin
  Result := CmptView('') + ' and ' + fCmpt_id + ' = ' + intToStr(Cmpt_id);
end;

//--Группы заплывов--
function SwmnView(OrderBy: TSQLStr = tSwTp + '.Name'): TSQLStr;
begin
  Result := 'Select ' + fSwmn_BYear + ', ' +  fSwmn_Sex + ', ' + fSwTp_Name +
    'as stName, ' + fPlTp_Name + ' as plName from ' + tSwmn + ', ' +
    tSwTp + ', ' + tPlTp + ' where ' + fSwmn_SwTpID + ' = ' + fSwTp_id + ' and ' +
    fSwmn_PlTpID + ' = ' + fPlTp_id;
  if OrderBy <> '' then
    Result := Result + ' order by ' + OrderBy;
end;

function SwmnInfo(Swmn_id: integer): TSQLStr;
begin
  Result := SwmnView('') + ' and ' + fSwmn_id + ' = ' + IntToStr(Swmn_id);
end;

function SwmnByCmpt(Cmpt_id: integer): TSQLStr;
begin
  Result := SwmnView('') + ' and ' + fSwmn_CmptID + ' = ' + IntToStr(Cmpt_id) +
    ' order by ' + fSwTp_Name;
end;

//--Заплывы--
function HeatsView(OrderBy: TSQLStr = ''): TSQLStr;
begin
  Result := 'select distinct ' + fHeat_id + ', ' + fHeat_Heat + ', ' +
    fHeat_Path + ', ' + fHeat_Place + ', ' + fHeat_TTime + ', ' + fHeat_PTime + ', ' +
    fHeat_SwmnID + ', ' + fHeat_NoCat + ', ' + fSwTp_Name + ' as SwTp, ' +
    fPtrc_FName + ', ' + fPtrc_Name + ', ' + fPtrc_LName + ', ' +
    fPtrc_BYear + ', ' + fPtrc_Sex + ', ' + fCity_Name + ' as City, ' +
    fSchl_Name + ' as Schl, ' + fTrnr_Name + ' as Trnr, ' + fCtNm_Name + ' as CtNm' +
    ' from ' + tHeats + ', ' + tPtrc + ', ' + tSwmn + ', ' +
    tSwTp + ', ' + tCity + ', ' + tSchl + ', ' + tTrnr + ', ' + tCtNm + ' where ' +
    fHeat_PtrcID + ' = ' + fPtrc_id + ' and ' + fHeat_SwmnID + ' = ' + fSwmn_id +
    ' and '+ fSwmn_SwTpID + ' = ' + fSwTp_id + ' and ' + fPtrc_CityID + ' = ' +
    fCity_id + ' and ' + fPtrc_SchlID + ' = ' + fSchl_id + ' and ' + fPtrc_TrnrID +
    ' = ' + fTrnr_id + ' and ' + fPtrc_CtNmID + ' = ' + fCtNm_id;
  if OrderBy <> '' then
    Result := Result + ' order by ' + OrderBy;
end;

function HeatsViewBySwmn(Swmn_id: integer; OrderBy: TSQLStr = fPtrc_FName): TSQLStr;
begin
  Result := HeatsView + ' and ' + fHeat_SwmnID + ' = ' + IntToStr(Swmn_id);
end;

function HeatsViewByCmpt(Cmpt_id: integer; OrderBy: TSQLStr =
  fHeat_SwmnID + ', ' + fSwTp_Name + ', ' + fHeat_Heat + ', ' + fHeat_Path): TSQLStr;
begin
  Result := HeatsView + ' and ' + fSwmn_CmptID + ' = ' + IntToStr(Cmpt_id);
  if OrderBy <> '' then
    Result := Result + ' order by ' + OrderBy;
end;

function HeatsViewPEnd(Cmpt_id: integer): TSQLStr;
begin
  Result := HeatsViewByCmpt(Cmpt_id,fHeat_SwmnID + ', ' + fHeat_NoCat + ' desc, ' +
    fHeat_Place);
end;

function GetHeatInfo(Heat_id: integer): TSQLStr;
begin
  Result := HeatsView + ' and ' + fHeat_id + ' = ' + IntToStr(Heat_id);
end;

function HeatsByHeat(Heat_id: integer; OrderBy: TSQLStr = fHeat_PTime): TSQLStr;
var SQLWhere: TSQLStr;
begin
  // Формирование предложения where
  SQLWhere := fHeat_SwmnID + ' = (' + TSQL.Select(tHeats,fHeat_SwmnID,
    fHeat_id + ' = ' + IntToStr(Heat_id)) + ')';
  // Формирование запроса
  Result := TSQL.Select(tHeats,AllFields,SQLWhere,OrderBy);
end;

function HeatsBySwmn(Swmn_id: integer;  OrderBy: TSQLStr = fHeat_PTime): TSQLStr;
begin
  Result := TSQL.Select(tHeats,AllFields,
    fHeat_SwmnID + ' = ' + IntToStr(Swmn_id),OrderBy);
end;

{ TSwmnSQL }

class function TSwmnSQL.CmptInfo(Cmpt_id: integer): TSQLStr;
begin
  if Cmpt_id <> ID_ERROR then
  Result := CmptView + ' where ' + vCmpt + '.id = ' + IntToStr(Cmpt_id);
end;

class function TSwmnSQL.CmptView(OrderBy: TSQLStr): TSQLStr;
begin
  Result := 'Select * from ' + vCmpt;
  if Trim(OrderBy) <> '' then
    Result := Result + 'order by ' + OrderBy;
end;

class function TSwmnSQL.DeleteHeatBySwmn(Swmn_id: integer): TSQLStr;
begin
  Result := 'Delete from ' + tHeats + ' where ' +
    tHeats + '.Swmn_id = ' + IntToStr(Swmn_id);
end;

class function TSwmnSQL.HeatByCmpt(Cmpt_id: integer; OrderBy: TSQLStr): TSQLStr;
begin
  Result := HeatsView + ' where ' + vHeats + '.Cmpt_id = ' +
    IntToStr(Cmpt_id);
  if Trim(OrderBy) = '' then
    Result := Result + ' order by ' + vHeats + '.SwTp, '  + vHeats + '.Heat, ' +
      vHeats + '.Path'
  else
    Result := Result + ' order by ' + OrderBy;
end;

class function TSwmnSQL.HeatBySwmn(Swmn_id: integer; OrderBy: TSQLStr): TSQLStr;
begin
  Result := HeatsView + ' where ' + vHeats + '.Swmn_id = ' +
    IntToStr(Swmn_id);
  if Trim(OrderBy) = '' then
    Result := Result + ' order by ' + tPtrc + '.FName'
  else
    Result := Result + ' order by ' + OrderBy;
end;

class function TSwmnSQL.HeatPEnd(Cmpt_id: integer): TSQLStr;
begin
  Result := HeatByCmpt(Cmpt_id, tHeats + '.Swmn_id, ' + tHeats + '.NoCat DESC , ' +
    tHeats + '.Place');
end;

class function TSwmnSQL.HeatsInfo(Heats_id: integer): TSQLStr;
begin
  Result := HeatsView + ' where ' + vHeats + '.id = ' + IntToStr(Heats_id);
end;

class function TSwmnSQL.HeatsView(OrderBy: TSQLStr): TSQLStr;
begin
  Result := 'Select * from ' + vHeats;
  if Trim(OrderBy) <> '' then
    Result := Result + ' order by ' + OrderBy;
end;

class function TSwmnSQL.SwmnByCmpt(Cmpt_id: integer): TSQLStr;
begin
  if Cmpt_id <> ID_ERROR then
    Result := SwmnView + ' where ' + vSwmn + '.Cmpt_id = ' + IntToStr(Cmpt_id);
end;

class function TSwmnSQL.SwmnInfo(Swmn_id: integer): TSQLStr;
begin
  if Swmn_id <> ID_ERROR then
    Result := SwmnView + ' where ' + vSwmn + '.id = ' + IntToStr(Swmn_id);
end;

class function TSwmnSQL.SwmnView(OrderBy: TSQLStr): TSQLStr;
begin
  Result := 'Select * from ' + vSwmn;
  if OrderBy <> '' then
    Result := Result + OrderBy;
end;

{ TCustomSQL }

class function TCustomSQL.SelectByField(Table, Field: TSQLStr; Value: Variant;
  OrderBy: TSQLStr): TSQLStr;

  function PrepareValue(Value: Variant): TSQLStr;
  begin
    if VarIsStr(Value) then
      Result := '''' + VarToStr(Value) + ''''
    else
      Result := VarToStr(Value);
  end;

begin
  Result := 'Select * from ' + Table + ' where ' + Table + '.' + Field + '=' +
    PrepareValue(Value);
end;

class function TCustomSQL.SelectByID(Table: TSQLStr; ID: integer;
  OrderBy: TSQLStr): TSQLStr;
begin
  Result := SelectByField(Table,'ID',ID,OrderBy);
end;

initialization
  SwSQL := TSwmnSQL.Create;
finalization
  SwSQL.Free;

end.
