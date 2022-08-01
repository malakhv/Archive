program Swmng;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CmptInfo in 'CmptInfo.pas' {CmptInfoForm},
  Global in 'Global.pas',
  NodeUnit in 'NodeUnit.pas',
  SQLUnit in 'SQLUnit.pas',
  DBList in 'DBList.pas' {frmDBList},
  SwmInfo in 'SwmInfo.pas' {frmSwmInfo},
  GetStrUnit in 'GetStrUnit.pas' {frmGetValue},
  ADODBWork in 'DBWork\ADODBWork.pas',
  SwimmingDB in 'DBWork\SwimmingDB.pas',
  PtrcEditor in 'PtrcEditor.pas' {frmPatricipants},
  PtrcInfo in 'PtrcInfo.pas' {ftmPtrcInfo},
  DlgUnit in 'DlgUnit.pas' {DlgFrm},
  TimeUnit in 'TimeUnit.pas' {TimeForm},
  TimeWrk in 'TimeWrk.pas',
  HTML in 'HTML.pas',
  DrawListView in 'DrawListView.pas',
  Word in 'Word.pas',
  PntsEditor in 'PntsEditor.pas' {frmPointsEditor},
  ABOUT in 'ABOUT.pas' {AboutBox},
  Query in 'Query.pas',
  SwmnSQL in 'SwmnSQL.pas',
  SwmnTables in 'SwmnTables.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := true;
  Application.Title := 'DBSwimming';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
