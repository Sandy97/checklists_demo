object ChecklistsResource1: TChecklistsResource1
  OldCreateOrder = False
  Height = 298
  Width = 320
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=IB'
      'CharacterSet=WIN1251'
      'Database=C:\data\CL2V.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'InstanceName=gds_db')
    LoginPrompt = False
    Left = 32
    Top = 56
  end
  object fdqChecklists: TFDQuery
    Connection = FDConnection1
    Left = 120
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Left = 8
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 120
    Top = 8
  end
  object fdqCL_Items: TFDQuery
    Connection = FDConnection1
    Left = 120
    Top = 120
  end
end
