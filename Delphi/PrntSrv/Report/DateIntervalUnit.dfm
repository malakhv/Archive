object DateIntrvlFrm: TDateIntrvlFrm
  Left = 415
  Top = 157
  Width = 211
  Height = 154
  Caption = #1048#1085#1090#1077#1088#1074#1072#1083
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 10
    Height = 13
    Caption = #1057':'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 17
    Height = 13
    Caption = #1055#1086':'
  end
  object btnOk: TSpeedButton
    Left = 72
    Top = 100
    Width = 57
    Height = 17
    Caption = #1054#1050
    Flat = True
    OnClick = btnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 136
    Top = 100
    Width = 57
    Height = 17
    Caption = #1054#1090#1084#1077#1085#1072
    Flat = True
    OnClick = btnCancelClick
  end
  object DTP1: TDateTimePicker
    Left = 8
    Top = 24
    Width = 186
    Height = 21
    Date = 39180.702658958340000000
    Time = 39180.702658958340000000
    TabOrder = 0
    OnChange = DTP1Change
  end
  object DTP2: TDateTimePicker
    Left = 8
    Top = 64
    Width = 186
    Height = 21
    Date = 39180.702705439810000000
    Time = 39180.702705439810000000
    TabOrder = 1
    OnChange = DTP1Change
  end
end
