object dmAdapter: TdmAdapter
  OldCreateOrder = False
  Height = 607
  Width = 386
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=IB'
      'Database=C:\data\CL2V.IB'
      'InstanceName=gds_db'
      'Password=masterkey'
      'User_Name=sysdba'
      'CharacterSet=WIN1251')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 36
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 296
    Top = 8
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
    Left = 16
    Top = 156
    ParamData = <
      item
        Name = 'USER_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 19
      end
      item
        Name = 'ONDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 42276d
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
      'select * from suresults'
      'where tsk_id = :tskid')
    Left = 156
    Top = 200
    ParamData = <
      item
        Name = 'TSKID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 8
      end>
  end
  object fqCheckList: TFDQuery
    AggregatesActive = True
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT T.I_ID,T.IORDER,T.IWEIGHT,T.NEXT_IORD,T.IPROMPT_REF,T.GR_' +
        'NAME_REF,T.GRID,T.CLID FROM CLITEMS T'
      'where t.CLID = :CLID'
      'order by t.CLID,T.IORDER,T.GRID')
    Left = 76
    Top = 172
    ParamData = <
      item
        Name = 'CLID'
        DataType = ftString
        ParamType = ptInput
        Value = '8'
      end>
  end
  object fqPlaces: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT T.PLC_ID,T.PLC_NAME,T.PLC_ADDRESS,T.PLC_MANAGER,T.PLC_PHO' +
        'NE,T.PLC_STAFF,T.COMMENTS FROM PLACES T')
    Left = 204
    Top = 92
  end
  object fqTexts: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from TEXTS')
    Left = 140
    Top = 92
  end
  object fqResponsible: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT T.REP_ID,T.BOSS,T.REP_NAME,T.REP_PHONE FROM RESPONSIBLE T')
    Left = 272
    Top = 92
  end
  object fqAssignment: TFDQuery
    IndexFieldNames = 'TSK_ID;I_ID'
    MasterSource = DataSource1
    MasterFields = 'TSK_ID;I_ID'
    Connection = FDConnection1
    SchemaAdapter = adaSuresultsAssignment
    SQL.Strings = (
      'SELECT * FROM ASSIGNMENT T where T.tsk_id = :tskid')
    Left = 284
    Top = 248
    ParamData = <
      item
        Name = 'TSKID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 8
      end>
  end
  object DataSource1: TDataSource
    DataSet = fqSuresults
    Left = 228
    Top = 216
  end
  object adaSuresultsAssignment: TFDSchemaAdapter
    Left = 264
    Top = 168
  end
end
