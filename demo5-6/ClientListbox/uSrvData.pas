unit uSrvData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, IPPeerClient,
  REST.Backend.ServiceTypes, System.JSON, REST.Backend.EMSServices, FireDAC.Stan.StorageJSON,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, REST.Backend.EndPoint,
  REST.Backend.EMSProvider, FireDAC.Stan.Intf, FireDAC.Comp.UI, CLInterfaces,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmSrvData = class(TDataModule, ICLDataAPI)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    EMSProviderCLv2: TEMSProvider;
    BackendEndpoint1: TBackendEndpoint;
    GetResponse1: TRESTResponse;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
  private
    procedure SetServer(const Value: string);
    function GetServer(): string;
    { Private declarations }
  public
    { Public declarations }
    property Server: string read GetServer write SetServer;
    procedure GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime);
    procedure GetTasks(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
    procedure GetCLItems(tg: TFDDataset; const tskid, clid: integer);
    procedure GetWDayCL(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
    procedure GetTexts(tg: TFDDataset);
    procedure GetResponsible(tg: TFDDataset);
    procedure GetSuresults(tg: TFDDataset; const tskid: integer);
    procedure GetAssignments(tg: TFDDataset; const tskid: integer);
    procedure PostSuresults(sd: TFDDataset; const tskid: integer);
    procedure PostAssignments(sd: TFDDataset; const tskid: integer);
    procedure GetSuresultsSchema(tg: TFDSchemaAdapter; const tskid: integer);
    procedure PostSuresultsSchema(sda: TFDSchemaAdapter; const tskid: integer);
    procedure PostTasks(tg: TFDDataset);
  end;

var
  dmSrvData: TdmSrvData;

implementation

{ %CLASSGROUP 'FMX.Controls.TControl' }

uses
  FMX.Dialogs, REST.Types;

{ %CLASSGROUP 'System.Classes.TPersistent' }

{$R *.dfm}
{ TdmSrvData }

procedure TdmSrvData.GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime);
begin
  // Для отладки пока фиксированные значения
  usr_id := 19;
  wdate := StrToDate('29.09.2015');
  // showmessage('GetAccess');
end;

procedure TdmSrvData.GetAssignments(tg: TFDDataset; const tskid: integer);
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
    tg.Close;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
    // tg.SaveToFile('c:/abc/ass.json',TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
  // showmessage('GetAssignment');
end;

procedure TdmSrvData.GetCLItems(tg: TFDDataset; const tskid, clid: integer);
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
  // showmessage('GetCLItems');
end;

procedure TdmSrvData.GetResponsible(tg: TFDDataset);
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
  // showmessage('GetResponsibles');
end;

function TdmSrvData.GetServer: string;
begin
  result := EMSProviderCLv2.URLHost;
end;

procedure TdmSrvData.GetSuresults(tg: TFDDataset; const tskid: integer);
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
    tg.Close;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
  // showmessage('GetSuresults');
end;

procedure TdmSrvData.GetSuresultsSchema(tg: TFDSchemaAdapter; const tskid: integer);
begin
  (*
    Заготовка для другого варианта реализации
  *)
  // showmessage('GetSUresultsSchema');
end;

procedure TdmSrvData.GetWDayCL(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
  // todo 1 : получение всех CLitems из всех CL из задания на день
var
  s: TMemoryStream;
begin
  BackendEndpoint1.Method := rmGet;
  BackendEndpoint1.Params.Clear;
  BackendEndpoint1.Resource := format('checklists/ondate/%d/%s', [usrid, DateToStr(wdate)]);
  BackendEndpoint1.Execute;
  s := TMemoryStream.Create;
  try
    s.Write(GetResponse1.RawBytes, Length(GetResponse1.RawBytes));
    s.Position := 0;
    tg.Close;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
end;

procedure TdmSrvData.GetTasks(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
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
    tg.Close;
    tg.LoadFromStream(s, TFDStorageFormat.sfJSON);
  finally
    s.Free;
  end;
  // showmessage('GetTasks');
end;

procedure TdmSrvData.GetTexts(tg: TFDDataset);
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
  // showmessage('GetTexts');
end;

procedure TdmSrvData.PostAssignments(sd: TFDDataset; const tskid: integer);
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
  // showmessage('PostAssignments');
end;

procedure TdmSrvData.PostSuresults(sd: TFDDataset; const tskid: integer);
var
  m: TMemoryStream;
  bs: string;
begin
  m := TMemoryStream.Create;
  //try
    sd.SaveToStream(m, TFDStorageFormat.sfJSON);
    m.Position := 0;
    BackendEndpoint1.Resource := 'surveys/suresults';
    BackendEndpoint1.Method := rmPost;
    BackendEndpoint1.AddBody(m, TRESTContentType.ctAPPLICATION_JSON);
    bs:=BackendEndpoint1.Response.JSONText;
    BackendEndpoint1.Execute;
  //finally
  //  m.Free;
  //end;
  // showmessage('PostSuresults');
end;

procedure TdmSrvData.PostSuresultsSchema(sda: TFDSchemaAdapter; const tskid: integer);
begin
  (* Заготовка для другого варианта реализации  *)
  showmessage('PostSuresultsSchema');
end;

procedure TdmSrvData.PostTasks(tg: TFDDataset);
var
  m: TMemoryStream;
begin
  m := TMemoryStream.Create;
  tg.SaveToStream(m, TFDStorageFormat.sfJSON);
  m.Position := 0;
  BackendEndpoint1.Resource := 'tasks';
  BackendEndpoint1.Method := rmPost;
  BackendEndpoint1.AddBody(m, TRESTContentType.ctAPPLICATION_JSON);
  BackendEndpoint1.Execute;     //executeasync()
  // showmessage('PostTasks');
end;

procedure TdmSrvData.SetServer(const Value: string);
begin
  EMSProviderCLv2.URLHost := Value;
end;

end.
