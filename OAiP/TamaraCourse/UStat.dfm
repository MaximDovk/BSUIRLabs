object frmStat: TfrmStat
  Left = 272
  Top = 125
  Width = 928
  Height = 480
  Caption = 'Stat'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatTable: TStringGrid
    Left = 16
    Top = 8
    Width = 321
    Height = 193
    FixedCols = 0
    FixedRows = 0
    TabOrder = 0
  end
  object StatBtn: TBitBtn
    Left = 376
    Top = 80
    Width = 137
    Height = 49
    Caption = 'StatBtn'
    TabOrder = 1
  end
end
