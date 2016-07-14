object frmMain: TfrmMain
  Left = 1494
  Top = 318
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
  ClientHeight = 322
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pcTabs: TPageControl
    Left = 0
    Top = 0
    Width = 650
    Height = 322
    ActivePage = tabSimple
    Align = alClient
    Style = tsButtons
    TabOrder = 0
    TabStop = False
    TabWidth = 80
    OnChange = pcTabsChange
    object tabSimple: TTabSheet
      Caption = #1054#1073#1099#1095#1085#1099#1081
      object panelExtended: TPanel
        Left = 0
        Top = 0
        Width = 153
        Height = 291
        Align = alLeft
        TabOrder = 0
        Visible = False
        object btnEuler: TSpeedButton
          Left = 8
          Top = 8
          Width = 55
          Height = 32
          Caption = 'e'
          OnClick = btnEulerClick
        end
        object btnPi: TSpeedButton
          Left = 80
          Top = 8
          Width = 55
          Height = 32
          Caption = 'Pi'
          OnClick = btnPiClick
        end
        object btnSqr: TSpeedButton
          Left = 80
          Top = 56
          Width = 55
          Height = 32
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
          Caption = 'x^2'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSqrClick
        end
        object btnXPowerY: TSpeedButton
          Left = 8
          Top = 56
          Width = 55
          Height = 32
          Caption = 'x^y'
          OnClick = btnXPowerYClick
        end
        object btnSqrt: TSpeedButton
          Left = 80
          Top = 104
          Width = 55
          Height = 32
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
          Caption = 'x^(1/2)'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSqrtClick
        end
        object btnXRootY: TSpeedButton
          Left = 8
          Top = 104
          Width = 55
          Height = 32
          Caption = 'x^(1/y)'
          OnClick = btnXRootYClick
        end
        object btnLn: TSpeedButton
          Left = 8
          Top = 152
          Width = 55
          Height = 32
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
          Caption = 'ln'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnLnClick
        end
        object btn1DivX: TSpeedButton
          Left = 80
          Top = 152
          Width = 55
          Height = 32
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
          Caption = '1/x'
          ParentShowHint = False
          ShowHint = True
          OnClick = btn1DivXClick
        end
        object btnLog: TSpeedButton
          Left = 8
          Top = 200
          Width = 55
          Height = 32
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
          Caption = 'log'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnLogClick
        end
        object btnLg: TSpeedButton
          Left = 80
          Top = 200
          Width = 55
          Height = 32
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
          Caption = 'lg'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnLgClick
        end
        object btnCos: TSpeedButton
          Left = 80
          Top = 248
          Width = 55
          Height = 32
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
          Caption = 'cos'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCosClick
        end
        object btnSin: TSpeedButton
          Left = 8
          Top = 248
          Width = 55
          Height = 32
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
          Caption = 'sin'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSinClick
        end
      end
      object panelHistory: TPanel
        Left = 392
        Top = 0
        Width = 250
        Height = 291
        Align = alRight
        TabOrder = 1
        Visible = False
        object lvHistory: TListView
          Left = 1
          Top = 25
          Width = 248
          Height = 265
          Hint = #1053#1072#1078#1084#1080#1090#1077' '#1085#1072' '#1101#1083#1077#1084#1077#1085#1090' '#1074' '#1080#1089#1090#1086#1088#1080#1080', '#1095#1090#1086#1073#1099' '#1074#1077#1088#1085#1091#1090#1100' '#1077#1075#1086' '#1074' '#1087#1086#1083#1077' '#1074#1074#1086#1076#1072
          Align = alClient
          Columns = <
            item
              Caption = #1042#1099#1088#1072#1078#1077#1085#1080#1077
              Width = 130
            end
            item
              Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
              Width = 94
            end>
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TabStop = False
          ViewStyle = vsReport
          OnEnter = lvHistoryEnter
          OnSelectItem = lvHistorySelectItem
        end
        object panelHistoryTitle: TPanel
          Left = 1
          Top = 1
          Width = 248
          Height = 24
          Align = alTop
          TabOrder = 1
          object labelHistory: TLabel
            Left = 1
            Top = 1
            Width = 120
            Height = 22
            Align = alLeft
            Alignment = taCenter
            AutoSize = False
            Caption = #1048#1089#1090#1086#1088#1080#1103
            Layout = tlCenter
          end
          object labelHistoryClear: TSpeedButton
            Left = 120
            Top = 0
            Width = 129
            Height = 25
            Caption = #1054#1095#1080#1089#1090#1080#1090#1100
            OnClick = btnClearHistoryClick
          end
        end
      end
      object panelMain: TPanel
        Left = 153
        Top = 0
        Width = 239
        Height = 291
        Align = alClient
        TabOrder = 2
        object labelLeftArrow: TLabel
          Left = 1
          Top = 1
          Width = 9
          Height = 289
          Align = alLeft
          AutoSize = False
          Caption = '<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          OnClick = labelLeftArrowClick
        end
        object labelRightArrow: TLabel
          Left = 229
          Top = 1
          Width = 9
          Height = 289
          Align = alRight
          Caption = '>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          OnClick = labelRightArrowClick
        end
        object panelMainNoArrows: TPanel
          Left = 10
          Top = 1
          Width = 219
          Height = 289
          Align = alClient
          TabOrder = 0
          object btn7: TSpeedButton
            Left = 8
            Top = 116
            Width = 44
            Height = 32
            Caption = '7'
            OnClick = btn7Click
          end
          object btn8: TSpeedButton
            Left = 61
            Top = 116
            Width = 44
            Height = 32
            Caption = '8'
            OnClick = btn8Click
          end
          object btn9: TSpeedButton
            Left = 114
            Top = 116
            Width = 44
            Height = 32
            Caption = '9'
            OnClick = btn9Click
          end
          object btnMul: TSpeedButton
            Left = 168
            Top = 116
            Width = 44
            Height = 32
            Caption = '*'
            OnClick = btnMulClick
          end
          object btnSub: TSpeedButton
            Left = 168
            Top = 160
            Width = 44
            Height = 32
            Caption = '-'
            OnClick = btnSubClick
          end
          object btn4: TSpeedButton
            Left = 8
            Top = 160
            Width = 44
            Height = 32
            Caption = '4'
            OnClick = btn4Click
          end
          object btn5: TSpeedButton
            Left = 61
            Top = 160
            Width = 44
            Height = 32
            Caption = '5'
            OnClick = btn5Click
          end
          object btn6: TSpeedButton
            Left = 114
            Top = 160
            Width = 44
            Height = 32
            Caption = '6'
            OnClick = btn6Click
          end
          object btnAdd: TSpeedButton
            Left = 168
            Top = 204
            Width = 44
            Height = 32
            Caption = '+'
            OnClick = btnAddClick
          end
          object btn1: TSpeedButton
            Left = 8
            Top = 204
            Width = 44
            Height = 32
            Caption = '1'
            OnClick = btn1Click
          end
          object btn2: TSpeedButton
            Left = 61
            Top = 204
            Width = 44
            Height = 32
            Caption = '2'
            OnClick = btn2Click
          end
          object btn3: TSpeedButton
            Left = 114
            Top = 204
            Width = 44
            Height = 32
            Caption = '3'
            OnClick = btn3Click
          end
          object btnEqual: TSpeedButton
            Left = 168
            Top = 248
            Width = 44
            Height = 32
            Caption = '='
            OnClick = btnEqualClick
          end
          object btn0: TSpeedButton
            Left = 8
            Top = 248
            Width = 44
            Height = 32
            Caption = '0'
            OnClick = btn0Click
          end
          object btnChangeSign: TSpeedButton
            Left = 61
            Top = 248
            Width = 44
            Height = 32
            Hint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1087#1077#1088#1072#1085#1076', '#1072' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
            Caption = '+/-'
            ParentShowHint = False
            ShowHint = True
            OnClick = btnChangeSignClick
          end
          object btnDot: TSpeedButton
            Left = 114
            Top = 248
            Width = 44
            Height = 32
            Caption = '.'
            OnClick = btnDotClick
          end
          object btnDiv: TSpeedButton
            Left = 168
            Top = 72
            Width = 44
            Height = 32
            Caption = '/'
            OnClick = btnDivClick
          end
          object btnCE: TSpeedButton
            Left = 8
            Top = 72
            Width = 44
            Height = 32
            Caption = 'CE'
            OnClick = btnCEClick
          end
          object btnC: TSpeedButton
            Left = 61
            Top = 72
            Width = 44
            Height = 32
            Caption = 'C'
            OnClick = btnCClick
          end
          object btnBackspace: TSpeedButton
            Left = 114
            Top = 72
            Width = 44
            Height = 32
            Caption = 'Back'
            OnClick = btnBackspaceClick
          end
          object panelOutput: TPanel
            Left = 1
            Top = 1
            Width = 217
            Height = 62
            Align = alTop
            TabOrder = 0
            object sgOutput: TStringGrid
              Left = 1
              Top = 1
              Width = 215
              Height = 60
              TabStop = False
              Align = alClient
              BorderStyle = bsNone
              ColCount = 1
              DefaultColWidth = 215
              DefaultRowHeight = 29
              DefaultDrawing = False
              Enabled = False
              FixedCols = 0
              RowCount = 2
              FixedRows = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Lucida Bright'
              Font.Style = []
              Options = [goFixedHorzLine, goHorzLine]
              ParentFont = False
              ScrollBars = ssNone
              TabOrder = 0
              OnDrawCell = sgOutputDrawCell
              OnEnter = sgOutputEnter
            end
          end
        end
      end
    end
    object tabBit: TTabSheet
      Caption = #1050#1086#1085#1074#1077#1088#1090#1077#1088
      ImageIndex = 1
      object bbtn7: TSpeedButton
        Tag = 1
        Left = 6
        Top = 128
        Width = 57
        Height = 25
        Caption = '7'
        OnClick = bbtn7Click
      end
      object bbtn8: TSpeedButton
        Tag = 2
        Left = 70
        Top = 128
        Width = 57
        Height = 25
        Caption = '8'
        OnClick = bbtn8Click
      end
      object bbtn9: TSpeedButton
        Tag = 2
        Left = 134
        Top = 128
        Width = 57
        Height = 25
        Caption = '9'
        OnClick = bbtn9Click
      end
      object bbtn4: TSpeedButton
        Tag = 1
        Left = 6
        Top = 160
        Width = 57
        Height = 25
        Caption = '4'
        OnClick = bbtn4Click
      end
      object bbtn5: TSpeedButton
        Tag = 1
        Left = 70
        Top = 160
        Width = 57
        Height = 25
        Caption = '5'
        OnClick = bbtn5Click
      end
      object bbtn6: TSpeedButton
        Tag = 1
        Left = 134
        Top = 160
        Width = 57
        Height = 25
        Caption = '6'
        OnClick = bbtn6Click
      end
      object bbtn1: TSpeedButton
        Left = 6
        Top = 192
        Width = 57
        Height = 25
        Caption = '1'
        OnClick = bbtn1Click
      end
      object bbtn2: TSpeedButton
        Tag = 1
        Left = 70
        Top = 192
        Width = 57
        Height = 25
        Caption = '2'
        OnClick = bbtn2Click
      end
      object bbtn3: TSpeedButton
        Tag = 1
        Left = 134
        Top = 192
        Width = 57
        Height = 25
        Caption = '3'
        OnClick = bbtn3Click
      end
      object bbtn0: TSpeedButton
        Left = 6
        Top = 224
        Width = 57
        Height = 25
        Caption = '0'
        OnClick = bbtn0Click
      end
      object bbtnA: TSpeedButton
        Tag = 3
        Left = 198
        Top = 128
        Width = 57
        Height = 25
        Caption = 'A'
        OnClick = bbtnAClick
      end
      object bbtnC: TSpeedButton
        Tag = 3
        Left = 198
        Top = 160
        Width = 57
        Height = 25
        Caption = 'C'
        OnClick = bbtnCClick
      end
      object bbtnB: TSpeedButton
        Tag = 3
        Left = 262
        Top = 128
        Width = 57
        Height = 25
        Caption = 'B'
        OnClick = bbtnBClick
      end
      object bbtnE: TSpeedButton
        Tag = 3
        Left = 198
        Top = 192
        Width = 57
        Height = 25
        Caption = 'E'
        OnClick = bbtnEClick
      end
      object bbtnClear: TSpeedButton
        Left = 198
        Top = 224
        Width = 123
        Height = 25
        Action = aClearNumber
      end
      object bbtnD: TSpeedButton
        Tag = 3
        Left = 262
        Top = 160
        Width = 57
        Height = 25
        Caption = 'D'
        OnClick = bbtnDClick
      end
      object bbtnF: TSpeedButton
        Tag = 3
        Left = 262
        Top = 192
        Width = 57
        Height = 25
        Caption = 'F'
        OnClick = bbtnFClick
      end
      object bbtnBackspace: TSpeedButton
        Left = 70
        Top = 224
        Width = 123
        Height = 25
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        OnClick = bbtnBackspaceClick
      end
      object bpanelOutput: TPanel
        Left = 0
        Top = 0
        Width = 642
        Height = 121
        Align = alTop
        TabOrder = 0
        object panelCountSystemLabel: TPanel
          Left = 1
          Top = 1
          Width = 24
          Height = 119
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object blabelH: TLabel
            Left = 0
            Top = 0
            Width = 24
            Height = 25
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'H'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
          end
          object blabelD: TLabel
            Left = 0
            Top = 25
            Width = 24
            Height = 25
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'D'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
          end
          object blabelB: TLabel
            Left = 0
            Top = 75
            Width = 24
            Height = 44
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'B'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
          end
          object blabelO: TLabel
            Left = 0
            Top = 50
            Width = 24
            Height = 25
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'O'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
          end
        end
        object panelOperand: TPanel
          Left = 25
          Top = 1
          Width = 616
          Height = 119
          Align = alClient
          TabOrder = 1
          object beditH: TStaticText
            Left = 1
            Top = 1
            Width = 614
            Height = 25
            Align = alTop
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvSpace
            BevelKind = bkSoft
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            OnClick = beditHClick
          end
          object beditD: TStaticText
            Left = 1
            Top = 26
            Width = 614
            Height = 25
            Align = alTop
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvSpace
            BevelKind = bkSoft
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 1
            OnClick = beditDClick
          end
          object beditO: TStaticText
            Left = 1
            Top = 51
            Width = 614
            Height = 25
            Align = alTop
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvSpace
            BevelKind = bkSoft
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 2
            OnClick = beditOClick
          end
          object beditB: TStaticText
            Left = 1
            Top = 76
            Width = 614
            Height = 42
            Align = alClient
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvSpace
            BevelKind = bkSoft
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 3
            OnClick = beditBClick
          end
        end
      end
    end
    object tabExpression: TTabSheet
      Caption = #1042#1099#1088#1072#1078#1077#1085#1080#1081
      ImageIndex = 2
      object ebevSplitter1: TBevel
        Left = 69
        Top = 64
        Width = 1
        Height = 121
        Style = bsRaised
      end
      object ebevSplitter2: TBevel
        Left = 189
        Top = 64
        Width = 1
        Height = 121
        Style = bsRaised
      end
      object ebevSplitter3: TBevel
        Left = 8
        Top = 224
        Width = 529
        Height = 1
        Style = bsRaised
      end
      object ebevSplitter4: TBevel
        Left = 309
        Top = 64
        Width = 1
        Height = 121
        Style = bsRaised
      end
      object ebevSplitter5: TBevel
        Left = 485
        Top = 64
        Width = 1
        Height = 121
        Style = bsRaised
      end
      object ebtnCalculate: TButton
        Left = 8
        Top = 192
        Width = 529
        Height = 25
        Action = aCalculate
        TabOrder = 1
        OnKeyPress = ebtnCalculateKeyPress
      end
      object ebtnPi: TButton
        Left = 8
        Top = 64
        Width = 49
        Height = 25
        Caption = 'Pi'
        TabOrder = 3
        TabStop = False
        OnClick = ebtnPiClick
      end
      object ebtnEuler: TButton
        Left = 8
        Top = 96
        Width = 49
        Height = 25
        Caption = 'e'
        TabOrder = 5
        TabStop = False
        OnClick = ebtnEulerClick
      end
      object ebtnY: TButton
        Left = 8
        Top = 128
        Width = 49
        Height = 25
        Caption = 'y'
        TabOrder = 6
        TabStop = False
        OnClick = ebtnYClick
      end
      object ebtnX: TButton
        Left = 8
        Top = 160
        Width = 49
        Height = 25
        Caption = 'x'
        TabOrder = 7
        TabStop = False
        OnClick = ebtnXClick
      end
      object ebtnSin: TButton
        Left = 80
        Top = 64
        Width = 41
        Height = 25
        Caption = 'sin'
        TabOrder = 8
        TabStop = False
        OnClick = ebtnSinClick
      end
      object ebtnCos: TButton
        Left = 80
        Top = 96
        Width = 41
        Height = 25
        Caption = 'cos'
        TabOrder = 9
        TabStop = False
        OnClick = ebtnCosClick
      end
      object ebtnTg: TButton
        Left = 80
        Top = 128
        Width = 41
        Height = 25
        Caption = 'tg'
        TabOrder = 10
        TabStop = False
        OnClick = ebtnTgClick
      end
      object ebtnCtg: TButton
        Left = 80
        Top = 160
        Width = 41
        Height = 25
        Caption = 'ctg'
        TabOrder = 11
        TabStop = False
        OnClick = ebtnCtgClick
      end
      object ebtnAsin: TButton
        Left = 136
        Top = 64
        Width = 41
        Height = 25
        Caption = 'asin'
        TabOrder = 12
        TabStop = False
        OnClick = ebtnAsinClick
      end
      object ebtnAcos: TButton
        Left = 136
        Top = 96
        Width = 41
        Height = 25
        Caption = 'acos'
        TabOrder = 13
        TabStop = False
        OnClick = ebtnAcosClick
      end
      object ebtnAtg: TButton
        Left = 136
        Top = 128
        Width = 41
        Height = 25
        Caption = 'atg'
        TabOrder = 14
        TabStop = False
        OnClick = ebtnAtgClick
      end
      object ebtnActg: TButton
        Left = 136
        Top = 160
        Width = 41
        Height = 25
        Caption = 'actg'
        TabOrder = 15
        TabStop = False
        OnClick = ebtnActgClick
      end
      object ebtnLog: TButton
        Left = 200
        Top = 64
        Width = 41
        Height = 25
        Caption = 'log'
        TabOrder = 16
        TabStop = False
        OnClick = ebtnLogClick
      end
      object ebtnLg: TButton
        Left = 200
        Top = 96
        Width = 41
        Height = 25
        Caption = 'lg'
        TabOrder = 17
        TabStop = False
        OnClick = ebtnLgClick
      end
      object ebtnLn: TButton
        Left = 200
        Top = 128
        Width = 41
        Height = 25
        Caption = 'ln'
        TabOrder = 18
        TabStop = False
        OnClick = ebtnLnClick
      end
      object ebtnAbs: TButton
        Left = 200
        Top = 160
        Width = 41
        Height = 25
        Caption = '| x |'
        TabOrder = 19
        TabStop = False
        OnClick = ebtnAbsClick
      end
      object ebtnMod: TButton
        Left = 256
        Top = 64
        Width = 41
        Height = 25
        Caption = 'mod'
        TabOrder = 20
        TabStop = False
        OnClick = ebtnModClick
      end
      object ebtnDiv: TButton
        Left = 256
        Top = 96
        Width = 41
        Height = 25
        Caption = 'div'
        TabOrder = 21
        TabStop = False
        OnClick = ebtnDivClick
      end
      object ebtnFact: TButton
        Left = 256
        Top = 128
        Width = 41
        Height = 25
        Caption = '!'
        TabOrder = 22
        TabStop = False
        OnClick = ebtnFactClick
      end
      object ebtnPower: TButton
        Left = 256
        Top = 160
        Width = 41
        Height = 25
        Caption = 'x ^ y'
        TabOrder = 23
        TabStop = False
        OnClick = ebtnPowerClick
      end
      object ebtnMul: TButton
        Left = 496
        Top = 64
        Width = 43
        Height = 25
        Caption = '*'
        TabOrder = 24
        TabStop = False
        OnClick = ebtnMulClick
      end
      object ebtnDivision: TButton
        Left = 496
        Top = 96
        Width = 43
        Height = 25
        Caption = '/'
        TabOrder = 25
        TabStop = False
        OnClick = ebtnDivisionClick
      end
      object ebtnAdd: TButton
        Left = 496
        Top = 128
        Width = 43
        Height = 25
        Caption = '+'
        TabOrder = 26
        TabStop = False
        OnClick = ebtnAddClick
      end
      object ebtnSub: TButton
        Left = 496
        Top = 160
        Width = 43
        Height = 25
        Caption = '-'
        TabOrder = 27
        TabStop = False
        OnClick = ebtnSubClick
      end
      object ebtnOpen: TButton
        Left = 8
        Top = 232
        Width = 529
        Height = 25
        Action = aOpenFile
        TabOrder = 28
        TabStop = False
      end
      object eeditResult: TEdit
        Left = 8
        Top = 32
        Width = 457
        Height = 24
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 29
        Text = #1056#1077#1079#1091#1083#1100#1090#1072#1090
        OnEnter = eeditResultEnter
      end
      object eeditOperands: TEdit
        Left = 336
        Top = 0
        Width = 201
        Height = 25
        Hint = #1060#1086#1088#1084#1072#1090': AB=3,C=-8.64'
        AutoSelect = False
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Text = #1054#1087#1077#1088#1072#1085#1076#1099
        OnEnter = eeditOperandsEnter
        OnExit = eeditOperandsExit
        OnKeyPress = eeditOperandsKeyPress
      end
      object eeditExpression: TEdit
        Left = 8
        Top = 0
        Width = 321
        Height = 25
        AutoSelect = False
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = #1042#1099#1088#1072#1078#1077#1085#1080#1077
        OnEnter = eeditExpressionEnter
        OnExit = eeditExpressionExit
        OnKeyDown = eeditExpressionKeyDown
        OnKeyPress = eeditExpressionKeyPress
      end
      object ebtn7: TButton
        Left = 320
        Top = 64
        Width = 41
        Height = 25
        Caption = '7'
        TabOrder = 30
        TabStop = False
        OnClick = ebtn7Click
      end
      object ebtn4: TButton
        Left = 320
        Top = 96
        Width = 41
        Height = 25
        Caption = '4'
        TabOrder = 31
        TabStop = False
        OnClick = ebtn4Click
      end
      object ebtn1: TButton
        Left = 320
        Top = 128
        Width = 41
        Height = 25
        Caption = '1'
        TabOrder = 32
        TabStop = False
        OnClick = ebtn1Click
      end
      object ebtn0: TButton
        Left = 320
        Top = 160
        Width = 41
        Height = 25
        Caption = '0'
        TabOrder = 33
        TabStop = False
        OnClick = ebtn0Click
      end
      object ebtn8: TButton
        Left = 376
        Top = 64
        Width = 41
        Height = 25
        Caption = '8'
        TabOrder = 34
        TabStop = False
        OnClick = ebtn8Click
      end
      object ebtn5: TButton
        Left = 376
        Top = 96
        Width = 41
        Height = 25
        Caption = '5'
        TabOrder = 35
        TabStop = False
        OnClick = ebtn5Click
      end
      object ebtn2: TButton
        Left = 376
        Top = 128
        Width = 41
        Height = 25
        Caption = '2'
        TabOrder = 36
        TabStop = False
        OnClick = ebtn2Click
      end
      object ebtnDot: TButton
        Left = 376
        Top = 160
        Width = 41
        Height = 25
        Caption = '.'
        TabOrder = 37
        TabStop = False
        OnClick = ebtnDotClick
      end
      object ebtn9: TButton
        Left = 432
        Top = 64
        Width = 41
        Height = 25
        Caption = '9'
        TabOrder = 38
        TabStop = False
        OnClick = ebtn9Click
      end
      object ebtn6: TButton
        Left = 432
        Top = 96
        Width = 41
        Height = 25
        Caption = '6'
        TabOrder = 39
        TabStop = False
        OnClick = ebtn6Click
      end
      object ebtn3: TButton
        Left = 432
        Top = 128
        Width = 41
        Height = 25
        Caption = '3'
        TabOrder = 40
        TabStop = False
        OnClick = ebtn3Click
      end
      object ebtnLBracket: TButton
        Left = 432
        Top = 160
        Width = 17
        Height = 25
        Caption = '('
        TabOrder = 41
        TabStop = False
        OnClick = ebtnLBracketClick
      end
      object ebtnRBracket: TButton
        Left = 456
        Top = 160
        Width = 17
        Height = 25
        Caption = ')'
        TabOrder = 42
        TabStop = False
        OnClick = ebtnRBracketClick
      end
      object ebtnC: TButton
        Left = 472
        Top = 32
        Width = 67
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 0
        TabStop = False
        OnClick = ebtnCClick
      end
    end
  end
  object alMain: TActionList
    Left = 60
    Top = 323
    object aCalculate: TAction
      Category = 'ExpressionButtons'
      Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
      OnExecute = aCalculateExecute
    end
    object aUndo: TAction
      Category = 'ExpressionButtons'
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ShortCut = 16474
      OnExecute = aUndoExecute
    end
    object aOpenFile: TAction
      Category = 'ExpressionButtons'
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      ShortCut = 16463
      OnExecute = aOpenFileExecute
    end
    object aClearNumber: TAction
      Category = 'BitButtons'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = aClearNumberExecute
    end
  end
  object openDialog: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 100
    Top = 323
  end
end
