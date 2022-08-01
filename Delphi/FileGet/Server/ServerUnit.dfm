object ServerForm: TServerForm
  Left = 263
  Top = 142
  Width = 473
  Height = 359
  Caption = 'IP: '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 16
    Top = 8
    object mnServer: TMenuItem
      Caption = #1057#1077#1088#1074#1077#1088
      object mnStart: TMenuItem
        Caption = #1057#1090#1072#1088#1090
        OnClick = mnStartClick
      end
      object mnStop: TMenuItem
        Caption = #1057#1090#1086#1087
        OnClick = mnStopClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mnExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = mnExitClick
      end
    end
  end
end
