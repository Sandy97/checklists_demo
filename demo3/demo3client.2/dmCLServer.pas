unit dmCLServer;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Stan.StorageBin;

type
  TdmAdapter = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    fqTask: TFDQuery;
    fqSuresults: TFDQuery;
    fqCheckList: TFDQuery;
    fqPlaces: TFDQuery;
    fqTexts: TFDQuery;
    fqResponsible: TFDQuery;
    fqAssignment: TFDQuery;
    DataSource1: TDataSource;
    fqTaskTSK_ID: TIntegerField;
    fqTaskONDATE: TDateField;
    fqTaskBYDATE: TSQLTimeStampField;
    fqTaskPRIORITY: TLargeintField;
    fqTaskUSER_ID: TIntegerField;
    fqTaskCLTITLE: TWideStringField;
    fqTaskCLID: TIntegerField;
    fqTaskPLC_ID: TIntegerField;
    fqTaskCOMMENTS: TWideStringField;
    fqTaskSTATUS: TWideStringField;
    fqTaskDONE: TSQLTimeStampField;
    fqTaskNEXT_Q: TSmallintField;
    fqTaskPLC_NAME: TWideStringField;
    adaSuresultsAssignment: TFDSchemaAdapter;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime);
    procedure GetTasks(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
    procedure GetCLItems(tg: TFDDataset; const tskid, clid: integer);
    procedure GetTexts(tg: TFDDataset);
    procedure GetResponsible(tg: TFDDataset);
    procedure GetSuresults(tg: TFDDataset; const tskid : integer);
    procedure GetAssignments(tg: TFDDataset; const tskid : integer);
    procedure PostSuresults(sd: TFDDataset; const tskid : integer);
    procedure PostAssignments(sd: TFDDataset; const tskid : integer);
    procedure GetSuresultsSchema(tg: TFDSchemaAdapter; const tskid : integer);
    procedure PostSuresultsSchema(sda: TFDSchemaAdapter; const tskid : integer);
  end;

var
  dmAdapterSRV: TdmAdapter;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure LoadMemTableFromDS(ds: TFDQuery; tg: TFDDataset);  //TFDMemTable
begin
  // ex: FDMemTable1.CopyDataSet(DataSet1, [coStructure, coRestart, coAppend])
  ds.Open;
  ds.FetchAll;
  // tg.CopyDataSet(ds, [coStructure, coRestart, coAppend]);
  tg.Data := ds.Data;
  ds.Close;
  tg.First;
end;

{ TdmAdapter }

procedure TdmAdapter.GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime);
begin
  // Для отладки пока фиксированные значения
  usr_id := 19;
  wdate := StrToDate('29.09.2015');
end;

procedure TdmAdapter.GetAssignments(tg: TFDDataset; const tskid: integer);
begin
  fqAssignment.Close;
  fqAssignment.ParamByName('tskid').AsInteger := tskid;
  LoadMemTableFromDS(fqAssignment, tg);
end;

procedure TdmAdapter.GetCLItems(tg: TFDDataset; const tskid, clid: integer);
begin
  fqCheckList.Close;
  fqCheckList.ParamByName('CLID').AsInteger := clid;
  LoadMemTableFromDS(fqCheckList, tg);
end;

procedure TdmAdapter.GetResponsible(tg: TFDDataset);
begin
  fqResponsible.Close;
  LoadMemTableFromDS(fqResponsible, tg);
end;

procedure TdmAdapter.GetSuresults(tg: TFDDataset; const tskid: integer);
begin
  fqSuresults.Close;
  fqSuresults.ParamByName('tskid').AsInteger:= tskid;
  LoadMemTableFromDS(fqSuresults, tg);
end;

procedure TdmAdapter.GetSuresultsSchema(tg: TFDSchemaAdapter; const tskid: integer);
begin
  //
end;

procedure TdmAdapter.GetTasks(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
begin
  fqTask.Close;
  fqTask.ParamByName('USER_ID').AsInteger := usrid;
  fqTask.ParamByName('ONDATE').AsDateTime := wdate;
  LoadMemTableFromDS(fqTask, tg);
end;

procedure TdmAdapter.GetTexts(tg: TFDDataset);
begin
  LoadMemTableFromDS(fqTexts, tg);
end;

procedure TdmAdapter.PostAssignments(sd: TFDDataset; const tskid: integer);
begin
  //
end;

procedure TdmAdapter.PostSuresults(sd: TFDDataset; const tskid: integer);
begin
  //
end;

procedure TdmAdapter.PostSuresultsSchema(sda: TFDSchemaAdapter; const tskid: integer);
begin
  //
end;

end.
