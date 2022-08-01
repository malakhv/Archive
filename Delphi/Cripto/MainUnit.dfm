object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1080#1084#1077#1088' '#1040#1083#1075#1086#1088#1080#1090#1084#1086#1074' '#1064#1080#1092#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 459
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 400
    Width = 577
    Height = 9
    Shape = bsTopLine
  end
  object btnExit: TButton
    Left = 512
    Top = 408
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 1
  end
  object btnStart: TButton
    Left = 8
    Top = 408
    Width = 121
    Height = 25
    Caption = #1047#1072#1096#1080#1092#1088#1086#1074#1072#1090#1100
    TabOrder = 0
  end
  object Original: TMemo
    Left = 8
    Top = 8
    Width = 577
    Height = 121
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object OriginalToShfr: TMemo
    Left = 8
    Top = 136
    Width = 577
    Height = 121
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object ShftToOriginal: TMemo
    Left = 8
    Top = 264
    Width = 577
    Height = 121
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 440
    Width = 593
    Height = 19
    Panels = <
      item
        Text = #1052#1077#1090#1086#1076' '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1103': '#1052#1086#1085#1086#1072#1083#1092#1072#1074#1080#1090#1085#1099#1081' '
        Width = 50
      end>
  end
  object btnDeShfr: TButton
    Left = 136
    Top = 408
    Width = 121
    Height = 25
    Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1072#1090#1100
    TabOrder = 6
    OnClick = btnDeShfrClick
  end
  object MainMenu: TMainMenu
    Left = 16
    Top = 16
    object mnFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object mnCreate: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        OnClick = mnCreateClick
      end
      object mnOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        OnClick = mnOpenClick
      end
      object N3: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        object mnSaveOrig: TMenuItem
          Caption = #1054#1088#1080#1075#1080#1085#1072#1083
          OnClick = mnSaveOrigClick
        end
        object mnSaveShfr: TMenuItem
          Caption = #1064#1080#1092#1088
          OnClick = mnSaveShfrClick
        end
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object mnExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        Default = True
        OnClick = mnExitClick
      end
    end
    object mnShfr: TMenuItem
      Caption = #1064#1080#1092#1088#1086#1074#1072#1085#1080#1077
      object mnMonoalf: TMenuItem
        Caption = #1052#1086#1085#1086#1072#1083#1092#1072#1074#1080#1090#1085#1099#1081
        Checked = True
        RadioItem = True
        OnClick = ShfrItemClick
      end
      object mnViginer: TMenuItem
        Caption = #1042#1080#1078#1080#1085#1077#1088#1072
        RadioItem = True
        OnClick = ShfrItemClick
      end
      object mnGomofon: TMenuItem
        Caption = #1043#1086#1084#1086#1092#1086#1085#1080#1095#1077#1089#1082#1080#1081
        RadioItem = True
        OnClick = ShfrItemClick
      end
      object mnPlayfer: TMenuItem
        Caption = #1055#1083#1077#1081#1092#1077#1088#1072
        RadioItem = True
        OnClick = ShfrItemClick
      end
      object mnMyAlgoritm: TMenuItem
        Caption = #1057#1074#1086#1081' '#1040#1083#1075#1086#1088#1080#1090#1084
        RadioItem = True
        OnClick = ShfrItemClick
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text File|*.txt'
    Left = 48
    Top = 16
  end
  object OpenDialog: TOpenDialog
    Left = 16
    Top = 48
  end
end
