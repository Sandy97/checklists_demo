unit surveysRes;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Phys.IBBase, FireDAC.Comp.UI;

type
(*
//  Работа с опросами (передача и сохранение на сервере)
	GET 	/Surveys
	POST 	/Surveys

	GET 	/Surveys/Suresults
	POST 	/Surveys/Suresults/{tsk}

	GET 	/Surveys/Assignments
	POST 	/Surveys/Assignments/{tsk}
*)
  [ResourceName('Surveys')]
  TSurveysResource1 = class(TDataModule)
    FDConnection1: TFDConnection;
    fdqAssignment: TFDQuery;
    fdqSuResults: TFDQuery;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    fdqSuResultsSUID: TIntegerField;
    fdqSuResultsAVALUE: TIntegerField;
    fdqSuResultsWEIGHT: TSingleField;
    fdqSuResultsI_ID: TIntegerField;
    fdqSuResultsTSK_ID: TIntegerField;
    fdqTskResults: TFDQuery;
    fdqAssignments: TFDQuery;
  public
    constructor Create(AOwner: TComponent); override;
  published
    [EndpointName('GetSurveys')] // Name of the call to show in the analytics.
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [EndpointName('PostSurveys')] // Name of the call to show in the analytics.
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndpointName('GetSuresults')] // Name of the call to show in the analytics.
    [ResourceSuffix('Suresults/{tsk}')]
    procedure GetSuresults(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [EndpointName('PostSuresults')] // Name of the call to show in the analytics.
    [ResourceSuffix('Suresults')]
    procedure PostSuresults(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndpointName('PostAssignments')] // Name of the call to show in the analytics.
    [ResourceSuffix('Assignments')]
    procedure PostAssignments(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [EndpointName('GetAssignments')] // Name of the call to show in the analytics.
    [ResourceSuffix('Assignments/{tsk}')]
    procedure GetAssignments(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TSurveysResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  oStr: TMemoryStream;
begin
  oStr := TMemoryStream.Create;
  try
    fdqSuResults.Open;
    fdqAssignment.Open;
    FDSchemaAdapter1.SaveToStream(oStr, TFDStorageFormat.sfJSON);
    // Response owns stream
    AResponse.Body.SetStream(oStr, 'application/json', True);
  except
    oStr.Free;
  end;
end;

procedure TSurveysResource1.GetAssignments(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  oStr: TMemoryStream;
begin
  oStr := TMemoryStream.Create;
  try
    fdqAssignments.Close;
    fdqAssignments.SQL.Text := 'SELECT T.BYDATE,T.REP_ID,T.TSK_ID,T.I_ID, T.NOTES,T.TODO FROM ASSIGNMENT T where T.TSK_ID = :tsk';
    fdqAssignments.ParamByName('tsk').AsString := ARequest.Params.Values['tsk'];
    fdqAssignments.Open;
    fdqAssignments.SaveToStream(oStr,TFDStorageFormat.sfJSON);
    // Response owns the stream
    AResponse.Body.SetStream(oStr, 'application/json', True);
  except
    oStr.Free;
  end;
end;

procedure TSurveysResource1.GetSuresults(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  oStr: TMemoryStream;
begin
  oStr := TMemoryStream.Create;
  try
    fdqTskResults.Close;
    fdqTskResults.SQL.Text := 'SELECT T.SUID,T.AVALUE,T.WEIGHT,T.I_ID,T.TSK_ID FROM SURESULTS T where t.TSK_ID = :tsk';
    fdqTskResults.ParamByName('tsk').AsString := ARequest.Params.Values['tsk'];
    fdqTskResults.Open;
    fdqTskResults.SaveToStream(oStr,TFDStorageFormat.sfJSON);
    // Response owns the stream
    AResponse.Body.SetStream(oStr, 'application/json', True);
  except
    oStr.Free;
  end;
end;

procedure TSurveysResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LStream: TStream;
  iErrors: integer;
begin
  if not SameText(ARequest.Body.ContentType, 'application/json') then
    AResponse.RaiseBadRequest('content type');
  if not ARequest.Body.TryGetStream(LStream) then
    AResponse.RaiseBadRequest('no stream');
  LStream.Position := 0;
  FDSchemaAdapter1.LoadFromStream(LStream, TFDStorageFormat.sfJSON);
  (*
      FDConnection1.StartTransaction;
      iErrors := FDQuery1.ApplyUpdates;
      if iErrors = 0 then begin
        FDQuery1.CommitUpdates;
        FDConnection1.Commit;
      end
      else
        FDConnection1.Rollback;
  *)
  FDConnection1.StartTransaction;
  iErrors := FDSchemaAdapter1.ApplyUpdates(0);
  if iErrors = 0 then
    FDConnection1.Commit
  else
    FDConnection1.Rollback;
end;

procedure TSurveysResource1.PostAssignments(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  s: TStream;
begin
  if not SameText(ARequest.Body.ContentType, 'application/json') then
    AResponse.RaiseBadRequest('content type');
  if not ARequest.Body.TryGetStream(s) then
    AResponse.RaiseBadRequest('task: no stream');
  s.Position := 0;
  fdqAssignments.LoadFromStream(s, TFDStorageFormat.sfJSON);
  fdqAssignments.ApplyUpdates;
end;

procedure TSurveysResource1.PostSuresults(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  s: TStream;
begin
  if not SameText(ARequest.Body.ContentType, 'application/json') then
    AResponse.RaiseBadRequest('content type');
  if not ARequest.Body.TryGetStream(s) then
    AResponse.RaiseBadRequest('task: no stream');
  s.Position := 0;
  fdqTskResults.LoadFromStream(s, TFDStorageFormat.sfJSON);
  fdqTskResults.ApplyUpdates;
end;

constructor TSurveysResource1.Create(AOwner: TComponent);
begin
  inherited;
  try
    FDConnection1.Connected := True;
  except
    raise Exception.Create('You are seeing this exception because the ' +
                           'FDConnection on the DbDemosModule cannot find ' +
                           'the database. Please use the FireDAC connection ' +
                           'editor for the FDConnection to configure and test ' +
                           'your connection, and then try again.');
  end;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TSurveysResource1));
end;

initialization
  Register;
end.


