object NRepForm: TNRepForm
  Left = 426
  Top = 235
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1086#1074#1099#1081' '#1092#1080#1083#1100#1090#1088
  ClientHeight = 83
  ClientWidth = 177
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 71
    Height = 13
    Caption = #1048#1084#1103' '#1092#1080#1083#1100#1090#1088#1072':'
  end
  object btnOk: TSpeedButton
    Left = 48
    Top = 55
    Width = 57
    Height = 17
    Caption = #1054#1050
    Flat = True
    OnClick = btnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 112
    Top = 55
    Width = 57
    Height = 17
    Caption = #1054#1090#1084#1077#1085#1072
    Flat = True
    OnClick = btnCancelClick
  end
  object FNameEdit: TEdit
    Left = 8
    Top = 24
    Width = 161
    Height = 21
    TabOrder = 0
    Text = #1060#1080#1083#1100#1090#1088
    OnChange = FNameEditChange
  end
end
