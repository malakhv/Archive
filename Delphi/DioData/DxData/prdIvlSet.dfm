object prnIvl: TprnIvl
  Left = 1089
  Top = 121
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1076#1080#1072#1087#1072#1079#1086#1085#1072' '#1087#1077#1095#1072#1090#1080
  ClientHeight = 232
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object hdtPage: TPageControl
    Left = 8
    Top = 32
    Width = 345
    Height = 169
    ActivePage = hdtSheet
    TabIndex = 0
    TabOrder = 0
    object hdtSheet: TTabSheet
      Caption = #1055#1077#1095#1072#1090#1100' '#1089#1091#1090#1086#1095#1085#1099#1093
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 81
        Height = 13
        Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
      end
      object Label2: TLabel
        Left = 176
        Top = 8
        Width = 74
        Height = 13
        Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
      end
      object prnIvlFrom: TDateTimePicker
        Left = 8
        Top = 24
        Width = 153
        Height = 21
        CalAlignment = dtaLeft
        Date = 37412.9547765741
        Time = 37412.9547765741
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
      object prnIvlTo: TDateTimePicker
        Left = 176
        Top = 24
        Width = 153
        Height = 21
        CalAlignment = dtaLeft
        Date = 37412.9548384606
        Time = 37412.9548384606
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
      object cbNakop: TCheckBox
        Left = 8
        Top = 56
        Width = 113
        Height = 17
        Caption = #1053#1072#1082#1086#1087#1080#1090#1077#1083#1100#1085#1099#1077
        TabOrder = 2
        OnClick = cbNakopClick
      end
      object cbExportMSWord: TCheckBox
        Left = 8
        Top = 80
        Width = 129
        Height = 17
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' MS Word'
        TabOrder = 3
      end
    end
    object hrdtSheet: TTabSheet
      Caption = #1055#1077#1095#1072#1090#1100' '#1087#1086#1095#1072#1089#1086#1074#1099#1093
      ImageIndex = 1
      object clb: TCheckListBox
        Left = 8
        Top = 8
        Width = 209
        Height = 121
        ItemHeight = 13
        TabOrder = 0
      end
      object Button3: TButton
        Left = 224
        Top = 8
        Width = 105
        Height = 21
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077' '
        TabOrder = 1
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 224
        Top = 32
        Width = 105
        Height = 21
        Caption = #1059#1073#1088#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
        TabOrder = 2
        OnClick = Button4Click
      end
    end
  end
  object Button1: TButton
    Left = 200
    Top = 208
    Width = 75
    Height = 21
    Caption = #1055#1077#1095#1072#1090#1100
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 208
    Width = 73
    Height = 21
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = Button2Click
  end
  object fsCombo: TComboBox
    Left = 8
    Top = 8
    Width = 345
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      #1060#1086#1088#1084#1072' '#1086#1090#1095#1077#1090#1072' '#1089' '#1086#1073#1098#1077#1084#1086#1084)
  end
end
