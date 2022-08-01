object MainForm: TMainForm
  Left = 265
  Top = 120
  Width = 537
  Height = 494
  Caption = #1055#1086#1080#1089#1082' '#1086#1076#1080#1085#1072#1082#1086#1074#1099#1093' '#1082#1072#1088#1090#1080#1085#1086#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 419
    Width = 529
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object SpeedButton2: TSpeedButton
      Left = 440
      Top = 8
      Width = 81
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Flat = True
      OnClick = SpeedButton2Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 529
    Height = 419
    Align = alClient
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 108
      Height = 13
      Caption = #1055#1072#1087#1082#1072' '#1089' '#1082#1072#1088#1090#1080#1085#1082#1072#1084#1080' '
    end
    object btnDir: TSpeedButton
      Left = 496
      Top = 32
      Width = 23
      Height = 22
      Caption = '...'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = btnDirClick
    end
    object btnRunFind: TSpeedButton
      Left = 8
      Top = 384
      Width = 105
      Height = 25
      Caption = #1053#1072#1095#1072#1090#1100' '#1087#1086#1080#1089#1082
      Flat = True
      OnClick = btnRunFindClick
    end
    object btnSaveResult: TSpeedButton
      Left = 128
      Top = 384
      Width = 121
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
      Flat = True
      OnClick = btnSaveResultClick
    end
    object edDir: TEdit
      Left = 8
      Top = 32
      Width = 481
      Height = 21
      TabOrder = 0
    end
    object ResultList: TListBox
      Left = 8
      Top = 152
      Width = 513
      Height = 225
      ItemHeight = 13
      PopupMenu = ResultMenu
      TabOrder = 1
      OnDblClick = ResultListDblClick
    end
    object chbSubFolder: TCheckBox
      Left = 8
      Top = 56
      Width = 121
      Height = 17
      Caption = #1042#1082#1083#1102#1095#1072#1103' '#1087#1086#1076#1087#1072#1087#1082#1080
      TabOrder = 2
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 72
      Width = 513
      Height = 73
      Caption = #1061#1086#1076' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1080' '
      TabOrder = 3
      object Label2: TLabel
        Left = 8
        Top = 16
        Width = 60
        Height = 13
        Caption = #1057#1088#1072#1074#1085#1080#1074#1072#1102' '
      end
      object lblIm1: TLabel
        Left = 80
        Top = 16
        Width = 30
        Height = 13
        Caption = '----------'
      end
      object Label4: TLabel
        Left = 8
        Top = 32
        Width = 7
        Height = 13
        Caption = #1057
      end
      object lblIm2: TLabel
        Left = 80
        Top = 32
        Width = 30
        Height = 13
        Caption = '----------'
      end
      object ProgressBar: TProgressBar
        Left = 8
        Top = 48
        Width = 497
        Height = 17
        TabOrder = 0
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'log'
    Filter = #1054#1090#1095#1077#1090'|*.log'
    Left = 16
    Top = 160
  end
  object ResultMenu: TPopupMenu
    Left = 48
    Top = 160
    object mnSaveResult: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100'...'
      OnClick = btnSaveResultClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mnClearResult: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnClick = mnClearResultClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnDelFile: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1092#1072#1081#1083
    end
  end
end
