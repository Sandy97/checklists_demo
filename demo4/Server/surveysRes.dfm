object SurveysResource1: TSurveysResource1
  OldCreateOrder = False
  Height = 330
  Width = 374
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=IB'
      'CharacterSet=WIN1251'
      'Database=C:\data\CL2V.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'InstanceName=gds_db')
    Connected = True
    LoginPrompt = False
    Left = 44
    Top = 20
  end
  object fdqAssignment: TFDQuery
    Active = True
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      
        'SELECT'#9't.BYDATE, t.REP_ID, t.TSK_ID, t.I_ID, t.NOTES, t.TODO FRO' +
        'M ASSIGNMENT t')
    Left = 56
    Top = 200
  end
  object fdqSuResults: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from suresults')
    Left = 24
    Top = 152
    object fdqSuResultsSUID: TIntegerField
      FieldName = 'SUID'
      Origin = 'SUID'
      Required = True
    end
    object fdqSuResultsAVALUE: TIntegerField
      FieldName = 'AVALUE'
      Origin = 'AVALUE'
    end
    object fdqSuResultsWEIGHT: TSingleField
      FieldName = 'WEIGHT'
      Origin = 'WEIGHT'
    end
    object fdqSuResultsI_ID: TIntegerField
      FieldName = 'I_ID'
      Origin = 'I_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqSuResultsTSK_ID: TIntegerField
      FieldName = 'TSK_ID'
      Origin = 'TSK_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 128
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Left = 232
    Top = 12
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 176
    Top = 4
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 280
    Top = 40
  end
  object fdqTskResults: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 168
    Top = 140
  end
  object fdqAssignments: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT T.BYDATE,T.REP_ID,T.TSK_ID,T.I_ID, T.NOTES,T.TODO FROM AS' +
        'SIGNMENT T')
    Left = 204
    Top = 184
  end
end
