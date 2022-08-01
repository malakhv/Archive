program dmngr;

uses
  Forms,
  DioMngrUnit in 'DioMngrUnit.pas' {Form1},
  XMLDioList in 'XMLDioList.pas',
  DioTypes in '..\Dio Library\DioTypes.pas',
  DioInfoLib in '..\Dio Library\DioInfoLib.pas',
  DioUtils in '..\Dio Library\DioUtils.pas',
  MyXMLUtils in '..\..\MyUnits\XML\MyXMLUtils.pas',
  DioDataLib in '..\Dio Library\DioDataLib.pas',
  DioMassaLib in '..\Dio Library\DioMassaLib.pas',
  DioFieldLib in '..\Dio Library\DioFieldLib.pas',
  DioFieldInfo in '..\Dio Library\DioFieldInfo.pas',
  DioXML in '..\Dio Library\DioXML.pas',
  uDioOpt in '..\uDioOpt.pas',
  MyProgOpt in '..\MyProgOpt.pas',
  DioTypeLib in '..\Dio Library\DioTypeLib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
