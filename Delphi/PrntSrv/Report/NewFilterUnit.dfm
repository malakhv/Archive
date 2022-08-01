object NewFilterForm: TNewFilterForm
  Left = 299
  Top = 126
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1092#1080#1083#1100#1090#1088
  ClientHeight = 263
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 76
    Height = 13
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080':'
  end
  object Label2: TLabel
    Left = 8
    Top = 136
    Width = 54
    Height = 13
    Caption = #1055#1088#1080#1085#1090#1077#1088#1099':'
  end
  object Label3: TLabel
    Left = 176
    Top = 48
    Width = 69
    Height = 13
    Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088#1099':'
  end
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 71
    Height = 13
    Caption = #1048#1084#1103' '#1092#1080#1083#1100#1090#1088#1072':'
  end
  object btnPanel: TPanel
    Left = 0
    Top = 222
    Width = 346
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      346
      41)
    object btnOk: TSpeedButton
      Left = 183
      Top = 8
      Width = 73
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Flat = True
      OnClick = btnOkClick
    end
    object btnCancel: TSpeedButton
      Left = 265
      Top = 8
      Width = 73
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      Flat = True
      OnClick = btnCancelClick
    end
  end
  object UserList: TListBox
    Left = 8
    Top = 64
    Width = 161
    Height = 65
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 1
  end
  object PrList: TListBox
    Left = 8
    Top = 152
    Width = 329
    Height = 57
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 2
  end
  object CompList: TListBox
    Left = 176
    Top = 64
    Width = 161
    Height = 65
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 3
  end
  object FNameEdit: TEdit
    Left = 8
    Top = 24
    Width = 161
    Height = 21
    TabOrder = 4
    Text = #1053#1086#1074#1099#1081' '#1092#1080#1083#1100#1090#1088
  end
end
