object dmSrvData: TdmSrvData
  OldCreateOrder = False
  Height = 318
  Width = 268
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 180
    Top = 16
  end
  object EMSProviderCLv2: TEMSProvider
    ApiVersion = '1'
    URLHost = 'mslasovt02'
    URLPort = 8080
    Left = 32
    Top = 16
  end
  object BackendEndpoint1: TBackendEndpoint
    Provider = EMSProviderCLv2
    Params = <>
    Response = GetResponse1
    Left = 36
    Top = 108
  end
  object GetResponse1: TRESTResponse
    ContentType = 'application/json'
    ContentEncoding = 'csWIN1251'
    Left = 108
    Top = 84
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 94
    Top = 36
  end
end
