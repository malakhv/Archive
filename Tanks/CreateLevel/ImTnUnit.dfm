object ImTnForm: TImTnForm
  Left = 397
  Top = 108
  Width = 265
  Height = 339
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
  object TankListBox: TFileListBox
    Left = 0
    Top = 0
    Width = 257
    Height = 264
    Align = alClient
    FileType = [ftDirectory]
    ItemHeight = 16
    ShowGlyphs = True
    TabOrder = 0
    OnChange = TankListBoxChange
    OnClick = TankListBoxClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 264
    Width = 257
    Height = 48
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Image1: TImage
      Left = 8
      Top = 8
      Width = 32
      Height = 32
    end
    object BitBtn1: TBitBtn
      Left = 168
      Top = 16
      Width = 83
      Height = 25
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Enabled = False
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 80
      Top = 16
      Width = 83
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
  end
end
