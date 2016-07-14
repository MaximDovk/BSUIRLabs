object frmMain: TfrmMain
  Left = 1685
  Top = 311
  BorderStyle = bsSingle
  Caption = #1041#1080#1073#1083#1080#1086#1090#1077#1082#1072
  ClientHeight = 478
  ClientWidth = 904
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = menuMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControls: TPanel
    Left = 696
    Top = 0
    Width = 208
    Height = 478
    Align = alRight
    TabOrder = 0
    object bevelLineTop: TBevel
      Left = 8
      Top = 160
      Width = 185
      Height = 1
      Shape = bsBottomLine
      Style = bsRaised
    end
    object bevelLineBottom: TBevel
      Left = 8
      Top = 376
      Width = 193
      Height = 1
      Shape = bsBottomLine
      Style = bsRaised
    end
    object btnShowBadVisitors: TBitBtn
      Left = 8
      Top = 40
      Width = 193
      Height = 25
      Action = aShowBadVisitors
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077#1076#1086#1074#1077#1088#1077#1085#1085#1099#1093
      TabOrder = 0
    end
    object btnShowDebts: TButton
      Left = 8
      Top = 72
      Width = 193
      Height = 25
      Action = aShowDebts
      TabOrder = 1
    end
    object btnShowBorrowedBooks: TButton
      Left = 8
      Top = 232
      Width = 193
      Height = 25
      Action = aShowBorrowedBooks
      TabOrder = 2
    end
    object btnFindBooksByAuthor: TButton
      Left = 8
      Top = 288
      Width = 193
      Height = 25
      Action = aFindBooksByAuthor
      TabOrder = 3
    end
    object editBooksAuthor: TEdit
      Left = 8
      Top = 264
      Width = 193
      Height = 21
      TabOrder = 4
      Text = #1042#1074#1077#1076#1080#1090#1077' '#1092#1072#1084#1080#1083#1080#1102' '#1072#1074#1090#1086#1088#1072
    end
    object editBooksTitle: TEdit
      Left = 8
      Top = 320
      Width = 193
      Height = 21
      TabOrder = 5
      Text = #1042#1074#1077#1076#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1082#1085#1080#1075#1080
    end
    object btnFindBooksByTitle: TButton
      Left = 8
      Top = 344
      Width = 193
      Height = 25
      Action = aFindBooksByTitle
      TabOrder = 6
    end
    object btnShowAllBooks: TButton
      Left = 8
      Top = 168
      Width = 193
      Height = 25
      Action = aShowAllBooks
      TabOrder = 7
    end
    object btnShowAllVisitors: TButton
      Left = 8
      Top = 8
      Width = 193
      Height = 25
      Action = aShowAllVisitors
      TabOrder = 8
    end
    object editVisitorsName: TEdit
      Left = 8
      Top = 104
      Width = 193
      Height = 21
      TabOrder = 9
      Text = #1042#1074#1077#1076#1080#1090#1077' '#1080#1084#1103' '#1087#1086#1089#1077#1090#1080#1090#1077#1083#1103
    end
    object btnFindVisitorsByName: TButton
      Left = 8
      Top = 128
      Width = 193
      Height = 25
      Action = aFindVisitorsByName
      TabOrder = 10
    end
    object btnShowNotBorrowedBooks: TButton
      Left = 8
      Top = 200
      Width = 193
      Height = 25
      Action = aShowNotBorrowedBooks
      TabOrder = 11
    end
    object btnShowAllBorrows: TButton
      Left = 8
      Top = 384
      Width = 193
      Height = 25
      Action = aShowAllBorrows
      TabOrder = 12
    end
    object btnShowOpenBorrows: TButton
      Left = 8
      Top = 416
      Width = 193
      Height = 25
      Action = aShowOpenBorrows
      TabOrder = 13
    end
    object btnShowClosedBorrows: TButton
      Left = 8
      Top = 448
      Width = 193
      Height = 25
      Action = aShowClosedBorrows
      TabOrder = 14
    end
  end
  object pnlLists: TPanel
    Left = 0
    Top = 0
    Width = 696
    Height = 478
    Align = alClient
    TabOrder = 1
    object labelCurrentList: TLabel
      Left = 1
      Top = 1
      Width = 694
      Height = 17
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = #1042#1089#1077' '#1082#1085#1080#1075#1080
    end
    object lvCurrentList: TListView
      Left = 1
      Top = 18
      Width = 694
      Height = 459
      Align = alClient
      Columns = <>
      GridLines = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object alMain: TActionList
    Left = 16
    Top = 32
    object aAddBook: TAction
      Category = 'Books'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1085#1080#1075#1091
      OnExecute = aAddBookExecute
    end
    object aDeleteBook: TAction
      Category = 'Books'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1085#1080#1075#1091
      OnExecute = aDeleteBookExecute
    end
    object aChangeBook: TAction
      Category = 'Books'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1086' '#1082#1085#1080#1075#1077
      OnExecute = aChangeBookExecute
    end
    object aAddVisitor: TAction
      Category = 'Visitors'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1089#1077#1090#1080#1090#1077#1083#1103
      OnExecute = aAddVisitorExecute
    end
    object aDeleteVisitor: TAction
      Category = 'Visitors'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1089#1077#1090#1080#1090#1077#1083#1103
      OnExecute = aDeleteVisitorExecute
    end
    object aChangeVisitor: TAction
      Category = 'Visitors'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1086' '#1087#1086#1089#1077#1090#1080#1090#1077#1083#1077
      OnExecute = aChangeVisitorExecute
    end
    object aAddBorrow: TAction
      Category = 'Borrows'
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1085#1080#1075#1091' '#1085#1072' '#1087#1086#1089#1077#1090#1080#1090#1077#1083#1103
      OnExecute = aAddBorrowExecute
    end
    object aChangeBorrow: TAction
      Category = 'Borrows'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100' '#1086' '#1074#1079#1103#1090#1080#1080' '#1082#1085#1080#1075#1080
      OnExecute = aChangeBorrowExecute
    end
    object aShowDebts: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1086#1083#1078#1085#1080#1082#1086#1074
      OnExecute = aShowDebtsExecute
    end
    object aShowBadVisitors: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077#1076#1086#1074#1077#1088#1077#1085#1085#1099#1093
      OnExecute = aShowBadVisitorsExecute
    end
    object aShowBorrowedBooks: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1079#1103#1090#1099#1077' '#1082#1085#1080#1075#1080
      OnExecute = aShowBorrowedBooksExecute
    end
    object aFindBooksByAuthor: TAction
      Category = 'Controls'
      Caption = #1053#1072#1081#1090#1080' '#1082#1085#1080#1075#1080' '#1087#1086' '#1072#1074#1090#1086#1088#1091
      OnExecute = aFindBooksByAuthorExecute
    end
    object aFindBooksByTitle: TAction
      Category = 'Controls'
      Caption = #1053#1072#1081#1090#1080' '#1082#1085#1080#1075#1080' '#1087#1086' '#1085#1072#1079#1074#1072#1085#1080#1102
      OnExecute = aFindBooksByTitleExecute
    end
    object aShowAllBooks: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1082#1085#1080#1075#1080
      OnExecute = aShowAllBooksExecute
    end
    object aShowAllVisitors: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077#1093' '#1087#1086#1089#1077#1090#1080#1090#1077#1083#1077#1081
      OnExecute = aShowAllVisitorsExecute
    end
    object aFindVisitorsByName: TAction
      Category = 'Controls'
      Caption = #1053#1072#1081#1090#1080' '#1087#1086#1089#1077#1090#1080#1090#1077#1083#1077#1081' '#1087#1086' '#1080#1084#1077#1085#1080
      OnExecute = aFindVisitorsByNameExecute
    end
    object aShowNotBorrowedBooks: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077#1074#1079#1103#1090#1099#1077' '#1082#1085#1080#1075#1080
      OnExecute = aShowNotBorrowedBooksExecute
    end
    object aShowAllBorrows: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1079#1072#1087#1080#1089#1080
      OnExecute = aShowAllBorrowsExecute
    end
    object aShowOpenBorrows: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1086#1090#1082#1088#1099#1090#1099#1077' '#1079#1072#1087#1080#1089#1080
      OnExecute = aShowOpenBorrowsExecute
    end
    object aShowClosedBorrows: TAction
      Category = 'Controls'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1079#1072#1082#1088#1099#1090#1099#1077' '#1079#1072#1087#1080#1089#1080
      OnExecute = aShowClosedBorrowsExecute
    end
    object aCloseBorrow: TAction
      Category = 'Borrows'
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1079#1072#1087#1080#1089#1100
      OnExecute = aCloseBorrowExecute
    end
  end
  object menuMain: TMainMenu
    Left = 56
    Top = 32
    object miBooks: TMenuItem
      Caption = #1050#1085#1080#1075#1080
      object msiAddBook: TMenuItem
        Action = aAddBook
      end
      object msiChangeBook: TMenuItem
        Action = aChangeBook
      end
      object msiDeleteBook: TMenuItem
        Action = aDeleteBook
      end
      object msiBookSplitter: TMenuItem
        Caption = '-'
      end
      object msiShowAllBooks: TMenuItem
        Action = aShowAllBooks
      end
      object msiShowBorrowedBooks: TMenuItem
        Action = aShowBorrowedBooks
      end
      object msiShowNotBorrowedBooks: TMenuItem
        Action = aShowNotBorrowedBooks
      end
    end
    object miVisitors: TMenuItem
      Caption = #1055#1086#1089#1077#1090#1080#1090#1077#1083#1080
      object msiAddVisitor: TMenuItem
        Action = aAddVisitor
      end
      object msiChangeVisitor: TMenuItem
        Action = aChangeVisitor
      end
      object msiDeleteVisitor: TMenuItem
        Action = aDeleteVisitor
      end
      object msiVisitorSplitter: TMenuItem
        Caption = '-'
      end
      object msiShowAllVisitors: TMenuItem
        Action = aShowAllVisitors
      end
      object msiShowDebts: TMenuItem
        Action = aShowDebts
      end
      object msiShowBadVisitors: TMenuItem
        Action = aShowBadVisitors
      end
    end
    object miBorrows: TMenuItem
      Caption = #1042#1079#1103#1090#1099#1077' '#1082#1085#1080#1075#1080
      object msiAddBorrow: TMenuItem
        Action = aAddBorrow
      end
      object msiChangeBorrow: TMenuItem
        Action = aChangeBorrow
      end
      object msiCloseBorrow: TMenuItem
        Action = aCloseBorrow
      end
      object msiBorrowSplitter: TMenuItem
        Caption = '-'
      end
      object msiShowAllBorrows: TMenuItem
        Action = aShowAllBorrows
      end
      object msiShowOpenBorrows: TMenuItem
        Action = aShowOpenBorrows
      end
      object msiShowClosedBorrows: TMenuItem
        Action = aShowClosedBorrows
      end
    end
  end
end
