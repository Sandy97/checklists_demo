unit fClient2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Edit,
  FMX.SearchBox, FMX.StdCtrls, FMX.Layouts, FMX.TabControl,
  FMX.Controls.Presentation, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.DBScope, Data.Bind.GenData,
  Data.Bind.ObjectScope, System.Actions,
  FMX.ActnList, Data.DB, FMX.Bind.Grid, Data.Bind.Grid, FMX.Grid, FMX.ComboEdit,
  FMX.DateTimeCtrls;

type
  TForm1 = class(TForm)
    ActionList1: TActionList;
    acStartSurvey: TAction;
    acSwitchToCheckList: TChangeTabAction;
    acSwitchToTasks: TChangeTabAction;
    acSwitchToUtils: TChangeTabAction;
    acPost: TAction;
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
    btRefresh: TButton;
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
    btAnketaRight: TSpeedButton;
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
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    LinkPropertyToFieldText7: TLinkPropertyToField;
    LinkPropertyToFieldText8: TLinkPropertyToField;
    LinkPropertyToFieldText9: TLinkPropertyToField;
    acSwitchToLogin: TChangeTabAction;
    Button1: TButton;
    BindSourceDB2: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    BindSourceDB3: TBindSourceDB;
    ComboBoxREP_ID: TComboBox;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btRefreshClick(Sender: TObject);
    procedure btPriorClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure acStartSurveyExecute(Sender: TObject);
    procedure acPostExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    // procedure LinkControlToPropertyRecNoAssigningValue(Sender: TObject;AssignValueRec: TBindingAssignValueRec; var Value: TValue;var Handled: Boolean);
    procedure ListBoxItemClick(Sender: TObject);
    procedure BindSourceDB1SubDataSourceDataChange(Sender: TObject; Field: TField);
    procedure btnAddAssignmentClick(Sender: TObject);
    procedure btCancelAssignmentClick(Sender: TObject);
    procedure btLoginClick(Sender: TObject);
    procedure FormSaveState(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    __usrid: integer;
    __date: TDateTime;
    __tsk_id: integer;
    __cl_id: integer;
    __albi: TListBoxItem;
    notClosed: boolean;
    procedure updateJobButton;
    procedure FillCLListBox;
    procedure SaveAppState;
    procedure RestoreAppState;
    function FormatDetails(const tsk_id, item_id: integer): string;
    function isResultChecked(const tsk_id, item_id: integer): boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

uses dmClientLB;

procedure PrepareSuresultsDetails(litem: TListBoxItem; const tsk_id: integer);
begin
  if dmMobile.mtAssignment.Locate('TSK_ID;I_ID', VarArrayOf([tsk_id, litem.Tag]), []) then
  begin
    litem.ItemData.Detail := format('%s - %-20s',
      [dmMobile.mtAssignment.FieldByName('BYDATE').AsString,
      dmMobile.mtAssignment.FieldByName('TODO').AsString]);
  end;
end;

function TForm1.isResultChecked(const tsk_id, item_id: integer):boolean;
var
  val : integer;
begin
  Result := False;
  if dmMobile.mtSuresults.Locate('TSK_ID;I_ID', VarArrayOf([tsk_id, item_id]), []) then
  begin
    val:= dmMobile.mtSuresults.FieldByName('AVALUE').AsInteger;
    Result:=(val > 0);
  end;

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

procedure TForm1.updateJobButton;
begin
  if (dmMobile.mtTask.FieldByName('Status').AsString = 'CLOSED') then
  begin
    btSave.StyleLookup := 'organizetoolbutton';
    btSave.Action := acPost;
  end
  else
  begin
    btSave.StyleLookup := 'playtoolbutton';
    btSave.Action := acStartSurvey;
  end;
end;

procedure TForm1.acPostExecute(Sender: TObject);
var
  i: integer;
begin
  with dmMobile do
  begin
    for i := 0 to lstAnketa.Items.Count - 1 do
    begin
      if (lstAnketa.ListItems[i] is TListBoxGroupHeader) then
        continue;
      if not(mtSuresults.State in [dsInsert, dsEdit, dsSetKey]) then
        if mtSuresults.Locate('TSK_ID;I_ID', VarArrayOf([__tsk_id, lstAnketa.ListItems[i].Tag]), [])
        then
          mtSuresults.Edit
        else
        begin
          mtSuresults.Insert;
          mtSuresults.FieldByName('TSK_ID').AsInteger := __tsk_id;
          mtSuresults.FieldByName('I_ID').AsInteger := lstAnketa.ListItems[i].Tag;
        end;
      if lstAnketa.ListItems[i].IsChecked then
        mtSuresults.FieldByName('AVALUE').AsInteger := 1
      else
        mtSuresults.FieldByName('AVALUE').AsInteger := 0;
      mtSuresults.Post;
    end;
    mtSuresults.CommitUpdates;
    mtAssignment.CommitUpdates;

    With mtTask do
    begin
      if Locate('TSK_ID', __tsk_id, []) then
      begin
        Edit;
        FieldByName('DONE').AsDateTime := now;
        FieldByName('STATUS').AsString := 'FILLED';
        Post;
      end;
      CommitUpdates;
    end;
    {
      Сохранить на сервер SURESULTS ASSIGNMENT
    }
    dmMobile.StoreResults(__tsk_id);
  end;
  acSwitchToTasks.ExecuteTarget(self);
end;

procedure TForm1.acStartSurveyExecute(Sender: TObject);
begin
  __tsk_id := dmMobile.mtTask.FieldByName('TSK_ID').AsInteger;
  __cl_id := dmMobile.mtTask.FieldByName('CLID').AsInteger;
  dmMobile.GetCLItems(__tsk_id, __cl_id);
  FillCLListBox;
  acSwitchToCheckList.ExecuteTarget(self);
end;

procedure TForm1.BindSourceDB1SubDataSourceDataChange(Sender: TObject; Field: TField);
begin
  updateJobButton;
end;

procedure TForm1.btNextClick(Sender: TObject);
begin
  dmMobile.mtTask.Next;
end;

procedure TForm1.btPriorClick(Sender: TObject);
begin
  dmMobile.mtTask.Prior;
end;

procedure TForm1.btRefreshClick(Sender: TObject);
begin
  dmMobile.mtTask.Refresh;
  dmMobile.mtTask.First;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SaveAppState;
end;

procedure TForm1.btCancelAssignmentClick(Sender: TObject);
begin
  if dmMobile.mtAssignment.State in [dsInsert, dsEdit, dsSetKey] then
    dmMobile.mtAssignment.Cancel;
  acSwitchToCheckList.ExecuteTarget(self);
end;

procedure TForm1.btLoginClick(Sender: TObject);
var
  i: integer;
begin
  //
  for i := 1 to 3 do
  begin
    if dmMobile.GetAccess(edUserName.Text, edPsw.Text, __usrid, __date) then
    begin
      if dmMobile.StartWDay(__usrid, __date) then
      begin
        dmMobile.GetDictionaries;
        dmMobile.LoadTasks(__usrid, __date);
        dmMobile.PrepareResults(__tsk_id);
      end
      else
        RestoreAppState;
      updateJobButton;
      Label2.Text := format('%10s / %s', [edUserName.Text, DateToStr(__date)]);
      acSwitchToTasks.ExecuteTarget(self);
      break;
    end
    else
      showmessage('Неудача при подключении');
  end;
  // Application.Terminate;
end;

procedure TForm1.btnAddAssignmentClick(Sender: TObject);
begin
  dmMobile.mtAssignment.Post;
  __albi.ItemData.Detail := FormatDetails(__tsk_id, __albi.Tag);
  // PrepareSuresultsDetails(__albi, __tsk_id);
  acSwitchToCheckList.ExecuteTarget(self);
end;

procedure TForm1.FillCLListBox;
var
  rgrid, curgrid: integer;
  procedure _AddGroupHeader(tgt: TListBox);
  var
    ngrp: TListBoxGroupHeader;
  begin
    ngrp := TListBoxGroupHeader.Create(tgt);
    ngrp.Parent := tgt;
    ngrp.Height := 44;
    ngrp.StyleLookup := 'listboxplainheader';
    ngrp.Tag := rgrid; // dmMobile.mtClitems.FieldByName('GRID').Value;
    // здесь выполняется расшифровка
    ngrp.ItemData.Text := dmMobile.FindTextName(dmMobile.mtClitems.FieldByName('Gr_Name_ref')
      .AsInteger);
  end;
  procedure _AddAnketaItem(tgt: TListBox);
  var
    ncli: TListBoxItem;
  begin
    ncli := TListBoxItem.Create(tgt);
    ncli.Parent := tgt;
    ncli.Height := 44;
    ncli.StyleLookup := 'listboxitembottomdetail';
    ncli.ItemData.Accessory := TListBoxItemData.TAccessory.aMore;
    ncli.Tag := dmMobile.mtClitems.FieldByName('I_ID').Value;
    ncli.OnClick := ListBoxItemClick;
    // здесь выполняется расшифровка
    ncli.ItemData.Text := dmMobile.FindTextName(dmMobile.mtClitems.FieldByName('iprompt_ref').AsInteger);
    ncli.IsChecked := isResultChecked(__tsk_id, ncli.Tag);
    ncli.ItemData.Detail := FormatDetails(__tsk_id, ncli.Tag);
    // PrepareSuresultsDetails(ncli, __tsk_id);
  end;

begin
  // open clitems DS
  // Обеспечить фильтрацию по clid
  if not dmMobile.mtClitems.Eof then
  begin
    lstAnketa.BeginUpdate;
    lstAnketa.Items.Clear;
    curgrid := 0;
    try
      // dmMobile.PrepareResults(__tsk_id);
      dmMobile.mtClitems.First;
      while not dmMobile.mtClitems.Eof do
      begin
        rgrid := dmMobile.mtClitems.FieldByName('GRID').AsInteger;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  (* отладка dmMobile.GetDebugData; *)
  __usrid := 0;
  __date := Date;
  __tsk_id := 0;
  __cl_id := 0;
  notClosed := False;
  // if notClosed  then
  RestoreAppState;
  tbcMain.TabIndex := 0;
end;

procedure TForm1.ListBoxItemClick(Sender: TObject);
begin
  // if (Sender is TListBoxGroupHeader) then exit;
  __albi := (Sender as TListBoxItem);
  // create or edit the linked record in Assignment with master current Suresults
  if not(dmMobile.mtAssignment.State in [dsInsert, dsEdit, dsSetKey]) then
    if dmMobile.mtAssignment.Locate('TSK_ID;I_ID', VarArrayOf([__tsk_id, __albi.Tag]), []) then
      dmMobile.mtAssignment.Edit
    else
    begin
      dmMobile.mtAssignment.Insert;
      dmMobile.mtAssignment.FieldByName('TSK_ID').AsInteger := __tsk_id;
      dmMobile.mtAssignment.FieldByName('I_ID').AsInteger := __albi.Tag;
    end;
  acSwitchToUtils.ExecuteTarget(self);
end;

procedure TForm1.RestoreAppState;
var
  x: TBinaryReader;
begin
  if SaveState.Stream.size > 0 then
  begin
    x := TBinaryReader.Create(SaveState.Stream);
    try
      __usrid := x.ReadInteger;
      __date := x.ReadDouble;
      __tsk_id := x.ReadInteger;
      __cl_id := x.ReadInteger;
      dmMobile.RestoreAppData;
      // ...
    finally
      x.Free;
    end;
  end;
end;

procedure TForm1.SaveAppState;
var
  w: TBinaryWriter;
begin
  SaveState.Stream.Clear;
  w := TBinaryWriter.Create(SaveState.Stream);
  try
    w.Write(__usrid);
    w.Write(__date);
    w.Write(__tsk_id);
    w.Write(__cl_id);
    dmMobile.SaveAppData;
    // ...
  finally
    w.Free;
  end;
end;

procedure TForm1.FormSaveState(Sender: TObject);
begin
  SaveAppState;
end;

end.

// procedure TForm1.LinkControlToPropertyRecNoAssigningValue(Sender: TObject;
// AssignValueRec: TBindingAssignValueRec; var Value: TValue;
// var Handled: Boolean);
// begin
// Value := format('%d / %d', [dmMobile.mtTask.RecNo,dmMobile.mtTask.RecordCount]);
// end;
