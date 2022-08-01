object MainForm: TMainForm
  Left = 219
  Top = 154
  Caption = 'MainForm'
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
  object Splitter: TSplitter
    Left = 153
    Top = 58
    Height = 376
    ExplicitLeft = 184
    ExplicitTop = 160
    ExplicitHeight = 100
  end
  object MainMenuBar: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 632
    Height = 29
    UseSystemFont = False
    Caption = 'MainMenuBar'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Spacing = 0
  end
  object MainToolBar: TActionToolBar
    Left = 0
    Top = 29
    Width = 632
    Height = 29
    Caption = 'MainToolBar'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Spacing = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 434
    Width = 632
    Height = 19
    Panels = <>
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 58
    Width = 153
    Height = 376
    Align = alLeft
    Indent = 19
    TabOrder = 3
    Items.NodeData = {
      0102000000270000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00072804300431043B043E043D044B04290000000000000000000000FFFFFFFF
      FFFFFFFF00000000000000000820043004410441044B043B043A043004}
  end
  object Msg: TMemo
    Left = 156
    Top = 58
    Width = 476
    Height = 376
    Align = alClient
    TabOrder = 4
  end
  object Button1: TButton
    Left = 24
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 5
    OnClick = Button1Click
  end
  object ActionManager: TActionManager
    Left = 16
    Top = 160
    StyleName = 'XP Style'
    object Open: TAction
      Category = #1060#1072#1081#1083
      Caption = #1054#1090#1082#1088#1099#1090#1100
    end
    object Save: TAction
      Category = #1060#1072#1081#1083
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    end
    object SaveAs: TAction
      Category = #1060#1072#1081#1083
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
    end
  end
  object PopupActionBar: TPopupActionBar
    Left = 16
    Top = 128
  end
end
