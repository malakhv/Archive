object AddCompForm: TAddCompForm
  Left = 361
  Top = 154
  BorderStyle = bsDialog
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1077
  ClientHeight = 188
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 91
    Height = 13
    Caption = #1048#1084#1103' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072':'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 69
    Height = 13
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103':'
  end
  object btnPanel: TPanel
    Left = 0
    Top = 147
    Width = 265
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object btnCancel: TSpeedButton
      Left = 184
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Flat = True
      OnClick = btnCancelClick
    end
    object btnOK: TSpeedButton
      Left = 104
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1050
      Flat = True
      OnClick = btnOKClick
    end
  end
  object Info: TMemo
    Left = 8
    Top = 72
    Width = 249
    Height = 65
    TabOrder = 1
  end
  object CompBox: TComboBox
    Left = 8
    Top = 24
    Width = 249
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    OnChange = CompBoxChange
  end
end
