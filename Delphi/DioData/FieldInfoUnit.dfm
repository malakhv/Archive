object FieldInfoForm: TFieldInfoForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1087#1086#1083#1077#1081' '#1076#1072#1085#1085#1099#1093'...'
  ClientHeight = 238
  ClientWidth = 274
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
  object btnPanel: TPanel
    Left = 0
    Top = 197
    Width = 274
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object btnClose: TButton
      Left = 192
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnOK: TButton
      Left = 111
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1050
      TabOrder = 1
      OnClick = btnOKClick
    end
  end
  object FieldList: TListView
    Left = 0
    Top = 0
    Width = 274
    Height = 197
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        AutoSize = True
      end>
    ColumnClick = False
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsList
    OnItemChecked = FieldListItemChecked
  end
end
