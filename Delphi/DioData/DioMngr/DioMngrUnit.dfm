object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DioTree: TTreeView
    Left = 0
    Top = 29
    Width = 185
    Height = 394
    Align = alLeft
    HideSelection = False
    Indent = 19
    TabOrder = 0
    OnChange = DioTreeChange
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 423
    Width = 624
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object MainMenu: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 624
    Height = 29
    ActionManager = ActionManager
    Caption = 'MainMenu'
    Color = clMenuBar
    ColorMap.HighlightColor = clWhite
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 0
  end
  object Edit1: TEdit
    Left = 191
    Top = 35
    Width = 425
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object btnAddDio: TButton
    Left = 191
    Top = 62
    Width = 75
    Height = 25
    Caption = 'btnAdd'
    TabOrder = 4
    OnClick = btnAddDioClick
  end
  object btnDelete: TButton
    Left = 272
    Top = 62
    Width = 75
    Height = 25
    Caption = 'btnDelete'
    TabOrder = 5
    OnClick = btnDeleteClick
  end
  object RadioButton1: TRadioButton
    Left = 191
    Top = 93
    Width = 113
    Height = 17
    Caption = 'n'
    TabOrder = 6
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 191
    Top = 116
    Width = 113
    Height = 17
    Caption = 'n - a'
    TabOrder = 7
    OnClick = RadioButton1Click
  end
  object RadioButton3: TRadioButton
    Left = 191
    Top = 139
    Width = 113
    Height = 17
    Caption = 'o'
    TabOrder = 8
    OnClick = RadioButton1Click
  end
  object btnFind: TButton
    Left = 353
    Top = 62
    Width = 75
    Height = 25
    Caption = 'btnFind'
    TabOrder = 9
    OnClick = btnFindClick
  end
  object ActionManager: TActionManager
    Left = 440
    Top = 104
    StyleName = 'Platform Default'
  end
  object OpenDialog: TOpenDialog
    Filter = 
      #1060#1072#1081#1083' '#1086#1087#1080#1089#1072#1085#1080#1103' '#1087#1088#1080#1073#1086#1088#1072'|*.info|'#1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093' '#1087#1088#1080#1073#1086#1088#1072'|*.d9m|'#1060#1072#1081#1083' '#1089#1087#1080#1089 +
      #1082#1072' '#1087#1088#1080#1073#1086#1088#1086#1074'|*.xml'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 64
    Top = 112
  end
  object SaveDialog: TSaveDialog
    Filter = 
      #1060#1072#1081#1083' '#1086#1087#1080#1089#1072#1085#1080#1103' '#1087#1088#1080#1073#1086#1088#1072'|*.info|'#1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093' '#1087#1088#1080#1073#1086#1088#1072'|*.d9m|'#1060#1072#1081#1083' '#1089#1087#1080#1089 +
      #1082#1072' '#1087#1088#1080#1073#1086#1088#1086#1074'|*.xml'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 64
    Top = 168
  end
end
