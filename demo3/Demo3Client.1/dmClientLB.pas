unit dmClientLB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Stan.StorageBin;

type
  TdmMobile = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    mtPlaces: TFDMemTable;
    mtResponsible: TFDMemTable;
    mtClitems: TFDMemTable;
    mtSuresults: TFDMemTable;
    mtAssignment: TFDMemTable;
    mtTask: TFDMemTable;
    mtClitemsI_ID: TIntegerField;
    mtClitemsIORDER: TLargeintField;
    mtClitemsIWEIGHT: TSingleField;
    mtClitemsNEXT_IORD: TLargeintField;
    mtClitemsIPROMPT_REF: TIntegerField;
    mtClitemsGR_NAME_REF: TIntegerField;
    mtClitemsGRID: TIntegerField;
    mtClitemsCLID: TIntegerField;
    mtClitemscliGrName: TStringField;
    mtTexts: TFDMemTable;
    mtPrompt: TFDMemTable;
    mtClitemscliPrompt: TStringField;
    DataSource1: TDataSource;
    FDConnection1: TFDConnection;
    fqTask: TFDQuery;
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
    fqSuresults: TFDQuery;
    fqCheckList: TFDQuery;
    fqCheckListI_ID: TIntegerField;
    fqCheckListIORDER: TLargeintField;
    fqCheckListIWEIGHT: TSingleField;
    fqCheckListNEXT_IORD: TLargeintField;
    fqCheckListIPROMPT_REF: TIntegerField;
    fqCheckListGR_NAME_REF: TIntegerField;
    fqCheckListGRID: TIntegerField;
    fqCheckListCLID: TIntegerField;
    fqPlaces: TFDQuery;
    fqTexts: TFDQuery;
    fqResponsible: TFDQuery;
    fqAssignment: TFDQuery;
    adaSuresultsAssignment: TFDSchemaAdapter;
  private
    { Private declarations }
  public
    { Public declarations }
    //procedure GetDebugData;
    function GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime)
      : boolean;
    procedure GetDictionaries;
    function FindTextName(ref: integer): string;
    procedure LoadTasks(const usrid: integer; const cdate: TDatetime);
    procedure GetCLItems(const tskid: integer; const clid: integer);
    procedure PrepareResults(const tskid: integer);
    procedure StoreResults(const tskid: integer);
    procedure SaveApp;
    procedure RestoreApp;
    // StartWDay  : True -новый, False - ≈ще на закрыты
    function StartWDay(const usr_id: integer; const wdate: TDatetime): boolean;
    function CloseWDay(const usr_id: integer; const wdate: TDatetime): boolean;

  end;

var
  dmMobile: TdmMobile;

implementation

{ %CLASSGROUP 'FMX.Controls.TControl' }

{$R *.dfm}
(*
   Overriding Posting Updates (FireDAC)
*)

{ TdmMobile }

procedure LoadMemTableFromDS(ds: TFDQuery; tg: TFDMemTable);
begin
  // ex: FDMemTable1.CopyDataSet(DataSet1, [coStructure, coRestart, coAppend])
  ds.Open;
  ds.FetchAll;
  // tg.CopyDataSet(ds, [coStructure, coRestart, coAppend]);
  tg.Data := ds.Data;
  ds.Close;
  tg.First;
end;

//procedure TdmMobile.GetDebugData;
//begin
//  // --LoadMemTableFromDS(datamodule6.fqPlaces, mtPlaces);
//  LoadMemTableFromDS(fqTexts, mtTexts);
//  mtPrompt.CloneCursor(mtTexts, True, False);
//  LoadMemTableFromDS(fqTask, mtTask);
//  LoadMemTableFromDS(fqCheckList, mtClitems);
//  LoadMemTableFromDS(fqResponsible, mtResponsible);
//  LoadMemTableFromDS(fqSuresults, mtSuresults);
//  LoadMemTableFromDS(fqAssignment, mtAssignment);
//end;

function TdmMobile.FindTextName(ref: integer): string;
begin
  Result := '-';
  if mtTexts.Locate('tx_id', ref, []) then
    Result := mtTexts.FieldByName('tx_caption').AsString;
end;

function TdmMobile.GetAccess(const usrnm, psw: string; var usr_id: integer;
  var wdate: TDatetime): boolean;
begin
  Result:= False;
  usr_id := 19;
  wdate := StrToDate('29.09.2015');
  Result:=True;
end;

procedure TdmMobile.GetCLItems(const tskid, clid: integer);
begin
  // получение списка вопросов дл€ задачи
  // и дл€ формировани€ ListBox
  //  - dmAdapter.GetClitems(tskid,clid);
  LoadMemTableFromDS(fqCheckList, mtClitems);
  // ‘ильтраци€ не об€зательна, если используетс€ вызов dmAdapter
  mtClitems.Filter:=format('CLID=%d',[clid]);
  mtClitems.Filtered:=True;
end;

procedure TdmMobile.GetDictionaries;
begin
  // считывание с сервера и синхронизаци€ на устройстве справочников
  // Responsibles и Texts
  LoadMemTableFromDS(fqTexts, mtTexts);
  //--  mtPrompt.CloneCursor(mtTexts, True, False);
  // --LoadMemTableFromDS(fqPlaces, mtPlaces);
  LoadMemTableFromDS(fqResponsible, mtResponsible);
end;

procedure TdmMobile.LoadTasks(const usrid: integer; const cdate: TDatetime);
begin
  // —читывание с сервера списка задач на указанную дату
  // вариант: синхронизаци€ еще не завершенных задач
  LoadMemTableFromDS(fqTask, mtTask);
end;

procedure TdmMobile.PrepareResults(const tskid: integer);
begin
  // подготовка и публикаци€ SURESULTS & ASSIGNMENT
  LoadMemTableFromDS(fqSuresults, mtSuresults);
  LoadMemTableFromDS(fqAssignment, mtAssignment);
end;

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
  // ѕередача результатов заполнени€ анкеты дл€ указанной задачи на сервер
end;

(* ===================================================================================== *)

procedure TdmMobile.RestoreApp;
begin
  // восстановление рабочего состо€ни€ приложени€ после возврата к нему
end;

procedure TdmMobile.SaveApp;
begin
  // сохранение рабочего состо€ни€ приложени€ перед переключением на другое
end;

end.
