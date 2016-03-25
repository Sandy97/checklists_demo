unit fClitestLB02;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, FMX.Edit,
  FMX.SearchBox, FMX.StdCtrls, FMX.Layouts, FMX.TabControl, FMX.Controls.Presentation, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.DBScope, Data.Bind.GenData, Data.Bind.ObjectScope, System.Actions,
  FMX.ActnList, Data.DB;

type
  TForm1 = class(TForm)
    tbcMain: TTabControl;
    tabTasks: TTabItem;
    tabCheckList: TTabItem;
    tabUtils: TTabItem;
    lstAnketa: TListBox;
    AnketaHeaderToolBar: TToolBar;
    Label1: TLabel;
    btAnketaRight: TSpeedButton;
    btBackToTasks: TSpeedButton;
    ListBoxHeader1: TListBoxHeader;
    SearchBox1: TSearchBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    tbarTop: TToolBar;
    Label2: TLabel;
    btRefresh: TButton;
    lbCLTitle: TLabel;
    lbPlaceNm: TLabel;
    tbarFoot: TToolBar;
    Panel1: TPanel;
    lbComments: TLabel;
    btPrior: TButton;
    btNext: TButton;
    lbByDate: TLabel;
    lbPriority: TLabel;
    btSave: TButton;
    lbusr_id: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    lbStatus: TLabel;
    lbDone: TLabel;
    lbNext_Q: TLabel;
    LinkPropertyToFieldText7: TLinkPropertyToField;
    LinkPropertyToFieldText8: TLinkPropertyToField;
    LinkPropertyToFieldText9: TLinkPropertyToField;
    ActionList1: TActionList;
    acStartSurvey: TAction;
    acSwitchToCheckList: TChangeTabAction;
    acSwitchToTasks: TChangeTabAction;
    acSwitchToUtils: TChangeTabAction;
    acPost: TAction;
    tabOpenClose: TTabItem;
    Layout1: TLayout;
    edUserName: TEdit;
    edPsw: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    procedure btRefreshClick(Sender: TObject);
    procedure btPriorClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure acStartSurveyExecute(Sender: TObject);
    procedure acPostExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BindSourceDB1SubDataSourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    procedure updateJobButton;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses dmtestLB;

procedure Tform1.updateJobButton;
begin
  if (DataModule6.fqTask.FieldByName('Status').AsString = 'CLOSED') then begin
    btSave.StyleLookup := 'organizetoolbutton';
    btSave.Action := acPost;
  end
  else begin
    btSave.StyleLookup := 'playtoolbutton';
    btSave.Action := acStartSurvey;
  end;
end;

procedure TForm1.acPostExecute(Sender: TObject);
begin
  beep; //MessageDlg('Post To Server');
end;

procedure TForm1.acStartSurveyExecute(Sender: TObject);
begin
  acSwitchToCheckList.ExecuteTarget(Self);
end;

procedure TForm1.BindSourceDB1SubDataSourceDataChange(Sender: TObject; Field: TField);
begin
  updateJobButton;
end;

procedure TForm1.btNextClick(Sender: TObject);
begin
  DataModule6.fqTask.Next;
end;

procedure TForm1.btPriorClick(Sender: TObject);
begin
  DataModule6.fqTask.Prior;
end;

procedure TForm1.btRefreshClick(Sender: TObject);
begin
  DataModule6.fqTask.Refresh;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  updateJobButton;
end;

end.



