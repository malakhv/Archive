object dtPreview44: TdtPreview44
  Left = 322
  Top = 171
  Width = 842
  Height = 567
  Caption = 'dtPreview44'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object qr2: TQuickRep
    Left = -2
    Top = -5
    Width = 794
    Height = 1123
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Frame.Style = psClear
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'SBAND1'
      'SBAND2'
      'QRSTRINGSBAND2'
      'SBM'
      'SMD'
      'SMB')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39
      #39#39
      #39#39
      #39#39
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      150
      2970
      100
      2100
      100
      50
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = First
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    object sband1: TQRStringsBand
      Left = 38
      Top = 167
      Width = 737
      Height = 22
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AfterPrint = sband1AfterPrint
      AlignToBottom = False
      BeforePrint = sband1BeforePrint
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        58.2083333333333
        1949.97916666667)
      Master = smd
      Items.Strings = (
        '12312312')
      PrintBefore = False
      object QRShape10: TQRShape
        Left = 703
        Top = -1
        Width = 34
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1860.02083333333
          -2.64583333333333
          89.9583333333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape9: TQRShape
        Left = 666
        Top = -1
        Width = 38
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1762.125
          -2.64583333333333
          100.541666666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape6: TQRShape
        Left = 294
        Top = -1
        Width = 73
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          777.875
          -2.64583333333333
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape5: TQRShape
        Left = 222
        Top = -1
        Width = 73
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          587.375
          -2.64583333333333
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape4: TQRShape
        Left = 182
        Top = -1
        Width = 41
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          481.541666666667
          -2.64583333333333
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape3: TQRShape
        Left = 142
        Top = -1
        Width = 41
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          375.708333333333
          -2.64583333333333
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape2: TQRShape
        Left = 64
        Top = -1
        Width = 79
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          169.333333333333
          -2.64583333333333
          209.020833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape1: TQRShape
        Left = 1
        Top = -1
        Width = 64
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          2.64583333333333
          -2.64583333333333
          169.333333333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object q1: TQRExpr
        Left = 2
        Top = 2
        Width = 61
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          5.29166666666667
          5.29166666666667
          161.395833333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object q2: TQRExpr
        Left = 67
        Top = 2
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          177.270833333333
          5.29166666666667
          193.145833333333)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object q3: TQRExpr
        Left = 144
        Top = 2
        Width = 35
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          381
          5.29166666666667
          92.6041666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object q4: TQRExpr
        Left = 184
        Top = 2
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          486.833333333333
          5.29166666666667
          95.25)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object q5: TQRExpr
        Left = 224
        Top = 2
        Width = 68
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          592.666666666667
          5.29166666666667
          179.916666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object q6: TQRExpr
        Left = 296
        Top = 2
        Width = 68
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          783.166666666667
          5.29166666666667
          179.916666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object QRShape8: TQRShape
        Left = 595
        Top = -1
        Width = 73
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1574.27083333333
          -2.64583333333333
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape36: TQRShape
        Left = 524
        Top = -1
        Width = 73
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1386.41666666667
          -2.64583333333333
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape41: TQRShape
        Left = 484
        Top = -1
        Width = 41
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1280.58333333333
          -2.64583333333333
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape42: TQRShape
        Left = 444
        Top = -1
        Width = 41
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1174.75
          -2.64583333333333
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape43: TQRShape
        Left = 366
        Top = -1
        Width = 79
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          968.375
          -2.64583333333333
          209.020833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRExpr2: TQRExpr
        Left = 368
        Top = 2
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          973.666666666667
          5.29166666666667
          193.145833333333)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object QRExpr3: TQRExpr
        Left = 446
        Top = 2
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1180.04166666667
          5.29166666666667
          95.25)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object QRExpr4: TQRExpr
        Left = 486
        Top = 2
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1285.875
          5.29166666666667
          95.25)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object QRExpr6: TQRExpr
        Left = 526
        Top = 2
        Width = 68
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1391.70833333333
          5.29166666666667
          179.916666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object QRExpr7: TQRExpr
        Left = 598
        Top = 2
        Width = 66
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1582.20833333333
          5.29166666666667
          174.625)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object QRExpr8: TQRExpr
        Left = 669
        Top = 2
        Width = 31
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1770.0625
          5.29166666666667
          82.0208333333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
      object QRExpr9: TQRExpr
        Left = 705
        Top = 2
        Width = 30
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1865.3125
          5.29166666666667
          79.375)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = q1Print
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'sband1'
        FontSize = 8
      end
    end
    object smd: TQRStringsBand
      Left = 38
      Top = 38
      Width = 737
      Height = 129
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AfterPrint = smdAfterPrint
      AlignToBottom = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ForceNewColumn = False
      ForceNewPage = True
      ParentFont = False
      Size.Values = (
        341.3125
        1949.97916666667)
      Master = qr2
      PrintBefore = False
      object QRExpr1: TQRExpr
        Left = 0
        Top = 46
        Width = 537
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          0
          121.708333333333
          1420.8125)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'smd'
        FontSize = 8
      end
      object QRLabel1: TQRLabel
        Left = 0
        Top = 0
        Width = 290
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          0
          0
          767.291666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = #1057#1091#1090#1086#1095#1085#1099#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103' DIO-99M (4V4T)'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 12
      end
      object QRShape21: TQRShape
        Left = 1
        Top = 65
        Width = 64
        Height = 64
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Frame.Style = psClear
        Size.Values = (
          169.333333333333
          2.64583333333333
          171.979166666667
          169.333333333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel12: TQRLabel
        Left = 7
        Top = 89
        Width = 51
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          18.5208333333333
          235.479166666667
          134.9375)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1044#1072#1090#1072
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape22: TQRShape
        Left = 64
        Top = 97
        Width = 79
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          169.333333333333
          256.645833333333
          209.020833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel13: TQRLabel
        Left = 68
        Top = 106
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          179.916666666667
          280.458333333333
          193.145833333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Q, '#1043#1050#1072#1083
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape23: TQRShape
        Left = 142
        Top = 97
        Width = 41
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          375.708333333333
          256.645833333333
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel14: TQRLabel
        Left = 143
        Top = 106
        Width = 37
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          378.354166666667
          280.458333333333
          97.8958333333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 't1, oC'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape24: TQRShape
        Left = 182
        Top = 97
        Width = 41
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          481.541666666667
          256.645833333333
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape25: TQRShape
        Left = 222
        Top = 97
        Width = 73
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          587.375
          256.645833333333
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel16: TQRLabel
        Left = 230
        Top = 104
        Width = 57
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          55.5625
          608.541666666667
          275.166666666667
          150.8125)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'V1, '#1084'3'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape26: TQRShape
        Left = 294
        Top = 97
        Width = 73
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          777.875
          256.645833333333
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel17: TQRLabel
        Left = 302
        Top = 104
        Width = 57
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          799.041666666667
          275.166666666667
          150.8125)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'V2, '#1084'3'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape29: TQRShape
        Left = 667
        Top = 65
        Width = 38
        Height = 64
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          169.333333333333
          1764.77083333333
          171.979166666667
          100.541666666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape30: TQRShape
        Left = 703
        Top = 65
        Width = 34
        Height = 64
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          169.333333333333
          1860.02083333333
          171.979166666667
          89.9583333333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel23: TQRLabel
        Left = 184
        Top = 106
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          486.833333333333
          280.458333333333
          95.25)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 't2, oC'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object hrSNum: TQRLabel
        Left = 528
        Top = 0
        Width = 209
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          1397
          0
          552.979166666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '123123'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 12
      end
      object QRShape35: TQRShape
        Left = 64
        Top = 65
        Width = 303
        Height = 33
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          87.3125
          169.333333333333
          171.979166666667
          801.6875)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel22: TQRLabel
        Left = 706
        Top = 91
        Width = 28
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1867.95833333333
          240.770833333333
          74.0833333333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1041#1072#1090'.'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape27: TQRShape
        Left = 366
        Top = 97
        Width = 79
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          968.375
          256.645833333333
          209.020833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel5: TQRLabel
        Left = 373
        Top = 106
        Width = 73
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          986.895833333333
          280.458333333333
          193.145833333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Q, '#1043#1050#1072#1083
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape28: TQRShape
        Left = 444
        Top = 97
        Width = 41
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          1174.75
          256.645833333333
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel6: TQRLabel
        Left = 445
        Top = 106
        Width = 37
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1177.39583333333
          280.458333333333
          97.8958333333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 't1, oC'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape37: TQRShape
        Left = 484
        Top = 97
        Width = 41
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          1280.58333333333
          256.645833333333
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape38: TQRShape
        Left = 524
        Top = 97
        Width = 73
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          1386.41666666667
          256.645833333333
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel7: TQRLabel
        Left = 531
        Top = 104
        Width = 57
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          55.5625
          1404.9375
          275.166666666667
          150.8125)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'V1, '#1084'3'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape39: TQRShape
        Left = 596
        Top = 97
        Width = 72
        Height = 32
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          84.6666666666667
          1576.91666666667
          256.645833333333
          190.5)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel8: TQRLabel
        Left = 603
        Top = 104
        Width = 57
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.9166666666667
          1595.4375
          275.166666666667
          150.8125)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'V2, '#1084'3'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel9: TQRLabel
        Left = 485
        Top = 106
        Width = 37
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1283.22916666667
          280.458333333333
          97.8958333333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 't2, oC'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape40: TQRShape
        Left = 366
        Top = 65
        Width = 302
        Height = 33
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          87.3125
          968.375
          171.979166666667
          799.041666666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel10: TQRLabel
        Left = 668
        Top = 91
        Width = 34
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1767.41666666667
          240.770833333333
          89.9583333333333)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Caption = 't '#1086#1082#1088'.'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel11: TQRLabel
        Left = 95
        Top = 73
        Width = 234
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          251.354166666667
          193.145833333333
          619.125)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1050#1086#1085#1090#1091#1088' 1'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRLabel15: TQRLabel
        Left = 399
        Top = 73
        Width = 234
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1055.6875
          193.145833333333
          619.125)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1050#1086#1085#1090#1091#1088' 2'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object qrInf: TQRLabel
        Left = 0
        Top = 24
        Width = 737
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.6875
          0
          63.5
          1949.97916666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'qrInf'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
    end
    object QRSysData1: TQRSysData
      Left = 712
      Top = 1064
      Width = 46
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.9791666666667
        1883.83333333333
        2815.16666666667
        121.708333333333)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      Color = clWhite
      Data = qrsPageNumber
      Transparent = False
      FontSize = 10
    end
    object smb: TQRStringsBand
      Left = 38
      Top = 189
      Width = 737
      Height = 115
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AfterPrint = smbAfterPrint
      AlignToBottom = False
      BeforePrint = smbBeforePrint
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        304.270833333333
        1949.97916666667)
      Master = smd
      PrintBefore = False
      object QRShape17: TQRShape
        Left = 366
        Top = 21
        Width = 80
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          968.375
          55.5625
          211.666666666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape45: TQRShape
        Left = 445
        Top = 65
        Width = 41
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1177.39583333333
          171.979166666667
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape33: TQRShape
        Left = 224
        Top = 65
        Width = 222
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          592.666666666667
          171.979166666667
          587.375)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape31: TQRShape
        Left = 184
        Top = 65
        Width = 41
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          486.833333333333
          171.979166666667
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape20: TQRShape
        Left = 143
        Top = 65
        Width = 42
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          378.354166666667
          171.979166666667
          111.125)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape19: TQRShape
        Left = 664
        Top = 21
        Width = 73
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1756.83333333333
          55.5625
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape18: TQRShape
        Left = 525
        Top = 21
        Width = 73
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1389.0625
          55.5625
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape16: TQRShape
        Left = 294
        Top = 21
        Width = 73
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          777.875
          55.5625
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape15: TQRShape
        Left = 222
        Top = 21
        Width = 73
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          587.375
          55.5625
          193.145833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape14: TQRShape
        Left = 142
        Top = 21
        Width = 81
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          375.708333333333
          55.5625
          214.3125)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape13: TQRShape
        Left = 64
        Top = 21
        Width = 79
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          169.333333333333
          55.5625
          209.020833333333)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape12: TQRShape
        Left = 0
        Top = 21
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          0
          55.5625
          171.979166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape11: TQRShape
        Left = 0
        Top = -1
        Width = 737
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          0
          -2.64583333333333
          1949.97916666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRExpr10: TQRExpr
        Left = 67
        Top = 24
        Width = 69
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          177.270833333333
          63.5
          182.5625)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRExpr11: TQRExpr
        Left = 145
        Top = 68
        Width = 37
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          42.3333333333333
          383.645833333333
          179.916666666667
          97.8958333333333)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRExpr12: TQRExpr
        Left = 185
        Top = 68
        Width = 37
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          489.479166666667
          179.916666666667
          97.8958333333333)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRExpr13: TQRExpr
        Left = 226
        Top = 24
        Width = 65
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          42.3333333333333
          597.958333333333
          63.5
          171.979166666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRExpr14: TQRExpr
        Left = 298
        Top = 24
        Width = 65
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          42.3333333333333
          788.458333333333
          63.5
          171.979166666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRLabel3: TQRLabel
        Left = 5
        Top = 2
        Width = 227
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          13.2291666666667
          5.29166666666667
          600.604166666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = #1048#1090#1086#1075#1086#1074#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1079#1072' '#1086#1090#1095#1077#1090#1085#1099#1081' '#1087#1077#1088#1080#1086#1076':'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape32: TQRShape
        Left = 0
        Top = 65
        Width = 144
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          0
          171.979166666667
          381)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape34: TQRShape
        Left = 0
        Top = 43
        Width = 737
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          0
          113.770833333333
          1949.97916666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRLabel4: TQRLabel
        Left = 5
        Top = 46
        Width = 226
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          13.2291666666667
          121.708333333333
          597.958333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = #1057#1088#1077#1076#1085#1080#1077' '#1079#1085#1072#1095#1077#1085#1080#1103'  '#1079#1072' '#1086#1090#1095#1077#1090#1085#1099#1081' '#1087#1077#1088#1080#1086#1076':'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 8
      end
      object QRShape7: TQRShape
        Left = 525
        Top = 65
        Width = 212
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1389.0625
          171.979166666667
          560.916666666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRShape44: TQRShape
        Left = 485
        Top = 65
        Width = 41
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          60.8541666666667
          1283.22916666667
          171.979166666667
          108.479166666667)
        Pen.Width = 2
        Shape = qrsRectangle
      end
      object QRExpr5: TQRExpr
        Left = 368
        Top = 23
        Width = 74
        Height = 16
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          42.3333333333333
          973.666666666667
          60.8541666666667
          195.791666666667)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRExpr15: TQRExpr
        Left = 447
        Top = 68
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1182.6875
          179.916666666667
          95.25)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRExpr16: TQRExpr
        Left = 487
        Top = 68
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1288.52083333333
          179.916666666667
          95.25)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRExpr17: TQRExpr
        Left = 528
        Top = 24
        Width = 66
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1397
          63.5
          174.625)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
      object QRExpr18: TQRExpr
        Left = 599
        Top = 24
        Width = 63
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1584.85416666667
          63.5
          166.6875)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        OnPrint = dtTotalPrint
        ResetAfterPrint = False
        Transparent = False
        WordWrap = True
        Expression = 'SMB'
        FontSize = 8
      end
    end
  end
end
