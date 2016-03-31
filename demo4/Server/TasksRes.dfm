object TasksResource1: TTasksResource1
  OldCreateOrder = False
  Height = 323
  Width = 290
  object fdqTasks: TFDQuery
    CachedUpdates = True
    OnUpdateRecord = fdqTasksUpdateRecord
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT T.TSK_ID,T.ONDATE,T.BYDATE,T.PRIORITY,T.USER_ID,T.CLTITLE' +
        ', T.CLID,T.PLC_ID,T.COMMENTS, T.STATUS, T.DONE FROM TASKSV T')
    Left = 148
    Top = 120
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 120
    Top = 8
  end
  object fdqTaskItems: TFDQuery
    Connection = FDConnection1
    Left = 48
    Top = 160
  end
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
    Left = 32
    Top = 56
  end
  object usTasks: TFDUpdateSQL
    Connection = FDConnection1
    InsertSQL.Strings = (
      'INSERT INTO TASK'
      '(ONDATE, STATUS)'
      'VALUES (:NEW_ONDATE, :NEW_STATUS)')
    ModifySQL.Strings = (
      'UPDATE TASK'
      'SET ONDATE = :NEW_ONDATE, STATUS = :NEW_STATUS'
      'WHERE TSK_ID = :OLD_TSK_ID')
    Left = 176
    Top = 180
  end
end
