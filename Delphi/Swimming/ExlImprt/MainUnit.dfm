object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = #1048#1084#1087#1086#1088#1090'...'
  ClientHeight = 156
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge: TGauge
    Left = 8
    Top = 54
    Width = 332
    Height = 25
    MaxValue = 200
    Progress = 0
  end
  object btnOpenFile: TSpeedButton
    Left = 317
    Top = 8
    Width = 23
    Height = 22
    Flat = True
    OnClick = btnOpenFileClick
  end
  object Label1: TLabel
    Left = 8
    Top = 35
    Width = 67
    Height = 13
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103':'
  end
  object lblInfo: TLabel
    Left = 81
    Top = 35
    Width = 3
    Height = 13
  end
  object edFileName: TEdit
    Left = 8
    Top = 8
    Width = 303
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object btnExit: TButton
    Left = 265
    Top = 92
    Width = 75
    Height = 56
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 1
    OnClick = btnExitClick
  end
  object btnImprt: TButton
    Left = 8
    Top = 92
    Width = 251
    Height = 25
    Caption = #1048#1084#1087#1086#1088#1090' '#1086#1095#1082#1086#1074
    Enabled = False
    TabOrder = 2
    OnClick = btnImprtClick
  end
  object btnCtgrImprt: TButton
    Left = 8
    Top = 123
    Width = 251
    Height = 25
    Caption = #1048#1084#1087#1086#1088#1090' '#1088#1072#1079#1088#1103#1076#1086#1074
    Enabled = False
    TabOrder = 3
    OnClick = btnCtgrImprtClick
  end
  object OpenDialog: TOpenDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 256
    Top = 40
  end
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Documents and Se' +
      'ttings\'#1052#1072#1083#1072#1093#1086#1074'\'#1052#1086#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'\RAD Studio\Projects\Swimming\ExlImp' +
      'rt\DB.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 40
  end
  object Query: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 72
    Top = 40
  end
end
