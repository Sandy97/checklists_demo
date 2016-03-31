object DictionariesResource1: TDictionariesResource1
  OldCreateOrder = False
  Height = 361
  Width = 338
  object fdqDictionaries: TFDQuery
    Connection = FDConnection1
    Left = 32
    Top = 24
  end
  object fsaDictionaries: TFDSchemaAdapter
    Left = 136
    Top = 112
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 160
    Top = 16
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\data\CL2V.IB'
      'User_Name=sysdba'
      'DriverID=IB'
      'CharacterSet=WIN1251'
      'Password=masterkey'
      'InstanceName=gds_db')
    LoginPrompt = False
    Left = 212
    Top = 68
  end
  object fdqLogin: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      '')
    Left = 24
    Top = 96
  end
end
