object ProgressForm: TProgressForm
  Left = 336
  Top = 206
  BorderStyle = bsNone
  Caption = #1046#1076#1080#1090#1077'...'
  ClientHeight = 89
  ClientWidth = 386
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
  object Gauge: TGauge
    Left = 8
    Top = 32
    Width = 369
    Height = 25
    ForeColor = clNavy
    Progress = 0
  end
  object lblPr: TLabel
    Left = 8
    Top = 8
    Width = 45
    Height = 13
    Caption = #1069#1082#1089#1087#1086#1088#1090':'
  end
end
