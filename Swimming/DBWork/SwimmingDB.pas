unit SwimmingDB;

interface

uses
  ComCtrls, ADODBWork;

const
  ID_ERROR = -1;

type
  TSexArray = array[0..1] of string[3];

var
  Sex: TSexArray = ('муж','жен');

type
  TSwmDB = class(TCustomADODB)
  public
    // Виды заплывов
    function SSwType(Name: string; ID: integer = ID_ERROR): boolean;
    function GSwType(Des: TObject): boolean;
    function DSwType(ID: integer): boolean;
    // Бассейн
    function SPlType(Name: string; ID: integer = ID_ERROR): boolean;
    function GPlType(Des: TObject): boolean;
    function DPlType(ID: integer): boolean;
    // Соревнования
    function SCmpt(Name, Info: string; DateTime: TDateTime;
      ID: integer = ID_ERROR): boolean;
    function GCmpt(Des: TObject): boolean;
    function DCmpt(ID: Integer): boolean;
    // Групы заплывов
    function SSwmn(Cmpt_id, SwTp_id, PlTp_id, BYear, Sex: integer;
      ID: integer = ID_ERROR): boolean;
    function GSwmn(Des: TObject): boolean;
    function DSwmn(ID: integer): boolean;
    // Учасники соревнований
    function SPtrc(FName, Name, LName: string; BYear, Sex, Schl_id, Trnr_id,
      City_id: integer; ID: integer = ID_ERROR): boolean;
    function GPtrc(Des: TObject): boolean; overload;
    function GPtrc(Des: TObject; SQL: WideString): boolean; overload;
    function DPtrc(ID: integer): boolean;
    function SPtrcCtgr(ID, CtNm_id: integer): boolean;
    // Города
    function SCity(Name: string; ID: integer = ID_ERROR): boolean;
    function GCity(Des: TObject): boolean;
    function DCity(ID: integer): boolean;
    // Тренер
    function STrnr(Name: string; ID: integer = ID_ERROR): boolean;
    function GTrnr(Des: TObject): boolean;
    function DTrnr(ID: integer): boolean;
    // Школы
    function SSchl(Name: string; ID: integer = ID_ERROR): boolean;
    function GSchl(Des: TObject): boolean;
    function DSchl(ID: integer): boolean;
    // Заплывы
    function SHeats(Swmn_id, Ptrc_id,PTime: integer;
      NoCat: boolean = false; ID: integer = ID_ERROR): boolean;
    function GHeats(Des: TObject; Swmn_id: integer): boolean;
    function DHeats(ID: integer): boolean;
    function STime(ATime,ID: integer): boolean;
    function SPTime(PTime,ID: integer): boolean;
    procedure ReConfigHeats(ID: integer; TimeField: TFieldName = 'PTime'); overload;
    procedure ReconfigHeats(SQL: WideString;
      PathCount, MinPtrcCount: integer); overload;
    procedure ReConfigPlace(ID: integer); overload;
    procedure ReConfigPlace(SQL: WideString); overload;
    // Очки
    function GPntsByPtrc(SQL: WideString): integer;
    // Время
    function GPtrcPTime(Ptrc_id, Swmn_id: integer): integer;
    // Разряды
    function GetCtgrNm(Heats_id, ATime: integer): integer; 
    // Общие функции
    function Sv(TableName: TTableName; FieldName: TFieldName; Value: Variant;
      ID: integer = ID_ERROR; Flag: boolean = true): boolean;
    function Gt(TableName: TTableName; FieldName: TFieldName;
      ID: integer; Flag: boolean = true): Variant;
    // Работа с деревом
    procedure LoadTreeView(TreeView: TTreeView);
  end;

implementation

uses SysUtils, Classes, Variants, DateUtils, SQLUnit, ADODB, NodeUnit, SwmnSQL,
  SwmnTables;

{ TSwmDB }

function TSwmDB.DCity(ID: integer): boolean;
begin
  Result := Self.DelRec(tCity,ID);
  if Result then
    Self.SaveRec(SelRecByField(tPtrc,'City_id',ID),'City_id',1);
end;

function TSwmDB.DCmpt(ID: Integer): boolean;
var List: TStringList;
    i: integer;
begin
  Result := Self.DelRec(tCmpt,ID);
  if Result then
  begin
    List := TStringList.Create;
    try
      if Self.LoadRec(List,SwSQL.SwmnByCmpt(ID),'ID','ID') then
        for i := 0 to List.Count - 1 do
          Self.DSwmn(StrToInt(List.Names[i]));
    finally
      List.Free;
    end;
  end;
end;

function TSwmDB.DHeats(ID: integer): boolean;
var SID: integer;
begin
  SID := Self.Gt(tHets,'Swmn_id',ID,false);
  Result := Self.DelRec(tHets,ID);
  if Result then
    ReConfigHeats(GetHeatsListSwmn(SID),6,3);
end;

function TSwmDB.DPlType(ID: integer): boolean;
begin
  Result := Self.DelRec(tPlTp,ID);
  if Result then
  begin
    Self.SaveRec('Select * from ' + tSwmn + ' where ' + tSwmn + '.PlTp_id = ' +
      IntToStr(ID),'PlTp_id',1);
    Self.SaveRec('Select * from ' + tCtgr + ' where ' + tCtgr + '.PlTp_id = ' +
      IntToStr(ID),'PlTp_id',1);
    Self.SaveRec('Select * from ' + tPnts + ' where ' + tPnts + '.PlTp_id = ' +
      IntToStr(ID),'PlTp_id',1);
  end;
end;

function TSwmDB.DPtrc(ID: integer): boolean;
begin
  Result := Self.DelRec(tPtrc,ID);
  if Result then
  begin
    Self.DelRec(tHets,tHets + '.Ptrc_id = ' + IntToStr(ID));
  end;
end;

function TSwmDB.DSchl(ID: integer): boolean;
begin
  Result := Self.DelRec(tSchl,ID);
  if Result then
    Self.SaveRec(SelRecByField(tPtrc,'Schl_id',ID),'Schl_id',1);
end;

function TSwmDB.DSwmn(ID: integer): boolean;
begin
  // Удаление группы заплывов
  Result := Self.DelRec(tSwmn,ID);
  // Если группа заплывов удалена успешно, удаляем все заплывы группы
  if Result then Self.ExecQuery(SwSQL.HeatBySwmn(ID),qmExec);
end;

function TSwmDB.DSwType(ID: integer): boolean;
begin
  Result := Self.DelRec(tSwTp,ID);
  if Result then
  begin
    Self.SaveRec('Select * from ' + tSwmn + ' where ' + tSwmn + '.SwTp_id = ' +
      IntToStr(ID),'SwTp_id',1);
    Self.SaveRec('Select * from ' + tPnts + ' where ' + tPnts + '.SwTp_id = ' +
      IntToStr(ID),'SwTp_id',1);
  end;
end;

function TSwmDB.DTrnr(ID: integer): boolean;
begin
  Result := Self.DelRec(tTrnr,ID);
  if Result then
    Self.SaveRec(SelRecByField(tPtrc,'Trnr_id',ID),'Trnr_id',1);
end;

function TSwmDB.GCity(Des: TObject): boolean;
begin
  Result := Self.LoadRec(Des,sql_City,'Name','ID');
end;

function TSwmDB.GCmpt(Des: TObject): boolean;
begin
  Result := Self.LoadRec(Des,sql_Cmpt,'Name','ID');
end;

function TSwmDB.GetCtgrNm(Heats_id, ATime: integer): integer;
var List: TStringList;
begin
  Result := 1;
  List := TStringList.Create;
  try
    if Self.LoadRec(List,GetCtgr(Heats_id,ATime),'nid','nid') then
    begin
      if List.Count <> 0 then
      begin
        Result := StrToIntDef(List.Names[0],1);
      end;
    end;
  finally
    List.Free;
  end;
end;

function TSwmDB.GHeats(Des: TObject; Swmn_id: integer): boolean;
begin
  //Result := Self.LoadRec(Des,sql_HeatsBySwmn + IntToStr(Swmn_id) + ' order by p.FName','FName','ID');
  Result := Self.LoadRec(Des,HeatsViewBySwmn(Swmn_id),'FName','ID');
end;

function TSwmDB.GPlType(Des: TObject): boolean;
begin
  Result := Self.LoadRec(Des,sql_PlTp,'Name','ID');
end;

function TSwmDB.GPntsByPtrc(SQL: WideString): integer;
var List: TStringList;
begin
  Result := -1;
  List := TStringList.Create;
  try
    if Self.LoadRec(List,SQL,'Points','Points') then
      if List.Count > 0 then
        Result := StrToInt(List.Names[0]);
  finally
    List.Free;
  end;
end;

function TSwmDB.GPtrc(Des: TObject): boolean;
begin
  Result := GPtrc(Des,sql_Ptrc_view);
end;

function TSwmDB.GPtrc(Des: TObject; SQL: WideString): boolean;
var FList: TFieldNameList;
    Count: Integer;
begin
  SetLength(FList,6);
  FList[0] := 'FName';
  FList[1] := 'Name';
  FList[2] := 'SName';
  FList[3] := 'BYear';
  FList[4] := 'TName';
  FList[5] := 'CName';
  //FList[6] := 'LName';
  Result := Self.LoadRec(Des,SQL,Flist,'ID','',Count);
  SetLength(FList,0);
end;

function TSwmDB.GPtrcPTime(Ptrc_id, Swmn_id: integer): integer;
var List: TStringList;
    Y: integer;
begin
  Result := 0;
  Y := YearOf(Date);
  List := TStringList.Create;
  try
    if Self.LoadRec(List,GetPtrcMaxTimeSQL(Y,Ptrc_id,Swmn_id),'TmMax','TmMax') then
    begin
      if Self.RecordCount > 0 then
        Result := StrToIntDef(List.Names[0],0)
      else
      begin
        List.Clear;
        if Self.LoadRec(List,GetPtrcMaxTimeSQL(Y - 1,Ptrc_id,Swmn_id),'TmMax','TmMax') then
        begin
          if Self.RecordCount > 0 then
            Result := StrToIntDef(List.Names[0],0);
        end;
      end;
    end;
  finally
    List.Free;
  end;
end;

function TSwmDB.GSchl(Des: TObject): boolean;
begin
  Result := Self.LoadRec(Des,SelRec(tSchl,true,'Name'),'Name','ID');
end;

function TSwmDB.GSwmn(Des: TObject): boolean;
begin
  Result := Self.LoadRec(Des,sql_Swmn,'Name','ID');
end;

function TSwmDB.GSwType(Des: TObject): boolean;
begin
  Result := Self.LoadRec(Des,sql_SwTp,'Name','ID');
end;

function TSwmDB.Gt(TableName: TTableName; FieldName: TFieldName;
  ID: integer; Flag: boolean): Variant;
begin
  VarClear(Result);
  if Self.ExecQuery(GetRecByID(TableName,ID,flag)) then
  begin
    Result := Self.FieldByName(FieldName).AsVariant;
  end;
end;

function TSwmDB.GTrnr(Des: TObject): boolean;
begin
  Result := Self.LoadRec(Des,SelRec(tTrnr,true,'Name'),'Name','ID');
end;

procedure TSwmDB.LoadTreeView(TreeView: TTreeView);

  procedure LoadPtrcNode(Parent: TTreeNode);
  var TmpQuery: TADOQuery;
      Node: TTreeNode; Inf: TNdInf;
  begin
    TmpQuery := TADOQuery.Create(nil);
    try
      TmpQuery.ConnectionString := Self.ConnectionString;
      if TCustomADODB.ExecQuery(TmpQuery,TSwmnSQL.HeatBySwmn(GetNodeInfo(Parent).ID)) then
      begin
        while not TmpQuery.Eof do
        begin
          inf.NodeType := ntHeats;
          inf.ID := TmpQuery.FieldByName(f_id).AsInteger;
          Node   := TreeView.Items.AddChild(Parent, TmpQuery.FieldByName(f_FName).AsString + ' ' +
            TmpQuery.FieldByName(f_Name).AsString);
          Node.ImageIndex := 3;
          Node.SelectedIndex := 3;
          SetNodeInfo(inf,Node);
          TmpQuery.Next;
        end;
      end;
    finally
      TmpQuery.Free;
    end;
  end;

  procedure LoadSwimmingNode(Parent: TtreeNode);
  var TmpQuery: TADOQuery;
      Node: TTreeNode; Inf: TNdInf;
  begin
    TmpQuery := TADOQuery.Create(nil);
    try
      TmpQuery.ConnectionString := Self.ConnectionString;
      if TCustomADODB.ExecQuery(TmpQuery,sql_SwimList + ' and sw.Cmpt_id = ' +
        IntToStr(GetNodeInfo(Parent.Parent).ID) + ' order by st.id') then
      begin
        while not TmpQuery.Eof do
        begin
          inf.NodeType := ntSwmn;
          inf.ID := TmpQuery.FieldByName('ID').AsInteger;
          Node := TreeView.Items.AddChild(Parent,
            TmpQuery.FieldByName('STName').AsString + ' - ' +
            Sex[TmpQuery.FieldByName('Sex').AsInteger] + '. ' +
            TmpQuery.FieldByName('BYear').AsString + ' г.р.');
          Node.ImageIndex := 2;
          Node.SelectedIndex := 2;
          SetNodeInfo(inf,Node);
          LoadPtrcNode(Node);
          TmpQuery.Next;
        end;
      end;
    finally
      TmpQuery.Free;
    end;
  end;

var Node, tmpNode: TTreeNode; Inf: TNdInf;
begin
  ClearTreeView(TreeView);
  if(Self.ExecQuery(sql_ComptList)) then
  begin
    inf.NodeType := ntCmpt;
    inf.ID := ID_ERROR;
    Self.First;
    while not self.Eof do
    begin
      Node := TreeView.Items.Add(nil,Self.FieldByName('Name').AsString);
      Node.ImageIndex := 0;
      Node.SelectedIndex := 0;
      inf.ID := Self.FieldByName('id').AsInteger;
      inf.NodeType := ntCmpt;
      SetNodeInfo(inf,Node);
      tmpNode := TreeView.Items.AddChild(Node,'Группы заплывов');
      tmpNode.ImageIndex := 1;
      tmpNode.SelectedIndex := 1;
      inf.NodeType := ntSwmnGrp;
      SetNodeInfo(inf,tmpNode);
      LoadSwimmingNode(tmpNode);
      inf.NodeType := ntProtocol;
      tmpNode := TreeView.Items.AddChild(Node,'Протоколы');
      tmpNode.ImageIndex := 4;
      tmpNode.SelectedIndex := 4;
      SetNodeInfo(inf,tmpNode);

      tmpNode := TreeView.Items.AddChild(tmpNode,'Стартовый');
      tmpNode.ImageIndex := 5;
      tmpNode.SelectedIndex := 5;
      inf.NodeType := ntPStart;
      SetNodeInfo(inf,tmpNode);
      tmpNode := TreeView.Items.Add(tmpNode,'Итоговый');
      tmpNode.ImageIndex := 5;
      tmpNode.SelectedIndex := 5;
      inf.NodeType := ntPEnd;
      SetNodeInfo(inf,tmpNode);
      
      Self.Next;
    end;
  end;
end;

procedure TSwmDB.ReConfigHeats(SQL: WideString;
  PathCount, MinPtrcCount: integer);

  var Path, dPath, Heat, Flag: integer;
      NextHeat: boolean;
      ChHeat, HMod: integer;

  procedure InitVar;
  begin
    Path  := PathCount div 2;
    dPath := 1;
    Flag := -1;
    NextHeat := false;
  end;

begin
  if Self.ExecQuery(SQL) then
  begin
    InitVar;
    Heat := 1;
    ChHeat := -1;
    if not Self.Eof then
    begin
      HMod := Self.RecordCount mod PathCount;
      if (HMod < MinPtrcCount) and (HMod <> 0) then
        ChHeat := Self.RecordCount - 3;
    end;
    while not Self.Eof do
    begin
      Self.Edit;
        Self.FieldByName('Path').AsInteger := Path;
        Self.FieldByName('Heat').AsInteger := Heat;
        if Self.FieldByName('NoCat').AsBoolean then
          Self.FieldByName('Place').AsInteger := 9999;
      Self.Post;
      // Расчет номера дорожки
      Path  := Path + dPath;
      dPath := (abs(dPath) + 1) * Flag;
      Flag  := Flag * -1;
      // Если в следующем заплыве людей меньше чем
      // MinPtrcCount, то переходим к след. заплыву
      {if (Self.RecordCount - MinPtrcCount) = Self.RecNo then
        Path := 0; }
      {if ((Self.RecordCount - MinPtrcCount) = Self.RecNo) and
      (((Self.RecordCount - Self.RecNo) div PathCount) = 0) then
        Path := 0;  }
      if ChHeat = Self.RecNo then
        Path := 0;
      
      // Если номер дорожки вышел за допустимый
      // диапазон - переходим к след. заплыву
      if (Path < 1) or (Path > PathCount) then
      begin
        inc(Heat);
        InitVar;
      end;

      Self.Next;
    end;
  end;
end;

procedure TSwmDB.ReConfigPlace(ID: integer);
begin
  ReConfigPlace(GetHeatsList(ID,'Time'));
end;

procedure TSwmDB.ReConfigPlace(SQL: WideString);
var Place: integer;
begin
  Place := 1;
  if Self.ExecQuery(SQL) then
  begin
    while not Self.Eof do
    begin
      Self.Edit;
      if not Self.FieldByName('NoCat').AsBoolean then
      begin
        if Self.FieldByName('Time').AsInteger <> 0 then
        begin
          Self.FieldByName('Place').AsInteger := Place;
          Inc(Place);
        end else
          Self.FieldByName('Place').AsInteger := 0;
      end else
        Self.FieldByName('Place').AsInteger := 9999;
      Self.Post;
      Self.Next;
    end;
  end;
end;

procedure TSwmDB.ReConfigHeats(ID: integer; TimeField: TFieldName);
begin
  ReConfigHeats(GetHeatsList(ID,TimeField),6,3);
end;

function TSwmDB.SCity(Name: string; ID: integer): boolean;
begin
  if ID <> ID_ERROR then
    Result := Self.SaveRec(sql_CityInf,'Name',Name)
  else
    Result := Self.AddRec(tCity,'Name',Name);
end;

function TSwmDB.SCmpt(Name, Info: string; DateTime: TDateTime; ID: integer): boolean;
var FList: TFieldList;
    Count: integer;
begin
  SetLength(FList,3);
  FList[0].Field := 'Name';
  FList[0].Value := Name;
  Flist[1].Field := 'Info';
  FList[1].Value := Info;
  FList[2].Field := 'Date';
  FList[2].Value := DateTime;
  if ID <> ID_Error then
    Result := Self.SaveRec(sql_CmptInf + IntToStr(ID),FList,Count)
  else
    Result := Self.AddRec(tCmpt,FList);
  SetLength(FList,0);
end;

function TSwmDB.SHeats(Swmn_id, Ptrc_id, PTime: integer;
  NoCat: boolean; ID: integer): boolean;
var FList: TFieldList; Count: integer;
begin
  SetLength(FList,4);
  FList[0].Field := 'Swmn_id'; FList[0].Value := Swmn_id;
  FList[1].Field := 'Ptrc_id'; FList[1].Value := Ptrc_id;
  FList[2].Field := 'PTime';   FList[2].Value := PTime;
  FList[3].Field := 'NoCat';   FList[3].Value := NoCat;
  if ID <> ID_ERROR then
    Result := Self.SaveRec(GetRecByID(tHets,ID,false),FList,Count)
  else
    Result := Self.AddRec(tHets,FList);
  SetLength(FList,0);
  if Result then
    ReConfigHeats(GetHeatsListSwmn(Swmn_id),6,3);
end;

function TSwmDB.SPlType(Name: string; ID: integer): boolean;
begin
  if ID <> ID_ERROR then
    Result := Self.SaveRec(sql_PlTpInf + IntToStr(ID),'Name',Name)
  else
    Result := Self.AddRec(tPlTp,'Name',Name);
end;

function TSwmDB.SPTime(PTime, ID: integer): boolean;
begin
  Result := Sv(tHets,'PTime',PTime,ID,False);
  if Result then
  begin
    ReConfigHeats(ID);
  end;
end;

function TSwmDB.SPtrc(FName, Name, LName: string; BYear, Sex, Schl_id, Trnr_id,
  City_id, ID: integer): boolean;
var FList: TFieldList;
    Count: integer;
begin
  SetLength(FList,8);
  FList[0].Field := 'FName';   FList[0].Value := FName;
  FList[1].Field := 'Name';    FList[1].Value := Name;
  FList[2].Field := 'LName';   FList[2].Value := LName;
  FList[3].Field := 'BYear';   FList[3].Value := BYear;
  FList[4].Field := 'Sex';     FList[4].Value := Sex;
  FList[5].Field := 'Schl_id'; FList[5].Value := Schl_id;
  FList[6].Field := 'Trnr_id'; FList[6].Value := Trnr_id;
  FList[7].Field := 'City_id'; FList[7].Value := City_id;
  if ID <> ID_ERROR then
    Result := Self.SaveRec(sql_PtrcInf + IntToStr(ID),FList,Count)
  else
    Result := Self.AddRec(tPtrc,FList);
  SetLength(FList,0);
end;

function TSwmDB.SPtrcCtgr(ID, CtNm_id: integer): boolean;
begin
  Result := Sv(tPtrc,'CtNm_id',CtNm_id,ID);
end;

function TSwmDB.SSchl(Name: string; ID: integer): boolean;
begin
  Result := Self.Sv(tSchl,'Name',Name,ID);
end;

function TSwmDB.SSwmn(Cmpt_id, SwTp_id, PlTp_id, BYear, Sex, ID: integer): boolean;
var FList: TFieldList;
    Count: integer;
begin
  SetLength(FList,5);
  FList[0].Field := 'Cmpt_id';  FList[0].Value := Cmpt_id;
  FList[1].Field := 'SwTp_id';  FList[1].Value := SwTp_id;
  FList[2].Field := 'PlTp_id';  FList[2].Value := PlTp_id;
  FList[3].Field := 'BYear';    FList[3].Value := BYear;
  FList[4].Field := 'Sex';      FList[4].Value := Sex;
  if ID <> ID_ERROR then
    Result := Self.SaveRec(sql_SwmnInf + IntToStr(ID),FList,Count)
  else
    Result := Self.AddRec(tSwmn,FList);
  SetLength(FList,0);
end;

function TSwmDB.SSwType(Name: string; ID: integer): boolean;
begin
  if ID <> ID_ERROR then
    Result := Self.SaveRec(sql_SwTpInf + IntToStr(ID),'Name',Name)
  else
    Result := Self.AddRec(tSwTp,'Name',Name);
end;

function TSwmDB.STime(ATime, ID: integer): boolean;
var p: integer;
    var Sql: WideString;
begin
  Result := Sv(tHets,'Time',ATime,ID,False);
  if Result then
  begin
    p := GPntsByPtrc(GPntsByHeatSQL(ID,ATime));
    if p <> -1 then
      Self.SaveRec(GetRecByID(tHets,ID,false),'Points',p)
    else
      Self.SaveRec(GetRecByID(tHets,ID,false),'Points',0);
    ReConfigPlace(ID);
    Sql := 'Select * from Ptrc where Ptrc.id = (Select Heats.Ptrc_id ' +
      ' from Heats where Heats.id = ' + IntToStr(ID) + ')';
    Self.SaveRec(Sql,'CtNm_id',GetCtgrNm(ID,ATime));
  end;
end;

function TSwmDB.STrnr(Name: string; ID: integer): boolean;
begin
  Result := Sv(tTrnr,'Name',Name,ID);
end;

function TSwmDB.Sv(TableName: TTableName; FieldName: TFieldName; Value: Variant;
  ID: integer; Flag: boolean): boolean;
begin
  if ID <> ID_ERROR then
  begin
    Result := Self.SaveRec(GetRecByID(TableName,ID,Flag),FieldName,Value);
  end else
    Result := Self.AddRec(TableName,FieldName,Value);
end;



end.
