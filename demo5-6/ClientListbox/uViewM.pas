unit uViewM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uLocalData, uSrvData,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope, FMX.Layouts, FMX.Grid, Data.Bind.Controls, Fmx.Bind.Navigator;

type
  TForm5 = class(TForm)
    Button1: TButton;
    grTasks: TGrid;
    btRead: TButton;
    btSave: TButton;
    Panel1: TPanel;
    Splitter1: TSplitter;
    grSuresults: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindNavigator1: TBindNavigator;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    Panel2: TPanel;
    btSuRead: TButton;
    Layout1: TLayout;
    grassignments: TGrid;
    BindSourceDB3: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btReadClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btSuReadClick(Sender: TObject);
    procedure btSuSaveClick(Sender: TObject);
  private
    { Private declarations }
    MobileD: TdmMobile;
    SrvD: TdmSrvData;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}


procedure TForm5.btReadClick(Sender: TObject);
begin
   MobileD.LoadTasks(19, StrToDate('29.09.2015'));
end;

procedure TForm5.btSaveClick(Sender: TObject);
begin
  MobileD.StoreResults(46);
end;

procedure TForm5.Button1Click(Sender: TObject);
var
usr_id: integer;
wdate: TDatetime;
begin
  with MobileD do begin
    DecodeTextRef(11);
    GetAccess('aa','bb', usr_id, wdate);
    GetCLItems(19,11);
    GetDictionaries;
    LoadTasks(19, StrToDate('29.09.2015'));
    PrepareResults(9);
    StartWDay(19, StrToDate('29.09.2015'));
    CloseWDay(19, StrToDate('29.09.2015'));
    RestoreAppData;
    SaveAppData;
    StoreResults(9);
  end;
end;

procedure TForm5.btSuReadClick(Sender: TObject);
begin
   MobileD.PrepareResults(8);
end;

procedure TForm5.btSuSaveClick(Sender: TObject);
begin
  MobileD.StoreResults(46);
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  MobileD:=TdmMobile.Create(self);
  MobileD.FAdapter:=TdmSrvData.Create(self);
end;

end.
