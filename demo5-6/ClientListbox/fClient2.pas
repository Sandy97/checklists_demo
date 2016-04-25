unit fClient2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Edit, FMX.SearchBox, FMX.StdCtrls, FMX.Layouts, FMX.TabControl,
  FMX.Controls.Presentation, System.Rtti, FMX.ComboEdit, FMX.DateTimeCtrls,
  System.Actions, FMX.ActnList, Data.DB, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope,
  System.ImageList, FMX.ImgList, FMX.Bind.Grid, Data.Bind.Grid, FMX.Grid, Data.Bind.Controls,
  System.Sensors, System.Sensors.Components, FMX.WebBrowser,
  FireDAC.Comp.DataSet,
  uLocalData, uWDState, FMX.Objects, FMX.ScrollBox, FMX.Memo;

const
  STATUSNEW = '';
  STATUSFILLED = 'FILLED';
  STATUSCLOSED = 'CLOSED';
  CLITEMHEIGHT = 44;          // высота строки анкеты

type
  TForm1 = class(TForm)
    ActionList1: TActionList;
    acStartSurvey: TAction;
    acSwitchToCheckList: TChangeTabAction;
    acSwitchToTasks: TChangeTabAction;
    acSwitchToUtils: TChangeTabAction;
    acPostSurvey: TAction;
    tbcMain: TTabControl;
    tabOpenClose: TTabItem;
    Layout1: TLayout;
    edUserName: TEdit;
    Label4: TLabel;
    edPsw: TEdit;
    Label3: TLabel;
    btLogin: TButton;
    tabTasks: TTabItem;
    tbarTop: TToolBar;
    Label2: TLabel;
    sbMenu: TSpeedButton;
    tbarFoot: TToolBar;
    btPrior: TButton;
    btNext: TButton;
    btSave: TButton;
    laTasks: TLayout;
    loTaskName: TLayout;
    paTaskNameHdr: TPanel;
    laTaskNameHDR: TLabel;
    laRecNo: TLabel;
    lbCLTitle: TLabel;
    loPlace: TLayout;
    paPlaceHdr: TPanel;
    laPlaceNameHdr: TLabel;
    lbPlaceNm: TLabel;
    paTaskInfo: TPanel;
    lbByDate: TLabel;
    lbPriority: TLabel;
    lbusr_id: TLabel;
    lbStatus: TLabel;
    lbDone: TLabel;
    lbNext_Q: TLabel;
    loComments: TLayout;
    paCommentHdr: TPanel;
    laCommentHdr: TLabel;
    lbComments: TLabel;
    tabCheckList: TTabItem;
    lstAnketa: TListBox;
    SearchBox1: TSearchBox;
    ListBoxHeader1: TListBoxHeader;
    Label1: TLabel;
    AnketaHeaderToolBar: TToolBar;
    btBackToTasks: TSpeedButton;
    SpeedButton1: TSpeedButton;
    tabNotes: TTabItem;
    Layout2: TLayout;
    loToDo: TLayout;
    Panel1: TPanel;
    laToDo: TLabel;
    edToDo: TEdit;
    loByDateTime: TLayout;
    Panel2: TPanel;
    laByDate: TLabel;
    DateEdit1: TDateEdit;
    TimeEdit1: TTimeEdit;
    loWho: TLayout;
    Panel3: TPanel;
    laWho: TLabel;
    LoNotes: TLayout;
    Panel4: TPanel;
    laNotesHdr: TLabel;
    edNotes: TEdit;
    ToolBar1: TToolBar;
    btCancelAssignment: TButton;
    ToolBar2: TToolBar;
    btnAddAssignment: TButton;
    acSwitchToLogin: TChangeTabAction;
    Button1: TButton;
    ComboBoxREP_ID: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    LinkPropertyToFieldText7: TLinkPropertyToField;
    BindSourceDB2: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    ImageList1: TImageList;
    LinkPropertyToFieldText8: TLinkPropertyToField;
    LinkPropertyToFieldText9: TLinkPropertyToField;
    VertScrollBox1: TVertScrollBox;
    SpeedButton2: TSpeedButton;
    Button2: TButton;
    LinkControlToField4: TLinkControlToField;
    tabLocation: TTabItem;
    edServer: TEdit;
    Label5: TLabel;
    paTiming: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    paStatus: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    StyleBook1: TStyleBook;
    Label10: TLabel;
    ToolBar3: TToolBar;
    spBack: TSpeedButton;
    swLocationSensor: TSwitch;
    Label11: TLabel;
    ListBox1: TListBox;
    lbLattitude: TListBoxItem;
    lbLongtitude: TListBoxItem;
    WebBrowser1: TWebBrowser;
    LocationSensor1: TLocationSensor;
    acSwitchToLocation: TChangeTabAction;
    tbWorkDay: TTabItem;
    btProcessWDay: TButton;
    Layout3: TLayout;
    btStopWDay: TButton;
    Layout4: TLayout;
    ToolBar4: TToolBar;
    Label12: TLabel;
    acUnlockUI: TAction;
    acSwitchToWD: TChangeTabAction;
    acStartWDay: TAction;
    acCloseWDay: TAction;
    acConfig: TAction;
    acMaps: TAction;
    BindSourceDB3: TBindSourceDB;
    ToolBar5: TToolBar;
    FlowLayoutBreak1: TLayout;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Image1: TImage;
    Panel5: TPanel;
    mmLog: TMemo;
    procedure btPriorClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure acStartSurveyExecute(Sender: TObject);
    procedure acPostSurveyExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    // procedure LinkControlToPropertyRecNoAssigningValue(Sender: TObject;AssignValueRec: TBindingAssignValueRec; var Value: TValue;var Handled: Boolean);
    procedure ListBoxItemClick(Sender: TObject);
    procedure BindSourceDB1SubDataSourceDataChange(Sender: TObject; Field: TField);
    procedure btnAddAssignmentClick(Sender: TObject);
    procedure btCancelAssignmentClick(Sender: TObject);
    procedure FormSaveState(Sender: TObject);
    procedure lbCommentsResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure LocationSensor1LocationChanged(Sender: TObject;const OldLocation, NewLocation: TLocationCoord2D);
    procedure swLocationSensorSwitch(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acUnlockUIExecute(Sender: TObject);
    procedure acStartWDayExecute(Sender: TObject);
    procedure acCloseWDayExecute(Sender: TObject);
    procedure acMapsExecute(Sender: TObject);
  private
    { Private declarations }
    wds: TwdState;
    notClosed: boolean;
    procedure updateGUI;
    procedure FillCLListBox(cl: TFDDataset);
    procedure SaveAppState;
    procedure RestoreAppState;
    function  FormatDetails(const tsk_id, item_id: integer): string;
    procedure MoveTaskDataToDS(tsk_id: integer);
    procedure Login;
    procedure UpdateWDSPanel;
    procedure Log(const msg:string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uSrvData, System.DateUtils;

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

function isEmptyString(str: string): boolean;
begin
  Result := (Trim(str) = '');
end;

procedure TForm1.UpdateWDSPanel;
begin
  if (wds.DayStarted = 0)
     // or not (CompareDate(wds.date,wds.DayStarted)=EqualsValue) //For Date Part only
  then begin
    btProcessWDay.Action := acStartWDay;
    btProcessWDay.StyleLookup := 'composetoolbuttonbordered';
  end
  else begin
    btProcessWDay.Action := acSwitchToTasks;
    btProcessWDay.StyleLookup := 'playtoolbutton';
  end;
  if (wds.DayStarted <= 0) then
      Label14.Text := ''
  else
      Label14.Text := dateTimeToStr( wds.DayStarted );
  Label16.Text := IntToStr( wds.TaskCnt );
  Label18.Text := IntToStr( wds.ClosedTaskCnt );
  btSave.Action := acStartSurvey;
end;

// Переносит все данные по текущей задаче в локальный датасет
procedure TForm1.acCloseWDayExecute(Sender: TObject);
begin
  //todo 1 : Конец смены с сохранением результатов
  Log('Закрытие смены ' + Label2.Text);
  dmMobile.CloseWDay(wds.usrid, wds.date);
  Log('Смена закрыта');
  wds.SetWdsState(0,0,0);
  updateGUI;
end;

procedure TForm1.acMapsExecute(Sender: TObject);
begin
  acSwitchToLocation.ExecuteTarget(Self);
end;

procedure TForm1.acPostSurveyExecute(Sender: TObject);
begin
  MoveTaskDataToDS(wds.tsk_id);
  Log('Задание завершено');
  acSwitchToTasks.ExecuteTarget(self);
end;

{ Запуск задачи в обработку }
procedure TForm1.acStartSurveyExecute(Sender: TObject);
begin
  wds.tsk_id := dmMobile.mtTask.FieldByName('TSK_ID').AsInteger;
  wds.cl_id := dmMobile.mtTask.FieldByName('CLID').AsInteger;
  Log(format('Начало задания #%d:%s',[wds.tsk_id,dmMobile.mtTask.FieldByName('CLTITLE').AsString]));
  { использовать локальные датасеты  }
  dmMobile.mtClitems.Filtered:=false;
  dmMobile.mtClitems.Filter:=format('CLID=%d',[wds.cl_id]);
  dmMobile.mtClitems.Filtered:=True;
  dmMobile.PrepareResults(wds.tsk_id);                    //todo : убрать! одготовить строки результатов
  FillCLListBox(dmMobile.mtClitems);
  //Log(format());
  acSwitchToCheckList.ExecuteTarget(self);
end;

// Первое подключение к серверу - открыть рабочий день
procedure TForm1.acStartWDayExecute(Sender: TObject);
begin
    Login;  // Проверить права доступа и получить рабочие wds.usrid и wds.wdate
    dmMobile.StartWDay(wds.usrid, wds.date);              // В начале получить usrid и дату для работы
    dmMobile.GetDictionaries;                             // загрузить таблицы только для чтения
    dmMobile.LoadTasks(wds.usrid, wds.date);              // Загрузить все задачи и анкеты на день
    wds.SetWdsState(now,dmMobile.mtTask.RecordCount,0);   // Начальное состояние статуса рабочего дня
    dmMobile.LoadWDayCLS(wds.usrid, wds.date);            // загрузить все анкеты на день
    dmMobile.mtTask.Locate('TSK_ID',wds.tsk_id);          // позиционироваться на текущую задачу wds.tsk_id
    Label2.Text := format('%10s / %s', [edUserName.Text, DateToStr(wds.date)]);
    Log('Начало смены ' + Label2.Text);
    btProcessWDay.Action := acSwitchToTasks;
    updateGUI;
    acSwitchToTasks.ExecuteTarget(self);
end;

procedure TForm1.Log(const msg: string);
begin
  mmLog.Lines.Add(DatetimeToStr(now) + ' '+msg);
end;

procedure TForm1.Login;
begin
  wds.usrid := 0;
  wds.date := 0;
  if not dmMobile.GetAccess(edUserName.Text, edPsw.Text, wds.usrid, wds.date) then
      raise Exception.Create('Нет прав для соединения с сервером');
end;

procedure TForm1.FormCreate(Sender: TObject);
(*var isEmptyString: TPredicate<string>;
begin
   isEmptyString := function(str: string): boolean
    begin
    Result := (Trim(str) = '');
    end; *)
begin
  dmMobile.FAdapter := TdmSrvData.Create(self);
  wds := TwdState.Create(self);
  tbcMain.TabIndex := 0;
  if SaveState.Stream.size > 0 then
    { Если перед этим сохранились, восстанавливаем пред.сессию }
    RestoreAppState
  else
    notClosed := False;
  mmLog.ClearContent;
  UpdateWDSPanel;
end;

{$REGION '1'}

procedure TForm1.lbCommentsResize(Sender: TObject);
begin
  VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, 10);
  VertScrollBox1.RealignContent;
end;

function TForm1.FormatDetails(const tsk_id, item_id: integer): string;
begin
  Result := '';
  if dmMobile.mtAssignment.Locate('TSK_ID;I_ID', VarArrayOf([tsk_id, item_id]), []) then
  begin
    Result := format('%s - %-20s', [dmMobile.mtAssignment.FieldByName('BYDATE').AsString,
      dmMobile.mtAssignment.FieldByName('TODO').AsString]);
  end;
end;

procedure TForm1.updateGUI;
begin
  UpdateWDSPanel;
  if (dmMobile.mtTask.FieldByName('Status').AsString = STATUSCLOSED) then
  begin
    btSave.StyleLookup := 'organizetoolbutton';
    //btSave.Action := acSaveAll;
    btSave.Enabled:=False;
  end
  else
  begin
    btSave.StyleLookup := 'playtoolbutton';
    btSave.Enabled:=True;
    btSave.Action := acStartSurvey;
  end;
end;

procedure TForm1.acUnlockUIExecute(Sender: TObject);
begin
  if not isEmptyString(edServer.Text) then    //todo 1 : Либо брать из конфигурации ???
    dmMobile.FAdapter.Server := edServer.Text;
  if isEmptyString(edUserName.Text) then      // имя пользователя потребуется позже
    raise Exception.Create('Пустое имя пользователя');
  acSwitchToWD.ExecuteTarget(self);
end;

procedure TForm1.BindSourceDB1SubDataSourceDataChange(Sender: TObject; Field: TField);
begin
  updateGUI;
end;

procedure TForm1.btNextClick(Sender: TObject);
begin
  dmMobile.mtTask.Next;
end;

procedure TForm1.btPriorClick(Sender: TObject);
begin
  dmMobile.mtTask.Prior;
end;

(* procedure TForm1.Button1Click(Sender: TObject);
begin
  // todo 1 : to remove
  SaveAppState;
end; *)

procedure TForm1.FormDestroy(Sender: TObject);
begin
  wds.Free;
end;

procedure TForm1.RestoreAppState;
var
  X: TBinaryReader;
begin
{$IFDEF MSWINDOWS }
exit;
{$ENDIF}
  if SaveState.Stream.size > 0 then
  begin
    X := TBinaryReader.Create(SaveState.Stream);
    try
      wds.usrid := X.ReadInteger;
      wds.date := X.ReadDouble;
      wds.tsk_id := X.ReadInteger;
      wds.cl_id := X.ReadInteger;
      wds.DayStarted := X.ReadDouble;
      wds.TaskCnt := X.ReadInteger;
      wds.ClosedTaskCnt := X.ReadInteger;
      wds.Server := X.ReadString;
      dmMobile.RestoreAppData(X);
      notClosed := True;
      Log('Восстановлено');
    finally
      SaveState.Stream.Clear; // очищаем предыдущее состояние
      X.Free;
    end;
  end;
end;

procedure TForm1.SaveAppState;
var
  w: TBinaryWriter;
begin
{$IFDEF MSWINDOWS }
exit;
{$ENDIF}
  SaveState.Stream.Clear;
  w := TBinaryWriter.Create(SaveState.Stream);
  try
    w.Write(wds.usrid);
    w.Write(wds.date);
    w.Write(wds.tsk_id);
    w.Write(wds.cl_id);
    w.Write(wds.DayStarted);
    w.Write(wds.TaskCnt);
    w.Write(wds.ClosedTaskCnt);
    w.Write(wds.Server);
    dmMobile.SaveAppData(w);
    Log('Сохранено');
  finally
    w.Free;
  end;
end;

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
const
  LGoogleMapsURL: String = 'https://maps.google.com/maps?q=%s,%s';
var
  ENUSLat, ENUSLong: String; // holders for URL strings
begin
  ENUSLat := NewLocation.Latitude.ToString(ffGeneral, 5, 2, TFormatSettings.Create('en-US'));
  ENUSLong := NewLocation.Longitude.ToString(ffGeneral, 5, 2, TFormatSettings.Create('en-US'));
  { convert the location to latitude and longitude }
  lbLattitude.Text := 'Широта: ' + ENUSLat;
  lbLongtitude.Text := 'Долгота: ' + ENUSLong;
  { and track the location via Google Maps }
  WebBrowser1.Navigate(format(LGoogleMapsURL, [ENUSLat, ENUSLong]));
end;

procedure TForm1.swLocationSensorSwitch(Sender: TObject);
begin
  { activate or deactivate the location sensor }
  LocationSensor1.Active := swLocationSensor.IsChecked;
end;

procedure TForm1.FormSaveState(Sender: TObject);
begin
  SaveAppState;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  { if Key = vkHardwareBack then begin
    if TabControlNotes.ActiveTab <> TabItemNotes then
    Key := 0;

    if TabControlNotes.ActiveTab = TabItemImages then
    actBackToObjectInfo.Execute
    else if TabControlNotes.ActiveTab = TabItemImage then
    actBackToImages. Execute
    else if TabControlNotes.ActiveTab = TabItemAudioRecord then
    actBackToObjectInfo.Execute
    else if TabControlNotes.ActiveTab = TabItemMemo then
    actBackToObjectInfo.Execute
    else if TabControlNotes.ActiveTab = TabItemMap then
    actBackToObjectInfo.Execute
    else if (TabControlNotes.ActiveTab = TabItemNote) then
    actSaveNewNote.Execute;
    end;
  }
end;

{$ENDREGION}

{$REGION '2'}
procedure TForm1.btCancelAssignmentClick(Sender: TObject);
begin
  if dmMobile.mtAssignment.State in [dsInsert, dsEdit, dsSetKey] then
    dmMobile.mtAssignment.Cancel;
  acSwitchToCheckList.ExecuteTarget(self);
end;

procedure TForm1.btnAddAssignmentClick(Sender: TObject);
begin
  if dmMobile.mtAssignment.State in [dsInsert, dsEdit, dsSetKey] then
    dmMobile.mtAssignment.Post;
  wds.albi.ItemData.Detail := FormatDetails(wds.tsk_id, wds.albi.Tag);
  acSwitchToCheckList.ExecuteTarget(self);
end;

procedure TForm1.FillCLListBox(cl: TFDDataset);
var
  rgrid, curgrid: integer;
  procedure _AddGroupHeader(tgt: TListBox);
  var
    ngrp: TListBoxGroupHeader;
  begin
    ngrp := TListBoxGroupHeader.Create(tgt);
    ngrp.Parent := tgt;
    ngrp.Height := CLITEMHEIGHT;
    ngrp.StyleLookup := 'listboxplainheader';
    ngrp.Tag := rgrid; // dmMobile.mtClitems.FieldByName('GRID').Value;
    // здесь выполняется расшифровка
    ngrp.ItemData.Text := dmMobile.DecodeTextRef(cl.FieldByName('Gr_Name_ref').AsInteger);
  end;
  procedure _AddAnketaItem(tgt: TListBox);
  var
    ncli: TListBoxItem;
  begin
    ncli := TListBoxItem.Create(tgt);
    ncli.Parent := tgt;
    ncli.Height := CLITEMHEIGHT;
    ncli.StyleLookup := 'listboxitembottomdetail';
    ncli.ItemData.Accessory := TListBoxItemData.TAccessory.aMore;
    ncli.Tag := cl.FieldByName('I_ID').Value;
    ncli.OnClick := ListBoxItemClick;
    // здесь выполняется расшифровка
    ncli.ItemData.Text := dmMobile.DecodeTextRef(cl.FieldByName('iprompt_ref').AsInteger);
    ncli.IsChecked := dmMobile.isResultChecked(wds.tsk_id, ncli.Tag);
    ncli.ItemData.Detail := FormatDetails(wds.tsk_id, ncli.Tag);
    // PrepareSuresultsDetails(ncli, wds.tsk_id);
  end;

begin
  // open clitems DS
  // Обеспечить фильтрацию по clid
  if not cl.IsEmpty then
  begin
    lstAnketa.BeginUpdate;
    lstAnketa.Items.Clear;
    curgrid := 0;
    try
      cl.First;
      while not cl.Eof do
      begin
        rgrid := cl.FieldByName('GRID').AsInteger;
        if rgrid <> curgrid then
        begin
          _AddGroupHeader(lstAnketa);
          curgrid := rgrid;
        end;
        _AddAnketaItem(lstAnketa);

        dmMobile.mtClitems.Next;
      end;
    finally
      lstAnketa.EndUpdate;
    end;
  end;
end;

procedure TForm1.ListBoxItemClick(Sender: TObject);
begin
  // if (Sender is TListBoxGroupHeader) then exit;
  wds.albi := (Sender as TListBoxItem);
  // create or edit the linked record in Assignment with master current Suresults
  if not(dmMobile.mtAssignment.State in [dsInsert, dsEdit, dsSetKey]) then begin
    if dmMobile.mtAssignment.Locate('TSK_ID;I_ID', VarArrayOf([wds.tsk_id, wds.albi.Tag]), []) then
      dmMobile.mtAssignment.Edit
    else
    begin
      dmMobile.mtAssignment.Insert;
      dmMobile.mtAssignment.FieldByName('TSK_ID').AsInteger := wds.tsk_id;
      dmMobile.mtAssignment.FieldByName('I_ID').AsInteger := wds.albi.Tag;
      dmMobile.mtAssignment.FieldByName('REP_ID').AsInteger := 29;
    end;

  end;
  acSwitchToUtils.ExecuteTarget(self);
end;

procedure TForm1.MoveTaskDataToDS(tsk_id: integer);
var
  i: integer;
begin
  with dmMobile do
  begin
    // Цикл по всем строкам анкеты, кроме заголовков групп
    for i := 0 to lstAnketa.Items.Count - 1 do
    begin
      if (lstAnketa.ListItems[i] is TListBoxGroupHeader) then
        continue;
      if not(mtSuresults.State in [dsInsert, dsEdit, dsSetKey]) then
        if mtSuresults.Locate('TSK_ID;I_ID', VarArrayOf([tsk_id, lstAnketa.ListItems[i].Tag]), [])
        then
          mtSuresults.Edit
        else
        begin
          mtSuresults.Insert;
          mtSuresults.FieldByName('TSK_ID').AsInteger := tsk_id;
          mtSuresults.FieldByName('I_ID').AsInteger := lstAnketa.ListItems[i].Tag;
        end;
      if lstAnketa.ListItems[i].IsChecked then
        mtSuresults.FieldByName('AVALUE').AsInteger := 1
      else
        mtSuresults.FieldByName('AVALUE').AsInteger := 0;
      mtSuresults.Post;
    end;
    // mtSuresults.CommitUpdates;  // mtAssignment.CommitUpdates;

    With mtTask do
    begin
      if Locate('TSK_ID', tsk_id, []) then
      begin
        Edit;
        FieldByName('DONE').AsDateTime := now;
        FieldByName('STATUS').AsString := STATUSFILLED;
        Post;
        wds.ClosedTaskCnt := dmMobile.TasksStatused(STATUSFILLED); //;
      end;
      // CommitUpdates;
    end;
    // ---- dmMobile.StoreResults(__tsk_id);
  end;
end;

{$ENDREGION}

end.

// procedure TForm1.LinkControlToPropertyRecNoAssigningValue(Sender: TObject;
// AssignValueRec: TBindingAssignValueRec; var Value: TValue;
// var Handled: Boolean);
// begin
// Value := format('%d / %d', [dmMobile.mtTask.RecNo,dmMobile.mtTask.RecordCount]);
// end;
