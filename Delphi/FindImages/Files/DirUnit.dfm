object DirForm: TDirForm
  Left = 314
  Top = 122
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1086#1088' '#1087#1072#1087#1082#1080' '#1089' '#1082#1072#1088#1090#1080#1085#1082#1072#1084#1080' ...'
  ClientHeight = 393
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 352
    Width = 373
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 200
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 288
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object DriveComboBox: TDriveComboBox
      Left = 8
      Top = 8
      Width = 145
      Height = 19
      DirList = DirList
      TabOrder = 2
    end
  end
  object DirList: TDirectoryListBox
    Left = 0
    Top = 0
    Width = 373
    Height = 352
    Align = alClient
    ItemHeight = 16
    TabOrder = 1
  end
end
