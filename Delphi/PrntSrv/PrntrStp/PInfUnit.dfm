object PInfoForm: TPInfoForm
  Left = 362
  Top = 212
  BorderStyle = bsDialog
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
  ClientHeight = 194
  ClientWidth = 273
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
  object InfoBox: TGroupBox
    Left = 0
    Top = 0
    Width = 273
    Height = 153
    Align = alClient
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '
    TabOrder = 0
    DesignSize = (
      273
      153)
    object Info: TMemo
      Left = 8
      Top = 16
      Width = 257
      Height = 127
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 153
    Width = 273
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      273
      41)
    object btnCancel: TSpeedButton
      Left = 190
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      Flat = True
      OnClick = btnCancelClick
    end
    object btnSave: TSpeedButton
      Left = 110
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Flat = True
      OnClick = btnSaveClick
    end
  end
end
