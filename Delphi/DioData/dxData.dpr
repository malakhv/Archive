program dxData;



uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Global in 'Global.pas',
  DioInfoUnit in 'DioInfoUnit.pas' {DioInfoForm},
  DioTypes in 'Dio Library\DioTypes.pas',
  DioFieldLib in 'Dio Library\DioFieldLib.pas',
  DioMassaLib in 'Dio Library\DioMassaLib.pas',
  DioDataLib in 'Dio Library\DioDataLib.pas',
  DioInfoLib in 'Dio Library\DioInfoLib.pas',
  ItemsWork in 'ItemsWork.pas',
  DataExport in 'DataExport.pas' {ExportFrm},
  DioUtils in 'Dio Library\DioUtils.pas',
  DioTypeLib in 'Dio Library\DioTypeLib.pas',
  DioFieldInfo in 'Dio Library\DioFieldInfo.pas',
  FieldInfoUnit in 'FieldInfoUnit.pas' {FieldInfoForm},
  uDioOpt in 'uDioOpt.pas',
  ReportUnit in 'ReportUnit.pas',
  DioXML in 'Dio Library\DioXML.pas',
  DioReports in 'DioReports.pas',
  MyProgOpt in 'MyProgOpt.pas',
  MyXML in '..\MyUnits\XML\MyXML.pas',
  XMLDioList in '..\Test Project\DioMngr\XMLDioList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
