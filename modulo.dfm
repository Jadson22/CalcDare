﻿object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 470
  Width = 509
  object fd: TFDConnection
    Params.Strings = (
      'Database=dbcaduceu_novo'
      'User_Name=root'
      'Compress=False'
      'Password=root'
      'Server=192.168.1.185'
      'DriverID=MySQL')
    FetchOptions.AssignedValues = [evItems]
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.AutoCommitUpdates = True
    Connected = True
    Left = 136
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 376
    Top = 8
  end
  object tb_gridiva: TFDTable
    Active = True
    IndexFieldNames = 'idProduto'
    Connection = fd
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert]
    UpdateOptions.UpdateTableName = 'dbcaduceu_novo.dbgridiva'
    TableName = 'dbcaduceu_novo.dbgridiva'
    Left = 32
    Top = 42
    object tb_gridivaidProduto: TIntegerField
      FieldName = 'idProduto'
      Origin = 'idProduto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tb_gridivaProduto: TStringField
      FieldName = 'Produto'
      Origin = 'Produto'
      Required = True
      Size = 100
    end
    object tb_gridivaQuantidade: TSingleField
      FieldName = 'Quantidade'
      Origin = 'Quantidade'
      Required = True
    end
    object tb_gridivaValorUnitario: TSingleField
      FieldName = 'ValorUnitario'
      Origin = 'ValorUnitario'
      Required = True
    end
    object tb_gridivaValorTotal: TSingleField
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Required = True
    end
    object tb_gridivaIcmsDest: TSingleField
      FieldName = 'IcmsDest'
      Origin = 'IcmsDest'
      Required = True
    end
    object tb_gridivaIcmsEmit: TSingleField
      FieldName = 'IcmsEmit'
      Origin = 'IcmsEmit'
      Required = True
    end
    object tb_gridivaIcmsEmitTotal: TSingleField
      FieldName = 'IcmsEmitTotal'
      Origin = 'IcmsEmitTotal'
      Required = True
    end
    object tb_gridivaIva: TSingleField
      FieldName = 'Iva'
      Origin = 'Iva'
      Required = True
    end
    object tb_gridivaIvaTotal: TSingleField
      FieldName = 'IvaTotal'
      Origin = 'IvaTotal'
      Required = True
    end
    object tb_gridivaIcmsDestTotal: TSingleField
      FieldName = 'IcmsDestTotal'
      Origin = 'IcmsDestTotal'
      Required = True
    end
    object tb_gridivareduFarmaceutica: TSingleField
      FieldName = 'reduFarmaceutica'
      Origin = 'reduFarmaceutica'
      Required = True
    end
    object tb_gridivareduCestaBasica: TSingleField
      FieldName = 'reduCestaBasica'
      Origin = 'reduCestaBasica'
      Required = True
    end
    object tb_gridivaStIva: TSingleField
      FieldName = 'StIva'
      Origin = 'StIva'
      Required = True
    end
    object tb_gridivareduBebida: TSingleField
      FieldName = 'reduBebida'
      Origin = 'reduBebida'
      Required = True
    end
  end
  object queryIVACALC: TFDQuery
    CachedUpdates = True
    Connection = fd
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvGeneratorName, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields, uvAutoCommitUpdates]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    SQL.Strings = (
      'SELECT * FROM dbgridiva')
    Left = 32
    Top = 104
    object queryIVACALCidProduto: TIntegerField
      FieldName = 'idProduto'
      Origin = 'idProduto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object queryIVACALCProduto: TStringField
      FieldName = 'Produto'
      Origin = 'Produto'
      Required = True
      Size = 100
    end
    object queryIVACALCQuantidade: TSingleField
      FieldName = 'Quantidade'
      Origin = 'Quantidade'
      Required = True
    end
    object queryIVACALCValorUnitario: TSingleField
      FieldName = 'ValorUnitario'
      Origin = 'ValorUnitario'
      Required = True
    end
    object queryIVACALCValorTotal: TSingleField
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Required = True
    end
    object queryIVACALCIcmsDest: TSingleField
      FieldName = 'IcmsDest'
      Origin = 'IcmsDest'
      Required = True
    end
    object queryIVACALCIcmsEmit: TSingleField
      FieldName = 'IcmsEmit'
      Origin = 'IcmsEmit'
      Required = True
    end
    object queryIVACALCIcmsEmitTotal: TSingleField
      FieldName = 'IcmsEmitTotal'
      Origin = 'IcmsEmitTotal'
      Required = True
    end
    object queryIVACALCIva: TSingleField
      FieldName = 'Iva'
      Origin = 'Iva'
      Required = True
    end
    object queryIVACALCIvaTotal: TSingleField
      FieldName = 'IvaTotal'
      Origin = 'IvaTotal'
      Required = True
    end
    object queryIVACALCIcmsDestTotal: TSingleField
      FieldName = 'IcmsDestTotal'
      Origin = 'IcmsDestTotal'
      Required = True
    end
    object queryIVACALCreduFarmaceutica: TSingleField
      FieldName = 'reduFarmaceutica'
      Origin = 'reduFarmaceutica'
      Required = True
    end
    object queryIVACALCreduCestaBasica: TSingleField
      FieldName = 'reduCestaBasica'
      Origin = 'reduCestaBasica'
      Required = True
    end
    object queryIVACALCStIva: TSingleField
      FieldName = 'StIva'
      Origin = 'StIva'
      Required = True
    end
    object queryIVACALCreduBebida: TSingleField
      FieldName = 'reduBebida'
      Origin = 'reduBebida'
      Required = True
    end
  end
  object DS1: TDataSource
    DataSet = queryIVACALC
    Left = 32
    Top = 168
  end
  object queryLojas: TFDQuery
    CachedUpdates = True
    Connection = fd
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvGeneratorName, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields, uvAutoCommitUpdates]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    SQL.Strings = (
      'SELECT * FROM lojas')
    Left = 384
    Top = 72
    object queryLojasidlojas: TFDAutoIncField
      FieldName = 'idlojas'
      Origin = 'idlojas'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryLojasnome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      Size = 50
    end
    object queryLojasrazãoSocial: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'raz'#227'oSocial'
      Origin = '`raz'#227'oSocial`'
      Size = 50
    end
    object queryLojascnpj: TStringField
      FieldName = 'cnpj'
      Origin = 'cnpj'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
  end
  object tb_gridPauta: TFDTable
    Active = True
    IndexFieldNames = 'idProduto'
    Connection = fd
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert]
    UpdateOptions.UpdateTableName = 'dbcaduceu_novo.dbgridpauta'
    TableName = 'dbcaduceu_novo.dbgridpauta'
    Left = 232
    Top = 42
    object tb_gridPautaidProduto: TIntegerField
      FieldName = 'idProduto'
      Origin = 'idProduto'
      Required = True
    end
    object tb_gridPautaProduto: TStringField
      FieldName = 'Produto'
      Origin = 'Produto'
      Required = True
      Size = 50
    end
    object tb_gridPautaQuantidade: TSingleField
      FieldName = 'Quantidade'
      Origin = 'Quantidade'
      Required = True
    end
    object tb_gridPautaValorUnitario: TSingleField
      FieldName = 'ValorUnitario'
      Origin = 'ValorUnitario'
      Required = True
    end
    object tb_gridPautaValorTotal: TSingleField
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Required = True
    end
    object tb_gridPautaIcmsEmit: TSingleField
      FieldName = 'IcmsEmit'
      Origin = 'IcmsEmit'
      Required = True
    end
    object tb_gridPautaIcmsEmitTotal: TSingleField
      FieldName = 'IcmsEmitTotal'
      Origin = 'IcmsEmitTotal'
      Required = True
    end
    object tb_gridPautaPauta: TSingleField
      FieldName = 'Pauta'
      Origin = 'Pauta'
      Required = True
    end
    object tb_gridPautaPautaTotal: TSingleField
      FieldName = 'PautaTotal'
      Origin = 'PautaTotal'
      Required = True
    end
    object tb_gridPautaIcmsDest: TSingleField
      FieldName = 'IcmsDest'
      Origin = 'IcmsDest'
      Required = True
    end
    object tb_gridPautaIcmsDestTotal: TSingleField
      FieldName = 'IcmsDestTotal'
      Origin = 'IcmsDestTotal'
      Required = True
    end
    object tb_gridPautaIcmsStTotal: TSingleField
      FieldName = 'IcmsStTotal'
      Origin = 'IcmsStTotal'
      Required = True
    end
    object tb_gridPautaRedCestaBasica: TSingleField
      FieldName = 'RedCestaBasica'
      Origin = 'RedCestaBasica'
      Required = True
    end
    object tb_gridPautaRedBebida: TSingleField
      FieldName = 'RedBebida'
      Origin = 'RedBebida'
      Required = True
    end
    object tb_gridPautaValorDare: TSingleField
      FieldName = 'ValorDare'
      Origin = 'ValorDare'
      Required = True
    end
  end
  object queryPAUTACALC: TFDQuery
    CachedUpdates = True
    Connection = fd
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvGeneratorName, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields, uvAutoCommitUpdates]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    SQL.Strings = (
      'SELECT * FROM dbgridpauta')
    Left = 232
    Top = 104
    object queryPAUTACALCidProduto: TIntegerField
      FieldName = 'idProduto'
      Origin = 'idProduto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object queryPAUTACALCProduto: TStringField
      FieldName = 'Produto'
      Origin = 'Produto'
      Required = True
      Size = 50
    end
    object queryPAUTACALCQuantidade: TSingleField
      FieldName = 'Quantidade'
      Origin = 'Quantidade'
      Required = True
    end
    object queryPAUTACALCValorUnitario: TSingleField
      FieldName = 'ValorUnitario'
      Origin = 'ValorUnitario'
      Required = True
    end
    object queryPAUTACALCValorTotal: TSingleField
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Required = True
    end
    object queryPAUTACALCIcmsEmit: TSingleField
      FieldName = 'IcmsEmit'
      Origin = 'IcmsEmit'
      Required = True
    end
    object queryPAUTACALCIcmsEmitTotal: TSingleField
      FieldName = 'IcmsEmitTotal'
      Origin = 'IcmsEmitTotal'
      Required = True
    end
    object queryPAUTACALCPauta: TSingleField
      FieldName = 'Pauta'
      Origin = 'Pauta'
      Required = True
    end
    object queryPAUTACALCPautaTotal: TSingleField
      FieldName = 'PautaTotal'
      Origin = 'PautaTotal'
      Required = True
    end
    object queryPAUTACALCIcmsDest: TSingleField
      FieldName = 'IcmsDest'
      Origin = 'IcmsDest'
      Required = True
    end
    object queryPAUTACALCIcmsDestTotal: TSingleField
      FieldName = 'IcmsDestTotal'
      Origin = 'IcmsDestTotal'
      Required = True
    end
    object queryPAUTACALCIcmsStTotal: TSingleField
      FieldName = 'IcmsStTotal'
      Origin = 'IcmsStTotal'
      Required = True
    end
    object queryPAUTACALCRedCestaBasica: TSingleField
      FieldName = 'RedCestaBasica'
      Origin = 'RedCestaBasica'
      Required = True
    end
    object queryPAUTACALCRedBebida: TSingleField
      FieldName = 'RedBebida'
      Origin = 'RedBebida'
      Required = True
    end
    object queryPAUTACALCValorDare: TSingleField
      FieldName = 'ValorDare'
      Origin = 'ValorDare'
      Required = True
    end
  end
  object DS2: TDataSource
    DataSet = queryPAUTACALC
    Left = 232
    Top = 168
  end
  object tb_dareiva: TFDTable
    Active = True
    IndexFieldNames = 'iddareiva'
    Connection = fd
    UpdateOptions.UpdateTableName = 'dbcaduceu_novo.dareiva'
    TableName = 'dbcaduceu_novo.dareiva'
    Left = 136
    Top = 272
    object tb_dareivaiddareiva: TFDAutoIncField
      FieldName = 'iddareiva'
      Origin = 'iddareiva'
      ReadOnly = True
    end
    object tb_dareivadanfeIVA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'danfeIVA'
      Origin = 'danfeIVA'
      Size = 50
    end
    object tb_dareivachaveXMLIVA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'chaveXMLIVA'
      Origin = 'chaveXMLIVA'
      Size = 50
    end
    object tb_dareivaproduto: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'produto'
      Origin = 'produto'
      Size = 45
    end
    object tb_dareivaquantidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object tb_dareivavalorUnitario: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorUnitario'
      Origin = 'valorUnitario'
    end
    object tb_dareivavalorTotal: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorTotal'
      Origin = 'valorTotal'
    end
    object tb_dareivaicmsDest: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'icmsDest'
      Origin = 'icmsDest'
    end
    object tb_dareivaicmsEmit: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'icmsEmit'
      Origin = 'icmsEmit'
    end
    object tb_dareivabaseIcmsEmit: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIcmsEmit'
      Origin = 'baseIcmsEmit'
    end
    object tb_dareivabaseIcmsDest: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIcmsDest'
      Origin = 'baseIcmsDest'
    end
    object tb_dareivaiva: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'iva'
      Origin = 'iva'
    end
    object tb_dareivabaseIva: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIva'
      Origin = 'baseIva'
    end
    object tb_dareivareduFarmaceutica: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduFarmaceutica'
      Origin = 'reduFarmaceutica'
    end
    object tb_dareivareduCestaBasica: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduCestaBasica'
      Origin = 'reduCestaBasica'
    end
    object tb_dareivareduBebida: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduBebida'
      Origin = 'reduBebida'
    end
    object tb_dareivavalorDare: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorDare'
      Origin = 'valorDare'
    end
  end
  object tb_darepauta: TFDTable
    Active = True
    IndexFieldNames = 'iddarepauta'
    Connection = fd
    UpdateOptions.UpdateTableName = 'dbcaduceu_novo.darepauta'
    TableName = 'dbcaduceu_novo.darepauta'
    Left = 232
    Top = 272
    object tb_darepautaiddarepauta: TFDAutoIncField
      FieldName = 'iddarepauta'
      Origin = 'iddarepauta'
      ReadOnly = True
    end
    object tb_darepautadanfePAUTA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'danfePAUTA'
      Origin = 'danfePAUTA'
      Size = 50
    end
    object tb_darepautachaveXMLPAUTA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'chaveXMLPAUTA'
      Origin = 'chaveXMLPAUTA'
      Size = 50
    end
    object tb_darepautaproduto: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'produto'
      Origin = 'produto'
      Size = 100
    end
    object tb_darepautaquantidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object tb_darepautavalorUnitario: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorUnitario'
      Origin = 'valorUnitario'
    end
    object tb_darepautavalorTotal: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorTotal'
      Origin = 'valorTotal'
    end
    object tb_darepautaicmsDest: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'icmsDest'
      Origin = 'icmsDest'
    end
    object tb_darepautaicmsEmit: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'icmsEmit'
      Origin = 'icmsEmit'
    end
    object tb_darepautabaseIcmsDest: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIcmsDest'
      Origin = 'baseIcmsDest'
    end
    object tb_darepautabaseIcmsEmit: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIcmsEmit'
      Origin = 'baseIcmsEmit'
    end
    object tb_darepautapauta: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'pauta'
      Origin = 'pauta'
    end
    object tb_darepautabasePauta: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'basePauta'
      Origin = 'basePauta'
    end
    object tb_darepautareduCestaBasica: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduCestaBasica'
      Origin = 'reduCestaBasica'
    end
    object tb_darepautareduBebida: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduBebida'
      Origin = 'reduBebida'
    end
    object tb_darepautacredEmitStDest: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'credEmitStDest'
      Origin = 'credEmitStDest'
    end
    object tb_darepautavalorDare: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorDare'
      Origin = 'valorDare'
    end
  end
  object tb_dadosnfedare: TFDTable
    Active = True
    IndexFieldNames = 'danfe;chaveXML'
    Connection = fd
    UpdateOptions.UpdateTableName = 'dbcaduceu_novo.dadosnfedare'
    TableName = 'dbcaduceu_novo.dadosnfedare'
    Left = 40
    Top = 272
  end
  object queryDadosNfeDare: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM dadosnfedare')
    Left = 40
    Top = 344
    object queryDadosNfeDaredanfe: TIntegerField
      FieldName = 'danfe'
      Origin = 'danfe'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object queryDadosNfeDarechaveXML: TStringField
      FieldName = 'chaveXML'
      Origin = 'chaveXML'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 100
    end
    object queryDadosNfeDarefornecedor: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'fornecedor'
      Origin = 'fornecedor'
      Size = 100
    end
    object queryDadosNfeDarecnpjFornecedor: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cnpjFornecedor'
      Origin = 'cnpjFornecedor'
      Size = 50
    end
    object queryDadosNfeDareieFornecedor: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ieFornecedor'
      Origin = 'ieFornecedor'
      Size = 50
    end
    object queryDadosNfeDarecfop: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cfop'
      Origin = 'cfop'
      Size = 50
    end
    object queryDadosNfeDareufEmitente: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ufEmitente'
      Origin = 'ufEmitente'
      Size = 30
    end
    object queryDadosNfeDareufDestinatario: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ufDestinatario'
      Origin = 'ufDestinatario'
      Size = 30
    end
    object queryDadosNfeDarerazaoSocialDestinatario: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'razaoSocialDestinatario'
      Origin = 'razaoSocialDestinatario'
      Size = 100
    end
    object queryDadosNfeDarecnpjDestinatario: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cnpjDestinatario'
      Origin = 'cnpjDestinatario'
      Size = 50
    end
    object queryDadosNfeDareieDestinatario: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ieDestinatario'
      Origin = 'ieDestinatario'
      Size = 50
    end
    object queryDadosNfeDaredataEmissaoDare: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'dataEmissaoDare'
      Origin = 'dataEmissaoDare'
    end
    object queryDadosNfeDaredataVencimentoDare: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'dataVencimentoDare'
      Origin = 'dataVencimentoDare'
    end
    object queryDadosNfeDareobservacao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'observacao'
      Origin = 'observacao'
      Size = 200
    end
    object queryDadosNfeDaretotalDare: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'totalDare'
      Origin = 'totalDare'
    end
    object queryDadosNfeDaretotalBaseCalculo: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'totalBaseCalculo'
      Origin = 'totalBaseCalculo'
    end
    object queryDadosNfeDaretotalIcmsDestTotal: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'totalIcmsDestTotal'
      Origin = 'totalIcmsDestTotal'
    end
    object queryDadosNfeDaretotalCredIcmsEmit: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'totalCredIcmsEmit'
      Origin = 'totalCredIcmsEmit'
    end
    object queryDadosNfeDarestatus: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'status'
      Origin = 'status'
      Size = 45
    end
    object queryDadosNfeDarefecoep: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'fecoep'
      Origin = 'fecoep'
    end
  end
  object queryDareIva: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM dareiva')
    Left = 136
    Top = 344
    object queryDareIvaiddareiva: TFDAutoIncField
      FieldName = 'iddareiva'
      Origin = 'iddareiva'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryDareIvadanfeIVA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'danfeIVA'
      Origin = 'danfeIVA'
      Size = 50
    end
    object queryDareIvachaveXMLIVA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'chaveXMLIVA'
      Origin = 'chaveXMLIVA'
      Size = 50
    end
    object queryDareIvaproduto: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'produto'
      Origin = 'produto'
      Size = 45
    end
    object queryDareIvaquantidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object queryDareIvavalorUnitario: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorUnitario'
      Origin = 'valorUnitario'
    end
    object queryDareIvavalorTotal: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorTotal'
      Origin = 'valorTotal'
    end
    object queryDareIvaicmsDest: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'icmsDest'
      Origin = 'icmsDest'
    end
    object queryDareIvaicmsEmit: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'icmsEmit'
      Origin = 'icmsEmit'
    end
    object queryDareIvabaseIcmsEmit: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIcmsEmit'
      Origin = 'baseIcmsEmit'
    end
    object queryDareIvabaseIcmsDest: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIcmsDest'
      Origin = 'baseIcmsDest'
    end
    object queryDareIvaiva: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'iva'
      Origin = 'iva'
    end
    object queryDareIvabaseIva: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIva'
      Origin = 'baseIva'
    end
    object queryDareIvareduFarmaceutica: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduFarmaceutica'
      Origin = 'reduFarmaceutica'
    end
    object queryDareIvareduCestaBasica: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduCestaBasica'
      Origin = 'reduCestaBasica'
    end
    object queryDareIvareduBebida: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduBebida'
      Origin = 'reduBebida'
    end
    object queryDareIvavalorDare: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorDare'
      Origin = 'valorDare'
    end
  end
  object queryDarePauta: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM darepauta')
    Left = 232
    Top = 344
    object queryDarePautaiddarepauta: TFDAutoIncField
      FieldName = 'iddarepauta'
      Origin = 'iddarepauta'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryDarePautadanfePAUTA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'danfePAUTA'
      Origin = 'danfePAUTA'
      Size = 50
    end
    object queryDarePautachaveXMLPAUTA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'chaveXMLPAUTA'
      Origin = 'chaveXMLPAUTA'
      Size = 50
    end
    object queryDarePautaproduto: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'produto'
      Origin = 'produto'
      Size = 100
    end
    object queryDarePautaquantidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object queryDarePautavalorUnitario: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorUnitario'
      Origin = 'valorUnitario'
    end
    object queryDarePautavalorTotal: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorTotal'
      Origin = 'valorTotal'
    end
    object queryDarePautaicmsDest: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'icmsDest'
      Origin = 'icmsDest'
    end
    object queryDarePautaicmsEmit: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'icmsEmit'
      Origin = 'icmsEmit'
    end
    object queryDarePautabaseIcmsDest: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIcmsDest'
      Origin = 'baseIcmsDest'
    end
    object queryDarePautabaseIcmsEmit: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'baseIcmsEmit'
      Origin = 'baseIcmsEmit'
    end
    object queryDarePautapauta: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'pauta'
      Origin = 'pauta'
    end
    object queryDarePautabasePauta: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'basePauta'
      Origin = 'basePauta'
    end
    object queryDarePautareduCestaBasica: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduCestaBasica'
      Origin = 'reduCestaBasica'
    end
    object queryDarePautareduBebida: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'reduBebida'
      Origin = 'reduBebida'
    end
    object queryDarePautacredEmitStDest: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'credEmitStDest'
      Origin = 'credEmitStDest'
    end
    object queryDarePautavalorDare: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valorDare'
      Origin = 'valorDare'
    end
  end
  object DS3: TDataSource
    DataSet = queryDadosNfeDare
    Left = 40
    Top = 392
  end
  object tb_log: TFDTable
    Active = True
    IndexFieldNames = 'idlog'
    Connection = fd
    UpdateOptions.UpdateTableName = 'dbcaduceu_novo.logs'
    TableName = 'dbcaduceu_novo.logs'
    Left = 352
    Top = 272
  end
  object queryUsuario: TFDQuery
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM usuario')
    Left = 424
    Top = 272
  end
end
