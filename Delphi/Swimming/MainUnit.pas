unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ActnCtrls, ToolWin, ActnMan, ActnMenus,
  XPStyleActnCtrls, ActnList, Global, StdCtrls, DB, ADODB, ImgList, OleCtrls,
  SHDocVw, NodeUnit;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    TreeView: TTreeView;
    ActionManager: TActionManager;
    ActionMainMenuBar: TActionMainMenuBar;
    ActionToolBar: TActionToolBar;
    Splitter: TSplitter;
    actAddCmpt: TAction;
    actEditCmpt: TAction;
    actAdd: TAction;
    actEdit: TAction;
    actImages: TImageList;
    Browser: TWebBrowser;
    actDelete: TAction;
    actAddSwmn: TAction;
    actEditSwmn: TAction;
    actExit: TAction;
    actDeleteCmpt: TAction;
    actDeleteSwmn: TAction;
    actEditSwTp: TAction;
    actEditCity: TAction;
    actEditPlTp: TAction;
    actEditTrnr: TAction;
    actEditSchl: TAction;
    actEditPtrc: TAction;
    actAddPtrc: TAction;
    actCreate: TAction;
    actRefresh: TAction;
    actDeleteHeats: TAction;
    actTime: TAction;
    actEditPTime: TAction;
    actEditTTime: TAction;
    actPrint: TAction;
    actSave: TAction;
    actPrintPrv: TAction;
    actSaveDoc: TAction;
    SaveDialog: TSaveDialog;
    actEditPoints: TAction;
    actEditCtgr: TAction;
    TreeImages: TImageList;
    actHelp: TAction;
    actAbout: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actAddCmptExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actEditCmptExecute(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure BrowserBeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure actAddSwmnExecute(Sender: TObject);
    procedure actEditSwmnExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actDeleteCmptExecute(Sender: TObject);
    procedure actDeleteSwmnExecute(Sender: TObject);
    procedure actEditSwTpExecute(Sender: TObject);
    procedure actEditPtrcExecute(Sender: TObject);
    procedure actAddPtrcExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actDeleteHeatsExecute(Sender: TObject);
    procedure actTimeExecute(Sender: TObject);
    procedure actEditPTimeExecute(Sender: TObject);
    procedure actEditTTimeExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actPrintPrvExecute(Sender: TObject);
    procedure actSaveDocExecute(Sender: TObject);
    procedure actEditPointsExecute(Sender: TObject);
    procedure actEditCtgrExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
  private
    function LoadCmptInfo(ID: integer): TFileName;
    function LoadSwmnInfo(ID: integer): TFileName;
    function LoadHetsInfo(ID: integer): TFileName;
    function LoadPStart(ID: integer): TFileName;
    function LoadPEnd(ID: integer): TFileName; 
    function CreateHTML(Node: TTreeNode): TFileName;  overload;
    function CreateHTML(NodeInfo: TNdInf): TFileName; overload;
    procedure DeleteNode(Inf: TNdInf);
    procedure SelectNode(NodeType: TNodeType; Parent: TTreeNode = nil);
    function PrepareData(DataStr: string): string;
  public
    procedure ReloadData(var Msg: TMessage); message WM_RELOADDATA;
    procedure UpdateBrwsr(var Msg: TMessage); message WM_UPDATEBRWSR;
    procedure BrowserPrint;
    procedure BrowserPrintPreview;
    procedure BrowserSave;
  end;

var
  MainForm: TMainForm;
  l: TStringList;

implementation

uses CmptInfo, SwmInfo, SQLUnit, DBList, ADODBWork, SwimmingDB, DateUtils, PtrcEditor,
  TimeUnit, TimeWrk, ActiveX, ComObj, Word, PntsEditor, DlgUnit, ShellApi, ABOUT, SwmnSQL;

{$R *.dfm}

var
  IndexHTML: TFileName;

procedure TMainForm.actAboutExecute(Sender: TObject);
var Dlg: TAboutBox;
begin
  Dlg := TAboutBox.Create(Self);
  try
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actAddCmptExecute(Sender: TObject);
var Dlg: TCmptInfoForm; dt: TDateTime;
begin
  Dlg := TCmptInfoForm.Create(Self);
  try
    if Dlg.ShowMode(1) = mrOK then
    begin
      dt := StrToDateTime(DateToStr(Dlg.dtDate.Date) +' '+
        TimeToStr(Dlg.dtTime.Time));
      if SwDB.SCmpt(Dlg.edtName.Text, Dlg.memInfo.Text, dt) then
      begin
        SendMessage(Self.Handle,WM_RELOADDATA,0,0);
        SelectNode(ntCmpt);
      end;
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actAddPtrcExecute(Sender: TObject);
var Dlg: TfrmPatricipants;
    TmDlg: TTimeForm;
    SID, BYear, Sex: integer;
begin
  SID := ID_ERROR;
  case GetNodeInfo(TreeView.Selected).NodeType of
    ntSwmn: begin
      SID := GetNodeInfo(TreeView.Selected).ID;
    end;
    ntHeats: begin
      SID := GetNodeInfo(TreeView.Selected.Parent).ID;
    end;
  end;
  BYear := SwDB.Gt(TSwmnSQL.tSwmn,'BYear',SID);
  Sex   := SwDB.Gt(TSwmnSQL.tSwmn,'Sex',SID);
  Dlg := TfrmPatricipants.Create(Self,BYear,Sex);
  try
    Dlg.btnPanel.Visible := true;
    Dlg.StatusBar.Visible := false;
    Dlg.DelEnabled := false;
    if Dlg.ShowModal = mrOK then
    begin
      TmDlg := TTimeForm.Create(Self);
      try
        TmDlg.SetData(Integer(Dlg.ListView.Selected.Data),SID);
        if TmDlg.ShowModal = mrOK then
        begin
          if SwDB.SHeats(SID,
            Integer(Dlg.ListView.Selected.Data),TmDlg.ATime,Dlg.chNoCat.Checked) then
          begin
            SendMessage(Self.Handle,WM_RELOADDATA,0,0);
            SelectNode(ntHeats);
          end;
        end;
      finally
        TmDlg.Free;
      end;
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actAddSwmnExecute(Sender: TObject);
var Dlg: TfrmSwmInfo;
begin
  Dlg := TfrmSwmInfo.Create(Self);
  try
    SendMessage(Dlg.Handle,WM_RELOADDATA,0,0);
    if Sender = actAdd then
      Dlg.cbCmpt.ItemIndex := Dlg.cbCmpt.Items.IndexOfObject(
        TObject(GetNodeInfo(TreeView.Selected.Parent).ID));
    if Dlg.ShowMode(1) = mrOK then
    begin
      if SwDB.SSwmn(Integer(Dlg.cbCmpt.Items.Objects[Dlg.cbCmpt.ItemIndex]),
        Integer(Dlg.cbSwTp.Items.Objects[Dlg.cbSwTp.ItemIndex]),
        Integer(Dlg.cbPlTp.Items.Objects[Dlg.cbPlTp.ItemIndex]),
        StrToInt(Dlg.cbBYear.Items[Dlg.cbBYear.ItemIndex]),
        Dlg.cbSex.ItemIndex) then
        begin
          SendMessage(Self.Handle,WM_RELOADDATA,0,0);
          SelectNode(ntSwmn);
        end;
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actCreateExecute(Sender: TObject);
begin
 //
end;

procedure TMainForm.actDeleteCmptExecute(Sender: TObject);
var Dlg: TDlgFrm;
begin
  Dlg := TDlgFrm.Create(Self);
  try
    Dlg.Text.Caption := 'Вы действительно хотите удалить информацию о соревновании?';
    if Dlg.ShowModal = mrOK then
    begin
      if SwDB.DCmpt(GetNodeInfo(TreeView.Selected).ID) then
        TreeView.Items.Delete(TreeView.Selected);
  end;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actDeleteHeatsExecute(Sender: TObject);
var Dlg: TDlgFrm;
begin
  Dlg := TDlgFrm.Create(Self);
  try
    Dlg.Text.Caption := 'Вы действительно хотите удалить информацию о участнике соревнования?';
    if Dlg.ShowModal = mrOK then
    begin
    if SwDB.DHeats(GetNodeInfo(TreeView.Selected).ID) then
      TreeView.Items.Delete(TreeView.Selected);
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actDeleteSwmnExecute(Sender: TObject);
var Dlg: TDlgFrm;
begin
  Dlg := TDlgFrm.Create(Self);
  try
    Dlg.Text.Caption := 'Вы действительно хотите удалить информацию о заплыве?';
    if Dlg.ShowModal = mrOK then
    begin
    if SwDB.DSwmn(GetNodeInfo(TreeView.Selected).ID) then
      TreeView.Items.Delete(TreeView.Selected);
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actEditCmptExecute(Sender: TObject);
var Dlg: TCmptInfoForm; dt: TDateTime;
    List: TStringList; ID: integer;
begin
  List := TStringList.Create;
  Dlg  := TCmptInfoForm.Create(Self);
  ID := GetNodeInfo(TreeView.Selected).ID;
  try
    if SwDB.LoadRec(List,TSwmnSQL.SelectByID(TSwmnSQL.tCmpt,ID),'ID') then
    begin
      Dlg.edtName.Text := List.Values['Name'];
      Dlg.dtDate.Date := DateOf(StrToDateTime(List.Values['Date']));
      Dlg.dtTime.Time := TimeOf(StrToDateTime(List.Values['Date']));
      Dlg.memInfo.Lines.Add(List.Values['Info']);
      if Dlg.ShowMode(2) = mrOk then
      begin
        dt := StrToDateTime(DateToStr(Dlg.dtDate.Date) +' '+
          TimeToStr(Dlg.dtTime.Time));
        if SwDB.SCmpt(Trim(Dlg.edtName.Text),Dlg.memInfo.Lines.Text,dt,ID) then
        begin
          SendMessage(Self.Handle,WM_RELOADDATA,0,0);
          SelectNode(ntCmpt);
        end;
      end;
    end;
  finally
    List.Free;
    Dlg.Free;
  end;
end;

procedure TMainForm.actEditCtgrExecute(Sender: TObject);
var Dlg: TfrmPointsEditor;
begin
  Dlg := TfrmPointsEditor.Create(Self,tCtgr);
  try
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actEditPointsExecute(Sender: TObject);
var Dlg: TfrmPointsEditor;
begin
  Dlg := TfrmPointsEditor.Create(Self,tPnts);
  try
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actEditPTimeExecute(Sender: TObject);
var Dlg: TTimeForm; str: string[8];
    ID: integer;
begin
  Dlg := TTimeForm.Create(Self);
  try
    ID := GetNodeInfo(TreeView.Selected).ID;
    str := SwTimeToStr(SwDb.Gt(TSwmnSQL.tHeats,'PTime',ID,false));
    Dlg.mskTime.Text := str;
    if Dlg.ShowModal = mrOK then
    begin
      if SwDB.SPTime(Dlg.ATime,ID) then
         Browser.Navigate(CreateHTML(TreeView.Selected));
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actEditPtrcExecute(Sender: TObject);
var Dlg: TfrmPatricipants;
begin
  Dlg := TfrmPatricipants.Create(Self);
  try
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.actEditSwmnExecute(Sender: TObject);
var Dlg: TfrmSwmInfo;
    List: TStringList;
    ID: integer;
begin
  List := TStringList.Create;
  Dlg := TfrmSwmInfo.Create(Self);
  ID := GetNodeInfo(TreeView.Selected).ID;
  try
    if SwDB.LoadRec(List,GetRecByID(tSwmn,ID,false),'ID') then
    begin
      SendMessage(Dlg.Handle,WM_RELOADDATA,0,0);
      Dlg.cbSwTp.ItemIndex :=
        Dlg.cbSwTp.Items.IndexOfObject(TObject(StrToInt(List.Values['SwTp_id'])));
      Dlg.cbPlTp.ItemIndex :=
        Dlg.cbPlTp.Items.IndexOfObject(TObject(StrToInt(List.Values['PlTp_id'])));
      Dlg.cbCmpt.ItemIndex :=
        Dlg.cbCmpt.Items.IndexOfObject(TObject(StrToInt(List.Values['Cmpt_id'])));
      Dlg.cbBYear.ItemIndex := Dlg.cbBYear.Items.IndexOf(List.Values['BYear']);
      Dlg.cbSex.ItemIndex := StrToIntDef(List.Values['Sex'],0);
      if Dlg.ShowMode(2) = mrOK then
      begin
        if SwDB.SSwmn(Integer(Dlg.cbCmpt.Items.Objects[Dlg.cbCmpt.ItemIndex]),
          Integer(Dlg.cbSwTp.Items.Objects[Dlg.cbSwTp.ItemIndex]),
          Integer(Dlg.cbPlTp.Items.Objects[Dlg.cbPlTp.ItemIndex]),
          StrToInt(Dlg.cbBYear.Items[Dlg.cbBYear.ItemIndex]),
          Dlg.cbSex.ItemIndex,ID) then
        begin
          SendMessage(Self.Handle,WM_RELOADDATA,0,0);
          SelectNode(ntSwmn);
        end;
      end;
    end;
  finally
    List.Free;
    Dlg.Free;
  end;
end;

procedure TMainForm.actEditSwTpExecute(Sender: TObject);
var Dlg: TfrmDBList;
begin
  Dlg := TfrmDBList.Create(Self,(Sender as TComponent).Tag);
  try
    Dlg.ShowModal;
  finally
    Dlg.Free
  end;
end;

procedure TMainForm.actEditTTimeExecute(Sender: TObject);
begin
  actTime.OnExecute(Sender);
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.actHelpExecute(Sender: TObject);
begin
  ShellExecute(Self.Handle,'open',PChar(AppDir + 'Help\Help.htm'),'','',SW_SHOWMAXIMIZED);
end;

procedure TMainForm.actPrintExecute(Sender: TObject);
begin
  BrowserPrint;
end;

procedure TMainForm.actPrintPrvExecute(Sender: TObject);
begin
  BrowserPrintPreview;
end;

procedure TMainForm.actRefreshExecute(Sender: TObject);
begin
  SendMessage(Self.Handle,WM_RELOADDATA,0,0);
end;

procedure TMainForm.actSaveDocExecute(Sender: TObject);
var App: TWordApplication;
begin
  if SaveDialog.Execute then
  begin
    App := TWordApplication.Create(true);
    try
      if App.Exists then
      begin
        App.Documents.Open(AppDir + 'Index.html');
        App.Documents.Item[0].SaveAs(SaveDialog.FileName,0);
      end;
    finally
      App.Free;
    end;
  end;
end;

procedure TMainForm.actSaveExecute(Sender: TObject);
begin
  BrowserSave;
end;

procedure TMainForm.actTimeExecute(Sender: TObject);
var Dlg: TTimeForm; ID: integer;
    str: string[8];
begin
  Dlg := TTimeForm.Create(Self);
  try
    ID := GetNodeInfo(TreeView.Selected).ID;
    str := SwTimeToStr(SwDb.Gt(tHets,'Time',ID,false));
    Dlg.mskTime.EditText := str;
    Dlg.lblSwmn.Caption := 'Результат:';
    if Dlg.ShowModal = mrOk then
      SwDB.STime(Dlg.ATime,GetNodeInfo(TreeView.Selected).ID)
  finally
    Dlg.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MainFormHandle := Self.Handle;
  AppDir := ExtractFilePath(Application.ExeName);
  IndexHTML := AppDir + 'Html\index.html';
  SwDB := TSwmDB.Create(Self);
  SwDB.ConnectionString := GetConnectionString;
  SendMessage(Self.Handle,WM_RELOADDATA,1,0);
  Browser.Navigate(IndexHTML);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SwDb.Active := false;
  SwDB.Free;
end;

function TMainForm.LoadCmptInfo(ID: integer): TFileName;
var HTML, DList, Table: TStringList;
    i, Heat, TablePos, Swmn_id: integer;
    TempStr: string; TimeStr: string[8];
begin
  Result := IndexHTML;
  TablePos := 0;
  DList := TStringList.Create;
  try
    if SwDB.LoadRec(DList,TSwmnSQL.SelectByID(TSwmnSQL.tCmpt,ID),'ID') then
    begin
      HTML := TStringList.Create;
      try
        HTML.LoadFromFile(AppDir + 'Html\CmptInfo.html');
        for i := 0 to HTML.Count - 1 do
        begin
          if Trim(HTML[i]) = '$TITLE' then HTML[i] := DList.Values['Name'];
          if Trim(HTML[i]) = '$HEAD' then HTML[i] := DList.Values['Name'];
          if Trim(HTML[i]) = '$DATETIME' then HTML[i] := PrepareData(DList.Values['Date']);
          if Trim(HTML[i]) = '$TABLE'  then
          begin
            TablePos := i;
            HTML[i] := '';
          end;
        end;
        if SwDB.ExecQuery(TSwmnSQL.HeatByCmpt(ID)) then
        begin
          Table := TStringList.Create;
          try
            Heat := -1;
            Swmn_id := ID_ERROR;
            if SwDB.RecordCount > 0 then
              Table.Add('<table width="100%">');
            while not SwDB.Eof do
            begin
              TempStr := SwDB.FieldByName('SwTp').AsString + ' - ' + Sex[SwDB.FieldByName('Sex').AsInteger] + '. ' +
                  SwDB.FieldByName('BYear').AsString + ' г.р.';
              if Swmn_id <> SwDB.FieldByName('Swmn_id').AsInteger then
              begin
                if Heat <> -1 then Table.Add('<tr><td class="Sep" colspan = "7">&nbsp;</td></tr>');
                Table.Add('<tr class="Head"><td colspan="7">' +
                  '<b>' + SwDB.FieldByName('SwTp').AsString + ' - ' + Sex[SwDB.FieldByName('Sex').AsInteger] + ' ' +
                   SwDB.FieldByName('BYear').AsString + ' г.р' + '</b></td></tr>');
                Heat := -1;
                Swmn_id := SwDB.FieldByName('Swmn_id').AsInteger;
              end;
              // Заплыв
              TempStr := '<tr><td class="alL" nowrap>';
              if Heat = SwDB.FieldByName('Heat').AsInteger then
                TempStr := TempStr + '&nbsp;'
              else begin
                TempStr := TempStr + 'Заплыв ' + SwDB.FieldByName('Heat').AsString;
                Heat := SwDB.FieldByName('Heat').AsInteger
              end;
              TempStr := TempStr + '</td>';
              Table.Add(TempStr);
              // Участник
              TempStr := '<td class="alL" nowrap>' + SwDB.FieldByName('Path').AsString + '. ' +
                SwDB.FieldByName('FName').AsString + ' ' + SwDB.FieldByName('Name').AsString + '</td>';
              Table.Add(TempStr);
              // Год рождения
              TempStr := '<td>' + SwDB.FieldByName('BYear').AsString + '</td>';
              Table.Add(TempStr);
              // Город
              TempStr := '<td class="alL">' + SwDB.FieldByName('City').AsString + '</td>';
              Table.Add(TempStr);
              // Школа
              TempStr := '<td class="alL">' + SwDB.FieldByName('Schl').AsString + '</td>';
              Table.Add(TempStr);
              // Время
              TimeStr := SwTimeToStr(SwDB.FieldByName('PTime').AsInteger);
              TempStr := '<td class="alR">' + TimeStr + '</td>';
              Table.Add(TempStr);
              // Ссылка
              TempStr := '<td class="alR"><a class="Del" href="#Heat=' +
                SwDB.FieldByName('id').AsString + '">[-]</a></td></tr>';
              Table.Add(TempStr);
              SwDB.Next;
            end;

            if Trim(Table.Text) <> '' then
            begin
              Table.Add('</table><br>');
              HTML.Insert(TablePos,Table.Text);
            end;
          finally
            Table.Free;
          end;
        end;
        HTML.SaveToFile(AppDir + 'index.html');
        Result := AppDir + 'index.html';
      finally
        HTML.Free;
      end;
    end;
  finally
    DList.Free;
  end;
end;

function TMainForm.LoadHetsInfo(ID: integer): TFileName;
var HTML: TStringList; i: integer;
    TimeStr: string[8];
begin
  Result := IndexHTML;
  if SwDB.ExecQuery(TSwmnSQL.HeatsInfo(ID)) then
  begin
    if not SwDB.Eof then
    begin
      HTML := TStringList.Create;
      try
        HTML.LoadFromFile(AppDir + 'Html\HeatsInfo.html');
        for i := 0 to HTML.Count - 1 do
        begin
          if (Trim(HTML[i]) = '$HEAD') or (Trim(HTML[i]) = '$TITLE')  then
          begin
            HTML[i] := SwDB.FieldByName('FName').AsString + ' ' +
              SwDB.FieldByName('Name').AsString;
          end;
          if Trim(HTML[i]) = '$INFO' then
          begin
            HTML[i] := SwDB.FieldByName('BYear').AsString + ' ' +
              Sex[SwDB.FieldByName('Sex').AsInteger] + '.';
          end;
          if Trim(HTML[i]) = '$HEAT' then
            HTML[i] := SwDB.FieldByName('Heat').AsString;

          if Trim(HTML[i]) = '$PATH' then
            HTML[i] := SwDB.FieldByName('Path').AsString;

          if Trim(HTML[i]) = '$PTIME' then
          begin
            TimeStr := SwTimeToStr(SwDB.FieldByName('PTime').AsInteger);
            HTML[i] := TimeStr;
          end;

          if Trim(HTML[i]) = '$TTIME' then
          begin
            TimeStr := SwTimeToStr(SwDB.FieldByName('Time').AsInteger);
            HTML[i] := TimeStr;
          end;

          if Trim(HTML[i]) = '$POINTS' then
          begin
            if not SwDB.FieldByName('NoCat').AsBoolean then
              HTML[i] := SwDB.FieldByName('Points').AsString
            else
              HTML[i] := 'в/к';
          end;

          if Trim(HTML[i]) = '$PLACE' then
          begin
            if not SwDB.FieldByName('NoCat').AsBoolean then
              HTML[i] := SwDB.FieldByName('Place').AsString
            else
              HTML[i] := 'в/к';
          end;

          if Trim(HTML[i]) = '$CAT' then
          begin
            HTML[i] := SwDB.FieldByName('CtNm').AsString;
          end;

          if Trim(HTML[i]) = '$LINK' then
            HTML[i] := '<a class="Del" href="#HEATS=' + SwDB.FieldByName('ID').AsString +'">[удалить]</a>';
        end;
        HTML.SaveToFile(AppDir + 'index.html');
        Result := AppDir + 'index.html';
      finally
        HTML.Free;
      end;
    end;
  end;
end;

function TMainForm.LoadPEnd(ID: integer): TFileName;
var HTML, DList, Table: TStringList;
    i, Number, TablePos, Swmn_id: integer;
    TempStr: string; TimeStr: string[8];
begin
  Result := IndexHTML;
  TablePos := 0;
  DList := TStringList.Create;
  try
    if SwDB.LoadRec(DList,TSwmnSQL.SelectByID(TSwmnSQL.tCmpt,ID),'ID') then
    begin
      HTML := TStringList.Create;
      try
        HTML.LoadFromFile(AppDir + 'Html\PEnd.html');
        for i := 0 to HTML.Count - 1 do
        begin
          if Trim(HTML[i]) = '$HEAD' then HTML[i] := SwDB.Gt(TSwmnSQL.tCmpt,'Info',ID);
          if Trim(HTML[i]) = '$DATETIME' then HTML[i] := PrepareData(DList.Values['Date']);
          if Trim(HTML[i]) = '$TABLE'  then
          begin
            TablePos := i;
            HTML[i] := '';
          end;
        end;
        if SwDB.ExecQuery(TSwmnSQL.HeatPEnd(ID)) then
        begin
          Table := TStringList.Create;
          try
            Number := 1;
            Swmn_id := ID_ERROR;
            if SwDB.RecordCount > 0 then
              Table.Add('<table width="100%">');
            while not SwDB.Eof do
            begin
              TempStr := SwDB.FieldByName('SwTp').AsString + ' - ' + Sex[SwDB.FieldByName('Sex').AsInteger] + '. ' +
                  SwDB.FieldByName('BYear').AsString + ' г.р.';
              if Swmn_id <> SwDB.FieldByName('Swmn_id').AsInteger then
              begin
                Table.Add('<tr height = "50"><td colspan="8">' +
                  '<b>' + SwDB.FieldByName('SwTp').AsString + ' - ' + Sex[SwDB.FieldByName('Sex').AsInteger] + ' ' +
                   SwDB.FieldByName('BYear').AsString + ' г.р' + '</b></td></tr>');
                TempStr := '<tr><td><b>№</b></td><td><b>Имя</b></td><td><b>Год</b></td><td><b>Результат</b></td>' +
                  '<td><b>Разряд</b></td><td><b>Очки</b></td><td><b>Город</b></td><td><b>Тренер</b></td></tr>';
                Table.Add(TempStr);
                Number := 1;
                Swmn_id := SwDB.FieldByName('Swmn_id').AsInteger;
              end;
              //Номер
              TempStr := '<tr><td class="alL" nowrap>' + IntToStr(Number) + '</td>';
              Table.Add(TempStr);
              // Участник
              TempStr := '<td class="alL" nowrap>' +
                SwDB.FieldByName('FName').AsString + ' ' + SwDB.FieldByName('Name').AsString + '</td>';
              Table.Add(TempStr);
              // Год рождения
              TempStr := '<td>' + SwDB.FieldByName('BYear').AsString + '</td>';
              Table.Add(TempStr);
              // Время
              TimeStr := SwTimeToStr(SwDB.FieldByName('Time').AsInteger);
              TempStr := '<td class="alR">' + TimeStr + '</td>';
              Table.Add(TempStr);
              // Разряд
              TempStr := '<td>' + SwDB.FieldByName('CtNm').AsString + '</td>';
              Table.Add(TempStr);
              // Очки
              TempStr := '<td class="alR">';
              if not SwDB.FieldByName('NoCat').AsBoolean then
                TempStr := TempStr + SwDB.FieldByName('Points').AsString
              else
              TempStr := TempStr + 'в/к';
              Table.Add(TempStr + '</td>');
              // Город
              TempStr := '<td class="alL">' + SwDB.FieldByName('City').AsString + '</td>';
              Table.Add(TempStr);
              // Тренер
              TempStr := '<td class="alL">' + SwDB.FieldByName('Trnr').AsString + '</td>';
              Table.Add(TempStr);
              Inc(Number);
              SwDB.Next;
            end;

            if Trim(Table.Text) <> '' then
            begin
              Table.Add('</table><br>');
              HTML.Insert(TablePos,Table.Text);
            end;

          finally
            Table.Free;
          end;
        end;
        HTML.SaveToFile(AppDir + 'index.html');
        Result := AppDir + 'index.html';
      finally
        HTML.Free;
      end;
    end;
  finally
    DList.Free;
  end;
end;

function TMainForm.LoadPStart(ID: integer): TFileName;
var HTML, DList, Table: TStringList;
    i, Heat, TablePos, Swmn_id: integer;
    TempStr: string; TimeStr: string[8];
begin
  Result := IndexHTML;
  TablePos := 0;
  DList := TStringList.Create;
  try
    if SwDB.LoadRec(DList,GetRecByID(tCmpt,ID),'ID') then
    begin
      HTML := TStringList.Create;
      try
        HTML.LoadFromFile(AppDir + 'Html\PStart.html');
        for i := 0 to HTML.Count - 1 do
        begin
          if Trim(HTML[i]) = '$HEAD' then HTML[i] := SwDB.Gt(tCmpt,'Info',ID);
          if Trim(HTML[i]) = '$DATETIME' then HTML[i] := PrepareData(DList.Values['Date']);
          if Trim(HTML[i]) = '$TABLE'  then
          begin
            TablePos := i;
            HTML[i] := '';
          end;
        end;
        if SwDB.ExecQuery(GetHeatsByCmpt(ID)) then
        begin
          Table := TStringList.Create;
          try
            Heat := -1;
            Swmn_id := ID_ERROR;
            if SwDB.RecordCount > 0 then
              Table.Add('<table width="100%">');
            while not SwDB.Eof do
            begin
              TempStr := SwDB.FieldByName('SwTp').AsString + ' - ' + Sex[SwDB.FieldByName('Sex').AsInteger] + '. ' +
                  SwDB.FieldByName('BYear').AsString + ' г.р.';
              if Swmn_id <> SwDB.FieldByName('Swmn_id').AsInteger then
              begin
                if Heat <> -1 then Table.Add('<tr><td class="Sep" colspan = "6">&nbsp;</td></tr>');
                Table.Add('<tr><td colspan="6">' +
                  '<b>' + SwDB.FieldByName('SwTp').AsString + ' - ' + Sex[SwDB.FieldByName('Sex').AsInteger] + ' ' +
                   SwDB.FieldByName('BYear').AsString + ' г.р' + '</b></td></tr>');
                Heat := -1;
                Swmn_id := SwDB.FieldByName('Swmn_id').AsInteger;
              end;
              // Заплыв
              TempStr := '<tr><td class="alL" nowrap>';
              if Heat = SwDB.FieldByName('Heat').AsInteger then
                TempStr := TempStr + '&nbsp;'
              else begin
                TempStr := TempStr + 'Заплыв ' + SwDB.FieldByName('Heat').AsString;
                Heat := SwDB.FieldByName('Heat').AsInteger;
              end;
              TempStr := TempStr + '</td>';
              Table.Add(TempStr);
              // Участник
              TempStr := '<td class="alL" nowrap>' + SwDB.FieldByName('Path').AsString + '. ' +
                SwDB.FieldByName('FName').AsString + ' ' + SwDB.FieldByName('Name').AsString + '</td>';
              Table.Add(TempStr);
              // Год рождения
              TempStr := '<td>' + SwDB.FieldByName('BYear').AsString + '</td>';
              Table.Add(TempStr);
              // Город
              TempStr := '<td class="alL">' + SwDB.FieldByName('CityName').AsString + '</td>';
              Table.Add(TempStr);
              // Школа
              TempStr := '<td class="alL">' + SwDB.FieldByName('SchlName').AsString + '</td>';
              Table.Add(TempStr);
              // Время
              TimeStr := SwTimeToStr(SwDB.FieldByName('PTime').AsInteger);
              TempStr := '<td class="alR">' + TimeStr + '</td>';
              Table.Add(TempStr);
              SwDB.Next;
            end;
        
            if Trim(Table.Text) <> '' then
            begin
              Table.Add('</table><br>');
              HTML.Insert(TablePos,Table.Text);
            end;
          finally
            Table.Free;
          end;
        end;
        HTML.SaveToFile(AppDir + 'index.html');
        Result := AppDir + 'index.html';
      finally
        HTML.Free;
      end;
    end;
  finally
    DList.Free;
  end;
end;

function TMainForm.LoadSwmnInfo(ID: integer): TFileName;
var HTML, DList, Table: TStringList;
    i, TablePos, Heat: integer;
    TempStr: string; TimeStr: string[8];
begin
  Result := IndexHTML;
  DList := TStringList.Create;
  TablePos := 0;
  try
    if SwDB.LoadRec(DList,GetSwmnInfo(ID),'ID') then
    begin
      HTML := TStringList.Create;
      try
        HTML.LoadFromFile(AppDir + 'Html\SwmnInfo.html');
        for i := 0 to HTML.Count - 1 do
        begin
          if (Trim(HTML[i]) = '$HEAD') or (Trim(HTML[i]) = '$TITLE') then
            HTML[i] := DList.Values['stName'] + ' - ' +
              Sex[SwDB.FieldByName('Sex').AsInteger] + '. ' +
              SwDB.FieldByName('BYear').AsString + ' г.р.';

          if Trim(HTML[i]) = '$INFO' then
            HTML[i] := 'Бассейн: ' + SwDB.FieldByName('plName').AsString;

          if Trim(HTML[i]) = '$LINK' then
            HTML[i] := '<a class="Del" href="#Swmn=' + IntToStr(ID) + '">изменить</a>';

          if Trim(HTML[i]) = '$TABLE' then
          begin
            HTML[i] := '';
            TablePos := i;
          end;
        end;

        if SwDB.ExecQuery(GetHeatsListBySwmn(ID)) then
        begin
          Heat := -1;
          Table := TStringList.Create;
          try
            if not SwDB.Eof then
            begin
              Table.Add('<table width="100%">');
              Table.Add('<tr class="Head"><td><b>Заплыв</b></td>'  +
                '<td><b>Участник</b></td>' + '<td><b>Год</b></td>' +
                '<td><b>Город</b></td>' + '<td><b>Школа</b></td>'  +
                '<td><b>Время</b></td>' + '<td><b>&nbsp;</b></td></tr>');
            end;
            while not SwDB.Eof do
            begin
              TempStr := '<tr><td class="alL" nowrap>';
              if Heat = SwDB.FieldByName('Heat').AsInteger then
                TempStr := TempStr + '&nbsp;'
              else begin
                TempStr := TempStr + 'Заплыв ' + SwDB.FieldByName('Heat').AsString;
                Heat := SwDB.FieldByName('Heat').AsInteger
              end;
              TempStr := TempStr + '</td>';
              Table.Add(TempStr);
              // Участник
              TempStr := '<td class="alL" nowrap>' + SwDB.FieldByName('Path').AsString + '. ' +
                SwDB.FieldByName('FName').AsString + ' ' + SwDB.FieldByName('Name').AsString + '</td>';
              Table.Add(TempStr);
              // Год рождения
              TempStr := '<td>' + SwDB.FieldByName('BYear').AsString + '</td>';
              Table.Add(TempStr);
              // Город
              TempStr := '<td class="alL">' + SwDB.FieldByName('CityName').AsString + '</td>';
              Table.Add(TempStr);
              // Школа
              TempStr := '<td class="alL">' + SwDB.FieldByName('SchlName').AsString + '</td>';
              Table.Add(TempStr);
              // Время
              TimeStr := SwTimeToStr(SwDB.FieldByName('PTime').AsInteger);
              TempStr := '<td class="alR">' + TimeStr + '</td>';
              Table.Add(TempStr);
              // Ссылка
              TempStr := '<td class="alR"><a class="Del" href="#Heat=' +
                SwDB.FieldByName('id').AsString + '">[-]</a></td></tr>';
              Table.Add(TempStr);
              SwDB.Next;
            end;
            if Trim(Table.Text) <> '' then
            begin
              Table.Add('</table><br>');
              HTML.Insert(TablePos,Table.Text);
            end;
          finally
            Table.Free;
          end;
        end;
        HTML.SaveToFile(AppDir + 'index.html');
        Result := AppDir + 'index.html';
      finally
        HTML.Free;
      end;
    end;
  finally
    DList.Free;
  end;
end;

function TMainForm.PrepareData(DataStr: string): string;
begin
  Result := DataStr;
  Delete(Result,Length(Result) - 3,3);
end;

procedure TMainForm.ReloadData(var Msg: TMessage);
var i: integer;
begin
  TreeView.Selected := nil;
  SwDB.LoadTreeView(TreeView);
  if Msg.WParam = 1 then
  begin
    for i := 0 to Screen.FormCount - 1 do
      PostMessage(Screen.Forms[i].Handle,WM_RELOADDATA,0,0);
  end;
end;

procedure TMainForm.SelectNode(NodeType: TNodeType;
  Parent: TTreeNode);
var Node: TTreeNode;
    inf: TndInf;
begin
  if SwDB.LastID = ID_ERROR then
    Exit;
  if Parent = nil then
    Node := TreeView.Items.GetFirstNode
  else
    Node := Parent.getFirstChild;
  while Node <> nil do
  begin
    inf := GetNodeInfo(Node);
    if (NodeType = inf.NodeType)
      and (SwDB.LastID = inf.id) then
    begin
      TreeView.Selected := Node;
      break;
    end;
    if Parent = nil then
      Node := Node.GetNext
    else
      Node := Parent.getNextSibling;
  end;
end;

procedure TMainForm.TreeViewChange(Sender: TObject; Node: TTreeNode);

  procedure SetAction(NodeType: TNodeType);
  begin
    actAddPtrc.Enabled := NodeType = ntSwmn;
    actTime.Enabled := NodeType = ntHeats;
    actSaveDoc.Enabled := (NodeType = ntPStart) or (NodeType = ntPEnd);  
    if NodeType = ntNone then
    begin
      actAdd.OnExecute := nil;
      actEdit.OnExecute := nil;
      actDelete.OnExecute := nil;
      actCreate.OnExecute := actAddCmpt.OnExecute;
      Exit;
    end;
    case NodeType of
      ntCmpt: begin
        actAdd.OnExecute    := actAddCmpt.OnExecute;
        actEdit.OnExecute   := actEditCmpt.OnExecute;
        actDelete.OnExecute := actDeleteCmpt.OnExecute;
        actAdd.Enabled    := true;
        actEdit.Enabled   := true;
        actDelete.Enabled := true;
        actCreate.OnExecute := actAddCmpt.OnExecute;
      end;
      ntSwmn: begin
        actAdd.OnExecute  := actAddSwmn.OnExecute;
        actEdit.OnExecute := actEditSwmn.OnExecute;
        actDelete.OnExecute := actDeleteSwmn.OnExecute;
        actAdd.Enabled  := true;
        actEdit.Enabled := true;
        actDelete.Enabled := true;
        actCreate.OnExecute := actAddSwmn.OnExecute;
      end;
      ntSwmnGrp: begin
        actAdd.OnExecute  := actAddSwmn.OnExecute;
        actEdit.OnExecute := nil;
        actDelete.OnExecute := nil;
        actAdd.Enabled  := true;
        actCreate.OnExecute := actAddSwmn.OnExecute;
      end;
      ntHeats: begin
        actAdd.OnExecute := actAddPtrc.OnExecute;
        actEdit.OnExecute := nil;
        actDelete.OnExecute := actDeleteHeats.OnExecute;
        actAdd.Enabled  := true;
        actDelete.Enabled := true;
      end
    else begin
      actAdd.OnExecute    := nil;
      actEdit.OnExecute   := nil;
      actDelete.OnExecute := nil;
      actCreate.OnExecute := actAddCmpt.OnExecute;
    end;
    end;
  end;

var Inf: TNdInf;
    URL: TFileName;

begin
  if Node = nil then
  begin
    actEdit.Enabled := false;
    actAdd.Enabled  := false;
    actDelete.Enabled := false;
    actAddPtrc.Enabled := false;
    Browser.Navigate(IndexHTML);
    Exit;
  end;

  Inf := GetNodeInfo(Node);
  SetAction(Inf.NodeType);

  URL := CreateHTML(inf);

  Browser.Navigate(URL);
end;

procedure TMainForm.UpdateBrwsr(var Msg: TMessage);
var Node: TTreeNode;
begin
  Node := TreeView.Selected;
  TreeView.Selected := nil;
  TreeView.Selected := Node; 
  //TreeViewChange(Treeview,TreeView.Selected);
end;

procedure TMainForm.BrowserBeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var Name: string;
    i: integer;
    inf: TndInf;
begin
  Name := VarToStr(URL);
  i := Pos('#',Name);
  Delete(Name,1,i);

  if Name = 'Info' then
  begin
    actEditCmpt.Execute;
    Exit;
  end;

  if Name[1] = 'H' then
  begin
    i := Pos('=',Name);
    Delete(Name,1,i);
    SwDB.DHeats(StrToIntDef(Name,-1));
    Browser.Navigate(CreateHTML(TreeView.Selected));
    Inf.NodeType := ntHeats;
    inf.ID := StrToIntDef(Name,-1);
    DeleteNode(inf);
    Exit;
  end;

  if Name[1] = 'S' then
  begin
    actEditSwmn.Execute;
    Browser.Navigate(CreateHTML(TreeView.Selected));
    Exit;
  end;

  if Name[1] = 'P' then
  begin
    actEditPTime.Execute;
    Browser.Navigate(CreateHTML(TreeView.Selected));
  end;

  if Name[1] = 'T' then
  begin
    actEditTTime.Execute;
    Browser.Navigate(CreateHTML(TreeView.Selected));
  end;

end;

procedure TMainForm.BrowserPrint;
var PostData, Headers: OLEvariant;
begin
  Browser.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DODEFAULT, PostData,
    Headers);
end;

procedure TMainForm.BrowserPrintPreview;
var PostData, Headers: OLEvariant;
begin
  Browser.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DODEFAULT, PostData,
    Headers);
end;

procedure TMainForm.BrowserSave;
var PostData, Headers: OLEvariant;
begin
  Browser.ExecWB(OLECMDID_SAVEAS, OLECMDEXECOPT_DODEFAULT, PostData,
    Headers);
end;

function TMainForm.CreateHTML(Node: TTreeNode): TFileName;
begin
  if Node <> nil then
    Result := CreateHTML(GetNodeInfo(Node))
  else
    Result := IndexHTML;
end;

function TMainForm.CreateHTML(NodeInfo: TNdInf): TFileName;
begin
  case NodeInfo.NodeType of
    ntCmpt: Result := LoadCmptInfo(NodeInfo.ID);
    ntSwmn: Result := LoadSwmnInfo(NodeInfo.ID);
    ntPtrc: ;
    ntHeats: Result := LoadHetsInfo(NodeInfo.ID);
    ntSwmnGrp: Result := LoadCmptInfo(NodeInfo.ID);
    ntPStart: Result := LoadPStart(NodeInfo.ID);
    ntPEnd: Result := LoadPEnd(NodeInfo.ID);
  else
    Result := IndexHTML;
  end;
end;

procedure TMainForm.DeleteNode(Inf: TNdInf);
var Node: TTreeNode;
begin
  Node := TreeView.Items.GetFirstNode;
  while Node <> nil do
  begin
    if (GetNodeInfo(Node).NodeType = Inf.NodeType)
      and (GetNodeInfo(Node).ID = Inf.ID) then
    begin
      Node.Delete;
      Break;
    end;
    Node := Node.GetNext;
  end;
end;

end.
