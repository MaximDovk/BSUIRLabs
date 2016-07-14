object frmText: TfrmText
  Left = 1777
  Top = 347
  Width = 671
  Height = 546
  Caption = #1060#1072#1081#1083' - '
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
  object splitter: TSplitter
    Left = 0
    Top = 217
    Width = 655
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object panelText: TPanel
    Left = 0
    Top = 0
    Width = 655
    Height = 217
    Align = alTop
    TabOrder = 0
    object reditText: TRichEdit
      Left = 1
      Top = 1
      Width = 653
      Height = 215
      Align = alClient
      ReadOnly = True
      TabOrder = 0
    end
  end
  object panelExpressions: TPanel
    Left = 0
    Top = 220
    Width = 655
    Height = 164
    Align = alClient
    TabOrder = 1
    object labelExpressions: TLabel
      Left = 1
      Top = 1
      Width = 653
      Height = 13
      Align = alTop
      Caption = #1053#1072#1081#1076#1077#1085#1085#1099#1077' '#1086#1087#1077#1088#1072#1094#1080#1080':'
    end
    object lvExpressions: TListView
      Left = 1
      Top = 14
      Width = 653
      Height = 149
      Align = alClient
      Columns = <>
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnEditing = lvExpressionsEditing
      OnSelectItem = lvExpressionsSelectItem
    end
  end
  object panelButtons: TPanel
    Left = 0
    Top = 384
    Width = 655
    Height = 123
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      655
      123)
    object btnHelp: TButton
      Left = 8
      Top = 44
      Width = 640
      Height = 30
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = #1055#1086#1084#1086#1097#1100
      TabOrder = 0
      OnClick = btnHelpClick
    end
    object btnReplaceAll: TButton
      Left = 8
      Top = 6
      Width = 640
      Height = 30
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1074#1089#1077
      TabOrder = 1
      OnClick = btnReplaceAllClick
    end
    object btnSave: TButton
      Left = 7
      Top = 82
      Width = 640
      Height = 30
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
      TabOrder = 2
      OnClick = btnSaveClick
    end
  end
end
