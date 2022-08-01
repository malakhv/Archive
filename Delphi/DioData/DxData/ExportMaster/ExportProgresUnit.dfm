object ExportProgresForm: TExportProgresForm
  Left = 570
  Top = 422
  BorderStyle = bsNone
  Caption = 'ExportProgresForm'
  ClientHeight = 92
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Progress: TCGauge
    Left = 8
    Top = 32
    Width = 465
    Height = 41
    ForeColor = clNavy
  end
  object lblInfo: TLabel
    Left = 8
    Top = 8
    Width = 28
    Height = 13
    Caption = 'lblInfo'
  end
end
