object AddUserForm: TAddUserForm
  Left = 355
  Top = 152
  Width = 265
  Height = 238
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
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
    Width = 257
    Height = 170
    Align = alClient
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077': '
    TabOrder = 0
    object lblName: TLabel
      Left = 8
      Top = 16
      Width = 25
      Height = 13
      Caption = #1048#1084#1103':'
    end
    object lblInfo: TLabel
      Left = 8
      Top = 56
      Width = 69
      Height = 13
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103':'
    end
    object edName: TEdit
      Left = 8
      Top = 32
      Width = 241
      Height = 21
      TabOrder = 0
      OnChange = edNameChange
    end
    object Info: TMemo
      Left = 8
      Top = 72
      Width = 241
      Height = 89
      TabOrder = 1
    end
  end
  object btnPanel: TPanel
    Left = 0
    Top = 170
    Width = 257
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object btnCancel: TSpeedButton
      Left = 176
      Top = 8
      Width = 73
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Flat = True
      OnClick = btnCancelClick
    end
    object btnOK: TSpeedButton
      Left = 96
      Top = 8
      Width = 73
      Height = 25
      Caption = #1044#1086#1073#1099#1074#1080#1090#1100
      Flat = True
      OnClick = btnOKClick
    end
  end
end
