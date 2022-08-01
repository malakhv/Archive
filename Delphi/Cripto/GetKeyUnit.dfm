object GetKeyForm: TGetKeyForm
  Left = 0
  Top = 0
  Width = 223
  Height = 117
  Caption = 'GetKeyForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnCansel: TBitBtn
    Left = 136
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkCancel
  end
  object btnOK: TBitBtn
    Left = 48
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object edKey: TEdit
    Left = 8
    Top = 16
    Width = 201
    Height = 21
    TabOrder = 2
    Text = #1082#1083#1102#1095
    OnChange = edKeyChange
  end
end
