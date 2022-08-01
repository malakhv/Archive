object DirForm: TDirForm
  Left = 348
  Top = 106
  Width = 365
  Height = 402
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DirList: TDirectoryListBox
    Left = 0
    Top = 0
    Width = 357
    Height = 334
    Align = alClient
    ItemHeight = 16
    TabOrder = 0
  end
  object btnPanel: TPanel
    Left = 0
    Top = 334
    Width = 357
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Drive: TDriveComboBox
      Left = 8
      Top = 8
      Width = 145
      Height = 19
      DirList = DirList
      TabOrder = 0
    end
    object btnCancel: TBitBtn
      Left = 272
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
    object btnOK: TBitBtn
      Left = 184
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 2
      Kind = bkOK
    end
  end
end
