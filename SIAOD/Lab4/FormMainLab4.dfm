object MainForm: TMainForm
  Left = 440
  Top = 93
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1080#1089#1090#1077#1084#1099' '#1089' '#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077#1084' '#1074#1088#1077#1084#1077#1085#1080
  ClientHeight = 592
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object labelConstType: TLabel
    Left = 8
    Top = 8
    Width = 111
    Height = 13
    Alignment = taCenter
    Caption = #1055#1086#1089#1090#1086#1103#1085#1085#1072#1103' '#1074#1077#1083#1080#1095#1080#1085#1072
  end
  object labelConstValue: TLabel
    Left = 144
    Top = 8
    Width = 126
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1074#1088#1077#1084#1077#1085#1080' '#1090#1072#1082#1090#1072
  end
  object comboConstType: TComboBox
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = #1042#1088#1077#1084#1103' '#1090#1072#1082#1090#1072
    OnChange = comboConstTypeChange
    OnKeyPress = comboConstTypeKeyPress
    Items.Strings = (
      #1042#1088#1077#1084#1103' '#1090#1072#1082#1090#1072
      #1042#1088#1077#1084#1103' '#1074#1074#1086#1076#1072)
  end
  object editConstValue: TEdit
    Left = 144
    Top = 24
    Width = 129
    Height = 21
    TabOrder = 1
    Text = '5'
    OnKeyPress = editConstValueKeyPress
  end
  object panelGraph: TPanel
    Left = 8
    Top = 56
    Width = 449
    Height = 529
    TabOrder = 2
    object imageGraph: TImage
      Left = 1
      Top = 1
      Width = 447
      Height = 527
      Align = alClient
      AutoSize = True
    end
    object labelT01: TLabel
      Left = 16
      Top = 16
      Width = 57
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT01Click
    end
    object labelT02: TLabel
      Left = 72
      Top = 16
      Width = 39
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT02Click
    end
    object labelT03: TLabel
      Left = 110
      Top = 16
      Width = 39
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT03Click
    end
    object labelT04: TLabel
      Left = 148
      Top = 16
      Width = 39
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT04Click
    end
    object labelT05: TLabel
      Left = 186
      Top = 16
      Width = 39
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT05Click
    end
    object labelT07: TLabel
      Left = 262
      Top = 16
      Width = 39
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT07Click
    end
    object labelT06: TLabel
      Left = 224
      Top = 16
      Width = 39
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT06Click
    end
    object labelT08: TLabel
      Left = 300
      Top = 16
      Width = 39
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT08Click
    end
    object labelT09: TLabel
      Left = 338
      Top = 16
      Width = 39
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT09Click
    end
    object labelT10: TLabel
      Left = 376
      Top = 16
      Width = 57
      Height = 418
      AutoSize = False
      Transparent = True
      OnClick = labelT10Click
    end
  end
  object buttonShowGraph: TButton
    Left = 288
    Top = 8
    Width = 169
    Height = 41
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1075#1088#1072#1092#1080#1082
    TabOrder = 3
    OnClick = buttonShowGraphClick
  end
end
