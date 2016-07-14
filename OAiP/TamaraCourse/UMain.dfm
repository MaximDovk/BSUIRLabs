object frmMain: TfrmMain
  Left = 1940
  Top = 519
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1088#1077#1089#1090#1080#1082#1080' - '#1085#1086#1083#1080#1082#1080
  ClientHeight = 254
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object panelControls: TPanel
    Left = 254
    Top = 0
    Width = 156
    Height = 254
    Align = alRight
    TabOrder = 0
    object labelFieldSize: TLabel
      Left = 8
      Top = 8
      Width = 137
      Height = 21
      AutoSize = False
      Caption = #1056#1072#1079#1084#1077#1088' '#1087#1086#1083#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object labelWinLine: TLabel
      Left = 8
      Top = 56
      Width = 84
      Height = 16
      Caption = #1044#1083#1080#1085#1072' '#1083#1080#1085#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object labelCurrentMove: TLabel
      Left = 8
      Top = 136
      Width = 137
      Height = 21
      Alignment = taCenter
      AutoSize = False
      Caption = #1061#1086#1076#1080#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object labelMove: TLabel
      Left = 8
      Top = 160
      Width = 137
      Height = 89
      Alignment = taCenter
      AutoSize = False
      Caption = 'X'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object editFieldSize: TEdit
      Left = 8
      Top = 24
      Width = 121
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 0
      Text = '3'
      OnChange = editFieldSizeChange
    end
    object udFieldSize: TUpDown
      Left = 129
      Top = 24
      Width = 16
      Height = 21
      Associate = editFieldSize
      Min = 3
      Max = 7
      Position = 3
      TabOrder = 1
    end
    object editWinLine: TEdit
      Left = 8
      Top = 72
      Width = 121
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 2
      Text = '3'
      OnChange = editWinLineChange
    end
    object udWinLine: TUpDown
      Left = 129
      Top = 72
      Width = 16
      Height = 21
      Associate = editWinLine
      Min = 3
      Max = 7
      Position = 3
      TabOrder = 3
    end
    object btnNewGame: TButton
      Left = 8
      Top = 104
      Width = 137
      Height = 25
      Action = aNewGame
      TabOrder = 4
    end
  end
  object panelField: TPanel
    Left = 0
    Top = 0
    Width = 254
    Height = 254
    Align = alClient
    TabOrder = 1
    object sgField: TStringGrid
      Left = 1
      Top = 1
      Width = 252
      Height = 252
      TabStop = False
      Align = alClient
      BiDiMode = bdLeftToRight
      BorderStyle = bsNone
      ColCount = 3
      DefaultDrawing = False
      FixedCols = 0
      RowCount = 3
      FixedRows = 0
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentBiDiMode = False
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 0
      OnDrawCell = sgFieldDrawCell
      OnSelectCell = sgFieldSelectCell
    end
  end
  object alMain: TActionList
    Left = 262
    Top = 216
    object aNewGame: TAction
      Category = 'Game'
      Caption = #1053#1086#1074#1072#1103' '#1080#1075#1088#1072
      ShortCut = 16462
      OnExecute = aNewGameExecute
    end
    object aUndo: TAction
      Category = 'Game'
      Caption = 'aUndo'
      ShortCut = 16474
      OnExecute = aUndoExecute
    end
  end
end
