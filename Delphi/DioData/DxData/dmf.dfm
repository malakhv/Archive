object dampForm: TdampForm
  Left = 488
  Top = 366
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Дамп памяти архива'
  ClientHeight = 233
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 41
    Height = 13
    Caption = 'Flash #0'
  end
  object Label2: TLabel
    Left = 0
    Top = 120
    Width = 41
    Height = 13
    Caption = 'Flash #1'
  end
  object dm: TMemo
    Left = 0
    Top = 136
    Width = 406
    Height = 97
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'dm')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object dm1: TMemo
    Left = 0
    Top = 16
    Width = 406
    Height = 97
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'dm')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
