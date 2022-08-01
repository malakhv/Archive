object MainForm: TMainForm
  Left = 233
  Top = 113
  Width = 648
  Height = 507
  Caption = 'Tanks'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Pole: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 473
    Align = alClient
    BevelOuter = bvNone
    Color = clBlack
    TabOrder = 0
  end
  object OpLDialog: TOpenDialog
    Filter = #1060#1072#1081#1083' '#1091#1088#1086#1074#1085#1103'|*.tnl'
    Title = #1042#1099#1073#1077#1088#1080#1090#1077' '#1092#1072#1081#1083' '#1091#1088#1086#1074#1085#1103' ...'
    Left = 16
    Top = 16
  end
end
