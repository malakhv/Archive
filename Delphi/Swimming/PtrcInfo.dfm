object ftmPtrcInfo: TftmPtrcInfo
  Left = 441
  Top = 233
  BorderStyle = bsDialog
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1089#1087#1086#1088#1090#1089#1084#1077#1085#1077'...'
  ClientHeight = 211
  ClientWidth = 259
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 143
    Width = 40
    Height = 13
    Caption = #1058#1088#1077#1085#1077#1088':'
  end
  object Label2: TLabel
    Left = 8
    Top = 89
    Width = 38
    Height = 13
    Caption = #1064#1082#1086#1083#1072':'
  end
  object Label3: TLabel
    Left = 8
    Top = 116
    Width = 35
    Height = 13
    Caption = #1043#1086#1088#1086#1076':'
  end
  object Label4: TLabel
    Left = 8
    Top = 62
    Width = 23
    Height = 13
    Caption = #1055#1086#1083':'
  end
  object Label7: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object Label8: TLabel
    Left = 8
    Top = 35
    Width = 23
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object btnPanel: TPanel
    Left = 0
    Top = 170
    Width = 259
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 7
    ExplicitTop = 197
    object btnCancel: TSpeedButton
      Left = 176
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Flat = True
      OnClick = btnCancelClick
    end
    object btnOK: TSpeedButton
      Left = 95
      Top = 8
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
      Flat = True
      OnClick = btnOKClick
    end
  end
  object cbTrnr: TComboBox
    Left = 67
    Top = 143
    Width = 184
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 6
    OnChange = edFNameChange
  end
  object cbSchl: TComboBox
    Left = 67
    Top = 89
    Width = 184
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = edFNameChange
  end
  object cbBYear: TComboBox
    Left = 150
    Top = 62
    Width = 101
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = #1043#1086#1076' '#1088#1086#1078#1076#1077#1085#1080#1103
    OnChange = edFNameChange
    Items.Strings = (
      #1043#1086#1076' '#1088#1086#1078#1076#1077#1085#1080#1103)
  end
  object cbSex: TComboBox
    Left = 67
    Top = 62
    Width = 77
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = #1084#1091#1078
    OnChange = edFNameChange
    Items.Strings = (
      #1084#1091#1078
      #1078#1077#1085)
  end
  object cbCity: TComboBox
    Left = 67
    Top = 116
    Width = 184
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    OnChange = edFNameChange
  end
  object edFName: TEdit
    Left = 67
    Top = 8
    Width = 184
    Height = 21
    TabOrder = 0
    OnChange = edFNameChange
  end
  object edName: TEdit
    Left = 67
    Top = 35
    Width = 184
    Height = 21
    TabOrder = 1
    OnChange = edFNameChange
  end
end
