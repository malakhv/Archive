object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Version Generator'
  ClientHeight = 147
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnSave: TButton
    Left = 170
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object cbDate: TCheckBox
    Left = 8
    Top = 8
    Width = 49
    Height = 17
    Caption = #1044#1072#1090#1072
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object cbNumber: TCheckBox
    Left = 8
    Top = 58
    Width = 49
    Height = 17
    Caption = #1053#1086#1084#1077#1088
    TabOrder = 2
  end
  object edtNumber: TEdit
    Left = 8
    Top = 81
    Width = 237
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object dtpDate: TDateTimePicker
    Left = 8
    Top = 31
    Width = 237
    Height = 21
    Date = 39994.458848379640000000
    Time = 39994.458848379640000000
    TabOrder = 4
  end
  object btnLoad: TButton
    Left = 89
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 5
    OnClick = btnLoadClick
  end
  object btnGenerate: TButton
    Left = 8
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Generate'
    TabOrder = 6
    OnClick = btnGenerateClick
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'ver'
    Filter = 'Version File|*.ver|All Files|*.*'
    Left = 88
    Top = 8
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'ver'
    Filter = 'Version File|*.ver|All Files|*.*'
    Left = 152
    Top = 8
  end
end
