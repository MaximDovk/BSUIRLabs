object frmMain: TfrmMain
  Left = 1615
  Top = 174
  Width = 1000
  Height = 700
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imageField: TImage
    Left = 0
    Top = 0
    Width = 760
    Height = 661
    Align = alClient
  end
  object panelButtons: TPanel
    Left = 760
    Top = 0
    Width = 224
    Height = 661
    Align = alRight
    TabOrder = 0
    DesignSize = (
      224
      661)
    object btnMainMenu: TSpeedButton
      Left = 8
      Top = 8
      Width = 209
      Height = 41
      Caption = 'Main menu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Cooper Black'
      Font.Style = []
      ParentFont = False
      OnClick = btnMainMenuClick
    end
    object btnExit: TSpeedButton
      Left = 8
      Top = 56
      Width = 209
      Height = 41
      Caption = 'Exit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Cooper Black'
      Font.Style = []
      ParentFont = False
      OnClick = btnExitClick
    end
    object labelPlayerScoreTitle: TLabel
      Left = 8
      Top = 104
      Width = 209
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Caption = 'Your score:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Cooper Black'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object labelPlayerScore: TLabel
      Left = 8
      Top = 144
      Width = 209
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -24
      Font.Name = 'Cooper Black'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object labelComputerScoreTitle: TLabel
      Left = 8
      Top = 184
      Width = 209
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Caption = 'Bot`s score:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Cooper Black'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object labelComputerScore: TLabel
      Left = 8
      Top = 224
      Width = 209
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -24
      Font.Name = 'Cooper Black'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object btnPause: TSpeedButton
      Left = 8
      Top = 608
      Width = 209
      Height = 41
      Anchors = [akLeft, akBottom]
      Caption = 'Pause'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Cooper Black'
      Font.Style = []
      ParentFont = False
      OnClick = btnPauseClick
    end
  end
  object timerField: TTimer
    Enabled = False
    Interval = 300
    OnTimer = timerFieldTimer
    Left = 6
    Top = 8
  end
  object timerStart: TTimer
    Enabled = False
    OnTimer = timerStartTimer
    Left = 38
    Top = 8
  end
end
