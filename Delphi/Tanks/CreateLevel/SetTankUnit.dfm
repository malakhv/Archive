object STForm: TSTForm
  Left = 258
  Top = 88
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1090#1072#1085#1082#1086#1074' ...'
  ClientHeight = 197
  ClientWidth = 274
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
  object Panel1: TPanel
    Left = 0
    Top = 156
    Width = 274
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 104
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 137
    Height = 156
    Align = alLeft
    Caption = #1058#1072#1085#1082'1 ...'
    TabOrder = 1
    object T1Image0: TImage
      Left = 96
      Top = 16
      Width = 32
      Height = 32
    end
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 24
      Width = 81
      Height = 17
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Flat = True
      OnClick = SpeedButton1Click
    end
    object Label1: TLabel
      Left = 8
      Top = 80
      Width = 50
      Height = 16
      Caption = #1046#1080#1079#1085#1100' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 104
      Width = 39
      Height = 16
      Caption = #1059#1088#1086#1085' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 128
      Width = 72
      Height = 16
      Caption = #1058#1080#1087' '#1090#1072#1085#1082#1072' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 8
      Top = 56
      Width = 43
      Height = 16
      Caption = #1053#1072#1087#1088'. :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object T1LivEdit: TSpinEdit
      Left = 88
      Top = 80
      Width = 41
      Height = 22
      MaxValue = 5
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnChange = T1LivEditChange
    end
    object T1YronEdit: TSpinEdit
      Left = 88
      Top = 104
      Width = 41
      Height = 22
      MaxValue = 5
      MinValue = 1
      TabOrder = 1
      Value = 1
      OnChange = T1YronEditChange
    end
    object T1TypeEdit: TSpinEdit
      Left = 88
      Top = 128
      Width = 41
      Height = 22
      MaxValue = 19
      MinValue = 10
      TabOrder = 2
      Value = 10
      OnChange = T1TypeEditChange
    end
    object T1NaprEdit: TSpinEdit
      Left = 88
      Top = 56
      Width = 41
      Height = 22
      MaxValue = 3
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 137
    Top = 0
    Width = 137
    Height = 156
    Align = alClient
    Caption = #1058#1072#1085#1082'2 ...'
    TabOrder = 2
    object T2Image0: TImage
      Left = 96
      Top = 16
      Width = 32
      Height = 32
    end
    object SpeedButton2: TSpeedButton
      Left = 8
      Top = 24
      Width = 81
      Height = 17
      Caption = #1053#1072#1087#1088'. 0'
      Flat = True
      OnClick = SpeedButton2Click
    end
    object Label4: TLabel
      Left = 8
      Top = 80
      Width = 50
      Height = 16
      Caption = #1046#1080#1079#1085#1100' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 104
      Width = 39
      Height = 16
      Caption = #1059#1088#1086#1085' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 128
      Width = 72
      Height = 16
      Caption = #1058#1080#1087' '#1090#1072#1085#1082#1072' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 56
      Width = 43
      Height = 16
      Caption = #1053#1072#1087#1088'. :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object T2LivEdit: TSpinEdit
      Left = 88
      Top = 80
      Width = 41
      Height = 22
      MaxValue = 5
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnChange = T2LivEditChange
    end
    object T2YronEdit: TSpinEdit
      Left = 88
      Top = 104
      Width = 41
      Height = 22
      MaxValue = 5
      MinValue = 1
      TabOrder = 1
      Value = 1
      OnChange = T2YronEditChange
    end
    object T2TypeEdit: TSpinEdit
      Left = 88
      Top = 128
      Width = 41
      Height = 22
      MaxValue = 30
      MinValue = 20
      TabOrder = 2
      Value = 20
      OnChange = T2TypeEditChange
    end
    object T2NaprEdit: TSpinEdit
      Left = 88
      Top = 56
      Width = 41
      Height = 22
      MaxValue = 3
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
  end
  object OpImageDialog: TOpenPictureDialog
    Left = 24
    Top = 280
  end
end
