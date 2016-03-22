unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.TabControl, Data.Bind.Components, FMX.StdCtrls,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListBox, FMX.Controls.Presentation,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Layouts, FMX.Grid;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    ListBoxHeader1: TListBoxHeader;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkListControlToField1: TLinkListControlToField;
    LinkFillControlToField1: TLinkFillControlToField;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

end.