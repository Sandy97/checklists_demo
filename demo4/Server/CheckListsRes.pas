unit CheckListsRes;

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
{
GET
  /Checklists         - список всех анкет
  /Checklists/[cl_id] - список вопросов из указанной анкеты в порядке ввода
}
  [ResourceName('Checklists')]
  TChecklistsResource1 = class(TDataModule)
    FDConnection1: TFDConnection;
    fdqChecklists: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    fdqCL_Items: TFDQuery;
  public
      constructor Create(AOwner: TComponent); override;
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
    [ResourceSuffix('{clist}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TChecklistsResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqChecklists.SQL.Text := 'SELECT T.CLID,T.CLTITLE FROM CHECKLIST T';
    fdqChecklists.Open;
    fdqChecklists.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
  except
    ms.Free;
  end;
end;

procedure TChecklistsResource1.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest;
const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqCL_Items.SQL.Text :=
    'SELECT T.I_ID,T.IORDER,T.IWEIGHT,T.NEXT_IORD,T.IPROMPT_REF,T.GR_NAME_REF,T.GRID,T.CLID FROM CLITEMS T ' +
    ' where t.CLID = :CLID order by t.CLID,T.IORDER,T.GRID';
    fdqCL_Items.ParamByName('clid').AsString := ARequest.Params.Values['clist'];
    fdqCL_Items.Open;
    fdqCL_Items.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
  except
    ms.Free;
  end;
end;

constructor TChecklistsResource1.Create(AOwner: TComponent);
begin
  inherited;
  try
    FDConnection1.Connected := True;
  except
    raise Exception.Create('You are seeing this exception because the ' +
                           'FDConnection on the Module cannot find ' +
                           'the database. Please use the FireDAC connection ' +
                           'editor for the FDConnection to configure and test ' +
                           'your connection, and then try again.');
  end;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TChecklistsResource1));
end;

initialization
  Register;
end.


