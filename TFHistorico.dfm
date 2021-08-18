object FrmHistorico: TFrmHistorico
  Left = 0
  Top = 0
  Caption = 'Hist'#243'rico Downloads'
  ClientHeight = 447
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnFechar: TButton
    Left = 640
    Top = 414
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 0
    OnClick = btnFecharClick
  end
  object gdDownload: TDBGrid
    Left = 0
    Top = 0
    Width = 766
    Height = 401
    Align = alTop
    BiDiMode = bdLeftToRight
    DataSource = DM.dtsDados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
    ParentBiDiMode = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Column2'
        Title.Caption = 'Data Inicio'
        Width = 113
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Column3'
        Title.Caption = 'Data Fim'
        Width = 111
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Column4'
        Title.Caption = 'Status'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'url'
        Title.Caption = 'Url'
        Visible = True
      end>
  end
end
