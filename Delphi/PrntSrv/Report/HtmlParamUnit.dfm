object HtmlParamForm: THtmlParamForm
  Left = 368
  Top = 153
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1101#1082#1089#1087#1086#1088#1090#1072'...'
  ClientHeight = 308
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnPanel: TPanel
    Left = 0
    Top = 267
    Width = 289
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object btnOk: TSpeedButton
      Left = 128
      Top = 8
      Width = 73
      Height = 25
      Caption = #1054#1050
      Enabled = False
      Flat = True
      OnClick = btnOkClick
    end
    object btnCancel: TSpeedButton
      Left = 208
      Top = 8
      Width = 73
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Flat = True
      OnClick = btnCancelClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 289
    Height = 105
    Align = alTop
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082': '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 13
      Caption = #1058#1077#1082#1089#1090':'
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 78
      Height = 13
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077':'
    end
    object Label3: TLabel
      Left = 136
      Top = 56
      Width = 28
      Height = 13
      Caption = #1062#1074#1077#1090':'
    end
    object HeadEdit: TEdit
      Left = 8
      Top = 32
      Width = 273
      Height = 21
      TabOrder = 0
      Text = #1054#1090#1095#1077#1090
    end
    object AlignBox: TComboBox
      Left = 8
      Top = 72
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = #1055#1086' '#1094#1077#1085#1090#1088#1091
      Items.Strings = (
        #1055#1086' '#1094#1077#1085#1090#1088#1091
        #1055#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
        #1055#1086' '#1087#1088#1072#1074#1072#1084#1091' '#1082#1088#1072#1102)
    end
    object HeadColor: TColorBox
      Left = 136
      Top = 72
      Width = 145
      Height = 22
      ItemHeight = 16
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 105
    Width = 289
    Height = 111
    Align = alClient
    Caption = #1058#1072#1073#1083#1080#1094#1072': '
    TabOrder = 2
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 26
      Height = 13
      Caption = #1060#1086#1085':'
    end
    object Label5: TLabel
      Left = 8
      Top = 64
      Width = 36
      Height = 13
      Caption = #1056#1072#1084#1082#1072':'
    end
    object Label6: TLabel
      Left = 64
      Top = 64
      Width = 78
      Height = 13
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077':'
    end
    object Label7: TLabel
      Left = 152
      Top = 16
      Width = 84
      Height = 13
      Caption = #1062#1074#1077#1090' '#1079#1072#1075#1086#1083#1086#1074#1082#1072':'
    end
    object TableBgColor: TColorBox
      Left = 8
      Top = 32
      Width = 137
      Height = 22
      DefaultColorColor = clWhite
      Selected = clWhite
      ItemHeight = 16
      TabOrder = 0
    end
    object TableBorder: TSpinEdit
      Left = 8
      Top = 80
      Width = 49
      Height = 22
      MaxValue = 255
      MinValue = 0
      TabOrder = 1
      Value = 1
    end
    object TableAlBox: TComboBox
      Left = 64
      Top = 80
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 2
      Text = #1055#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
      Items.Strings = (
        #1055#1086' '#1094#1077#1085#1090#1088#1091
        #1055#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
        #1055#1086' '#1087#1088#1072#1074#1072#1084#1091' '#1082#1088#1072#1102)
    end
    object TableHeadColor: TColorBox
      Left = 152
      Top = 32
      Width = 129
      Height = 22
      DefaultColorColor = clWhite
      Selected = clSilver
      ItemHeight = 16
      TabOrder = 3
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 216
    Width = 289
    Height = 51
    Align = alBottom
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
    TabOrder = 3
    object btnSelectPath: TSpeedButton
      Left = 256
      Top = 16
      Width = 23
      Height = 22
      Flat = True
      OnClick = btnSelectPathClick
    end
    object PathEdit: TEdit
      Left = 8
      Top = 16
      Width = 241
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'html'
    Filter = 'HTML File (*.html, *.htm)|*.html; *.htm|All Files|*.*'
    Left = 8
    Top = 232
  end
end
