object MainForm: TMainForm
  Left = 248
  Top = 200
  Width = 640
  Height = 480
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Paint: TPaintBox
    Left = 0
    Top = 0
    Width = 632
    Height = 446
    Align = alClient
    PopupMenu = ImageMenu
  end
  object Image: TImage
    Left = 0
    Top = 0
    Width = 632
    Height = 446
    Align = alClient
    PopupMenu = ImageMenu
    Visible = False
  end
  object SaveDialog: TSavePictureDialog
    DefaultExt = 'bmp'
    Left = 8
    Top = 8
  end
  object ImageMenu: TPopupMenu
    Left = 40
    Top = 8
    object N3: TMenuItem
      Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100
      OnClick = N3Click
    end
    object mnSave: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100'...'
      OnClick = mnSaveClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnFull: TMenuItem
      Caption = #1042#1086' '#1074#1077#1089#1100' '#1101#1082#1088#1072#1085
      OnClick = mnFullClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mnOptions: TMenuItem
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099'...'
      OnClick = mnOptionsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnExit: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      Default = True
      OnClick = mnExitClick
    end
  end
end
