program ChecklistClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  fClient2 in 'fClient2.pas' {Form1},
  uSrvData in 'uSrvData.pas' {dmSrvData: TDataModule},
  uLocalData in 'uLocalData.pas' {dmMobile: TDataModule},
  CLInterfaces in 'CLInterfaces.pas',
  uWDState in 'uWDState.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMobile, dmMobile);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
