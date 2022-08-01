program VRprt;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  GlRprt in 'GlRprt.pas',
  Global in '..\Global.pas',
  netapi32 in '..\netapi32.pas',
  CalendarUnit in 'CalendarUnit.pas' {CalendarForm},
  YearUnit in 'YearUnit.pas' {YearForm},
  RTFUnit in 'RTFUnit.pas' {RTFForm},
  DateIntervalUnit in 'DateIntervalUnit.pas' {DateIntrvlFrm},
  HtmlParamUnit in 'HtmlParamUnit.pas' {HtmlParamForm},
  ExportHTML in 'ExportHTML.pas',
  ExportExcel in 'ExportExcel.pas',
  ExlParamUnit in 'ExlParamUnit.pas' {ExlParamForm},
  ProgressUnit in 'ProgressUnit.pas' {ProgressForm},
  DstStringUnit in 'DstStringUnit.pas',
  ClearDBUnit in 'ClearDBUnit.pas' {ClearDBForm},
  SQLEditorUnit in 'SQLEditorUnit.pas' {SQLEditorForm},
  CodeCmplEditUnit in 'CodeCmplEditUnit.pas' {CdCmplForm},
  NRepUnit in 'NRepUnit.pas' {NRepForm},
  NewFilterUnit in 'NewFilterUnit.pas' {NewFilterForm},
  ProgOptionsUnit in 'ProgOptionsUnit.pas',
  InfoUnit in 'InfoUnit.pas' {InfoForm},
  AboutUnit in 'AboutUnit.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TCalendarForm, CalendarForm);
  Application.CreateForm(TYearForm, YearForm);
  Application.CreateForm(TRTFForm, RTFForm);
  Application.CreateForm(TDateIntrvlFrm, DateIntrvlFrm);
  Application.CreateForm(THtmlParamForm, HtmlParamForm);
  Application.CreateForm(TExlParamForm, ExlParamForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.CreateForm(TClearDBForm, ClearDBForm);
  Application.CreateForm(TSQLEditorForm, SQLEditorForm);
  Application.CreateForm(TCdCmplForm, CdCmplForm);
  Application.CreateForm(TNRepForm, NRepForm);
  Application.CreateForm(TNewFilterForm, NewFilterForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
