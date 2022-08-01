object ExlParamForm: TExlParamForm
  Left = 238
  Top = 149
  BorderStyle = bsSingle
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1101#1082#1089#1087#1086#1088#1090#1072'...'
  ClientHeight = 152
  ClientWidth = 297
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
  object btnPanel: TPanel
    Left = 0
    Top = 111
    Width = 297
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object btnOk: TSpeedButton
      Left = 136
      Top = 8
      Width = 73
      Height = 25
      Caption = #1054#1050
      Flat = True
      OnClick = btnOkClick
    end
    object btnCancel: TSpeedButton
      Left = 216
      Top = 8
      Width = 73
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Flat = True
      OnClick = btnCancelClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 297
    Height = 111
    Align = alClient
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082': '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 13
      Caption = #1058#1077#1082#1089#1090':'
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 84
      Height = 13
      Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072':'
    end
    object Label3: TLabel
      Left = 104
      Top = 64
      Width = 28
      Height = 13
      Caption = #1062#1074#1077#1090':'
    end
    object HeadEdit: TEdit
      Left = 8
      Top = 32
      Width = 281
      Height = 21
      TabOrder = 0
      Text = #1054#1090#1095#1077#1090
    end
    object FontSize: TSpinEdit
      Left = 8
      Top = 80
      Width = 89
      Height = 22
      MaxValue = 72
      MinValue = 8
      TabOrder = 1
      Value = 14
    end
    object HeadColor: TColorBox
      Left = 104
      Top = 80
      Width = 145
      Height = 22
      ItemHeight = 16
      TabOrder = 2
    end
  end
end
