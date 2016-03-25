object dmMobile: TdmMobile
  OldCreateOrder = False
  Height = 620
  Width = 342
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 204
    Top = 20
  end
  object mtPlaces: TFDMemTable
    FieldDefs = <
      item
        Name = 'PLC_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'PLC_NAME'
        DataType = ftWideString
        Size = 400
      end
      item
        Name = 'PLC_ADDRESS'
        DataType = ftWideString
        Size = 2000
      end
      item
        Name = 'PLC_MANAGER'
        DataType = ftWideString
        Size = 400
      end
      item
        Name = 'PLC_PHONE'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 60
      end
      item
        Name = 'PLC_STAFF'
        DataType = ftWideString
        Size = 2000
      end
      item
        Name = 'COMMENTS'
        DataType = ftWideString
        Size = 4000
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 184
    Top = 96
  end
  object mtResponsible: TFDMemTable
    FieldDefs = <
      item
        Name = 'REP_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'BOSS'
        DataType = ftInteger
      end
      item
        Name = 'REP_NAME'
        DataType = ftWideString
        Size = 400
      end
      item
        Name = 'REP_PHONE'
        Attributes = [faFixed]
        DataType = ftFixedWideChar
        Size = 60
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 248
    Top = 96
  end
  object mtClitems: TFDMemTable
    FieldOptions.AutoCreateMode = acCombineAlways
    FieldDefs = <
      item
        Name = 'I_ID'
        DataType = ftInteger
      end
      item
        Name = 'IORDER'
        DataType = ftLargeint
      end
      item
        Name = 'IWEIGHT'
        DataType = ftSingle
        Precision = 8
      end
      item
        Name = 'NEXT_IORD'
        DataType = ftLargeint
      end
      item
        Name = 'IPROMPT_REF'
        DataType = ftInteger
      end
      item
        Name = 'GR_NAME_REF'
        DataType = ftInteger
      end
      item
        Name = 'GRID'
        DataType = ftInteger
      end
      item
        Name = 'CLID'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 44
    Top = 212
    object mtClitemsI_ID: TIntegerField
      FieldName = 'I_ID'
    end
    object mtClitemsIORDER: TLargeintField
      FieldName = 'IORDER'
    end
    object mtClitemsIWEIGHT: TSingleField
      FieldName = 'IWEIGHT'
    end
    object mtClitemsNEXT_IORD: TLargeintField
      FieldName = 'NEXT_IORD'
    end
    object mtClitemsIPROMPT_REF: TIntegerField
      FieldName = 'IPROMPT_REF'
    end
    object mtClitemsGR_NAME_REF: TIntegerField
      FieldName = 'GR_NAME_REF'
    end
    object mtClitemsGRID: TIntegerField
      FieldName = 'GRID'
    end
    object mtClitemsCLID: TIntegerField
      FieldName = 'CLID'
    end
    object mtClitemscliGrName: TStringField
      FieldKind = fkLookup
      FieldName = 'cliGrName'
      LookupDataSet = mtTexts
      LookupKeyFields = 'TX_ID'
      LookupResultField = 'TX_CAPTION'
      KeyFields = 'GR_NAME_REF'
      Size = 100
      Lookup = True
    end
    object mtClitemscliPrompt: TStringField
      FieldKind = fkLookup
      FieldName = 'cliPrompt'
      LookupDataSet = mtPrompt
      LookupKeyFields = 'TX_ID'
      LookupResultField = 'TX_CAPTION'
      KeyFields = 'IPROMPT_REF'
      Size = 100
      Lookup = True
    end
  end
  object mtSuresults: TFDMemTable
    FieldDefs = <
      item
        Name = 'SUID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'AVALUE'
        DataType = ftInteger
      end
      item
        Name = 'WEIGHT'
        DataType = ftSingle
        Precision = 8
      end
      item
        Name = 'I_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TSK_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 132
    Top = 192
  end
  object mtAssignment: TFDMemTable
    FieldDefs = <
      item
        Name = 'SUID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOTES'
        DataType = ftWideString
        Size = 2000
      end
      item
        Name = 'TODO'
        DataType = ftWideString
        Size = 2000
      end
      item
        Name = 'BYDATE'
        DataType = ftTimeStamp
      end
      item
        Name = 'REP_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <>
    MasterSource = DataSource1
    MasterFields = 'SUID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 192
    Top = 244
  end
  object mtTask: TFDMemTable
    FieldDefs = <
      item
        Name = 'TSK_ID'
        DataType = ftInteger
      end
      item
        Name = 'ONDATE'
        DataType = ftDate
      end
      item
        Name = 'BYDATE'
        DataType = ftTimeStamp
      end
      item
        Name = 'PRIORITY'
        DataType = ftLargeint
      end
      item
        Name = 'USER_ID'
        DataType = ftInteger
      end
      item
        Name = 'CLTITLE'
        DataType = ftWideString
        Size = 400
      end
      item
        Name = 'CLID'
        DataType = ftInteger
      end
      item
        Name = 'PLC_ID'
        DataType = ftInteger
      end
      item
        Name = 'COMMENTS'
        DataType = ftWideString
        Size = 4000
      end
      item
        Name = 'STATUS'
        DataType = ftWideString
        Size = 16
      end
      item
        Name = 'DONE'
        DataType = ftTimeStamp
      end
      item
        Name = 'NEXT_Q'
        DataType = ftSmallint
      end
      item
        Name = 'PLC_NAME'
        DataType = ftWideString
        Size = 400
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 32
    Top = 128
  end
  object mtTexts: TFDMemTable
    FieldDefs = <
      item
        Name = 'TX_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TX_CAPTION'
        DataType = ftWideString
        Size = 200
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 116
    Top = 96
  end
  object mtPrompt: TFDMemTable
    FieldDefs = <
      item
        Name = 'TX_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TX_CAPTION'
        DataType = ftWideString
        Size = 200
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 72
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = mtSuresults
    Left = 216
    Top = 184
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=IB'
      'Database=C:\data\CL2V.IB'
      'InstanceName=gds_db'
      'Password=masterkey'
      'User_Name=sysdba'
      'CharacterSet=WIN1251')
    LoginPrompt = False
    Left = 36
    Top = 440
  end
  object fqTask: TFDQuery
    FieldOptions.AutoCreateMode = acCombineAlways
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT'
      '    T.TSK_ID,'
      '    T.ONDATE,'
      '    T.BYDATE,'
      '    T.PRIORITY,'
      '    T.USER_ID,'
      '    T.CLTITLE,'
      '    T.CLID,'
      '    T.PLC_ID,'
      '    T.COMMENTS,'
      '    T.STATUS,'
      '    T.DONE,'
      '    T.NEXT_Q,'
      '    T.PLC_NAME'
      'FROM TASKSV T'
      'WHERE'
      '    T.USER_ID = :user_id '
      '    AND'
      '    T.ONDATE = :ondate')
    Left = 56
    Top = 508
    ParamData = <
      item
        Name = 'USER_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '19'
      end
      item
        Name = 'ONDATE'
        DataType = ftString
        ParamType = ptInput
        Value = '2015.09.29'
      end>
    object fqTaskTSK_ID: TIntegerField
      FieldName = 'TSK_ID'
      Origin = 'TSK_ID'
    end
    object fqTaskONDATE: TDateField
      FieldName = 'ONDATE'
      Origin = 'ONDATE'
    end
    object fqTaskBYDATE: TSQLTimeStampField
      FieldName = 'BYDATE'
      Origin = 'BYDATE'
    end
    object fqTaskPRIORITY: TLargeintField
      FieldName = 'PRIORITY'
      Origin = 'PRIORITY'
    end
    object fqTaskUSER_ID: TIntegerField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
    end
    object fqTaskCLTITLE: TWideStringField
      FieldName = 'CLTITLE'
      Origin = 'CLTITLE'
      Size = 400
    end
    object fqTaskCLID: TIntegerField
      FieldName = 'CLID'
      Origin = 'CLID'
    end
    object fqTaskPLC_ID: TIntegerField
      FieldName = 'PLC_ID'
      Origin = 'PLC_ID'
    end
    object fqTaskCOMMENTS: TWideStringField
      FieldName = 'COMMENTS'
      Origin = 'COMMENTS'
      Size = 4000
    end
    object fqTaskSTATUS: TWideStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Size = 16
    end
    object fqTaskDONE: TSQLTimeStampField
      FieldName = 'DONE'
      Origin = 'DONE'
    end
    object fqTaskNEXT_Q: TSmallintField
      FieldName = 'NEXT_Q'
      Origin = 'NEXT_Q'
    end
    object fqTaskPLC_NAME: TWideStringField
      FieldName = 'PLC_NAME'
      Origin = 'PLC_NAME'
      Size = 400
    end
  end
  object fqSuresults: TFDQuery
    Connection = FDConnection1
    SchemaAdapter = adaSuresultsAssignment
    SQL.Strings = (
      'select * from suresults')
    Left = 152
    Top = 508
  end
  object fqCheckList: TFDQuery
    AggregatesActive = True
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT T.I_ID,T.IORDER,T.IWEIGHT,T.NEXT_IORD,T.IPROMPT_REF,T.GR_' +
        'NAME_REF,T.GRID,T.CLID FROM CLITEMS T'
      'where t.CLID = :CLID'
      'order by t.CLID,T.IORDER,T.GRID')
    Left = 108
    Top = 524
    ParamData = <
      item
        Name = 'CLID'
        DataType = ftString
        ParamType = ptInput
        Value = '8'
      end>
    object fqCheckListI_ID: TIntegerField
      FieldName = 'I_ID'
      Origin = 'I_ID'
    end
    object fqCheckListIORDER: TLargeintField
      FieldName = 'IORDER'
      Origin = 'IORDER'
    end
    object fqCheckListIWEIGHT: TSingleField
      FieldName = 'IWEIGHT'
      Origin = 'IWEIGHT'
    end
    object fqCheckListNEXT_IORD: TLargeintField
      FieldName = 'NEXT_IORD'
      Origin = 'NEXT_IORD'
    end
    object fqCheckListIPROMPT_REF: TIntegerField
      FieldName = 'IPROMPT_REF'
      Origin = 'IPROMPT_REF'
    end
    object fqCheckListGR_NAME_REF: TIntegerField
      FieldName = 'GR_NAME_REF'
      Origin = 'GR_NAME_REF'
    end
    object fqCheckListGRID: TIntegerField
      FieldName = 'GRID'
      Origin = 'GRID'
    end
    object fqCheckListCLID: TIntegerField
      FieldName = 'CLID'
      Origin = 'CLID'
    end
  end
  object fqPlaces: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT T.PLC_ID,T.PLC_NAME,T.PLC_ADDRESS,T.PLC_MANAGER,T.PLC_PHO' +
        'NE,T.PLC_STAFF,T.COMMENTS FROM PLACES T')
    Left = 140
    Top = 456
  end
  object fqTexts: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from TEXTS')
    Left = 88
    Top = 456
  end
  object fqResponsible: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT T.REP_ID,T.BOSS,T.REP_NAME,T.REP_PHONE FROM RESPONSIBLE T')
    Left = 188
    Top = 456
  end
  object fqAssignment: TFDQuery
    IndexFieldNames = 'TSK_ID;I_ID'
    MasterFields = 'TSK_ID;I_ID'
    Connection = FDConnection1
    SchemaAdapter = adaSuresultsAssignment
    SQL.Strings = (
      'SELECT * FROM ASSIGNMENT T ')
    Left = 212
    Top = 544
  end
  object adaSuresultsAssignment: TFDSchemaAdapter
    Left = 240
    Top = 488
  end
end
