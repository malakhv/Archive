object WordExprtForm: TWordExprtForm
  Left = 625
  Top = 240
  BorderStyle = bsDialog
  Caption = 'WordExprtForm'
  ClientHeight = 404
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblShablon: TLabel
    Left = 40
    Top = 152
    Width = 42
    Height = 13
    Caption = #1064#1072#1073#1083#1086#1085':'
  end
  object btnAddShablon: TSpeedButton
    Left = 296
    Top = 168
    Width = 57
    Height = 21
    Caption = #1044#1088#1091#1075#1086#1081'...'
    Flat = True
  end
  object lblDocName: TLabel
    Left = 40
    Top = 200
    Width = 82
    Height = 13
    Caption = #1048#1084#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
  end
  object Bevel1: TBevel
    Left = 32
    Top = 272
    Width = 330
    Height = 9
    Shape = bsTopLine
  end
  object lblCount: TLabel
    Left = 40
    Top = 280
    Width = 47
    Height = 13
    Caption = #1057#1090#1086#1083#1073#1094#1099':'
  end
  object btnPanel: TPanel
    Left = 0
    Top = 363
    Width = 575
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object btnCancel: TButton
      Left = 248
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOK: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1050
      Enabled = False
      TabOrder = 1
      OnClick = btnOKClick
    end
  end
  object cbShablon: TComboBox
    Left = 40
    Top = 168
    Width = 249
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = cbShablonChange
  end
  object cbPassword: TCheckBox
    Left = 40
    Top = 248
    Width = 120
    Height = 17
    Caption = #1047#1072#1097#1080#1090#1072' '#1087#1072#1088#1086#1083#1077#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edDocName: TEdit
    Left = 40
    Top = 216
    Width = 313
    Height = 21
    TabOrder = 3
    OnChange = cbShablonChange
  end
  object crColData: TCheckBox
    Left = 40
    Top = 296
    Width = 57
    Height = 17
    Caption = #1044#1072#1090#1072
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object cbColQ: TCheckBox
    Left = 40
    Top = 312
    Width = 65
    Height = 17
    Caption = 'Q, '#1043#1050#1072#1083
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object cbColT1: TCheckBox
    Left = 120
    Top = 296
    Width = 49
    Height = 17
    Caption = 'T1, C'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object cbColT2: TCheckBox
    Left = 120
    Top = 312
    Width = 49
    Height = 17
    Caption = 'T2, C'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object cbColV1: TCheckBox
    Left = 192
    Top = 296
    Width = 57
    Height = 17
    Caption = 'V1, m3'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object cbColV2: TCheckBox
    Left = 192
    Top = 312
    Width = 57
    Height = 17
    Caption = 'V2, m3'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object cbColV3: TCheckBox
    Left = 272
    Top = 296
    Width = 57
    Height = 17
    Caption = 'V3, m3'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object cbColV4: TCheckBox
    Left = 272
    Top = 312
    Width = 57
    Height = 17
    Caption = 'V4, m3'
    Checked = True
    State = cbChecked
    TabOrder = 11
  end
  object cbColTOkr: TCheckBox
    Left = 120
    Top = 328
    Width = 57
    Height = 17
    Caption = 'T '#1086#1082#1088'.'
    Checked = True
    State = cbChecked
    TabOrder = 12
  end
  object cbColU: TCheckBox
    Left = 40
    Top = 328
    Width = 65
    Height = 17
    Caption = 'U '#1073#1072#1090'.'
    Checked = True
    State = cbChecked
    TabOrder = 13
  end
  object cbMSWordOpen: TCheckBox
    Left = 168
    Top = 248
    Width = 121
    Height = 17
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' MS Word'
    Checked = True
    State = cbChecked
    TabOrder = 14
  end
  object cbDeltaT: TCheckBox
    Left = 192
    Top = 328
    Width = 57
    Height = 17
    Caption = 'T2 - T1'
    Checked = True
    State = cbChecked
    TabOrder = 15
  end
end
