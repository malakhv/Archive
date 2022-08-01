object CalendarForm: TCalendarForm
  Left = 722
  Top = 125
  Width = 177
  Height = 209
  BorderIcons = []
  Caption = #1050#1072#1083#1077#1085#1076#1072#1088#1100
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
  object btnOk: TSpeedButton
    Left = 40
    Top = 160
    Width = 57
    Height = 17
    Caption = #1054#1050
    Flat = True
    OnClick = btnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 104
    Top = 160
    Width = 57
    Height = 17
    Caption = #1054#1090#1084#1077#1085#1072
    Flat = True
    OnClick = btnCancelClick
  end
  object Calendar: TMonthCalendar
    Left = 0
    Top = 0
    Width = 169
    Height = 153
    Align = alTop
    AutoSize = True
    Date = 39166.644110416670000000
    TabOrder = 0
  end
end
