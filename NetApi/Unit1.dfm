object Form1: TForm1
  Left = 245
  Top = 118
  BorderStyle = bsSingle
  Caption = 'Test'
  ClientHeight = 296
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 209
    Height = 145
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 0
  end
  object Button2: TButton
    Left = 8
    Top = 192
    Width = 209
    Height = 25
    Caption = 'NetWkstaUserGetInfo'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 224
    Width = 209
    Height = 25
    Caption = 'NetWkstaGetInfo'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 255
    Width = 225
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
  end
  object ServerName: TEdit
    Left = 8
    Top = 160
    Width = 209
    Height = 21
    TabOrder = 4
  end
end
