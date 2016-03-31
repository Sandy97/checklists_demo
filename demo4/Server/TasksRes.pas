unit TasksRes;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Comp.DataSet;

type
{
GET
   /Tasks                         - список всех задач
   /Tasks/[tsk_id]                - содержание конкретной задачи (не об€зательно)
   /Tasks/OnDate/[user_id]/[date] - список всех заданий пользовател€ на дату
POST
   /Tasks
PUT
   /Tasks/[tsk_id]                - модификаци€ конкретной задачи (не об€зательно)
DELETE
   /Tasks/[tsk_id]                - удаление конкретной задачи (не об€зательно)
}
  [ResourceName('Tasks')]
  TTasksResource1 = class(TDataModule)
    fdqTasks: TFDQuery;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    fdqTaskItems: TFDQuery;
    FDConnection1: TFDConnection;
    usTasks: TFDUpdateSQL;
    procedure fdqTasksUpdateRecord(ASender: TDataSet; ARequest: TFDUpdateRequest;
      var AAction: TFDErrorAction; AOptions: TFDUpdateRowOptions);
  public
    constructor Create(AOwner: TComponent); override;
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('OnDate/{usrid}/{idate}')]
    procedure GetOnDate(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TTasksResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqTasks.SQL.Text := 'SELECT T.TSK_ID,T.ONDATE,T.BYDATE,T.PRIORITY,T.USER_ID,T.CLTITLE, T.CLID,T.PLC_ID,T.COMMENTS, T.STATUS, T.DONE FROM TASKSV T';
    fdqTasks.Open;
    fdqTasks.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
  except
    ms.Free;
  end;
end;

procedure TTasksResource1.GetOnDate(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqTaskItems.SQL.Text := 'SELECT T.TSK_ID, T.ONDATE, T.BYDATE, T.PRIORITY, T.USER_ID, T.CLTITLE,'+
                          ' T.CLID, T.PLC_ID, T.COMMENTS, T.STATUS, T.DONE, T.NEXT_Q, T.PLC_NAME ' +
                          ' FROM TASKSV T WHERE T.USER_ID = :user_id AND T.ONDATE = :ondate ';
    fdqTaskItems.ParamByName('user_id').AsString := ARequest.Params.Values['usrid'];
    fdqTaskItems.ParamByName('ondate').AsString := ARequest.Params.Values['idate'];
    fdqTaskItems.Open;
    fdqTaskItems.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
    fdqTaskItems.Close;
  except
    ms.Free;
  end;
end;

procedure TTasksResource1.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqTaskItems.SQL.Text := 'SELECT T.TSK_ID,T.ONDATE,T.BYDATE,T.PRIORITY,T.USER_ID,T.CLTITLE,' +
                                ' T.CLID,T.PLC_ID,T.COMMENTS FROM TASKSV T WHERE T.TSK_ID = :tsk';
    fdqTaskItems.ParamByName('tsk').AsString := ARequest.Params.Values['item'];
    fdqTaskItems.Open;
    fdqTaskItems.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
    fdqTaskItems.Close;
  except
    ms.Free;
  end;
end;

procedure TTasksResource1.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  s: TStream;
  bs: string;
begin
  if not SameText(ARequest.Body.ContentType, 'application/json') then
    AResponse.RaiseBadRequest('content type');
  if not ARequest.Body.TryGetStream(s) then
    AResponse.RaiseBadRequest('task: no stream');
  bs:=ARequest.Body.GetValue.ToJSON;
  s.Position := 0;
  fdqTasks.LoadFromStream(s, TFDStorageFormat.sfJSON);
  fdqTasks.ApplyUpdates;
end;

procedure TTasksResource1.PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  //
  //  Ќе реализовано
  //
  LItem := ARequest.Params.Values['item'];
end;

constructor TTasksResource1.Create(AOwner: TComponent);
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

procedure TTasksResource1.DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  tskID: string;
  FDQuery: TFDQuery;
begin
  tskID := ARequest.Params.Values['item'];
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDConnection1;
    FDQuery.SQL.Text := 'DELETE FROM TASK WHERE TSK_ID = :id';
    FDQuery.Params[0].AsString := tskID;
    FDQuery.ExecSQL;
  finally
    FDQuery.Free;
  end;
end;

// –еализаци€ записи на сервере Ѕƒ каждой модифицированной записи Dataset (исходный запрос по VIEW с JOIN)
procedure TTasksResource1.fdqTasksUpdateRecord(ASender: TDataSet; ARequest: TFDUpdateRequest;
  var AAction: TFDErrorAction; AOptions: TFDUpdateRowOptions);
begin
  if not (ARequest in [arLock, arUnlock]) then begin
    usTasks.ConnectionName := fdqTasks.ConnectionName;
    usTasks.DataSet := fdqTasks;
    usTasks.Apply(ARequest, AAction, AOptions);
  end;
  AAction := eaApplied;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TTasksResource1));
end;

initialization
  Register;
end.


