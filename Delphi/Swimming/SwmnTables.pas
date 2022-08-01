unit SwmnTables;

interface

// Имена таблиц
const
  tSwTp = 'SwTp'; tCmpt = 'Cmpt'; tPlTp = 'PlTp';
  tPtrc = 'Ptrc'; tSwmn = 'Swm'; tCtgr = 'Ctgr';
  tRslt = 'Rslt'; tPnts = 'Pnts'; tHeats = 'Heats';
  tTrnr = 'Trnr'; tSchl = 'Schl'; tCity = 'City';
  tCtNm = 'CtNm';

// Представления
const
  vCmpt = 'CmptView';

// Поля таблиц
const
  f_id      = 'id';
  f_FName   = 'FName';
  f_Name    = 'Name';
  f_LName   = 'LName';
  f_Sex     = 'Sex';
  f_Date    = 'Date';
  f_SwTp_id = 'SwTp_id';
  f_PlTp_id = 'PlTp_id';
  f_City_id = 'City_id';
  f_Trnr_id = 'Trnr_id';

const
  // Соревнования
  fCmpt_id     = tCmpt + '.id';
  fCmpt_Name   = tCmpt + '.Name';
  fCmpt_Date   = tCmpt + '.Date';
  // Группы заплывов
  fSwmn_id     = tSwmn + '.id';
  fSwmn_BYear  = tSwmn + '.BYear';
  fSwmn_Sex    = tSwmn + '.Sex';
  fSwmn_CmptID = tSwmn + '.Cmpt_id';
  fSwmn_SwTpID = tSwmn + '.SwTp_id';
  fSwmn_PlTpID = tSwmn + '.PlTp_id';
  // Заплывы
  fHeat_id     = tHeats + '.id';
  fHeat_TTime  = tHeats + '.Time';
  fHeat_PTime  = tHeats + '.PTime';
  fHeat_Place  = tHeats + '.Place';
  fHeat_Path   = tHeats + '.Path';
  fHeat_Points = tHeats + '.Points';
  fHeat_Heat   = tHeats + '.Heat';
  fHeat_NoCat  = tHeats + '.NoCat';
  fHeat_SwmnID = tHeats + '.Swmn_id';
  fHeat_PtrcID = tHeats + '.Ptrc_id';
  // Участники соревнований
  fPtrc_id     = tPtrc + '.id';
  fPtrc_FName  = tPtrc + '.FName';
  fPtrc_Name   = tPtrc + '.Name';
  fPtrc_LName  = tPtrc + '.LName';
  fPtrc_BYear  = tPtrc + '.BYear';
  fPtrc_Sex    = tPtrc + '.Sex';
  fPtrc_SchlID = tPtrc + '.Schl_id';
  fPtrc_TrnrID = tPtrc + '.Trnr_id';
  fPtrc_CityID = tPtrc + '.City_id';
  fPtrc_CtNmID = tPtrc + '.CtNm_id';
  // Виды заплывов
  fSwTp_id     = tSwTp + '.id';
  fSwTp_Name   = tSwTp + '.Name';
  // Типы бассейна
  fPlTp_id     = tPlTp + '.id';
  fPlTp_Name   = tPlTp + '.Name';
  // Города
  fCity_id     = tCity + '.id';
  fCity_Name   = tCity + '.Name';
  // Школы
  fSchl_id     = tSchl + '.id';
  fSchl_Name   = tSchl + '.Name';
  // Разряды
  fCtNm_id     = tCtNm + '.id';
  fCtNm_Name   = tCtNm + '.Name';
  // Тренеры
  fTrnr_id     = tTrnr + '.id';
  fTrnr_Name   = tTrnr + '.Name';

type
  TTableSwmn = record
  private
    const
      fid      = 'id';
      BYear   = 'BYear';
      Sex     = 'Sex';
      Cmpt_id = 'Cmpt_id';
      SwTp_id = 'SwTp_id';
      PlTp_id = 'PlTp_id';
      Table   = tSwmn;
      function Get_id: string;
    public
      var FullName: boolean;
      property id: string read Get_id;
  end;

var
  t: TTableSwmn;

function Test: string;

implementation

function TTableSwmn.Get_id: string;
begin
  if FullName then
    Result := Table + '.' + fid
  else
    Result := fid;
end;

function Test: string;
begin
  Result := t.id;
end;

end.
