object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 573
  ClientWidth = 792
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
  object Splitter1: TSplitter
    Left = 137
    Top = 52
    Height = 502
    ExplicitLeft = 264
    ExplicitTop = 200
    ExplicitHeight = 100
  end
  object Memo1: TMemo
    Left = 140
    Top = 52
    Width = 652
    Height = 502
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    ExplicitLeft = 376
    ExplicitTop = 46
    ExplicitWidth = 422
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 792
    Height = 23
    ActionManager = ActionManager
    Caption = 'ActionMainMenuBar1'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Spacing = 0
    ExplicitLeft = 608
    ExplicitTop = 16
    ExplicitWidth = 150
    ExplicitHeight = 29
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 23
    Width = 792
    Height = 29
    Caption = 'ActionToolBar1'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Spacing = 0
    ExplicitLeft = 664
    ExplicitTop = 56
    ExplicitWidth = 150
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 554
    Width = 792
    Height = 19
    Panels = <>
    ExplicitLeft = 632
    ExplicitTop = 560
    ExplicitWidth = 0
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 52
    Width = 137
    Height = 502
    Align = alLeft
    Indent = 19
    TabOrder = 4
  end
  object OpenDialog: TOpenDialog
    Left = 616
    Top = 88
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = FileOpen1
                ImageIndex = 7
                ShortCut = 16463
              end
              item
                Action = FileSaveAs1
                ImageIndex = 30
              end
              item
                Action = FilePrintSetup1
              end
              item
                Action = FilePageSetup1
                Caption = '&Page Setup...'
              end
              item
                Action = FileExit1
                ImageIndex = 43
              end>
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = EditCut1
                ImageIndex = 0
                ShortCut = 16472
              end
              item
                Action = EditCopy1
                ImageIndex = 1
                ShortCut = 16451
              end
              item
                Action = EditPaste1
                ImageIndex = 2
                ShortCut = 16470
              end
              item
                Action = EditSelectAll1
                ShortCut = 16449
              end
              item
                Action = EditUndo1
                ImageIndex = 3
                ShortCut = 16474
              end
              item
                Action = EditDelete1
                ImageIndex = 5
                ShortCut = 46
              end>
            Caption = '&Edit'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 496
    Top = 208
    StyleName = 'Platform Default'
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object EditUndo1: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 3
      ShortCut = 16474
    end
    object EditDelete1: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
    end
    object HelpContents1: THelpContents
      Category = 'Help'
      Caption = '&Contents'
      Enabled = False
      Hint = 'Help Contents'
      ImageIndex = 40
    end
    object HelpTopicSearch1: THelpTopicSearch
      Category = 'Help'
      Caption = '&Topic Search'
      Enabled = False
      Hint = 'Topic Search'
      ImageIndex = 9
    end
    object HelpOnHelp1: THelpOnHelp
      Category = 'Help'
      Caption = '&Help on Help'
      Enabled = False
      Hint = 'Help on help'
    end
    object HelpContextAction1: THelpContextAction
      Category = 'Help'
      Caption = 'HelpContextAction1'
      Enabled = False
      ImageIndex = 11
    end
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
      BeforeExecute = FileOpen1BeforeExecute
    end
    object FileSaveAs1: TFileSaveAs
      Category = 'File'
      Caption = 'Save &As...'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 30
    end
    object FilePrintSetup1: TFilePrintSetup
      Category = 'File'
      Caption = 'Print Set&up...'
      Hint = 'Print Setup'
    end
    object FilePageSetup1: TFilePageSetup
      Category = 'File'
      Caption = 'Page Set&up...'
      Dialog.MinMarginLeft = 0
      Dialog.MinMarginTop = 0
      Dialog.MinMarginRight = 0
      Dialog.MinMarginBottom = 0
      Dialog.MarginLeft = 2500
      Dialog.MarginTop = 2500
      Dialog.MarginRight = 2500
      Dialog.MarginBottom = 2500
      Dialog.PageWidth = 21000
      Dialog.PageHeight = 29700
    end
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
    object ListControlCopySelection1: TListControlCopySelection
      Category = 'List'
      Caption = 'ListControlCopySelection1'
    end
    object ListControlDeleteSelection1: TListControlDeleteSelection
      Category = 'List'
      Caption = 'ListControlDeleteSelection1'
    end
    object ListControlMoveSelection1: TListControlMoveSelection
      Category = 'List'
      Caption = 'ListControlMoveSelection1'
    end
  end
end
