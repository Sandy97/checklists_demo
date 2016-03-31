unit GroupsRes;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Stan.StorageJSON, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  [ResourceName('Categories')]
  TGroupsResource1 = class(TDataModule)
    FDConnection1: TFDConnection;
    fdqGroups: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    fdqQuestions: TFDQuery;
  public
    constructor Create(AOwner: TComponent); override;
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('Questions/{item}')]
    procedure GetQuestions(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

constructor TGroupsResource1.Create(AOwner: TComponent);
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

procedure TGroupsResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  fdqGroups.Close;
  try
    fdqGroups.SQL.Text := 'SELECT T.G_ID,T.PARENT_LINK,T.GR_NAME,T.GR_DESCRIPTION FROM QGROUP T';
    //CustomersQuery.Params[0].AsString := ARequest.Params.Values['data'];
    fdqGroups.Open;
    fdqGroups.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
  except
    ms.Free;
  end;end;

procedure TGroupsResource1.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqGroups.SQL.Text := 'SELECT T.G_ID,T.PARENT_LINK,T.GR_NAME,T.GR_DESCRIPTION FROM QGROUP T where T.G_ID=:g_id';
    fdqGroups.ParamByName('g_id').AsString := ARequest.Params.Values['item'];
    fdqGroups.Open;
    fdqGroups.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
  except
    ms.Free;
  end;
end;

procedure TGroupsResource1.GetQuestions(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqQuestions.SQL.Text := 'SELECT G.G_ID,G.GR_NAME,Q.Q_ID,Q.Q_PROMPT,Q.Q_TYPE,Q.Q_REQ,Q.Q_WEIGHT,Q.PICTURE' +
                             '  FROM QGROUP_QUESTION GQ, QGROUP G, QUESTION Q ' +
                             '  WHERE G.G_ID=GQ.G_ID AND Q.Q_ID = GQ.Q_ID AND G.G_ID=:g_id';
    fdqQuestions.ParamByName('g_id').AsString := ARequest.Params.Values['item'];
    fdqQuestions.Open;
    fdqQuestions.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
  except
    ms.Free;
  end;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TGroupsResource1));
end;

initialization
  Register;
end.


