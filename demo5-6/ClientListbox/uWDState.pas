unit uWDState;

interface

uses
  System.Classes, FMX.ListBox;

type
  TwdState = class(TComponent)
  public
    DayStarted: TDateTime;
    usrid: integer;
    date: TDateTime;
    TaskCnt: integer;
    ClosedTaskCnt: integer;

    Server: string;
    tsk_id: integer;
    cl_id: integer;
    albi: TListBoxItem;
    constructor Create(Aowner: TComponent);
    procedure SetWdsState(dStarted: TdateTime; tsk, closed: integer);
  end;

implementation

{ TwdState }

constructor TwdState.Create(Aowner: TComponent);
begin
  inherited;
  DayStarted := 0;
  usrid := 0;
  date := 0;
  TaskCnt := 0;
  ClosedTaskCnt := 0;

  Server := 'localhost';
  tsk_id := 0;
  cl_id := 0;
  albi := nil;
end;

procedure TwdState.SetWdsState(dStarted: TdateTime; tsk, closed: integer);
begin
  DayStarted:=dStarted;
  TaskCnt:=tsk;
  ClosedTaskCnt:=closed;
end;

end.
