object GroupsResource1: TGroupsResource1
  OldCreateOrder = False
  Height = 284
  Width = 296
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=IB'
      'CharacterSet=WIN1251'
      'Database=C:\data\CL2V.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'InstanceName=gds_db')
    LoginPrompt = False
    Left = 24
    Top = 56
  end
  object fdqGroups: TFDQuery
    Connection = FDConnection1
    Left = 120
    Top = 56
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 128
  end
  object fdqQuestions: TFDQuery
    Connection = FDConnection1
    Left = 120
    Top = 120
  end
end
