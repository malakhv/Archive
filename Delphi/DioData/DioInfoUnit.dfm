object DioInfoForm: TDioInfoForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 234
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 35
    Height = 13
    Caption = #1040#1076#1088#1077#1089':'
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 53
    Height = 13
    Caption = #1042#1083#1072#1076#1077#1083#1077#1094':'
  end
  object Label3: TLabel
    Left = 8
    Top = 100
    Width = 164
    Height = 13
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' 1:'
  end
  object Label4: TLabel
    Left = 8
    Top = 146
    Width = 164
    Height = 13
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' 2:'
  end
  object btnClose: TButton
    Left = 231
    Top = 201
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object btnOk: TButton
    Left = 150
    Top = 201
    Width = 75
    Height = 25
    Caption = #1054#1082
    TabOrder = 1
    OnClick = btnOkClick
  end
  object edAddress: TEdit
    Left = 8
    Top = 27
    Width = 298
    Height = 21
    TabOrder = 2
  end
  object edOwner: TEdit
    Left = 8
    Top = 73
    Width = 298
    Height = 21
    TabOrder = 3
  end
  object edRes01: TEdit
    Left = 8
    Top = 119
    Width = 298
    Height = 21
    TabOrder = 4
  end
  object edRes02: TEdit
    Left = 8
    Top = 165
    Width = 298
    Height = 21
    TabOrder = 5
  end
end
