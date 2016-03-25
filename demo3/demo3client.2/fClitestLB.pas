unit fClitestLB;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Layouts, FMX.Grid, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ListBox, FMX.TabControl;

type
  TForm3 = class(TForm)
    Grid1: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    TabControl1: TTabControl;
    tiTasks: TTabItem;
    tiCheckList: TTabItem;
    tiResults: TTabItem;
    ListBox1: TListBox;
    ListBoxHeader1: TListBoxHeader;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    Label1: TLabel;
    BindSourceDB3: TBindSourceDB;
    LinkPropertyToFieldText: TLinkPropertyToField;
    ListBoxItem1: TListBoxItem;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldIsChecked: TLinkPropertyToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses dmtestLB;

end.
