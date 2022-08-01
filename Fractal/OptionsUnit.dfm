object OptionsForm: TOptionsForm
  Left = 279
  Top = 126
  Width = 300
  Height = 244
  Caption = 'OptionsForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 109
    Height = 16
    Caption = #1042#1080#1076' '#1091#1088#1072#1074#1085#1077#1085#1080#1081' : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 139
    Height = 16
    Caption = 'X = KX * (X*X - Y*Y + P0)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 122
    Height = 16
    Caption = 'Y = KY * (2*X*Y+ Q0 )'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 88
    Width = 22
    Height = 16
    Caption = 'KX :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 120
    Width = 17
    Height = 16
    Caption = 'KY'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 136
    Top = 88
    Width = 45
    Height = 16
    Caption = #1064#1072#1075' K : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 169
    Width = 292
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object btnCansel: TBitBtn
      Left = 208
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkCancel
    end
    object btnOK: TBitBtn
      Left = 128
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkOK
    end
  end
  object edKX: TEdit
    Left = 32
    Top = 88
    Width = 81
    Height = 21
    TabOrder = 1
    Text = '0,9'
  end
  object edKY: TEdit
    Left = 32
    Top = 120
    Width = 81
    Height = 21
    TabOrder = 2
    Text = '-0,958'
  end
  object edShag: TEdit
    Left = 184
    Top = 88
    Width = 65
    Height = 21
    TabOrder = 3
    Text = '10'
  end
end
