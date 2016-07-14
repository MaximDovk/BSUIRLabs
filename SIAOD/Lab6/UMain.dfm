object frmMain: TfrmMain
  Left = 293
  Top = 166
  BorderStyle = bsDialog
  Caption = #1041#1080#1085#1072#1088#1085#1099#1077' '#1076#1077#1088#1077#1074#1100#1103
  ClientHeight = 761
  ClientWidth = 1399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object imgTree: TImage
    Left = 238
    Top = 0
    Width = 1161
    Height = 761
    Align = alClient
  end
  object pnlControls: TPanel
    Left = 0
    Top = 0
    Width = 238
    Height = 761
    Align = alLeft
    Locked = True
    TabOrder = 0
    object labelABR: TLabel
      Left = 10
      Top = 423
      Width = 218
      Height = 16
      AutoSize = False
      Caption = 'ABR:'
    end
    object labelABRResult: TLabel
      Left = 10
      Top = 443
      Width = 218
      Height = 90
      AutoSize = False
      WordWrap = True
    end
    object labelARB: TLabel
      Left = 10
      Top = 532
      Width = 31
      Height = 16
      Caption = 'ARB:'
    end
    object labelARBResult: TLabel
      Left = 10
      Top = 551
      Width = 218
      Height = 90
      AutoSize = False
      WordWrap = True
    end
    object labelRAB: TLabel
      Left = 10
      Top = 640
      Width = 31
      Height = 16
      Caption = 'RAB:'
    end
    object labelRABResult: TLabel
      Left = 10
      Top = 660
      Width = 218
      Height = 90
      AutoSize = False
      WordWrap = True
    end
    object strgNodesData: TStringGrid
      Left = 10
      Top = 49
      Width = 218
      Height = 326
      ColCount = 1
      DefaultColWidth = 214
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 10
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      ScrollBars = ssVertical
      TabOrder = 0
      OnKeyPress = strgNodesDataKeyPress
    end
    object editNumberOfNodes: TEdit
      Left = 10
      Top = 10
      Width = 188
      Height = 26
      AutoSize = False
      MaxLength = 2
      TabOrder = 1
      Text = '10'
      OnChange = editNumberOfNodesChange
      OnKeyPress = editNumberOfNodesKeyPress
    end
    object udNumberOfNodes: TUpDown
      Left = 198
      Top = 10
      Width = 20
      Height = 26
      Associate = editNumberOfNodes
      Min = 1
      Max = 99
      Position = 10
      TabOrder = 2
    end
    object btnDrawTree: TButton
      Left = 10
      Top = 384
      Width = 218
      Height = 31
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1076#1077#1088#1077#1074#1086
      TabOrder = 3
      OnClick = btnDrawTreeClick
    end
  end
end
