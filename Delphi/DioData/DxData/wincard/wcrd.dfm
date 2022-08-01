object cardMan: TcardMan
  Left = 432
  Top = 173
  BorderStyle = bsNone
  Caption = #1052#1077#1085#1077#1076#1078#1077#1088' '#1082#1072#1088#1090' NT'
  ClientHeight = 198
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 32
    Width = 169
    Height = 13
    AutoSize = False
    Caption = '...'
  end
  object pb1: TCGauge
    Left = 16
    Top = 173
    Width = 169
    Height = 16
    MaxValue = 32768
    Visible = False
  end
  object pName: TLabel
    Left = 200
    Top = 32
    Width = 105
    Height = 13
    AutoSize = False
    Caption = '...'
  end
  object getDataBtn: TButton
    Left = 200
    Top = 48
    Width = 105
    Height = 21
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
    TabOrder = 0
    OnClick = getDataBtnClick
  end
  object Button2: TButton
    Left = 200
    Top = 88
    Width = 105
    Height = 21
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1103#1095#1077#1081#1082#1091
    Enabled = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object devList: TComboBox
    Left = 16
    Top = 48
    Width = 169
    Height = 107
    Style = csSimple
    ItemHeight = 13
    TabOrder = 2
    Text = #1053#1086#1084#1077#1088#1072' '#1087#1088#1080#1073#1086#1088#1086#1074' '#1074' '#1082#1072#1088#1090#1077
    OnChange = devListChange
  end
  object Button1: TButton
    Left = 200
    Top = 168
    Width = 105
    Height = 21
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 200
    Top = 112
    Width = 105
    Height = 21
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1082#1072#1088#1090#1091
    TabOrder = 4
    OnClick = Button3Click
  end
  object toDayData: TCheckBox
    Left = 16
    Top = 155
    Width = 169
    Height = 17
    Caption = #1082#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1089#1091#1090#1086#1095#1085#1099#1077
    TabOrder = 5
  end
end
