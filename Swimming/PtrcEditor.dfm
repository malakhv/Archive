object frmPatricipants: TfrmPatricipants
  Left = 309
  Top = 186
  Caption = #1059#1095#1072#1089#1090#1085#1080#1082#1080' '#1089#1086#1088#1077#1074#1085#1086#1074#1072#1085#1080#1081
  ClientHeight = 453
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ActionToolBar: TActionToolBar
    Left = 0
    Top = 0
    Width = 632
    Height = 26
    ActionManager = ActionManager
    Caption = 'ActionToolBar'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Spacing = 0
  end
  object ListView: TListView
    Left = 0
    Top = 26
    Width = 632
    Height = 367
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = #1060#1072#1084#1080#1083#1080#1103
      end
      item
        AutoSize = True
        Caption = #1048#1084#1103
      end
      item
        Caption = #1064#1082#1086#1083#1072
        Width = 150
      end
      item
        Caption = #1043#1086#1076
        Width = 40
      end
      item
        Caption = #1058#1088#1077#1085#1077#1088
        Width = 100
      end
      item
        Caption = #1043#1086#1088#1086#1076
        Width = 100
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupAction
    TabOrder = 1
    ViewStyle = vsReport
    OnSelectItem = ListViewSelectItem
  end
  object FindEdit: TEdit
    Left = 140
    Top = 2
    Width = 119
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BorderStyle = bsNone
    TabOrder = 2
    Visible = False
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 434
    Width = 632
    Height = 19
    Panels = <>
  end
  object btnPanel: TPanel
    Left = 0
    Top = 393
    Width = 632
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    Visible = False
    DesignSize = (
      632
      41)
    object btnOk: TButton
      Left = 463
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1050
      Enabled = False
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 544
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object chNoCat: TCheckBox
      Left = 8
      Top = 6
      Width = 105
      Height = 17
      Caption = #1042#1085#1077' '#1082#1072#1090#1077#1075#1086#1088#1080#1080
      TabOrder = 2
      OnClick = chNoCatClick
    end
  end
  object ImageList: TImageList
    Left = 72
    Top = 51
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      000000000000000000000000000000000000000000004A637B00BD9494000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B9CC600188CE7004A7BA500C694
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004AB5FF0052B5FF00218CEF004A7B
      A500C69494000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052B5FF0052B5FF001884
      E7004A7BA500C694940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000052B5FF004AB5
      FF00188CE7004A7BA500BD949400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000052B5
      FF004AB5FF002184DE005A6B730000000000AD7B7300C6A59C00D6B5A500CEA5
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052BDFF00B5D6EF00A5948C00B59C8C00F7E7CE00FFFFD600FFFFD600FFFF
      D600E7DEBD00CEADA50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEB5B500D6B5A500FFEFC600FFFFD600FFFFD600FFFFD600FFFF
      DE00FFFFEF00F7F7EF00B58C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6948C00F7DEB500F7D6A500FFF7CE00FFFFD600FFFFDE00FFFF
      EF00FFFFF700FFFFFF00DED6BD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEBDA500FFE7AD00F7CE9400FFF7CE00FFFFDE00FFFFE700FFFF
      F700FFFFF700FFFFEF00F7EFD600C69C94000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7C6AD00FFDEAD00EFBD8400F7E7B500FFFFD600FFFFDE00FFFF
      E700FFFFE700FFFFDE00F7F7D600C6AD9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEBDAD00FFE7B500EFBD8400F7CE9400FFEFC600FFFFDE00FFFF
      DE00FFFFDE00FFFFDE00F7EFD600C6A59C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C69C9400FFEFC600FFEFC600F7D6A500F7CE9C00F7E7B500FFF7
      CE00FFF7D600FFFFD600E7DEBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEC6AD00FFFFFF00FFF7EF00F7CE9400EFBD8400F7CE
      9C00FFE7B500FFF7C600BD9C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6BDBD00F7EFD600FFEFC600FFE7AD00FFE7
      B500F7DEB500CEAD9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CEAD9400CEAD9C00DEBDA500DEBD
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B7818300B781
      8300B7818300B7818300B7818300B7818300B7818300B7818300B7818300B781
      8300B7818300B7818300B7818300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000732DE000732DE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C7A79C00FEEE
      D400F7E3C500F6DFBC00F5DBB400F3D7AB00F3D3A200F1CF9A00F0CF9700F0CF
      9800F0CF9800F5D49A00B781830000000000B7818300B7818300B7818300B781
      8300B7818300B7818300B7818300B7818300B7818300B7818300B7818300B781
      8300B7818300000000000000000000000000000000000732DE000732DE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000732DE000732DE000000000000000000B7818300A4787400A478
      7400A4787400A4787400A4787400A4787400A4787400A4787400A4787400A478
      7400A4787400986B660000000000000000000000000000000000C7A79E00FDEF
      D900F6E3CB00F5DFC200F4DBBA00F2D7B200F1D4A900F1D0A200EECC9900EECC
      9700EECC9700F3D19900B781830000000000B7818300FDEFD900F4E1C900E4CF
      B400D1BCA000CDB79800DAC09A00E4C59900E9C89600EDCB9600EECC9700F3D1
      9900B7818300000000000000000000000000000000000732DE000732DE000732
      DE00000000000000000000000000000000000000000000000000000000000000
      00000732DE000732DE00000000000000000000000000B7818300FDEFD900F6E3
      CB00F5DFC200F4DBBA00F2D7B200F1D4A900F1D0A200EECC9900EECC9700EECC
      9700F3D19900986B660000000000000000000000000000000000C7A9A100FEF3
      E300F8E7D300F5E3CB00F5DFC300F3DBBB00F2D7B200F1D4AB00F0D0A300EECC
      9A00EECC9700F3D19900B781830000000000B4817600FEF3E300F8E7D3004946
      4500373C3E0051606100AE9C8200BFA88900D0B48D00E4C39300EDCB9600F3D1
      9900B7818300000000000000000000000000000000000732DE000732DD000732
      DE000732DE000000000000000000000000000000000000000000000000000732
      DE000732DE0000000000000000000000000000000000B4817600FEF3E300F8E7
      D300F5E3CB00F5DFC300CFCF9F00018A0200018A0200CCC68B00EECC9A00EECC
      9700F3D19900986B660000000000000000000000000000000000C9ACA500FFF7
      EB00F9EBDA00F7E7D200F6E3CA00F5DFC200F4DBB900F2D7B200F1D4AA00F0D0
      A100EFCD9900F3D19800B781830000000000B4817600FFF7EB00F9EBDA00B0A5
      98001B617D00097CA80018556F0066625B00A7947900C5AC8600DCBD8D00EECD
      9500B781830000000000000000000000000000000000000000000534ED000732
      DF000732DE000732DE00000000000000000000000000000000000732DE000732
      DE000000000000000000000000000000000000000000B4817600FFF7EB00F9EB
      DA00018A0200D1D6AC00018A0200D0CF9E00CECC9800018A0200CCC68900EFCD
      9900F3D19800986B660000000000000000000000000000000000CEB2AA00FFFC
      F400FAEFE400F8EADA00F7E7D300F5E2CB00F5DFC200F4DBBB00F1D7B200F1D3
      AA00F0D0A100F3D29B00B781830000000000BA8E8500FFFCF400FAEFE400F2E5
      D6003872860029799A008D787F00956D6F00795953009D8B7300BAA38000D9BC
      8C00B47F81000000000000000000000000000000000000000000000000000000
      00000732DE000732DE000732DD00000000000732DD000732DE000732DE000000
      00000000000000000000000000000000000000000000BA8E8500FFFCF400FAEF
      E400018A0200018A0200D1D5AD00F5DFC200F4DBBB00CDCC9800018A0200F0D0
      A100F3D29B00986B660000000000000000000000000000000000D3B7AF00FFFF
      FD00FBF4EC00FAEFE300F9EBDA00F7E7D200F5E3C900F5DFC200F4DBBA00F2D7
      B100F0D4A900F5D5A300B781830000000000BA8E8500FFFFFD00FBF4EC00FAEF
      E300A5B3B1007C707800E5A6A300C8929200A47272007657510095856C00AF99
      7800A87779000000000000000000000000000000000000000000000000000000
      0000000000000732DD000633E6000633E6000633E9000732DC00000000000000
      00000000000000000000000000000000000000000000BA8E8500FFFFFD00FBF4
      EC00018A0200018A0200018A0200F5E3C900F5DFC200F4DBBA00F2D7B100F0D4
      A900F5D5A300986B660000000000000000000000000000000000D7BBB200FFFF
      FF00FEF9F500FBF3EC00FAEFE200F9EADA00F8E7D200F5E3CA00F5DEC200F4DB
      BA00F2D8B200F6D9AC00B781830000000000CB9A8200FFFFFF00FEF9F500FBF3
      EC00F4EBDF0085787C00EEB7B500DAA6A600C38E8E009E6E6E0073564F009383
      6B00996E6F000000000000000000000000000000000000000000000000000000
      000000000000000000000633E3000732E3000534EF0000000000000000000000
      00000000000000000000000000000000000000000000CB9A8200FFFFFF00FEF9
      F500FBF3EC00FAEFE200F9EADA00F8E7D200018A0200018A0200018A0200F2D8
      B200F6D9AC00986B660000000000000000000000000000000000DABEB300FFFF
      FF00FFFEFD00FDF8F400FBF3EC00F9EFE300F8EADA00F7E7D200F6E2CA00F6DE
      C100F4DBB900F8DDB400B781830000000000CB9A8200FFFFFF00FFFEFD00FDF8
      F400FBF3EC00F0E4D900A3797800E9B5B500D9A5A500C48F8F009D6D6D007759
      52008F6769000000000000000000000000000000000000000000000000000000
      0000000000000732DD000534ED000533E9000434EF000434F500000000000000
      00000000000000000000000000000000000000000000CB9A8200FFFFFF00FFFE
      FD00018A0200D6E3C900F9EFE300F8EADA00D2D9B300018A0200018A0200F4DB
      B900F8DDB400986B660000000000000000000000000000000000DEC1B500FFFF
      FF00FFFFFF00FFFEFD00FEF9F400FBF3EB00FAEFE200F9EBD900F8E6D100F6E2
      C800F7E1C200F0DAB700B781830000000000DCA88700FFFFFF00FFFFFF00FFFE
      FD00FEF9F400FBF3EB00E8D9CE009E747300E8B5B500D8A4A400C18D8D009D6C
      6C007D5556000000000000000000000000000000000000000000000000000000
      00000434F4000534EF000533EB0000000000000000000434F4000335F8000000
      00000000000000000000000000000000000000000000DCA88700FFFFFF00FFFF
      FF00D9EDD800018A0200D6E3C800D5E0C100018A0200D3D8B200018A0200F7E1
      C200F0DAB700986B660000000000000000000000000000000000E2C5B500FFFF
      FF00FFFFFF00FFFFFF00FFFEFD00FDF9F400FBF3EB00FAEEE200FAEDDC00FCEF
      D900E6D9C400C6BCA900B781830000000000DCA88700FFFFFF00FFFFFF00FFFF
      FF00FFFEFD00FDF9F400FBF3EB00E0CFC500A1767600ECB9B900D6A2A200C68E
      8E00965F5D00585C600000000000000000000000000000000000000000000335
      FC000534EF000434F800000000000000000000000000000000000335FC000335
      FB000000000000000000000000000000000000000000DCA88700FFFFFF00FFFF
      FF00FFFFFF00D9EDD800018A0200018A0200D5DFC100FAEDDC00FCEFD900E6D9
      C400C6BCA900986B660000000000000000000000000000000000E5C7B700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFEFD00FDF8F300FDF6EC00F1E1D500C6A1
      9400B5948900B08F8100B781830000000000E3B18E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFEFD00FDF8F300FDF6EC00DAC5BC00AC808000F3BCBB00A387
      8C003392B30019ADCC0019ADCC000000000000000000000000000335FB000335
      FB000335FC000000000000000000000000000000000000000000000000000335
      FB000335FB0000000000000000000000000000000000E3B18E00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFEFD00FDF8F300FDF6EC00F1E1D500B4817600B481
      7600B4817600B481760000000000000000000000000000000000E9CBB800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900BF8C
      7600E8B27000ECA54A00C587680000000000E3B18E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900AA7A7100B2787300469C
      BA000FCAF40000A4E600021EAA0000009900000000000335FB000335FB000335
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000335FB00000000000000000000000000E3B18E00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900B4817600E8B2
      7000ECA54A00C587680000000000000000000000000000000000ECCDBA00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200C89A
      7F00FAC57700CD9377000000000000000000EDBD9200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200B8857A00DCA76A0010A5
      CF0004A8E6000936C900092CC3000318AE000335FB000335FB000335FB000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDBD9200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200B4817600FAC5
      7700CD9377000000000000000000000000000000000000000000EACAB600FCF7
      F400FCF7F300FBF6F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00C797
      7C00CF9B8600000000000000000000000000EDBD9200FCF7F400FCF7F300FBF6
      F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00B8857A00CF9B86000000
      0000077DCD004860F100204ADD000416AA000335FB000335FB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDBD9200FCF7F400FCF7
      F300FBF6F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00B4817600CF9B
      8600000000000000000000000000000000000000000000000000E9C6B100EBCC
      B800EBCCB800EBCCB800EBCBB800EACBB800EACBB800EACCB900DABBB000B885
      7A0000000000000000000000000000000000EDBD9200DCA88700DCA88700DCA8
      8700DCA88700DCA88700DCA88700DCA88700DCA88700B8857A00000000000000
      0000000000003E4BDB00192DC400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDBD9200DAA48200DAA4
      8200DAA48200DAA48200DAA48200DAA48200DAA48200DAA48200B48176000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF009FFF0000000000000FFF000000000000
      07FF00000000000083FF000000000000C1FF000000000000E10F000000000000
      F003000000000000F801000000000000F801000000000000F800000000000000
      F800000000000000F800000000000000F801000000000000FC01000000000000
      FE03000000000000FF0F000000000000C001FFFFFFFCFFFFC00100079FF98003
      C00100078FF38003C001000787E78003C0010007C3CF8003C0010007F11F8003
      C0010007F83F8003C0010007FC7F8003C0010007F83F8003C0010007F19F8003
      C0010003E3CF8003C0010001C7E78003C00100008FFB8003C00300001FFF8007
      C00700103FFF800FC00F0039FFFF801F}
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = actAdd
            ImageIndex = 0
          end
          item
            Action = ActEdit
            ImageIndex = 1
          end
          item
            Action = actUpdate
            ImageIndex = 3
          end
          item
            Action = ActDelete
            ImageIndex = 2
          end>
      end
      item
        Items = <
          item
            Action = actAdd
            ImageIndex = 0
            ShowCaption = False
          end
          item
            Action = ActEdit
            ImageIndex = 1
            ShowCaption = False
          end
          item
            Caption = '-'
          end
          item
            Action = actUpdate
            ImageIndex = 3
            ShowCaption = False
          end
          item
            Caption = '-'
          end
          item
            Action = ActDelete
            ImageIndex = 2
            ShowCaption = False
          end
          item
            Visible = False
            Caption = '-'
          end
          item
            Action = actSep
            Caption = '                                      '
          end
          item
            Visible = False
            Action = actFind
            ImageIndex = 4
            ShowCaption = False
          end>
        ActionBar = ActionToolBar
      end>
    Images = ImageList
    Left = 40
    Top = 51
    StyleName = 'XP Style'
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1053#1086#1074#1099#1081'...'
      ImageIndex = 0
      OnExecute = actAddExecute
    end
    object ActEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Enabled = False
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = ActEditExecute
    end
    object ActDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = ActDeleteExecute
    end
    object actUpdate: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 3
      OnExecute = actUpdateExecute
    end
    object actFind: TAction
      Caption = #1053#1072#1081#1090#1080
      ImageIndex = 4
      OnExecute = actFindExecute
    end
    object actSep: TAction
      Caption = 'actSep'
    end
  end
  object PopupAction: TPopupActionBar
    Left = 8
    Top = 51
    object mnAdd: TMenuItem
      Action = actAdd
    end
    object mnEdit: TMenuItem
      Action = ActEdit
    end
    object mnSep1: TMenuItem
      Caption = '-'
      Enabled = False
      ImageIndex = 2
    end
    object mnDelete: TMenuItem
      Action = ActDelete
    end
    object mnSep2: TMenuItem
      Caption = '-'
    end
    object mnUpdate: TMenuItem
      Action = actUpdate
    end
  end
end