
{*******************************************************}
{                                                       }
{       Printer Server Application                      }
{       Main Form Unit                                  }
{                                                       }
{       Copyright (c) Малахов Михаил 2006               }
{                                                       }
{*******************************************************}

unit MainUnit;

interface
                   
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ThrClct, StdCtrls, DB, ADODB, Buttons, MsgPrSrv;

type
  TMainForm = class(TForm)    
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    ListBox: TListBox;
    BitBtn1: TBitBtn;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function Connection: boolean;
    function ExecSQL(SQLStr: string; flag: byte = 0): boolean;
    procedure LoadUsersInfo(var Msg: TMessage);    message DM_LOADUSERSINFO;
    procedure SetPagePrinted(var Msg: TMessage);   message DM_SETPAGEPRINTD;
    procedure StopWaitPrinters(var Msg: TMessage); message PM_STOPWAITPRNT;
    procedure StartWaitPrinters(var Msg: TMessage);message PM_STRTWAITPRNT;
    procedure DBClear(var Msg: TMessage);          message DM_DBCLEAR;
  public

  end;

var
  MainForm: TMainForm;
  ThreadList: TThreadCollection;

implementation

uses Global, GlPrSrv, MNameUnit, RegUnit;

{$R *.dfm}

var
  WaitStart: boolean = false;

function TMainForm.Connection: boolean;
var Rg: TMyReg;
begin
  Rg := TMyReg.Create(rmRead);
  Result := true;
  {ADOConnection.ConnectionString := ConStrSource + Rg.DBPath + LimitDBName +
    ConStrP1 + ConStrP2 + ConStrP3 + ConStrP4 + ConStrP5 + ConStrP6 +
    ConStrP7;   }
  ADOConnection.ConnectionString := ConnectionString + Rg.DBFileName;
  try
    ADOConnection.Open;
  except
    ShowMessage('Неудалось подключиться к базе данных');
    Result := false;
  end;
end;

function TMainForm.ExecSQL(SQLStr: string; flag: byte): boolean;
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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SetPriorityClass(GetCurrentProcess,HIGH_PRIORITY_CLASS);
  ThreadList := TThreadCollection.Create(Self.Handle);
  //if Connection then ListBox.Items.Add('Connection is OK');
  if Connection then
  begin
    ListBox.Items.Add('Connection is OK');
    SendMessage(Self.Handle,DM_LOADUSERSINFO,0,0);
    SendMessage(Self.Handle,PM_STRTWAITPRNT,0,0);
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ThreadList.Clear;
  //Application.ProcessMessages;
  ADOConnection.Close;
end;

{ Messages }

procedure TMainForm.LoadUsersInfo(var Msg: TMessage);
var SQL: string; Index,i,j: integer;
    Usrs: TUsersInfo;
begin
  if not ADOConnection.Connected then Exit;
  SetLength(Usrs,0);

  // Загрузка информации о пользователях
  SQL := 'Select * from Users';
  ExecSQL(SQL);
  if ADOQuery.Eof then Exit;
  while not ADOQuery.Eof do
  begin
    Index := Length(Usrs);
    SetLength(Usrs,Index + 1);
    Usrs[Index].ID          := ADOQuery.FieldByName('ID').AsInteger;
    Usrs[Index].UserName    := ADOQuery.FieldByName('Name').AsString;
    Usrs[Index].PagePrinted := ADOQuery.FieldByName('PrintedPages').AsInteger;
    SetLength(Usrs[Index].Limits,0);
    ADOQuery.Next;
  end;

  // Загрузка информации о лимитах;
  for i := 0 to Length(Usrs) - 1 do
  begin
    SQL := 'Select lim.ID, lim.PageLimit, lim.PagePrinted, lim.Type,'+
      ' lim.UserID, lim.PID, pr.PName, ps.Name' +
      ' from  Limits lim,  AllPrinters pr, PServer ps where' +
      ' lim.UserID = '+ IntToStr(Usrs[i].ID) +
      ' and pr.ID = lim.PID and ps.ID = pr.SID and' +
      ' ps.Name = ' + '''' + MachineName + '''';
    if not ExecSQL(SQL) then Continue;
    while not ADOQuery.Eof do
    begin
      Index := Length(Usrs[i].Limits);
      SetLength(Usrs[i].Limits,Index + 1);
      Usrs[i].Limits[Index].ID    := ADOQuery.FieldByName('ID').AsInteger;
      Usrs[i].Limits[Index].PageLimit :=
        ADOQuery.FieldByName('PageLimit').AsInteger;
      Usrs[i].Limits[Index].LType := ADOQuery.FieldByName('Type').AsInteger;
      Usrs[i].Limits[Index].PagePrinted :=
        ADOQuery.FieldByName('PagePrinted').AsInteger;
      Usrs[i].Limits[Index].LPrinter.PName :=
        ADOQuery.FieldByName('PName').AsString;
      Usrs[i].Limits[Index].LPrinter.MName :=
        ADOQuery.FieldByName('Name').AsString;
      Usrs[i].Limits[Index].LPrinter.ID :=
        ADOQuery.FieldByName('PID').AsInteger;
      SetLength(Usrs[i].Limits[Index].Intervals,0);
      ADOQuery.Next;
    end;
  end;

  // Загрузка информации о интервалах времени
  for i := 0 to Length(Usrs) - 1 do
  begin
    for j := 0 to Length(Usrs[i].Limits) - 1 do
    begin
      if Usrs[i].Limits[j].LType = 1 then Continue;
      SQL := 'Select * from [Interval] where [Interval].LimitID = '+
        IntToStr(Usrs[i].Limits[j].ID);
      ExecSQL(SQL);
      while not ADOQuery.Eof do
      begin
        Index := Length(Usrs[i].Limits[j].Intervals);
        SetLength(Usrs[i].Limits[j].Intervals, Index + 1);
        Usrs[i].Limits[j].Intervals[Index].ID :=
          ADOQuery.FieldByName('ID').AsInteger;
        Usrs[i].Limits[j].Intervals[Index].T1 :=
          ADOQuery.FieldByName('T1').AsDateTime;
        Usrs[i].Limits[j].Intervals[Index].T2 :=
          ADOQuery.FieldByName('T2').AsDateTime;
        ADOQuery.Next;
      end;
    end;
  end;

  LoadUsers(Usrs);
  SetLength(Usrs,0);
  Usrs := nil;
  ListBox.Items.Add('Load User info is OK');
end;

procedure TMainForm.SetPagePrinted(var Msg: TMessage);
var job: TJob; indx,PID,UID: integer; SQL: string;
begin
  PID := Msg.WParam;
  job  := PJob(Msg.LParam)^;
  indx := GetUserIndexByName(String(job.pUserName));
  if indx >= 0 then
  begin
    UpdatePrintedPage(indx,PID,Integer(job.PagesPrinted));
    UID := GetUserIDByName(String(job.pUserName));
    SQL := 'Select * from Limits l where l.UserID = '+ IntToStr(UID) +
      ' and l.PID = ' + IntToStr(PID);
    if not ExecSQL(SQL) then Exit;
    while not ADOQuery.Eof do
    begin
      ADOQuery.Edit;
      ADOQuery.FieldByName('PagePrinted').AsInteger :=
        ADOQuery.FieldByName('PagePrinted').AsInteger +
          Integer(job.PagesPrinted);
      ADOQuery.Post;
      ADOQuery.Next;
    end;
  end;
  // Запись в таблицу отчетов печати
  SQL := 'Select * from Report';
  if not ExecSQL(SQL) then Exit;
  ADOQuery.Append;
    ADOQuery.FieldByName('UName').AsString := String(job.pUserName);
    ADOQuery.FieldByName('PName').AsString := String(job.pPrinterName);
    ADOQuery.FieldByName('Document').AsString := String(job.pDocument);
    ADOQuery.FieldByName('Machine').AsString  := String(job.pMachineName);
    ADOQuery.FieldByName('PageCount').AsInteger := Integer(job.PagesPrinted);
    ADOQuery.FieldByName('Date').AsDateTime     := Now;
  ADOQuery.Post;

  ListBox.Items.Add(String(job.pDocument) + ' - ' + IntToStr(job.PagesPrinted));
end;

procedure TMainForm.StartWaitPrinters(var Msg: TMessage);
var SQL: string; Prntr: TPrinterInfo;
begin
  if WaitStart then Exit;
  ThreadList.Clear;
  SQL := 'Select allp.ID, allp.PName, ps.Name from AllPrinters allp, PServer ps' +
    ' where ps.Name ='+ ''''+ MachineName + '''' +
    ' and allp.SID = ps.ID and allp.Run=true';
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    Prntr.ID := ADOQuery.FieldByName('ID').AsInteger;
    Prntr.PName := ADOQuery.FieldByName('PName').AsString;
    Prntr.MName := ADOQuery.FieldByName('Name').AsString;
    if GetPrinterHandle(Prntr.PName,Prntr.Handle) then
    begin
      ThreadList.Add(Prntr);
      ListBox.Items.Add(Prntr.PName + ' Start Wait is OK');
    end;
    ADOQuery.Next;
  end;
  WaitStart := true;
end;

procedure TMainForm.StopWaitPrinters(var Msg: TMessage);
begin
  ThreadList.Clear;
  WaitStart := false;
end;

procedure TMainForm.DBClear(var Msg: TMessage);
var SQL: string;
begin
  SQL := 'delete * from Report';
  ExecSQL(SQL,1);
end;

end.
