object frmBoardDemo: TfrmBoardDemo
  Left = 259
  Top = 342
  Width = 525
  Height = 228
  Caption = 'frmBoardDemo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 174
    Top = 8
    Width = 70
    Height = 22
    Caption = 'Invers'
    Flat = True
    OnClick = SpeedButton1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 89
    Height = 21
    TabOrder = 0
    Text = 'Text'
    OnChange = Edit1Change
  end
  object CheckBox1: TCheckBox
    Left = 103
    Top = 8
    Width = 65
    Height = 17
    Caption = 'AutoSize'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object ColorBox1: TColorBox
    Left = 250
    Top = 8
    Width = 128
    Height = 22
    ItemHeight = 16
    TabOrder = 2
    OnChange = ColorBox1Change
  end
  object ColorBox2: TColorBox
    Left = 384
    Top = 8
    Width = 127
    Height = 22
    ItemHeight = 16
    TabOrder = 3
    OnChange = ColorBox2Change
  end
end
