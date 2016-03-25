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
    cbxResponsible: TComboBox;
    BindSourceDB2: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    acSwitchToLogin: TChangeTabAction;
    PreviousTabAction1: TPreviousTabAction;
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
  private
    { Private declarations }
    __usrid: integer;
    __date: TDateTime;
    __tsk_id: integer;
    __cl_id: integer;
    notClosed: boolean;
    procedure updateJobButton;
    procedure FillCLListBox;
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
begin
 { TODO 1 : Real Post To server }
  showmessage('Post'); // beep; // MessageDlg('Post To Server');
end;

procedure TForm1.acStartSurveyExecute(Sender: TObject);
begin
  __tsk_id := dmMobile.mtTask.FieldByName('TSK_ID').AsInteger;
  __cl_id := dmMobile.mtTask.FieldByName('CLID').AsInteger;
  dmMobile.GetCLItems(__tsk_id, __cl_id);
  FillCLListBox;
  acSwitchToCheckList.ExecuteTarget(Self);
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

procedure TForm1.btCancelAssignmentClick(Sender: TObject);
begin
  if dmMobile.mtAssignment.State in [dsInsert, dsEdit, dsSetKey] then
    dmMobile.mtAssignment.Cancel;
  acSwitchToCheckList.ExecuteTarget(Self);
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
      end
      else
        dmMobile.RestoreApp;
      updateJobButton;
      acSwitchToTasks.ExecuteTarget(Self);
      break;
    end
    else
      showmessage('Неудача при подключении');
  end;
  //Application.Terminate;
end;

procedure TForm1.btnAddAssignmentClick(Sender: TObject);
begin
  dmMobile.mtAssignment.Post;
  acSwitchToCheckList.ExecuteTarget(Self);
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
    {// вместо ниже можно здесь выполняется расшифровка
    ngrp.ItemData.Text := dmMobile.mtClitems.FieldByName('cliGrName').AsString; }
    ngrp.ItemData.Text := dmMobile.FindTextName(dmMobile.mtClitems.FieldByName('Gr_Name_ref').AsInteger);
  end;
  procedure _PrepareSuresultsDetails(litem: TListBoxItem; const tsk_id: integer);
  begin
    // if DataModule6.mtSuresults.Lookup('TSK_ID;I_ID',VarArrayof([
    // DataModule6.fqTask.FieldByName('TSK_ID').value,
    // DataModule6.mtClitems.FieldByName('TSK_ID').value
    // ]) then begin
    litem.ItemData.Detail := format('%s сделать: %10s', ['28.12.2015 23;00', 'поручение xxx']);
    // ncli.ItemData.Detail := DataModule6.mtClitems.FieldByName('cliPrompt').AsString;
    // end;
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
    {// вместо ниже можно здесь выполняется расшифровка
    ncli.ItemData.Text := dmMobile.mtClitems.FieldByName('cliPrompt').AsString; }
    ncli.ItemData.Text := dmMobile.FindTextName(dmMobile.mtClitems.FieldByName('iprompt_ref').AsInteger);
    _PrepareSuresultsDetails(ncli, __tsk_id);
  end;

begin
  // open clitems DS
  // Обеспечить фильтрацию по clid
  if not dmMobile.mtClitems.Eof then
  begin
    lstAnketa.BeginUpdate;
    curgrid := 0;
    try
      dmMobile.PrepareResults(__tsk_id);
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

  tbcMain.TabIndex := 0;
end;

procedure TForm1.ListBoxItemClick(Sender: TObject);
var
  kvals: Variant;
begin
  // create or edit the linked record in Assignment with master current Suresults
  kvals := VarArrayOf([dmMobile.mtTask.FieldByName('TSK_ID').Value, (Sender as TListBoxItem).Tag]);
  if not(dmMobile.mtAssignment.State in [dsInsert, dsEdit, dsSetKey]) then
    if dmMobile.mtAssignment.Locate('TSK_ID;I_ID', kvals, []) then
      dmMobile.mtAssignment.Edit
    else
      dmMobile.mtAssignment.Insert;
  acSwitchToUtils.ExecuteTarget(Self);
end;

end.

// procedure TForm1.LinkControlToPropertyRecNoAssigningValue(Sender: TObject;
// AssignValueRec: TBindingAssignValueRec; var Value: TValue;
// var Handled: Boolean);
// begin
// Value := format('%d / %d', [dmMobile.mtTask.RecNo,dmMobile.mtTask.RecordCount]);
// end;
