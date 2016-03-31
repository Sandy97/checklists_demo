object GroupsResource1: TGroupsResource1
  OldCreateOrder = False
  Height = 311
  Width = 347
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=IB'
      'CharacterSet=UTF8'
      
        'Database=C:\Users\asovtsov\OneDrive\'#1044#1086#1082#1091#1084#1077#1085#1090#1099'\Workshops\checklis' +
        'ts\data\CHECKLISTS.IB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 32
    Top = 56
  end
  object fdqGroups: TFDQuery
    Connection = FDConnection1
    Left = 120
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Left = 8
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 96
  end
  object fdqQuestions: TFDQuery
    Connection = FDConnection1
    Left = 120
    Top = 120
  end
end
