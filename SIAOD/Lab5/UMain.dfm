object frmMain: TfrmMain
  Left = 1924
  Top = 332
  BorderStyle = bsSingle
  Caption = #1055#1086#1089#1090#1092#1080#1082#1089#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
  ClientHeight = 110
  ClientWidth = 400
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
  object editInput: TEdit
    Left = 8
    Top = 8
    Width = 385
    Height = 21
    TabOrder = 0
    Text = #1042#1074#1077#1076#1080#1090#1077' '#1089#1090#1088#1086#1082#1091
    OnKeyPress = editInputKeyPress
  end
  object btnConvert: TButton
    Left = 8
    Top = 40
    Width = 385
    Height = 25
    Action = processString
    TabOrder = 1
  end
  object editResult: TEdit
    Left = 8
    Top = 80
    Width = 385
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object alMain: TActionList
    Left = 8
    object processString: TAction
      Category = 'Main'
      Caption = #1050#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1090#1088#1086#1082#1091
      OnExecute = processStringExecute
    end
  end
end
