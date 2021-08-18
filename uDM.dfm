object DM: TDM
  OldCreateOrder = False
  Height = 578
  Width = 728
  object Conexao: TSQLConnection
    DriverName = 'Sqlite'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxSqlite'
      
        'DriverPackageLoader=TDBXSqliteDriverLoader,DBXSqliteDriver270.bp' +
        'l'
      
        'MetaDataPackageLoader=TDBXSqliteMetaDataCommandFactory,DbxSqlite' +
        'Driver270.bpl'
      'FailIfMissing=True'
      
        'Database=D:\Documentos\Embarcadero\Studio\Projects\Win32\Debug\l' +
        'ogsoftplan.db')
    Left = 48
    Top = 64
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 72
    Top = 376
  end
  object qryDownload: TSQLQuery
    DataSource = dtsDados
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Conexao
    Left = 192
    Top = 208
  end
  object dspDados: TDataSetProvider
    DataSet = qryHistorico
    Left = 72
    Top = 232
  end
  object cdsDados: TClientDataSet
    Active = True
    Aggregates = <>
    Filtered = True
    FieldDefs = <
      item
        Name = 'codigo'
        Attributes = [faRequired]
        DataType = ftLargeint
      end
      item
        Name = 'url'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 600
      end
      item
        Name = 'Column2'
        Attributes = [faRequired]
        DataType = ftWideMemo
      end
      item
        Name = 'Column3'
        Attributes = [faRequired]
        DataType = ftWideMemo
      end
      item
        Name = 'Column4'
        Attributes = [faRequired]
        DataType = ftWideMemo
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'dspDados'
    StoreDefs = True
    Left = 72
    Top = 296
    object cdsDadoscodigo: TLargeintField
      FieldName = 'codigo'
      Required = True
    end
    object cdsDadosurl: TWideStringField
      FieldName = 'url'
      Required = True
      Size = 600
    end
    object cdsDadosColumn2: TWideMemoField
      FieldName = 'Column2'
      Required = True
      BlobType = ftWideMemo
      DisplayValue = dvFull
    end
    object cdsDadosColumn3: TWideMemoField
      FieldName = 'Column3'
      Required = True
      BlobType = ftWideMemo
      DisplayValue = dvFull
    end
    object cdsDadosColumn4: TWideMemoField
      FieldName = 'Column4'
      Required = True
      BlobType = ftWideMemo
      DisplayValue = dvFull
    end
  end
  object qryHistorico: TSQLQuery
    DataSource = dtsDados
    MaxBlobSize = 1
    Params = <>
    SQL.Strings = (
      'select l.codigo, l.url,  '
      'strftime('#39'%d/%m/%Y %H:%M:%S'#39', l.datainicio) as datainicio,'
      'strftime('#39'%d/%m/%Y %H:%M:%S'#39', l.datafim) as datafim,'
      'case coalesce(l.datafim, '#39#39') '
      'when '#39#39
      'then '#39'Interrompido'#39' '
      'else '#39'Finalizado'#39' '
      'end status'
      'from logdownload l '
      'order by l.codigo desc')
    SQLConnection = Conexao
    Left = 224
    Top = 328
    object qryHistoricocodigo: TLargeintField
      FieldName = 'codigo'
      Required = True
    end
    object qryHistoricourl: TWideStringField
      FieldName = 'url'
      Required = True
      Size = 600
    end
    object qryHistoricoColumn2: TWideMemoField
      FieldName = 'Column2'
      Required = True
      BlobType = ftWideMemo
      Size = 1
    end
    object qryHistoricoColumn3: TWideMemoField
      FieldName = 'Column3'
      Required = True
      BlobType = ftWideMemo
      Size = 1
    end
    object qryHistoricoColumn4: TWideMemoField
      FieldName = 'Column4'
      Required = True
      BlobType = ftWideMemo
      Size = 1
    end
  end
end
