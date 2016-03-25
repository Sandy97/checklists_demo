object dmMobile: TdmMobile
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 607
  Width = 386
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 296
    Top = 8
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
    Left = 76
    Top = 168
  end
  object mtSuresults: TFDMemTable
    FieldDefs = <>
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
    Left = 48
    Top = 248
    object mtSuresultsSUID: TIntegerField
      FieldName = 'SUID'
      Required = True
    end
    object mtSuresultsAVALUE: TIntegerField
      FieldName = 'AVALUE'
    end
    object mtSuresultsWEIGHT: TSingleField
      FieldName = 'WEIGHT'
    end
    object mtSuresultsI_ID: TIntegerField
      FieldName = 'I_ID'
      Required = True
    end
    object mtSuresultsTSK_ID: TIntegerField
      FieldName = 'TSK_ID'
      Required = True
    end
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
  object mtAssignment: TFDMemTable
    FieldDefs = <
      item
        Name = 'BYDATE'
        DataType = ftTimeStamp
      end
      item
        Name = 'REP_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TSK_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'I_ID'
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
    Left = 120
    Top = 260
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
    Top = 108
  end
end
