unit uLocalData;

interface

uses
  System.SysUtils, System.Variants, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI, CLInterfaces, System.Classes;

type
  TdmMobile = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    mtClitems: TFDMemTable;
    mtSuresults: TFDMemTable;
    mtSuresultsSUID: TIntegerField;
    mtSuresultsAVALUE: TIntegerField;
    mtSuresultsWEIGHT: TSingleField;
    mtSuresultsI_ID: TIntegerField;
    mtSuresultsTSK_ID: TIntegerField;
    mtTask: TFDMemTable;
    mtTexts: TFDMemTable;
    mtAssignment: TFDMemTable;
    mtResponsible: TFDMemTable;
    FDMemTable1: TFDMemTable;
  private
    { Private declarations }
    FFAdapter: ICLDataAPI;
    procedure SetFAdapter(const Value: ICLDataAPI);
  public
    { Public declarations }
    Property FAdapter: ICLDataAPI read FFAdapter write SetFAdapter;
    function DecodeTextRef(ref: integer): string;
    function GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime) : boolean;
    procedure GetCLItems(const tskid, clid: integer);
    procedure GetDictionaries;
    procedure LoadWDayCLS(const usrid: integer; const cdate: TDatetime);
    procedure LoadTasks(const usrid: integer; const cdate: TDatetime);
    procedure PrepareResults(const tskid: integer);
    function StartWDay(const usr_id: integer; const wdate: TDatetime): boolean;
    function CloseWDay(const usr_id: integer; const wdate: TDatetime): boolean;
    procedure RestoreAppData(rdr: TBinaryReader);
    procedure SaveAppData(wrt: TBinaryWriter);
    procedure StoreResults(const tskid: integer);
    function isResultChecked(const tsk_id, item_id: integer): boolean;
    function TasksStatused(const Status: String): integer;
  end;

var
  dmMobile: TdmMobile;

implementation

{ %CLASSGROUP 'System.Classes.TPersistent' }

{$R *.dfm}

function TdmMobile.isResultChecked(const tsk_id, item_id: integer): boolean;
var
  val: integer;
begin
  Result := False;
  if mtSuresults.Locate('TSK_ID;I_ID', VarArrayOf([tsk_id, item_id]), []) then
  begin
    val := dmMobile.mtSuresults.FieldByName('AVALUE').AsInteger;
    Result := (val > 0);
  end;
end;

function TdmMobile.DecodeTextRef(ref: integer): string;
begin
  Result := '-';
  if mtTexts.Locate('tx_id', ref, []) then
    Result := mtTexts.FieldByName('tx_caption').AsString;
end;

function TdmMobile.GetAccess(const usrnm, psw: string; var usr_id: integer;
  var wdate: TDatetime): boolean;
begin
  Result := False;
  FAdapter.GetAccess(usrnm, psw, usr_id, wdate);
  if (usr_id > 0) and (wdate > 0) then
    Result := True;
end;

procedure TdmMobile.GetCLItems(const tskid, clid: integer);
begin
  // получение списка вопросов для задачи и для формирования ListBox
  FAdapter.GetCLItems(mtClitems, tskid, clid);
  (* // Фильтрация не обязательна, если используется вызов FAdapter
    mtClitems.Filter:=format('CLID=%d',[clid]);
    mtClitems.Filtered:=True; *)
end;

procedure TdmMobile.LoadTasks(const usrid: integer; const cdate: TDatetime);
begin
  // Считывание с сервера списка задач на указанную дату
  // вариант: синхронизация еще не завершенных задач
  FAdapter.getTasks(mtTask, usrid, cdate);
end;

procedure TdmMobile.LoadWDayCLS(const usrid: integer; const cdate: TDatetime);
begin
  FAdapter.GetWDayCL(mtClitems, usrid, cdate);
end;

// подготовка и публикация SURESULTS & ASSIGNMENT
procedure TdmMobile.PrepareResults(const tskid: integer);
begin
  // Если в mtResults такие записи есть, то не затирать их
  if not mtSuresults.Locate('TSK_ID', VarArrayOf([tskid]), []) then
  begin
    FAdapter.GetSuresults(mtSuresults, tskid);
    FAdapter.GetAssignments(mtAssignment, tskid);
  end;
end;

procedure TdmMobile.GetDictionaries;
begin
  // считывание с сервера и синхронизация на устройстве справочников
  // Responsibles и Texts
  FAdapter.getTexts(mtTexts);
  FAdapter.getResponsible(mtResponsible);
end;

procedure TdmMobile.RestoreAppData(rdr: TBinaryReader);
begin
  // todo 1 :  восстановление рабочего состояния данных приложения после возврата к нему
end;

procedure TdmMobile.SaveAppData(wrt: TBinaryWriter);
begin
  // todo 1 : сохранение рабочего состояния данных приложения перед переключением на другое
end;

procedure TdmMobile.SetFAdapter(const Value: ICLDataAPI);
begin
  FFAdapter := Value;
end;

function TdmMobile.StartWDay(const usr_id: integer; const wdate: TDatetime): boolean;
begin
  // Заглушка для серии вебинаров
  Result := True;
end;

function TdmMobile.CloseWDay(const usr_id: integer; const wdate: TDatetime): boolean;
begin
  Result:=False;
  // store
  StoreResults(0);
  Result := True;
end;

procedure TdmMobile.StoreResults(const tskid: integer);
begin
  // Передача результатов заполнения анкеты для указанной задачи на сервер
  FAdapter.PostSuresults(mtSuresults, tskid);
  FAdapter.PostAssignments(mtAssignment, tskid);
  FAdapter.PostTasks(mtTask);
end;

function TdmMobile.TasksStatused(const Status: String): integer;
var
  tmds: TFDMemTable;
begin
  Result := 0;
  if not mtTask.Active then
    exit;
  try
    tmds := TFDMemTable.Create(Self);
    tmds.CloneCursor(mtTask, True, False);
    tmds.Filtered := False;
    tmds.Filter := 'STATUS=''' + Status + '''';
    tmds.Filtered := True;
    Result := tmds.RecordCount;
  finally
    tmds.Free;
  end;
end;

end.
