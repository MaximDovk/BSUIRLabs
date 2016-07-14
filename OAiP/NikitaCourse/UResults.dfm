object frmResults: TfrmResults
  Left = 2037
  Top = 125
  BorderStyle = bsSingle
  Caption = 'frmResults'
  ClientHeight = 601
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvResults: TListView
    Left = 0
    Top = 0
    Width = 473
    Height = 601
    Align = alClient
    Columns = <
      item
        Caption = #1057#1095#1105#1090
        Width = 150
      end
      item
        Caption = #1042#1088#1077#1084#1103
        Width = 150
      end
      item
        Caption = #1044#1083#1080#1085#1072' '#1079#1084#1077#1081#1082#1080
        Width = 150
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
end
