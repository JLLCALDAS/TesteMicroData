object dtmClienteContato: TdtmClienteContato
  OldCreateOrder = False
  Height = 415
  Width = 541
  object cnxClienteContato: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\DES\Documents\Embarcadero\Studio\Projects\Win3' +
        '2\TesteMicroData\DataBase\TESTE_MICRODATA.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=localhost'
      'Port=3051'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 14
  end
  object qryCliente: TFDQuery
    Connection = cnxClienteContato
    SQL.Strings = (
      'select * from cliente')
    Left = 48
    Top = 70
    object qryClienteID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryClienteNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object qryClienteCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Required = True
      Size = 8
    end
    object qryClienteLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Required = True
      Size = 60
    end
    object qryClienteNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Required = True
      Size = 10
    end
    object qryClienteCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Required = True
      Size = 40
    end
    object qryClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Required = True
      Size = 40
    end
    object qryClienteIBGE_CIDADE: TStringField
      FieldName = 'IBGE_CIDADE'
      Origin = 'IBGE_CIDADE'
      Required = True
      Size = 7
    end
    object qryClienteSIGLA_UF: TStringField
      FieldName = 'SIGLA_UF'
      Origin = 'SIGLA_UF'
      Required = True
      Size = 2
    end
    object qryClienteIBGE_UF: TStringField
      FieldName = 'IBGE_UF'
      Origin = 'IBGE_UF'
      Required = True
      Size = 2
    end
  end
end
