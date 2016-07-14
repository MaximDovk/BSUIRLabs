object frmSelectCode: TfrmSelectCode
  Left = 2093
  Top = 168
  BorderStyle = bsDialog
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1076
  ClientHeight = 97
  ClientWidth = 257
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object labelCode: TLabel
    Left = 8
    Top = 8
    Width = 66
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1076' '
  end
  object editCode: TEdit
    Left = 8
    Top = 32
    Width = 241
    Height = 21
    TabOrder = 0
    OnKeyPress = editCodeKeyPress
  end
  object btnComplete: TButton
    Left = 8
    Top = 64
    Width = 241
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' '
    TabOrder = 1
    OnClick = btnCompleteClick
  end
end
