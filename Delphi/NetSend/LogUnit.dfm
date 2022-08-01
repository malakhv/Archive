object LogForm: TLogForm
  Left = 219
  Top = 115
  Caption = #1046#1091#1088#1085#1072#1083' '#1089#1086#1073#1099#1090#1080#1081
  ClientHeight = 453
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object ActionMainMenuBar: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 632
    Height = 29
    Caption = 'ActionMainMenuBar'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Spacing = 0
  end
  object ActionToolBar: TActionToolBar
    Left = 0
    Top = 29
    Width = 632
    Height = 29
    Caption = 'ActionToolBar'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Spacing = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 434
    Width = 632
    Height = 19
    Panels = <>
  end
  object LogList: TListView
    Left = 0
    Top = 58
    Width = 632
    Height = 376
    Align = alClient
    Columns = <
      item
        Width = 20
      end
      item
        Caption = #1044#1072#1090#1072'/'#1074#1088#1077#1084#1103
        Width = 100
      end
      item
        Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
        Width = 100
      end
      item
        AutoSize = True
        Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
    OnCustomDrawItem = LogListCustomDrawItem
  end
  object ActionManager: TActionManager
    Left = 40
    Top = 104
    StyleName = 'XP Style'
    object actClose: TAction
      Category = #1060#1072#1081#1083
      Caption = #1047#1072#1082#1088#1099#1090#1100
      OnExecute = actCloseExecute
    end
    object actClear: TAction
      Category = #1055#1088#1072#1074#1082#1072
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    end
  end
  object PopupActionBar1: TPopupActionBar
    Left = 72
    Top = 104
  end
end
