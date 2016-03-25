unit dmClientLB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Stan.StorageBin, FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TdmMobile = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    mtPlaces: TFDMemTable;
    mtClitems: TFDMemTable;
    mtSuresults: TFDMemTable;
    mtTask: TFDMemTable;
    mtTexts: TFDMemTable;
    mtPrompt: TFDMemTable;
    mtSuresultsSUID: TIntegerField;
    mtSuresultsAVALUE: TIntegerField;
    mtSuresultsWEIGHT: TSingleField;
    mtSuresultsI_ID: TIntegerField;
    mtSuresultsTSK_ID: TIntegerField;
    mtAssignment: TFDMemTable;
    mtResponsible: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //procedure GetDebugData;
    //
    function GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime): boolean;
    procedure GetDictionaries;
    function FindTextName(ref: integer): string;
    procedure LoadTasks(const usrid: integer; const cdate: TDatetime);
    procedure GetCLItems(const tskid: integer; const clid: integer);
    procedure PrepareResults(const tskid: integer);
    procedure StoreResults(const tskid: integer);
    procedure SaveAppData;
    procedure RestoreAppData;
    function StartWDay(const usr_id: integer; const wdate: TDatetime): boolean;
    function CloseWDay(const usr_id: integer; const wdate: TDatetime): boolean;

  end;

var
  dmMobile: TdmMobile;

implementation

{ %CLASSGROUP 'FMX.Controls.TControl' }


uses dmCLServer;   //uses dmCLEMS;


{$R *.dfm}

var
    dmAdapter: TdmAdapter;

{ TdmMobile }

procedure TdmMobile.DataModuleCreate(Sender: TObject);
begin
  dmAdapter := TdmAdapter.Create(Self);
end;

function TdmMobile.FindTextName(ref: integer): string;
begin
  Result := '-';
  if mtTexts.Locate('tx_id', ref, []) then
    Result := mtTexts.FieldByName('tx_caption').AsString;
end;

function TdmMobile.GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime): boolean;
begin
  Result:= False;
  dmAdapter.GetAccess(usrnm, psw, usr_id, wdate);
  if (usr_id > 0) and (wdate > 0) then
    Result:=True;
end;

procedure TdmMobile.GetCLItems(const tskid, clid: integer);
begin
  // получение списка вопросов для задачи и для формирования ListBox
  dmAdapter.GetClitems(mtClitems,tskid,clid);  //LoadMemTableFromDS(dmAdapter.fqCheckList, mtClitems);
  (*// Фильтрация не обязательна, если используется вызов dmAdapter
    mtClitems.Filter:=format('CLID=%d',[clid]);
    mtClitems.Filtered:=True; *)
end;

procedure TdmMobile.GetDictionaries;
begin
  // считывание с сервера и синхронизация на устройстве справочников
  // Responsibles и Texts
  dmAdapter.getTexts(mtTexts);             // LoadMemTableFromDS(dmAdapter.fqTexts, mtTexts);
  dmAdapter.getResponsible(mtResponsible); //LoadMemTableFromDS(dmAdapter.fqResponsible, mtResponsible);
end;

procedure TdmMobile.LoadTasks(const usrid: integer; const cdate: TDatetime);
begin
  // Считывание с сервера списка задач на указанную дату
  // вариант: синхронизация еще не завершенных задач
  dmAdapter.getTasks(mtTask, usrid, cdate); //LoadMemTableFromDS(dmAdapter.fqTask, mtTask);
end;

procedure TdmMobile.PrepareResults(const tskid: integer);
begin
  //подготовка и публикация SURESULTS & ASSIGNMENT
  dmAdapter.GetSuresults(mtSuresults, tskid); // LoadMemTableFromDS(dmAdapter.fqSuresults, mtSuresults);
  dmAdapter.GetAssignments(mtAssignment, tskid); // LoadMemTableFromDS(dmAdapter.fqAssignment, mtAssignment);
end;

procedure TdmMobile.RestoreAppData;
begin
  // восстановление рабочего состояния данных приложения после возврата к нему
  //
end;

procedure TdmMobile.SaveAppData;
begin
  // сохранение рабочего состояния данных приложения перед переключением на другое
end;

// StartWDay  : True -новый, False - Еще на закрыты
function TdmMobile.StartWDay(const usr_id: integer; const wdate: TDatetime): boolean;
begin
  Result := True;
end;

function TdmMobile.CloseWDay(const usr_id: integer; const wdate: TDatetime): boolean;
begin
  Result := True;
end;

procedure TdmMobile.StoreResults(const tskid: integer);
begin
  // Передача результатов заполнения анкеты для указанной задачи на сервер
end;


end.
