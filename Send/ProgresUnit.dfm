object ProgresForm: TProgresForm
  Left = 312
  Top = 155
  BorderStyle = bsDialog
  Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
  ClientHeight = 107
  ClientWidth = 409
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 107
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object SendProgres: TGauge
      Left = 8
      Top = 32
      Width = 393
      Height = 25
      Progress = 0
    end
    object CompLabel: TLabel
      Left = 16
      Top = 8
      Width = 33
      Height = 20
      Caption = 'XXX'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 160
      Top = 72
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkCancel
    end
  end
end
