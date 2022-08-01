object config: Tconfig
  Left = 299
  Top = 163
  BorderStyle = bsDialog
  Caption = 'Настройки программы'
  ClientHeight = 238
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 289
    Height = 193
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Данные'
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 124
        Height = 13
        Caption = 'Путь к папке с данными'
      end
      object dpe: TEdit
        Left = 8
        Top = 136
        Width = 265
        Height = 21
        TabOrder = 0
        Text = 'dpe'
      end
      object DirectoryListBox1: TDirectoryListBox
        Left = 8
        Top = 24
        Width = 265
        Height = 105
        ItemHeight = 16
        TabOrder = 1
        OnChange = DirectoryListBox1Change
        OnClick = DirectoryListBox1Click
      end
    end
  end
  object Button1: TButton
    Left = 120
    Top = 208
    Width = 75
    Height = 22
    Caption = 'Закрыть'
    TabOrder = 1
    OnClick = Button1Click
  end
end
