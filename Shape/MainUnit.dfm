object MainForm: TMainForm
  Left = 151
  Top = 119
  Width = 770
  Height = 490
  Caption = #1052#1072#1083#1072#1093#1086#1074' '#1052#1080#1093#1072#1080#1083' '#1050#1042#1058' - 033'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 155
    Height = 403
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object ListBox: TListBox
      Left = 2
      Top = 2
      Width = 151
      Height = 357
      Align = alClient
      Color = clSkyBlue
      ItemHeight = 13
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 2
      Top = 359
      Width = 151
      Height = 42
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 1
      object SpeedButton3: TSpeedButton
        Left = 8
        Top = 11
        Width = 137
        Height = 22
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1060#1072#1081#1083#1099' '#1060#1080#1075#1091#1088#1099
        Flat = True
        OnClick = SpeedButton3Click
      end
    end
  end
  object ShapePanel: TPanel
    Left = 155
    Top = 41
    Width = 607
    Height = 403
    Cursor = crCross
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clInfoBk
    TabOrder = 1
    OnMouseMove = ShapePanelMouseMove
    OnMouseUp = ShapePanelMouseUp
    object PaintBox1: TPaintBox
      Left = 2
      Top = 2
      Width = 603
      Height = 399
      Align = alClient
      OnMouseMove = ShapePanelMouseMove
      OnMouseUp = ShapePanelMouseUp
      OnPaint = PaintBox1Paint
    end
  end
  object ToolBar: TPanel
    Left = 0
    Top = 0
    Width = 762
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object lblX: TLabel
      Left = 168
      Top = 16
      Width = 24
      Height = 13
      Caption = '0000'
    end
    object lblY: TLabel
      Left = 200
      Top = 16
      Width = 24
      Height = 13
      Caption = '0000'
    end
    object Bevel2: TBevel
      Left = 160
      Top = 8
      Width = 73
      Height = 25
    end
    object SpeedButton2: TSpeedButton
      Left = 472
      Top = 8
      Width = 89
      Height = 22
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1058#1086#1095#1082#1091
      Flat = True
      OnClick = SpeedButton2Click
    end
    object lblIndex: TLabel
      Left = 264
      Top = 16
      Width = 12
      Height = 13
      Caption = '00'
    end
    object Bevel3: TBevel
      Left = 240
      Top = 8
      Width = 113
      Height = 25
    end
    object Label3: TLabel
      Left = 248
      Top = 16
      Width = 14
      Height = 13
      Caption = #8470' '
    end
    object lblInfoX: TLabel
      Left = 288
      Top = 16
      Width = 24
      Height = 13
      Caption = '0000'
    end
    object lblInfoY: TLabel
      Left = 320
      Top = 16
      Width = 24
      Height = 13
      Caption = '0000'
    end
    object Bevel4: TBevel
      Left = 144
      Top = 8
      Width = 10
      Height = 26
      Shape = bsRightLine
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 7
      Height = 13
      Caption = 'X'
    end
    object Label2: TLabel
      Left = 72
      Top = 8
      Width = 7
      Height = 13
      Caption = 'Y'
    end
    object SpeedButton1: TSpeedButton
      Left = 664
      Top = 8
      Width = 23
      Height = 22
      Visible = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton4: TSpeedButton
      Left = 704
      Top = 8
      Width = 23
      Height = 22
      Visible = False
      OnClick = SpeedButton4Click
    end
    object edAddX: TEdit
      Left = 400
      Top = 8
      Width = 33
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object edAddY: TEdit
      Left = 432
      Top = 8
      Width = 33
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object chRebro: TCheckBox
      Left = 568
      Top = 8
      Width = 81
      Height = 17
      Caption = #1057#1086#1079#1076#1072#1074#1072#1090#1100' '#1088#1077#1073#1088#1072
      Checked = True
      State = cbChecked
      TabOrder = 2
      Visible = False
    end
    object edX: TEdit
      Left = 24
      Top = 8
      Width = 33
      Height = 21
      TabOrder = 3
      Text = '0'
    end
    object edY: TEdit
      Left = 88
      Top = 8
      Width = 33
      Height = 21
      TabOrder = 4
      Text = '0'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 444
    Width = 762
    Height = 19
    Panels = <>
  end
end
