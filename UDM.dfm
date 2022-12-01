object DM: TDM
  OldCreateOrder = False
  Height = 226
  Width = 344
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Users\aluno\Desktop\Calculator\BD\BD.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = FDConnection1AfterConnect
    BeforeConnect = FDConnection1BeforeConnect
    Left = 24
    Top = 16
  end
  object FDQVeiculo: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from veiculo')
    Left = 88
    Top = 16
    object FDQVeiculoidcarro: TFDAutoIncField
      FieldName = 'idcarro'
      Origin = 'idcarro'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQVeiculoplaca: TStringField
      FieldName = 'placa'
      Origin = 'placa'
      Size = 7
    end
    object FDQVeiculodescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 50
    end
    object FDQVeiculoqtdTanque: TIntegerField
      FieldName = 'qtdTanque'
      Origin = 'qtdTanque'
    end
    object FDQVeiculomediaG: TBCDField
      FieldName = 'mediaG'
      Origin = 'mediaG'
      Precision = 8
      Size = 2
    end
    object FDQVeiculomediaE: TBCDField
      FieldName = 'mediaE'
      Origin = 'mediaE'
      Precision = 8
      Size = 2
    end
    object FDQVeiculomediaD: TWideStringField
      FieldName = 'mediaD'
      Origin = 'mediaD'
      Size = 32767
    end
  end
  object FDQLogin: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from login'
      'where email =:pEmail')
    Left = 152
    Top = 16
    ParamData = <
      item
        Name = 'PEMAIL'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object FDQLoginidlogin: TFDAutoIncField
      FieldName = 'idlogin'
      Origin = 'idlogin'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQLoginemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Required = True
      Size = 50
    end
    object FDQLoginsenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 200
    end
  end
  object FDQViagem: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from viagem')
    Left = 224
    Top = 16
    object FDQViagemidviagem: TFDAutoIncField
      FieldName = 'idviagem'
      Origin = 'idviagem'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQViagemorigem: TStringField
      FieldName = 'origem'
      Origin = 'origem'
      Size = 100
    end
    object FDQViagemorigemlatitude: TFMTBCDField
      FieldName = 'origemlatitude'
      Origin = 'origemlatitude'
      Precision = 10
    end
    object FDQViagemorigemlongitude: TFMTBCDField
      FieldName = 'origemlongitude'
      Origin = 'origemlongitude'
      Precision = 10
    end
    object FDQViagemdestino: TStringField
      FieldName = 'destino'
      Origin = 'destino'
      Size = 100
    end
    object FDQViagemdestinolatitude: TFMTBCDField
      FieldName = 'destinolatitude'
      Origin = 'destinolatitude'
      Precision = 10
    end
    object FDQViagemdestinolongitude: TFMTBCDField
      FieldName = 'destinolongitude'
      Origin = 'destinolongitude'
      Precision = 10
    end
    object FDQViagemvalorgasolina: TFMTBCDField
      FieldName = 'valorgasolina'
      Origin = 'valorgasolina'
      Precision = 10
    end
    object FDQViagemvaloretanol: TFMTBCDField
      FieldName = 'valoretanol'
      Origin = 'valoretanol'
      Precision = 10
    end
    object FDQViagemvalordiesel: TFMTBCDField
      FieldName = 'valordiesel'
      Origin = 'valordiesel'
      Precision = 10
    end
    object FDQViagemidveiculoviagem: TWideStringField
      FieldName = 'idveiculoviagem'
      Origin = 'idveiculoviagem'
      Size = 32767
    end
  end
end
