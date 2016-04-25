unit CLInterfaces;

interface

uses
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  ICLDataAPI = interface
    ['{441FEB7C-945A-4CF5-94F2-8BEF755A0A0E}']
    function GetServer(): string;
    procedure SetServer(const Value: string);
    property Server: string read GetServer write SetServer;

    procedure GetAccess(const usrnm, psw: string; var usr_id: integer; var wdate: TDatetime);
    procedure GetTasks(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
    procedure GetCLItems(tg: TFDDataset; const tskid, clid: integer);
    procedure GetWDayCL(tg: TFDDataset; const usrid: integer; const wdate: TDatetime);
    procedure GetTexts(tg: TFDDataset);
    procedure GetResponsible(tg: TFDDataset);
    procedure GetSuresults(tg: TFDDataset; const tskid: integer);
    procedure GetAssignments(tg: TFDDataset; const tskid: integer);
    procedure PostSuresults(sd: TFDDataset; const tskid: integer);
    procedure PostAssignments(sd: TFDDataset; const tskid: integer);
    procedure GetSuresultsSchema(tg: TFDSchemaAdapter; const tskid: integer);
    procedure PostSuresultsSchema(sda: TFDSchemaAdapter; const tskid: integer);
    procedure PostTasks(tg: TFDDataset);
  end;

implementation

end.
