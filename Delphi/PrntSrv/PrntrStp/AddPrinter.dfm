object AddPrinterForm: TAddPrinterForm
  Left = 338
  Top = 126
  Width = 347
  Height = 254
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1080#1085#1090#1077#1088' '#1080#1079' '#1089#1087#1080#1089#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PList: TListView
    Left = 0
    Top = 0
    Width = 339
    Height = 186
    Align = alClient
    BevelKind = bkSoft
    BorderStyle = bsNone
    Columns = <
      item
        AutoSize = True
        Caption = #1042#1089#1077' '#1087#1088#1080#1085#1090#1077#1088#1099
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = PListSelectItem
  end
  object btnPanel: TPanel
    Left = 0
    Top = 186
    Width = 339
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object btnCansel: TSpeedButton
      Left = 256
      Top = 8
      Width = 73
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      OnClick = btnCanselClick
    end
    object btnAdd: TSpeedButton
      Left = 176
      Top = 8
      Width = 73
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      OnClick = btnAddClick
    end
  end
end
