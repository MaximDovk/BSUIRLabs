object frmMain: TfrmMain
  Left = 1751
  Top = 272
  BorderStyle = bsDialog
  Caption = #1043#1088#1072#1092#1099
  ClientHeight = 537
  ClientWidth = 786
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
  object imgGraph: TImage
    Left = 249
    Top = 0
    Width = 537
    Height = 537
    Align = alClient
  end
  object pnlControls: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 537
    Align = alLeft
    TabOrder = 0
    object labelFrom: TLabel
      Left = 8
      Top = 275
      Width = 33
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = #1054#1090
    end
    object labelTo: TLabel
      Left = 128
      Top = 275
      Width = 33
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = #1044#1086
    end
    object strgMatrix: TStringGrid
      Left = 8
      Top = 32
      Width = 235
      Height = 235
      ColCount = 11
      DefaultColWidth = 20
      DefaultRowHeight = 20
      RowCount = 11
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      ScrollBars = ssNone
      TabOrder = 0
      OnKeyPress = strgMatrixKeyPress
    end
    object editNumOfNodes: TEdit
      Left = 8
      Top = 8
      Width = 217
      Height = 21
      MaxLength = 2
      TabOrder = 1
      Text = '5'
      OnChange = editNumOfNodesChange
      OnKeyPress = editNumOfNodesKeyPress
    end
    object udNumOfNodes: TUpDown
      Left = 225
      Top = 8
      Width = 16
      Height = 21
      Associate = editNumOfNodes
      Min = 1
      Max = 10
      Position = 5
      TabOrder = 2
    end
    object editFrom: TEdit
      Left = 48
      Top = 272
      Width = 57
      Height = 21
      MaxLength = 2
      TabOrder = 3
      Text = '1'
      OnKeyPress = editFromKeyPress
    end
    object editTo: TEdit
      Left = 168
      Top = 272
      Width = 57
      Height = 21
      MaxLength = 2
      TabOrder = 4
      Text = '1'
      OnKeyPress = editToKeyPress
    end
    object udTo: TUpDown
      Left = 225
      Top = 272
      Width = 16
      Height = 21
      Associate = editTo
      Min = 1
      Max = 10
      Position = 1
      TabOrder = 5
    end
    object udFrom: TUpDown
      Left = 105
      Top = 272
      Width = 16
      Height = 21
      Associate = editFrom
      Min = 1
      Max = 10
      Position = 1
      TabOrder = 6
    end
    object btnShowGraph: TButton
      Left = 8
      Top = 296
      Width = 233
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1075#1088#1072#1092
      TabOrder = 7
      OnClick = btnShowGraphClick
    end
    object memoPathes: TMemo
      Left = 8
      Top = 328
      Width = 233
      Height = 201
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 8
    end
  end
end
