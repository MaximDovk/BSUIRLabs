object ResultsForm: TResultsForm
  Left = 186
  Top = 172
  BorderStyle = bsSingle
  ClientHeight = 195
  ClientWidth = 902
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
  object resultGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 902
    Height = 195
    Align = alClient
    BorderStyle = bsNone
    ColCount = 50
    DefaultColWidth = 33
    DefaultRowHeight = 14
    RowCount = 10
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Lucida Console'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentFont = False
    ScrollBars = ssHorizontal
    TabOrder = 0
  end
end
