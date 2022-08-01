object WayForm: TWayForm
  Left = 368
  Top = 192
  BorderStyle = bsSingle
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1091#1090#1080'...'
  ClientHeight = 129
  ClientWidth = 228
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000000C
    CC0000000000000000000000000000CFFFC00000000000000000000000000CFF
    FFFC0000000000000000000000000CFFFFFC0000000000000000000000000CFF
    FFFC00000000000000000000000000CFFFC0000000000000000000000000000C
    CC00000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000000C
    CC000000000CCC0000000000000000CFFFC0000000CFFFC00000000000000CFF
    FFFC00000CFFFFFC0000000000000CFFFFFC00000CFFFFFC0000000000000CFF
    FFFC00000CFFFFFC00000000000000CFFFC0000000CFFFC0000000000000000C
    CC000000000CCC0000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFE3FFFFFFC1FFFFFF80FFFFFF80FFFFFF80FF
    FFFFC1FFFFFFE3FFFFFFF7FFFFFFF7FFFFFFF7FFFFFFF7FFFFFFF7FFFFFFE3FE
    3FFFC1FC1FFF80F80FFF80000FFF80F80FFFC1FC1FFFE3FE3FFFFFFFFFFF}
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnPanel: TPanel
    Left = 0
    Top = 88
    Width = 228
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 61
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 228
    Height = 88
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 39
      Height = 16
      Caption = #1059#1079#1077#1083': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNumber: TLabel
      Left = 56
      Top = 8
      Width = 7
      Height = 16
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 128
      Height = 16
      Caption = #1057#1086#1077#1076#1080#1085#1080#1090#1100' '#1089' '#1091#1079#1083#1086#1084':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 56
      Width = 78
      Height = 16
      Caption = #1044#1083#1080#1085#1072' '#1087#1091#1090#1080':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object NodeBox: TComboBox
      Left = 144
      Top = 32
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object WayEdit: TEdit
      Left = 144
      Top = 56
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '1'
    end
  end
end
