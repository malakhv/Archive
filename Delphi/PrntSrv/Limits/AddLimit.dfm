object AddLimitForm: TAddLimitForm
  Left = 321
  Top = 142
  Width = 297
  Height = 174
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1083#1080#1084#1080#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object MainBox: TGroupBox
    Left = 0
    Top = 0
    Width = 289
    Height = 106
    Align = alClient
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1083#1080#1084#1080#1090#1077': '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 46
      Height = 13
      Caption = #1055#1088#1080#1085#1090#1077#1088':'
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 76
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
    end
    object PrinterBox: TComboBox
      Left = 8
      Top = 32
      Width = 273
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = PrinterBoxChange
    end
    object UserBox: TComboBox
      Left = 8
      Top = 72
      Width = 273
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = PrinterBoxChange
    end
  end
  object btnPanel: TPanel
    Left = 0
    Top = 106
    Width = 289
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object btnCancel: TSpeedButton
      Left = 208
      Top = 8
      Width = 73
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Flat = True
      OnClick = btnCancelClick
    end
    object btnOK: TSpeedButton
      Left = 128
      Top = 8
      Width = 73
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      Flat = True
      OnClick = btnOKClick
    end
  end
end
