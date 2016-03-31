unit ThingsModuleu;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.StrUtils,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.VCLUI.Wait;

type
  [ResourceName('Things')]
  TThingResource = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
  public
    constructor Create(AOwner: TComponent); override;
  published
    procedure Get(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure PutItem(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure DeleteItem(const AContext: TEndpointContext;
      const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;


implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


procedure Register;
begin
  RegisterResource(TypeInfo(TThingResource));
end;

function GetGuid: string;
var
  GUID: TGUID;
begin
  CreateGUID(GUID);
  Result := GuidToString(GUID);
end;

procedure TThingResource.Get(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ja: TJSONArray;
  jo, jr: TJSONObject;
  FDQuery: TFDQuery;
  i: integer;
begin
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := FDConnection1;
  FDQuery.SQL.Text := 'SELECT ThingID, ThingName FROM MYTHINGS';
  FDQuery.Open();
  try
    ja := TJSONArray.Create;
    while not FDQuery.Eof do
    begin
      jo := TJSONObject.Create;

      for i := 0 to FDQuery.FieldCount - 1 do
      begin
        jo.AddPair(TJSONString.Create(FDQuery.FieldDefs.Items[i].Name),
                   TJSONString.Create(FDQuery.Fields[i].AsString));
      end;
      ja.AddElement(jo);
      FDQuery.Next;
    end;
    jr := TJSONObject.Create(TJSONPair.Create('response', ja));
    AResponse.Body.SetValue(jr, True);
  finally
    FDQuery.Close;
  end;
end;

procedure TThingResource.GetItem(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ja: TJSONArray;
  jo: TJSONObject;
  FDQuery: TFDQuery;
  ThingID: string;
begin
  ThingID := ARequest.Params.Values['item'];
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := FDConnection1;
  FDQuery.SQL.Text := 'SELECT ThingID, ThingName FROM MYTHINGS WHERE ThingID = :id';
  FDQuery.Params[0].AsString := ThingID;
  FDQuery.Open();
  if FDQuery.RecordCount = 0 then
    AREsponse.RaiseNotFound('Item not found', ThingID + ' not found')
  else
  begin
    ja := TJSONArray.Create(TJSONString.Create(FDQuery.Fields[0].AsString),
                            TJSONString.Create(FDQuery.Fields[1].AsString));
    jo := TJSONObject.Create(TJSONPair.Create('response', ja));
    AResponse.Body.SetValue(jo, True);
  end;
  FDQuery.Close;
end;

procedure TThingResource.Post(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  FDQuery: TFDQuery;
  jo: TJSONObject;
  ja: TJSONArray;
  jv: TJSONValue;
begin
  if ARequest.Body.TryGetObject(jo) then
  begin
    ja := jo.GetValue('request') as TJSONArray;
    FDQuery := TFDQuery.Create(nil);
    try
      FDQuery.Connection := FDConnection1;
      FDConnection1.StartTransaction;
      FDQuery.SQL.Text := 'EXECUTE PROCEDURE CreateOrUpdateThing( :id, :name)';
      try
        try
          for jv in ja do
          begin
            FDQuery.Params[0].AsString := GetGuid;
            FDQuery.Params[1].AsString := TJSONString(jv).Value;
            FDQuery.ExecSQL;
          end;
          FDConnection1.Commit;
          AResponse.Body.SetValue(TJSONObject.Create(
                                  TJSONPair.Create('response',
                                    IntToStr(ja.Count) +
                                    ' thing(s) created')), True);
        except
          FDConnection1.Rollback;
          AResponse.RaiseBadRequest('Error', 'Invalid data. POST aborted');
        end;
      finally
        FDQuery.Free;
      end;
    finally
      jo.Free;
    end;
  end
  else
    AResponse.RaiseBadRequest('Error', 'JSON expected in message body');
end;

procedure TThingResource.PutItem(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  FDQuery: TFDQuery;
  jo: TJSONObject;
  ja: TJSONArray;
  jv: TJSONValue;
begin

  jo := TJSONObject.ParseJSONValue(ARequest.Params.Values['Item']) as TJSONObject;

  try
    ja := jo.GetValue('request') as TJSONArray;
    FDQuery := TFDQuery.Create(nil);
    try
      FDQuery.Connection := FDConnection1;
      FDQuery.SQL.Text := 'EXECUTE PROCEDURE CreateOrUpdateThing( :id, :name)';
      FDQuery.Params[0].AsString := ja.Items[0].Value;
      FDQuery.Params[1].AsString := ja.Items[1].Value;
      try
        FDQuery.ExecSQL;
      except
        AResponse.RaiseBadRequest('Error', 'Invalid data. PUT aborted');
      end;
     finally
      FDQuery.Free;
    end;
  except
    AResponse.RaiseBadRequest('Bad request', 'Bad request. Expecting JSONArray');
  end;
end;

procedure TThingResource.DeleteItem(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ThingID: string;
  FDQuery: TFDQuery;
begin
  ThingID := ARequest.Params.Values['item'];
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDConnection1;
    FDQuery.SQL.Text := 'DELETE FROM MyThings WHERE ThingID = :id';
    FDQuery.Params[0].AsString := ThingID;
    FDQuery.ExecSQL;
  finally
    FDQuery.Free;
  end;
end;

constructor TThingResource.Create(AOwner: TComponent);
var
  FDMetaInfoQuery1: TFDMetaInfoQuery;
begin
  inherited;
  try
    FDConnection1.Connected := True;
  except
    raise Exception.Create('You are seeing this exception because the ' +
                           'FDConnection on the ThingModule cannot find ' +
                           'the database. Please use the FireDAC connection ' +
                           'editor for the FDConnection to configure and test ' +
                           'your connection, and then try again.');

  end;
  FDMetaInfoQuery1 := TFDMetaInfoQuery.Create(nil);
  try
    FDMetaInfoQuery1.MetaInfoKind := mkTables;
    FDMetaInfoQuery1.TableKinds := [tkTable];
    FDMetaInfoQuery1.Filter := '[TABLE_NAME] = ''MYTHINGS''';
    FDMetaInfoQuery1.Connection := FDConnection1;
    FDMetaInfoQuery1.Filtered := True;
    FDMetaInfoQuery1.Open();
    if FDMetaInfoQuery1.RecordCount = 0 then
    begin
      FDConnection1.ExecSQL('CREATE TABLE MYTHINGS (' +
                              'ThingID CHAR(42) NOT NULL, ' +
                              'ThingName CHAR(100), ' +
                              'PRIMARY KEY (ThingID))');
    end;
    FDMetaInfoQuery1.Close;
    FDMetaInfoQuery1.MetaInfoKind := mkProcs;
    FDMetaInfoQuery1.Filter := '[PROC_NAME] = ''CREATEORUPDATETHING''';
    FDMetaInfoQuery1.Connection := FDConnection1;
    FDMetaInfoQuery1.Filtered := True;
    FDMetaInfoQuery1.Open();
    if FDMetaInfoQuery1.RecordCount = 0 then
    begin
      FDConnection1.ExecSQL('CREATE PROCEDURE CREATEORUPDATETHING(' +
                            '  ID CHAR(42), ' +
                            '  NAME CHAR(100) )' +
                            ' AS ' +
                            '  DECLARE VARIABLE cnt INTEGER; ' +
                            'BEGIN ' +
                            ' SELECT COUNT(ThingID) FROM MyThings ' +
                            '    WHERE ThingID = :ID INTO :cnt; ' +
                            '  IF (:cnt = 0) THEN ' +
                            '  BEGIN ' +
                            '    INSERT INTO MyThings (ThingID, ThingName) ' +
                            '       VALUES( :id, :name); ' +
                            '  END ' +
                            '  ELSE ' +
                            '  BEGIN ' +
                            '    UPDATE MyThings ' +
                            '      SET ThingName = :name ' +
                            '      WHERE ThingID = :ID; ' +
                            '  END ' +
                            'END');
    end;
  finally
    FDMetaInfoQuery1.Free;
  end;
end;

initialization
  Register;
end.


