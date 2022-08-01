object TimeForm: TTimeForm
  Left = 605
  Top = 132
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1042#1088#1077#1084#1103
  ClientHeight = 127
  ClientWidth = 185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    185
    127)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancel: TSpeedButton
    Left = 120
    Top = 96
    Width = 57
    Height = 22
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1084#1077#1085#1072
    Flat = True
    OnClick = btnCancelClick
  end
  object btnOK: TSpeedButton
    Left = 56
    Top = 96
    Width = 57
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Flat = True
    OnClick = btnOKClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 169
    Height = 81
    TabOrder = 0
    object dpT1: TDateTimePicker
      Left = 8
      Top = 16
      Width = 153
      Height = 21
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BevelKind = bkFlat
      Date = 39161.375000000000000000
      Format = 'HH:mm'
      Time = 39161.375000000000000000
      DateMode = dmUpDown
      Kind = dtkTime
      TabOrder = 0
      OnChange = dpT1Change
    end
    object dpT2: TDateTimePicker
      Left = 8
      Top = 48
      Width = 153
      Height = 21
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BevelKind = bkFlat
      Date = 39161.708333333340000000
      Format = 'HH:mm'
      Time = 39161.708333333340000000
      DateMode = dmUpDown
      Kind = dtkTime
      TabOrder = 1
    end
  end
end
