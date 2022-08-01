object TimeForm: TTimeForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1088#1077#1084#1103
  ClientHeight = 91
  ClientWidth = 179
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
  object lblSwmn: TLabel
    Left = 8
    Top = 8
    Width = 154
    Height = 13
    Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1088#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object btnOk: TButton
    Left = 96
    Top = 58
    Width = 75
    Height = 25
    Caption = #1054#1050
    Enabled = False
    TabOrder = 0
    OnClick = btnOkClick
  end
  object mskTime: TMaskEdit
    Left = 8
    Top = 27
    Width = 159
    Height = 21
    EditMask = '99.99.99;1;0'
    MaxLength = 8
    TabOrder = 1
    Text = '  .  .  '
    OnChange = mskTimeChange
  end
end
