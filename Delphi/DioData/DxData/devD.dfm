object devDescr: TdevDescr
  Left = 195
  Top = 350
  BorderStyle = bsDialog
  Caption = 'Описание прибора'
  ClientHeight = 115
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 0
    Width = 31
    Height = 13
    Caption = 'Адрес'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 181
    Height = 13
    Caption = 'Владелец (или ответственное лицо)'
  end
  object Button1: TButton
    Left = 176
    Top = 88
    Width = 75
    Height = 21
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button1Click
  end
  object addrEdit: TEdit
    Left = 8
    Top = 16
    Width = 321
    Height = 19
    TabOrder = 0
  end
  object ownerEdit: TEdit
    Left = 8
    Top = 56
    Width = 321
    Height = 19
    TabOrder = 1
  end
  object Button2: TButton
    Left = 88
    Top = 87
    Width = 75
    Height = 21
    Caption = 'Сохранить'
    ModalResult = 1
    TabOrder = 3
    OnClick = Button2Click
  end
end
