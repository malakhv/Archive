unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Gauges, DB, ADODB;

type
  TQueryMode = (qmOpen = 0, qmExec = 1);

type
  TMainForm = class(TForm)
    Gauge: TGauge;
    edFileName: TEdit;
    btnOpenFile: TSpeedButton;
    Label1: TLabel;
    lblInfo: TLabel;
    btnExit: TButton;
    btnImprt: TButton;
    OpenDialog: TOpenDialog;
    ADOConnection: TADOConnection;
    Query: TADOQuery;
    btnCtgrImprt: TButton;
    procedure btnOpenFileClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnImprtClick(Sender: TObject);
    procedure btnCtgrImprtClick(Sender: TObject);
  private
    FFileName: TFileName;
    procedure SetFileName(const Value: TFileName);
    { Private declarations }
  public
    property FileName: TFileName read  FFileName write SetFileName;
    function UpdateRecord(SQL: WideString; ATime: integer): boolean;
    function ExecQuery(SQL: WideString; QueryMode: TQueryMode = qmOpen): boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses ComObj, TimeWrk;

function GetSQL(Sex, PlTp, SwTp, Points: integer): WideString;
begin
  Result := 'Select * from Pnts as p where p.Sex = ' + IntToStr(Sex) + ' and ' +
    'p.PlTp_id = ' + IntToStr(PlTp) + ' and p.Points = ' + IntToStr(Points) +
    ' and p.SwTp_id = ' + IntToStr(SwTp);
end;

function GetSQLCtgr(Sex,PlTp,SwTp,CtNm: integer): WideString;
begin
  Result := 'Select * from Ctgr as c where c.Sex = ' + IntToStr(Sex) + ' and ' +
    'c.PlTp_id = ' + IntToStr(PlTp) + ' and c.SwTp_id = ' + IntToStr(SwTp) +
    ' and c.CtNm_id = ' + IntToStr(CtNm); 
end;

function ConvertTime(TimeStr: string): integer;
var SwTm: TSwTime;
    p,i: integer;
    str: string;
begin
  if Trim(TimeStr) = '' then
  begin
    Result := 0;
    Exit;
  end;

  SwTm.mm := 0;
  SwTm.ss := 0;
  SwTm.ml := 0;
  // Минуты
  p := Pos(':',TimeStr);
  if p > 0 then
  begin
    str := '';
    for i := 1 to p - 1 do
      str := str + TimeStr[i];
    SwTm.mm := StrToIntDef(str,0);
    Delete(TimeStr,1,p);
  end;
  // Секунды
  p := Pos('.',TimeStr);
  if p > 0 then
  begin
    str := '';
    for i := 1 to p - 1 do
      str := str + TimeStr[i];
    SwTm.ss := StrToIntDef(str,0);
    Delete(TimeStr,1,p);
  end;
  // Милисекунды
  if TimeStr <> '' then
  begin
    SwTm.ml := StrToIntDef(TimeStr + '0',0);
  end;
  Result := MlSecond(SwTm);
end;

{ TMainForm }

procedure TMainForm.btnCtgrImprtClick(Sender: TObject);
var
  App, WBooks, WBook, Sheet: Variant;
  ListIndex, i, j: integer;
  Sex, PlTp, SwTp, CtNm, ColCount, ATime: integer;
  TimeStr: string;
begin
  Gauge.MaxValue := 17;
  App := CreateOleObject('Excel.Application');
  try
    App.DisplayAlerts := false;
    WBooks := App.WorkBooks;
    WBook := WBooks.Open(FileName := FileName, ReadOnly := true);
    for ListIndex := 1 to WBook.Sheets.Count do
    begin
      Sheet := WBook.Sheets.Item[ListIndex];
      lblInfo.Caption := Sheet.Name;
      Gauge.Progress := 0;
      Application.ProcessMessages;
      Sex  := StrToIntDef(Sheet.Cells[1,1],-1);
      PlTp := StrToIntDef(Sheet.Cells[1,2],-1);
      if (Sex = -1) or (PlTp = -1) then Continue;
      j := 0;
      while string(Sheet.Cells[2,j + 2]) <> '' do
      begin
        Inc(j);
      end;
      ColCount := j;
      i := 3;
      while string(Sheet.Cells[i,1]) <> '' do
      begin
        SwTp := StrToIntDef(Sheet.Cells[i,1],-1);
        if SwTp <> -1 then
        begin
          Gauge.Progress := Gauge.Progress + 1;
          for j := 2 to ColCount + 1 do
          begin
            CtNm := StrToIntDef(Sheet.Cells[2,j],-1);
            if CtNm <> -1 then
            begin
              TimeStr := Trim(Sheet.Cells[i,j]);
              UpdateRecord(GetSQLCtgr(Sex,PlTp,SwTp,CtNm),ConvertTime(TimeStr));
            end;
          end;
        end;
        Inc(i);
      end;
    end;
  finally
    WBook.Close;
    App.Quit;
  end;

end;

procedure TMainForm.btnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.btnImprtClick(Sender: TObject);
var
  App, WBooks, WBook, Sheet: Variant;
  ListIndex, i, j: integer;
  Sex, PlTp, SwTp, Points, ColCount, ATime: integer;
  TimeStr: string;
begin
  Gauge.MaxValue := 201;
  App := CreateOleObject('Excel.Application');
  try
    App.DisplayAlerts := false;
    WBooks := App.WorkBooks;
    WBook := WBooks.Open(FileName := FileName, ReadOnly := true);
    for ListIndex := 1 to WBook.Sheets.Count do
    begin
      Sheet := WBook.Sheets.Item[ListIndex];
      lblInfo.Caption := Sheet.Name;
      Gauge.Progress := 0;
      Application.ProcessMessages;
      Sex  := StrToIntDef(Sheet.Cells[1,1],-1);
      PlTp := StrToIntDef(Sheet.Cells[1,2],-1);
      if (Sex = -1) or (PlTp = -1) then Continue;
      j := 0;
      while string(Sheet.Cells[2,j + 2]) <> '' do
      begin
        Inc(j);
      end;
      ColCount := j;
      i := 3;
      while string(Sheet.Cells[i,1]) <> '' do
      begin
        Points := StrToIntDef(Sheet.Cells[i,1],-1);
        if Points <> -1 then
        begin
          Gauge.Progress := Gauge.Progress + 1;
          for j := 2 to ColCount + 1 do
          begin
            SwTp := StrToIntDef(Sheet.Cells[2,j],-1);
            if SwTp <> -1 then
            begin
              TimeStr := Trim(Sheet.Cells[i,j]);
              UpdateRecord(GetSQL(Sex,PlTp,SwTp,Points),ConvertTime(TimeStr));
            end;
          end;
        end;
        Inc(i);
      end;
    end;
  finally
    WBook.Close;
    App.Quit;
  end;
end;

procedure TMainForm.btnOpenFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    FileName := OpenDialog.FileName;
    edFileName.Text := FileName;
  end;
end;

function TMainForm.ExecQuery(SQL: WideString; QueryMode: TQueryMode): boolean;
begin
  Result := true;
  try
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add(SQL);
    case QueryMode of
      qmOpen: Query.Open;
      qmExec: Query.ExecSQL;
    end;
  except
    Result := false;
  end;
end;

procedure TMainForm.SetFileName(const Value: TFileName);
begin
  FFileName := Value;
  btnImprt.Enabled := FileExists(FFileName);
  btnCtgrImprt.Enabled := btnImprt.Enabled;
end;

function TMainForm.UpdateRecord(SQL: WideString; ATime: integer): boolean;
begin
  Result := false;
  if True then
  if ExecQuery(SQL) then
  begin
    if not Query.Eof then
    begin
      Query.Edit;
      Query.FieldByName('Time').AsInteger := ATime;
      Query.Post;
      Result := true;
    end;
  end;
end;

end.
