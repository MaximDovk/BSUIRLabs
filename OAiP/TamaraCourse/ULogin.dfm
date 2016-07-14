object frmLogin: TfrmLogin
  Left = 1934
  Top = 276
  Width = 418
  Height = 219
  ActiveControl = btnStartGame
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
  object panelPlayerX: TPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 121
    Align = alLeft
    TabOrder = 0
    object labelX: TLabel
      Left = 1
      Top = 1
      Width = 199
      Height = 16
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = #1050#1088#1077#1089#1090#1080#1082#1080
    end
    object btnPlayerX: TSpeedButton
      Left = 8
      Top = 56
      Width = 185
      Height = 22
      GroupIndex = 1
      Caption = #1048#1075#1088#1086#1082
    end
    object btnIIX: TSpeedButton
      Left = 8
      Top = 88
      Width = 185
      Height = 22
      GroupIndex = 1
      Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
      OnClick = btnIIXClick
    end
    object editXName: TEdit
      Left = 8
      Top = 24
      Width = 185
      Height = 21
      TabOrder = 0
      OnEnter = editXNameEnter
      OnExit = editXNameExit
    end
  end
  object panelPlayerO: TPanel
    Left = 201
    Top = 0
    Width = 201
    Height = 121
    Align = alClient
    TabOrder = 1
    object labelO: TLabel
      Left = 1
      Top = 1
      Width = 199
      Height = 16
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = #1053#1086#1083#1080#1082#1080
    end
    object btnPlayerO: TSpeedButton
      Left = 8
      Top = 56
      Width = 185
      Height = 22
      GroupIndex = 2
      Caption = #1048#1075#1088#1086#1082
    end
    object btnIIO: TSpeedButton
      Left = 8
      Top = 88
      Width = 185
      Height = 22
      GroupIndex = 2
      Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
      OnClick = btnIIOClick
    end
    object editOName: TEdit
      Left = 8
      Top = 24
      Width = 185
      Height = 21
      TabOrder = 0
      OnEnter = editONameEnter
      OnExit = editONameExit
    end
  end
  object panelStart: TPanel
    Left = 0
    Top = 121
    Width = 402
    Height = 59
    Align = alBottom
    TabOrder = 2
    object btnStartGame: TButton
      Left = 8
      Top = 8
      Width = 385
      Height = 41
      Caption = #1053#1072#1095#1072#1090#1100' '#1080#1075#1088#1091
      TabOrder = 0
      OnClick = btnStartGameClick
    end
  end
end
