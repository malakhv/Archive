unit PntsEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ToolWin, ComCtrls, Menus, StdCtrls, ActnMan,
  ActnCtrls, XPStyleActnCtrls, ActnList, Global, ImgList;

type
  TfrmPointsEditor = class(TForm)
    StatusBar: TStatusBar;
    Browser: TWebBrowser;
    ActionManager: TActionManager;
    ActionToolBar: TActionToolBar;
    cbSex: TComboBox;
    cbPlTp: TComboBox;
    actSave: TAction;
    actPrint: TAction;
    actPreView: TAction;
    ImageList: TImageList;
    procedure cbSexChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BrowserBeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure actSaveExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreViewExecute(Sender: TObject);
  private
    FTableName: string;
    procedure BrowserPrint;
    procedure BrowserPrintPreview;
    procedure SetTableName(const Value: string);
    { Private declarations }
  public
    property TableName: string read FTableName write SetTableName;
    procedure ReloadData(var Msg: TMessage); message WM_RELOADDATA;
    function CreateHTML(Sex,PlTp_id: integer): TFileName;
    function CreateCtgr(Sex,PlTp_id: integer): TFileName;
    function CreatePnts(Sex,PlTp_id: integer): TFileName;
    procedure BrowserSave;
    constructor Create(AOwner: TComponent; Table: string); reintroduce; 
  end;

implementation

uses SQLUnit, TimeWrk, TimeUnit;

{$R *.dfm}

{ TfrmPointsEditor }

procedure TfrmPointsEditor.actPreViewExecute(Sender: TObject);
begin
  BrowserPrintPreview;
end;

procedure TfrmPointsEditor.actPrintExecute(Sender: TObject);
begin
  BrowserPrint;
end;

procedure TfrmPointsEditor.actSaveExecute(Sender: TObject);
begin
  BrowserSave;
end;

procedure TfrmPointsEditor.BrowserBeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var Name: string; TimeStr: string[8];
    i: integer;
    Dlg: TTimeForm;
begin
  Name := VarToStr(URL);
  i := Pos('#',Name);
  if i = 0 then Exit;
  Delete(Name,1,i);
  Dlg := TTimeForm.Create(Self);
  try
    TimeStr := SwTimeToStr(SwDB.Gt(FTableName,'Time',StrToIntDef(Name,1),false));
    Dlg.mskTime.EditText := TimeStr;
    if Dlg.ShowModal = mrOK then
    begin
      if SwDB.Sv(FTableName,'Time',Dlg.ATime,StrToIntDef(Name,0)) then
        cbSexChange(Self);
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmPointsEditor.BrowserSave;
var PostData, Headers: OLEvariant;
begin
  Browser.ExecWB(OLECMDID_SAVEAS, OLECMDEXECOPT_DODEFAULT, PostData,
    Headers);
end;

procedure TfrmPointsEditor.cbSexChange(Sender: TObject);
begin
  Browser.Navigate(CreateHTML(cbSex.ItemIndex,
    Integer(cbPlTp.Items.Objects[cbPlTp.ItemIndex])));
end;

constructor TfrmPointsEditor.Create(AOwner: TComponent; Table: string);
begin
  inherited Create(AOwner);
  TableName := Table;
end;

function TfrmPointsEditor.CreateCtgr(Sex, PlTp_id: integer): TFileName;
var HTML,Table: TStringList;
    TimeStr: string[8];
    i, TablePos, ColCount, CurCol, SwTp_id: integer;
begin
  HTML := TStringList.Create;
  try
    TablePos := 0;
    ColCount := 0;
    HTML.LoadFromFile(AppDir + 'Html\Category.html');
    for i := 0 to HTML.Count - 1 do
    begin
      if Trim(HTML[i]) = '$TABLE' then
      begin
        TablePos := i;
        HTML[i] := '';
        Break;
      end;
    end;

    Table := TStringList.Create;
    try
      Table.Add('<table width = "100%">');
      // Столбец заголовок
      if SwDB.ExecQuery(SelRec(tCtNm,true,tCtNm + '.id')) then
      begin
        if SwDB.RecordCount > 0 then
        begin
          Table.Add('<tr><td>&nbsp;</td>');
          ColCount := 1;
          while not SwDB.Eof do
          begin
            Table.Add('<td>' + SwDB.FieldByName('Name').AsString + '</td>');
            SwDB.Next;
            Inc(ColCount);
          end;
          Table.Add('</tr>');
        end;
      end;

      if SwDB.ExecQuery(GetCtgrList(Sex,PlTp_id)) then
      begin
        CurCol := -1;
        SwTp_id := -1;
        while not SwDB.Eof do
        begin
          if SwTp_id <> SwDB.FieldByName('sid').AsInteger then
          begin
            if (CurCol < ColCount) and (CurCol <> -1) then
              Table.Add('<td colspan="' + IntToStr(ColCount - CurCol) + '">&nbsp</td>');
            if SwTp_id <> -1 then
              Table.Add('</tr>');
            SwTp_id := SwDB.FieldByName('sid').AsInteger;
            CurCol := 1;
            Table.Add('<tr><td class="alL">' + SwDB.FieldByName('SWName').AsString + '</td>');
          end;
          Inc(CurCol);
          TimeStr := SwTimeToStr(SwDB.FieldByName('Time').AsInteger);
          Table.Add('<td>' + '<a href="#' + IntToStr(SwDB.FieldByName('id').AsInteger) + '">' +
           TimeStr + '</a></td>');

          SwDB.Next;
        end;
      end;
      Table.Add('</tr></table>');
      HTML.Insert(TablePos,Table.Text);
    finally
      Table.Free;
    end;
    HTML.SaveToFile(AppDir + 'Category.html');
    Result := AppDir + 'Category.html';
  finally
    HTML.Free;
  end;
end;

function TfrmPointsEditor.CreateHTML(Sex, PlTp_id: integer): TFileName;
begin
  if TableName = tPnts then
    Result := CreatePnts(Sex,PlTp_id);
  if TableName = tCtgr then
    Result := CreateCtgr(Sex,PlTp_id);
end;

function TfrmPointsEditor.CreatePnts(Sex, PlTp_id: integer): TFileName;
var HTML,Table: TStringList;
    TimeStr: string[8];
    i, TablePos, ColCount, CurCol, Points: integer;
begin
  HTML := TStringList.Create;
  try
    TablePos := 0;
    ColCount := 0;
    HTML.LoadFromFile(AppDir + 'Html\Points.html');
    for i := 0 to HTML.Count - 1 do
    begin
      if Trim(HTML[i]) = '$TABLE' then
      begin
        TablePos := i;
        HTML[i] := '';
        Break;
      end;
    end;

    Table := TStringList.Create;
    Table.Add('<table width = "100%">');
    try
      // Столбец заголовок
      if SwDB.ExecQuery(SelRec(tSwTp,true,tSwTp + '.id')) then
      begin
        if SwDB.RecordCount > 0 then
        begin
          Table.Add('<tr><td>&nbsp;</td>');
          ColCount := 1;
          while not SwDB.Eof do
          begin
            Table.Add('<td>' + SwDB.FieldByName('SName').AsString + '</td>');
            SwDB.Next;
            Inc(ColCount);
          end;
          Table.Add('</tr>');
        end;
      end;

      if SwDB.ExecQuery(GetPointsList(Sex,PlTp_id)) then
      begin
        Points := -1;
        CurCol := -1;
        while not SwDB.Eof do
        begin
          if Points <> SwDB.FieldByName('Points').AsInteger then
          begin
            if (CurCol < ColCount) and (CurCol <> -1) then
              Table.Add('<td colspan="' + IntToStr(ColCount - CurCol) + '">&nbsp</td>');
            Table.Add('</tr>');
            Points := SwDB.FieldByName('Points').AsInteger;
            CurCol := 1;
            Table.Add('<tr><td>' + IntToStr(Points) + '</td>');
          end;
          Inc(CurCol);
          TimeStr := SwTimeToStr(SwDB.FieldByName('Time').AsInteger);
          Table.Add('<td>' + '<a href="#' + IntToStr(SwDB.FieldByName('id').AsInteger) + '">' +
           TimeStr + '</a></td>');
          SwDB.Next;
        end;
      end;
      Table.Add('</tr></table>');
      HTML.Insert(TablePos,Table.Text);
    finally
      Table.Free;
    end;
    HTML.SaveToFile(AppDir + 'Points.html');
    Result := AppDir + 'Points.html';
  finally
    HTML.Free
  end;
end;

procedure TfrmPointsEditor.FormCreate(Sender: TObject);
begin
  SendMessage(Self.Handle,WM_RELOADDATA,0,0);
end;

procedure TfrmPointsEditor.ReloadData(var Msg: TMessage);
begin
  cbPlTp.OnChange := nil;
  SwDB.GPlType(cbPlTp);
  cbPlTp.OnChange := cbSexChange;
  cbPlTp.ItemIndex := 0;
  cbSexChange(Self);
end;

procedure TfrmPointsEditor.SetTableName(const Value: string);
begin
  FTableName := Trim(Value);
  if FTableName = tPnts then
    Self.Caption := 'Таблицы очков';
  if FTableName = tCtgr then
    Self.Caption := 'Разряды';
end;

procedure TfrmPointsEditor.BrowserPrint;
var PostData, Headers: OLEvariant;
begin
  Browser.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DODEFAULT, PostData,
    Headers);
end;

procedure TfrmPointsEditor.BrowserPrintPreview;
var PostData, Headers: OLEvariant;
begin
  Browser.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DODEFAULT, PostData,
    Headers);
end;

end.
