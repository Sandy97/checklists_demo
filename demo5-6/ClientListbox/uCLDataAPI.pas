unit uCLDataAPI;

interface

uses CLInterfaces, FireDAC.Comp.UI, REST.Backend.EMSProvider,
  REST.Backend.EndPoint, REST.Client, FireDAC.Stan.StorageJSON,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Classes;

const
  cContentType = 'application/json';
  cContentEncoding = 'csWIN1251';

type
  TCLDataApi = class(TComponent, {TInterfacedObject,} ICLDataAPI)
  private
    { Private declarations }
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    EMSProviderCLv2: TEMSProvider;
    BackendEndpoint1: TBackendEndpoint;
    GetResponse1: TRESTResponse;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
  public
    { Public declarations }
    constructor Create(const URLHost: string = 'localhost'; const URLPort: integer = 8080;
      const URLBasePath: string = '');
    procedure GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime);
    procedure GetTasks(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
    procedure GetCLItems(tg: TFDDataset; const tskid, clid: integer);
    procedure GetTexts(tg: TFDDataset);
    procedure GetResponsible(tg: TFDDataset);
    procedure GetSuresults(tg: TFDDataset; const tskid: integer);
    procedure GetAssignments(tg: TFDDataset; const tskid: integer);
    procedure PostSuresults(sd: TFDDataset; const tskid: integer);
    procedure PostAssignments(sd: TFDDataset; const tskid: integer);
    procedure GetSuresultsSchema(tg: TFDSchemaAdapter; const tskid: integer);
    procedure PostSuresultsSchema(sda: TFDSchemaAdapter; const tskid: integer);

  end;

implementation

uses
  System.SysUtils, FireDAC.Stan.Intf, REST.Types;

{ TCLDataApi }

constructor TCLDataApi.Create(const URLHost: string = 'localhost'; const URLPort: integer = 8080;
  const URLBasePath: string = '');
begin
  FDGUIxWaitCursor1 := TFDGUIxWaitCursor.Create(self);
  FDGUIxWaitCursor1.Provider := 'FMX';
  EMSProviderCLv2 := TEMSProvider.Create(self);
  EMSProviderCLv2.URLHost := URLHost;
  EMSProviderCLv2.URLPort := URLPort;
  EMSProviderCLv2.URLBasePath := URLBasePath;
  GetResponse1 := TRESTResponse.Create(self);
  GetResponse1.ContentType := cContentType;
  GetResponse1.ContentEncoding := cContentEncoding;
  BackendEndpoint1 := TBackendEndpoint.Create(self);
  BackendEndpoint1.Response := GetResponse1;
  FDStanStorageJSONLink1 := TFDStanStorageJSONLink.Create(self);

end;

procedure TCLDataApi.GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime);
begin
  // Для отладки пока фиксированные значения
  usr_id := 19;
  wdate := StrToDate('29.09.2015');
end;

procedure TCLDataApi.GetAssignments(tg: TFDDataset; const tskid: integer);
var
  s: TMemoryStream;
begin
  BackendEndpoint1.Method := rmGet;
  BackendEndpoint1.Params.Clear;
  BackendEndpoint1.Resource := format('surveys/assignments/%d', [tskid]);
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
    s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
    s.Position := 0;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
end;

procedure TCLDataApi.GetCLItems(tg: TFDDataset; const tskid, clid: integer);
var
  s: TMemoryStream;
begin
  BackendEndpoint1.Method := rmGet;
  BackendEndpoint1.Params.Clear;
  BackendEndpoint1.Resource := format('checklists/%d', [clid]);
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
    s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
    s.Position := 0;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
end;

procedure TCLDataApi.GetResponsible(tg: TFDDataset);
var
  s: TMemoryStream;
begin
  BackendEndpoint1.Method := rmGet;
  BackendEndpoint1.Params.Clear;
  BackendEndpoint1.Resource := 'dictionaries/persons';
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
    s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
    s.Position := 0;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
end;

procedure TCLDataApi.GetSuresults(tg: TFDDataset; const tskid: integer);
var
  s: TMemoryStream;
begin
  BackendEndpoint1.Method := rmGet;
  BackendEndpoint1.Params.Clear;
  BackendEndpoint1.Resource := format('surveys/suresults/%d', [tskid]);
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
    s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
    s.Position := 0;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
end;

procedure TCLDataApi.GetTasks(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
var
  s: TMemoryStream;
begin
  BackendEndpoint1.Method := rmGet;
  BackendEndpoint1.Params.Clear;
  BackendEndpoint1.Resource := format('tasks/ondate/%d/%s', [usrid, DateToStr(wdate)]);
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
    s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
    s.Position := 0;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
end;

procedure TCLDataApi.GetTexts(tg: TFDDataset);
var
  s: TMemoryStream;
begin
  BackendEndpoint1.Method := rmGet;
  BackendEndpoint1.Params.Clear;
  BackendEndpoint1.Resource := 'dictionaries/texts';
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
    s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
    s.Position := 0;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
end;

procedure TCLDataApi.PostAssignments(sd: TFDDataset; const tskid: integer);
var
  m: TMemoryStream;
begin
  m := TMemoryStream.Create;
  sd.SaveToStream(m, TFDStorageFormat.sfJSON);
  m.Position := 0;
  BackendEndpoint1.Resource := 'surveys/assignments';
  BackendEndpoint1.Method := rmPost;
  BackendEndpoint1.AddBody(m, TRESTContentType.ctAPPLICATION_JSON);
  BackendEndpoint1.ExecuteAsync();
end;

procedure TCLDataApi.PostSuresults(sd: TFDDataset; const tskid: integer);
var
  m: TMemoryStream;
begin
  m := TMemoryStream.Create;
  try
    sd.SaveToStream(m, TFDStorageFormat.sfJSON);
    m.Position := 0;
    BackendEndpoint1.Resource := 'surveys/suresults';
    BackendEndpoint1.Method := rmPost;
    BackendEndpoint1.AddBody(m, TRESTContentType.ctAPPLICATION_JSON);
    BackendEndpoint1.ExecuteAsync();
  finally
    m.Free;
  end;
end;

procedure TCLDataApi.GetSuresultsSchema(tg: TFDSchemaAdapter; const tskid: integer);
begin
  // todo 1 : sgsgs
end;

procedure TCLDataApi.PostSuresultsSchema(sda: TFDSchemaAdapter; const tskid: integer);
begin
  // todo 1 : sdfghjkl
end;

(* procedure TCLDataApi.GetGivenEndPointDataSet(tg: TFDDataset);
  var
  // s: TStringStream;
  s: TMemoryStream;
  begin
  BackendEndpoint1.Method := rmGet;
  BackendEndpoint1.Params.Clear;
  if Edit1.Text = '' then
  begin
  BackendEndpoint1.Resource := 'Categories';
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
  s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
  s.Position := 0;
  tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
  s.Free;
  end;
  end
  else
  begin
  BackendEndpoint1.Resource := Edit1.Text;
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
  s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
  s.Position := 0;
  tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
  s.Free;
  end;
  end;
  tg.CachedUpdates := True;
  end; *)

end.
