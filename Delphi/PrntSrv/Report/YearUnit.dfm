object YearForm: TYearForm
  Left = 398
  Top = 132
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1043#1086#1076
  ClientHeight = 64
  ClientWidth = 146
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
  object btnOK: TSpeedButton
    Left = 64
    Top = 40
    Width = 73
    Height = 17
    Caption = #1054#1050
    Flat = True
    OnClick = btnOKClick
  end
  object YearBox: TComboBox
    Left = 8
    Top = 8
    Width = 129
    Height = 21
    BevelInner = bvLowered
    BevelOuter = bvRaised
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = '2000'
    Items.Strings = (
      '2000'
      '2001'
      '2002'
      '2003'
      '2004'
      '2005'
      '2006'
      '2007'
      '2008'
      '2009'
      '2010'
      '2011'
      '2012'
      '2013'
      '2014'
      '2015'
      '2016'
      '2017'
      '2018'
      '2019'
      '2020')
  end
end
