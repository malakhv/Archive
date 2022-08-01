object frmGetValue: TfrmGetValue
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 93
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblName: TLabel
    Left = 8
    Top = 8
    Width = 23
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object btnCancel: TSpeedButton
    Left = 192
    Top = 60
    Width = 63
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    OnClick = btnCancelClick
  end
  object btnOk: TSpeedButton
    Left = 123
    Top = 60
    Width = 63
    Height = 25
    Caption = #1054#1050
    OnClick = btnOkClick
  end
  object edValue: TEdit
    Left = 8
    Top = 24
    Width = 247
    Height = 21
    TabOrder = 0
  end
end
