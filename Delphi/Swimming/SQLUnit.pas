unit SQLUnit;

interface

// Имена таблиц
const
  tSwTp = 'SwTp';
  tCmpt = 'Cmpt';
  tPlTp = 'PlTp';
  tPtrc = 'Ptrc';
  tSwmn = 'Swm';
  tCtgr = 'Ctgr';
  tRslt = 'Rslt';
  tPnts = 'Pnts';
  tHets = 'Heats';
  tTrnr = 'Trnr';
  tSchl = 'Schl';
  tCity = 'City';
  tCtNm = 'CtNm';

const
  sql_SwTp    = 'Select * from ' + tSwTp + ' where ' + tSwTp + '.ID <> 1 order by ' +
    tSwTp + '.Name';
  sql_SwTpInf = 'Select * from ' + tSwTp + ' where ' + tSwTp + '.ID <> 1 and ' + tSwTp + '.ID = ';
  sql_SwTpDel = 'Delete   from ' + tSwTp + ' where ' + tSwTp + '.ID = ';

  sql_PlTp    = 'Select * from ' + tPlTp + ' where ' + tPlTp + '.ID <> 1 order by ' +
    tPlTp + '.Name';
  sql_PlTpInf = 'Select * from ' + tPlTp + ' where ' + tPlTp + '.ID <> 1 and ' + tPlTp + '.ID = ';
  sql_PlTpDel = 'Delete   from ' + tPlTp + ' where ' + tPlTp + '.ID = ';

  sql_Cmpt    = 'Select * from ' + tCmpt + ' where ' + tCmpt + '.ID <> 1 order by ' +
    tCmpt + '.Name';
  sql_CmptInf = 'Select * from ' + tCmpt + ' where ' + tCmpt + '.ID <> 1 and ' + tCmpt + '.ID = ';
  sql_CmptDel = 'Delete   from ' + tCmpt + ' where ' + tCmpt + '.ID = ';

  sql_Ptrc    = 'Select * from ' + tPtrc + ' where ' + tPtrc + '.ID <> 1 order by ' +
    tPtrc + '.FirstName';

  sql_PtrcInf = 'Select * from ' + tPtrc + ' where ' + tPtrc + '.ID <> 1 and ' + tPtrc + '.ID = ';
  sql_Ptrc_view = 'Select '+ tPtrc + '.ID, ' + tPtrc + '.FName, ' + tPtrc + '.Name, ' +
    tPtrc + '.LName, ' + tPtrc + '.BYear, ' + tPtrc + '.Sex, ' + tSchl + '.Name as SName, ' +
    tTrnr + '.Name as TName, ' + tCity + '.Name as CName' + ' from ' + tPtrc + ', ' + tTrnr + ', ' + tSchl + ', ' + tCity +
    ' where ' + tPtrc + '.ID <> 1 and ' + tPtrc + '.Schl_id = ' + tSchl + '.ID and ' +
    tPtrc + '.Trnr_id = ' + tTrnr + '.ID and ' + tPtrc + '.City_id = ' + tCity + '.ID';

  sql_Swmn    = 'Select * from ' + tSwmn + ' where ' + tSwmn + '.ID <> 1 order by ' + tSwmn + '.Name';
  sql_SwmnInf = 'Select * from ' + tSwmn + ' where ' + tSwmn + '.ID <> 1 and ' + tSwmn + '.ID = ';

  sql_City    = 'Select * from ' + tCity + ' where ' + tCity + '.ID <> 1 order by ' +
    tCity + '.Name';
  sql_CityInf = 'Select * from ' + tCity + ' where ' + tCity + '.ID <> 1 and ' +
    tCity + '.ID = ';

  sql_ComptList = 'Select * from Cmpt where Cmpt.ID <> 1 order by Cmpt.Date, Cmpt.Name';
  sql_ComptInfo = 'Select * from Cmpt where Cmpt.ID = ';

  sql_SwimList = 'SELECT sw.id, sw.Sex, sw.BYear, pt.Name, cm.Name AS CMName, st.Name AS STName' +
    ' FROM Swmn AS sw, PlTp AS pt, Cmpt AS cm, SwTp AS st' +
    ' WHERE (((sw.PlTp_id)=[pt].[ID]) AND ((sw.Cmpt_id)=[cm].[id]) AND ((sw.SwTp_id)=[st].[id]))';

  {sql_HeatsBySwmn = 'Select p.FName, p.Name, p.LName, h.id, h.Path, h.Heat, h.Time, h.PTime, ' +
    'h.Place, h.Swmn_id, h.Ptrc_id, h.NoCat from Heats h, Ptrc p where h.Ptrc_id = p.ID and h.Swmn_id = '; }

function SelRec(TableName: string; Flag: boolean = true;
  OrderBy: string = ''): WideString;
function GetRecByID(TableName: string; ID: integer;
  Flag: boolean = true): WideString;
function SelRecByField(TableName, Field: string; Value: Variant;
  Flag: boolean = true; OrderBy: string = ''): WideString;

function GetPtrcMaxTimeSQL(AYear, Ptrc_id, Swmn_id: integer): WideString;
function GPntsBySwTpSQL(Ptrc_id, SwTp_id, ATime: integer): WideString;
function GPntsBySwmnSQL(Ptrc_id, Swmn_id, ATime: integer): WideString;
function GPntsByHeatSQL(Heat_id, ATime: integer): WideString;

// Reconfig Query
function GetHeatsList(ID: integer; TimeField: string = 'PTime'): WideString; overload; //
function GetHeatsListSwmn(Swmn_id: integer): WideString; overload;                     //

function GetHeatsListBySwmn(Swmn_id: integer; TimeField: string = 'PTime'): wideString; //

function GetHeatsByCmpt(Cmpt_id: integer; TimeField: string = 'PTime'): WideString; //
function GetHeatsByCmptPEnd(Cmpt_id: integer): WideString;                           //

function GetSwmnInfo(ID: integer): WideString;

function GetHeatsInfo(ID: integer): WideString;   //

function GetCtgr(Heats_id, ATime: integer): WideString;

function GetPointsList(Sex, PlTp_id: integer): WideString;
function GetCtgrList(Sex, PlTp_id: integer): WideString;

implementation

uses SysUtils, Variants, DateUtils;

function SelRec(TableName: string; Flag: boolean = true;
  OrderBy: string = ''): WideString;
begin
  Result := 'Select * from ' + TableName;
  if Flag then
    Result := Result + ' where ' + TableName + '.ID <> 1';
  if OrderBy <> '' then
    Result := Result + ' order by ' + OrderBy;
end;

function GetRecByID(TableName: string; ID: integer;
  Flag: boolean = true): WideString;
begin
  Result := SelRec(TableName,Flag);
  if not Flag then
    Result := Result + ' where '
  else
    Result := Result + ' and ';
  Result := Result + TableName + '.ID = ' + IntToStr(ID);
end;

function SelRecByField(TableName, Field: string; Value: Variant;
  Flag: boolean = true; OrderBy: string = ''): WideString;
begin
  Result := SelRec(TableName,Flag);
  if not Flag then
    Result := Result + ' where '
  else
    Result := Result + ' and ';
  Result := Result + TableName + '.' + Field + ' = ';
  if VarIsStr(Value) then
    Result := '''' + VarToStr(Value) + ''''
  else
    Result := Result + VarToStr(Value);
  if OrderBy <> '' then
    Result := Result + ' order by ' + OrderBy;
end;

function GetPtrcMaxTimeSQL(AYear, Ptrc_id, Swmn_id: integer): WideString;
begin
  Result := 'SELECT Min(Heats.Time) as TmMax FROM Heats, Swm, Cmpt ' +
    'WHERE Heats.Time <> 0 and Heats.Swmn_id = Swm.id and Year(Cmpt.Date)= ' + IntToStr(AYear) +
    ' and Heats.Ptrc_id = ' + IntToStr(Ptrc_id) + ' and Swm.SwTp_id = ' +
    '(Select Swm.SwTp_id from Swm where Swm.id = ' + IntToStr(Swmn_id) +')';
end;

function GPntsBySwTpSQL(Ptrc_id, SwTp_id, ATime: integer): WideString;
begin
  Result := 'Select Pnts.Points from Pnts, Ptrc where  Pnts.SwTp_id = ' + IntToStr(SwTp_id) +
    ' and Pnts.Time >= ' + IntToStr(ATime) + 'and Pnts.Sex = ' +
    '(Select Ptrc.Sex from Ptrc where Ptrc.ID = ' + IntToStr(Ptrc_id) +')';
end;

function GPntsBySwmnSQL(Ptrc_id, Swmn_id, ATime: integer): WideString;
begin
  Result := 'Select Pnts.Points from Pnts, Ptrc, Swm where Pnts.Time >= ' + IntToStr(ATime) +
    'and Pnts.Sex = (Select Ptrc.Sex from Ptrc where Ptrc.ID = ' +
    IntToStr(Ptrc_id) +') and Pnts.SwTp_id = (Select Swm.SwTp_id from Swm where Swm.ID = ' +
    IntToStr(Swmn_id) + ')';
end;

function GPntsByHeatSQL(Heat_id, ATime: integer): WideString;
begin
  // Надо учесть параметр NoCat
  Result := 'Select Pnts.Points from Pnts, Swm where Pnts.Time >= ' + intTostr(ATime) +
    ' and Pnts.Sex = (Select Swm.Sex from Swm where Swm.ID = (Select Heats.Swmn_id from Heats where Heats.ID = ' +
    IntToStr(Heat_id) + ')) and Pnts.SwTp_id = ' +
    '(Select Swm.SwTp_id from Swm where Swm.ID = (Select Heats.Swmn_id from Heats where Heats.ID = ' +
    IntToStr(Heat_id) + ')) order by Pnts.Points desc';
end;

function GetHeatsList(ID: integer; TimeField: string = 'PTime'): WideString;
begin
  Result := 'Select h.id, h.Path, h.Heat, h.Time, h.NoCat, h.PTime, h.Points, ' +
    'h.Place, h.Swmn_id, h.Ptrc_id, h.NoCat from Heats h where h.Swmn_id = ' +
    '(select Heats.Swmn_id from Heats where Heats.id = ' + IntToStr(ID) + ')' +
    ' order by h.' + TimeField;
end;

function GetHeatsListSwmn(Swmn_id: integer): WideString; overload;
begin
  Result := 'SELECT h.id, h.Heat, h.Path, h.Place, h.PTime, h.NoCat' +
    ' FROM Heats AS h WHERE h.Swmn_id = ' + intTostr(Swmn_id) +
    ' ORDER BY  h.PTime';
end;

function GetHeatsListBySwmn(Swmn_id: integer; TimeField: string = 'PTime'): wideString;
begin
  Result := 'SELECT distinct h.id, h.Heat, h.Path, h.Place, h.' + TimeField + ', h.NoCat, p.FName, p.Name, p.LName, p.BYear, p.Sex , ct.Name as CityName, sc.Name as SchlName ' +
    ' FROM Heats AS h, Ptrc as p, Swm AS s, SwTp as st, City as ct, Schl as sc ' +
    'WHERE h.Ptrc_id = p.id and s.SwTp_id = st.id and p.City_id = ct.id and p.Schl_id = sc.id and  h.Swmn_id = ' + intTostr(Swmn_id) +
    ' ORDER BY h.Heat, h.Path';
end;

function GetHeatsByCmpt(Cmpt_id: integer; TimeField: string = 'PTime'): WideString;
begin
  Result := 'SELECT distinct h.id,h.Heat, h.Path, h.' + TimeField + ', h.Swmn_id, h.NoCat, p.FName, p.Name, p.LName, p.BYear, p.Sex, st.Name as SwTp, ct.Name as CityName, sc.Name as SchlName ' +
    ' FROM Heats AS h, Ptrc as p, Swm AS s, SwTp as st, City as ct, Schl as sc,  Cmpt AS c ' +
    'WHERE h.Ptrc_id = p.id and s.SwTp_id = st.id and p.City_id = ct.id and p.Schl_id = sc.id and  h.Swmn_id = s.id and s.Cmpt_id = ' + IntToStr(Cmpt_id) +
    ' ORDER BY h.Swmn_id, st.Name, h.Heat, h.Path';
end;

function GetHeatsByCmptPEnd(Cmpt_id: integer): WideString;
begin
  Result := 'SELECT DISTINCT h.id, h.Time, h.Points, h.NoCat, h.Place, h.Swmn_id, p.FName, p.Name, p.LName, p.BYear, st.Name AS SwTp, s.Sex, cn.Name AS CtNm, ct.Name AS CityName, tr.Name AS TrnrName ' +
    'FROM Heats AS h, Ptrc AS p, SwTp AS st, Swm AS s, CtNm AS cn, City AS ct, Trnrs AS tr, Cmpt AS c ' +
    'WHERE h.Ptrc_id = p.id and p.CtNm_id = cn.id and  s.SwTp_id = st.id and p.City_id = ct.id and p.Trnr_id = tr.id  and h.Swmn_id = s.id and s.Cmpt_id = ' + IntToStr(Cmpt_id) +
    ' ORDER BY h.Swmn_id, h.NoCat DESC , h.Place';
end;

function GetSwmnInfo(ID: integer): WideString;
begin
  Result := 'Select s.BYear, s.Sex, st.Name as stName, pl.Name as plName from Swm as s, ' +
    'SwTp as st, PlTp as pl where s.SwTp_id = st.id and s.PlTp_id = pl.id and ' +
    's.id = ' + IntToStr(ID);
end;

function GetHeatsInfo(ID: integer): WideString;
begin
  Result := 'Select h.id, h.Path, h.Heat, h.PTime, h.Time, h.Place, h.Points, h.NoCat, p.FName, p.Name, p.LName, p.BYear, P.Sex, cn.Name as CNm ' +
    'from Heats as h, Ptrc as p, CtNm as cn where h.Ptrc_id = p.id and p.CtNm_id = cn.id and h.id = ' + IntToStr(ID);
end;

function GetCtgr(Heats_id, ATime: integer): WideString;
begin
  Result := 'SELECT DISTINCT ct.id, ct.Time, cn.Name, cn.id as nid ' +
    'FROM Ctgr AS ct, CtNm AS cn, Heats AS h, Swm AS s, SwTp AS st, PlTp AS pl, Ptrc AS p ' +
    'WHERE ct.CtNm_id = cn.id and ct.SwTp_id = (Select Swm.SwTp_id from Swm where ' +
    'Swm.id = (Select Heats.Swmn_id from Heats where Heats.id = ' + IntToStr(Heats_id) +')) and ' +
    'ct.PlTp_id = (Select Swm.PlTp_id from Swm where ' +
    'Swm.id = (Select Heats.Swmn_id from Heats where Heats.id = ' + IntToStr(Heats_id) + ')) and ' +
    'ct.Sex = (Select Ptrc.Sex from Ptrc where Ptrc.id = (Select Heats.Ptrc_id from '+
    'Heats where Heats.id = ' + IntToStr(Heats_id) + ')) and ct.Time >= ' + IntToStr(ATime) +
    ' order by ct.Time';
end;

function GetPointsList(Sex, PlTp_id: integer): WideString;
begin
  Result := 'Select p.id, p.Time, p.Points, sw.SName, sw.id as sid ' +
    ' from Pnts p, SwTp as sw where p.id <> 1 and p.SwTp_id = sw.id and ' +
    ' p.Sex = ' + IntToStr(Sex) + ' and p.PlTp_id = ' +
    IntToStr(PlTp_id) + ' order by p.Points, sw.id';
end;

function GetCtgrList(Sex, PlTp_id: integer): WideString;
begin
  Result := 'SELECT c.id, c.Time, sw.id AS sid, sw.Name AS SWName, cn.id as cid,  cn.Name AS CNName ' +
    'FROM Ctgr AS c, SwTp AS sw, CtNm AS cn ' +
    ' where c.id <> 1 and  c.SwTp_id = sw.id and c.CtNm_id = cn.id and  c.PlTp_id = ' + IntToStr(PlTp_id) +
    ' and c.Sex = ' + IntToStr(Sex) + ' order by sw.id, cn.id';
end;


end.
