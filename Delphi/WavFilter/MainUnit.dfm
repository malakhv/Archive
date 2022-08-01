object MainForm: TMainForm
  Left = 437
  Top = 162
  Width = 209
  Height = 269
  Caption = 'MainForm'
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 131
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072'                  :'
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 131
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1072#1085#1072#1083#1086#1074'        :'
  end
  object Label3: TLabel
    Left = 8
    Top = 40
    Width = 131
    Height = 13
    Caption = #1063#1072#1089#1090#1086#1090#1072' '#1076#1080#1089#1082#1088#1077#1090#1080#1079#1072#1094#1080#1080'  :'
  end
  object Label4: TLabel
    Left = 8
    Top = 56
    Width = 130
    Height = 13
    Caption = #1041#1072#1081#1090' '#1074' '#1089#1077#1082#1091#1085#1076#1091'                 :'
  end
  object Label5: TLabel
    Left = 144
    Top = 8
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label6: TLabel
    Left = 144
    Top = 24
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label7: TLabel
    Left = 144
    Top = 40
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label8: TLabel
    Left = 144
    Top = 56
    Width = 6
    Height = 13
    Caption = '0'
  end
  object btnSavePath: TSpeedButton
    Left = 168
    Top = 144
    Width = 23
    Height = 22
    Caption = '...'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = btnSavePathClick
  end
  object Button1: TButton
    Left = 8
    Top = 80
    Width = 185
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1092#1072#1081#1083
    TabOrder = 0
    OnClick = Button1Click
  end
  object btnFMax: TButton
    Left = 8
    Top = 176
    Width = 81
    Height = 25
    Caption = #1060#1080#1083#1100#1090#1088' >'
    Enabled = False
    TabOrder = 1
    OnClick = btnFMaxClick
  end
  object Edit1: TEdit
    Left = 56
    Top = 112
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '10000'
  end
  object btnEffekt: TButton
    Left = 8
    Top = 208
    Width = 81
    Height = 25
    Caption = #1069#1092#1092#1077#1082#1090' 1'
    Enabled = False
    TabOrder = 3
    OnClick = btnEffektClick
  end
  object btnFMin: TButton
    Left = 112
    Top = 176
    Width = 81
    Height = 25
    Caption = #1060#1080#1083#1100#1090#1088' <'
    Enabled = False
    TabOrder = 4
    OnClick = btnFMinClick
  end
  object edSave: TEdit
    Left = 8
    Top = 144
    Width = 153
    Height = 21
    ReadOnly = True
    TabOrder = 5
    Text = 'D:\Study\Filter.wav'
  end
  object Button2: TButton
    Left = 112
    Top = 208
    Width = 83
    Height = 25
    Caption = #1069#1092#1092#1077#1082#1090' 2'
    TabOrder = 6
    OnClick = Button2Click
  end
  object OpenDialog: TOpenDialog
    Left = 160
    Top = 8
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'wav'
    Left = 8
    Top = 112
  end
end
