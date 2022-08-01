program NSend;

{%TogetherDiagram 'ModelSupport_NSend\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_NSend\NSend\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_NSend\MainUnit\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_NSend\Global\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_NSend\DMUnit\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_NSend\default.txvpck'}
{%TogetherDiagram 'ModelSupport_NSend\DMUnit\default.txvpck'}
{%TogetherDiagram 'ModelSupport_NSend\NSend\default.txvpck'}
{%TogetherDiagram 'ModelSupport_NSend\Global\default.txvpck'}
{%TogetherDiagram 'ModelSupport_NSend\MainUnit\default.txvpck'}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  DMUnit in 'DMUnit.pas' {DM: TDataModule},
  Global in 'Global.pas',
  netapi32 in 'netapi32.pas',
  LogUnit in 'LogUnit.pas' {LogForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TLogForm, LogForm);
  Application.Run;
end.
