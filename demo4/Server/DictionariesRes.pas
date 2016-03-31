unit DictionariesRes;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageJSON;

type
  {
  GET
  /Dictionaries/Persons
  /Dictionaries/Places
  /Dictionaries/Users
  }
  [ResourceName('Dictionaries')]
  TDictionariesResource1 = class(TDataModule)
    fdqDictionaries: TFDQuery;
    fsaDictionaries: TFDSchemaAdapter;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDConnection1: TFDConnection;
    fdqLogin: TFDQuery;
  public
    constructor Create(AOwner: TComponent); override;
  published
   [ResourceSuffix('Persons')]
    procedure GetPersons(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
   [ResourceSuffix('Places')]
    procedure GetPlaces(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
   [ResourceSuffix('Texts')]
    procedure GetTexts(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
   [ResourceSuffix('Users')]
    procedure GetUsers(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
   [ResourceSuffix('Login/{usrnm}/{psw}')]
    procedure GetAccess(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
system.Character;


constructor TDictionariesResource1.Create(AOwner: TComponent);
begin
  inherited;
  try
    FDConnection1.Connected := True;
  except
    raise Exception.Create('You are seeing this exception because the ' +
                           'FDConnection on this unit cannot find ' +
                           'the database. Please use the FireDAC connection ' +
                           'editor for the FDConnection to configure and test ' +
                           'your connection, and then try again.');
  end;
end;

procedure TDictionariesResource1.GetAccess(const AContext: TEndpointContext;const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqLogin.SQL.Text := 'SELECT T.USER_ID, T.USER_ROLE,(select current_date from rdb$database) as CURDATE ' +
                         ' FROM USERS T where UPPER(t.USER_NAME) = :user_nm ';
    fdqLogin.ParamByName('user_nm').AsString := ToUpper(ARequest.Params.Values['usrnm']);
    //fdqLogin.ParamByName('pswtok').AsString := ARequest.Params.Values['psw'];
    fdqLogin.Open;
    fdqLogin.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json', True);
    fdqLogin.Close;
  except
    ms.Free;
  end;
end;

procedure TDictionariesResource1.GetPersons(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqDictionaries.SQL.Text := 'SELECT T.REP_ID,T.BOSS,T.REP_NAME,T.REP_PHONE FROM RESPONSIBLE T';
    fdqDictionaries.Open;
    fdqDictionaries.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json;charset=UTF-8', True);
    fdqDictionaries.Close;
  except
    ms.Free;
  end;
end;

procedure TDictionariesResource1.GetPlaces(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqDictionaries.SQL.Text := 'SELECT T.PLC_ID,T.PLC_NAME,T.PLC_ADDRESS,T.PLC_MANAGER,T.PLC_PHONE,T.PLC_STAFF,T.COMMENTS FROM PLACES T';
    fdqDictionaries.Open;
    fdqDictionaries.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json;charset=UTF-8', True);
    fdqDictionaries.Close;
  except
    ms.Free;
  end;
end;

procedure TDictionariesResource1.GetTexts(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqDictionaries.SQL.Text := 'SELECT	t.TX_ID, t.TX_CAPTION FROM TEXTS t';
    fdqDictionaries.Open;
    fdqDictionaries.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json;charset=UTF-8', True);
    fdqDictionaries.Close;
  except
    ms.Free;
  end;
end;

procedure TDictionariesResource1.GetUsers(const AContext: TEndpointContext;
  const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    fdqDictionaries.SQL.Text := 'SELECT T.USER_ID,T.USER_NAME,T.USER_ROLE,T.USER_CONTACTS FROM USERS T';
    fdqDictionaries.Open;
    fdqDictionaries.SaveToStream(ms, TFDStorageFormat.sfJSON);
    AResponse.Body.SetStream(ms, 'application/json;charset=UTF-8', True);
    fdqDictionaries.Close;
  except
    ms.Free;
  end;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TDictionariesResource1));
end;

initialization
  Register;
end.


