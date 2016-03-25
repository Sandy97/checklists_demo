program Demo3Client_2;

uses
  System.StartUpCopy,
  FMX.Forms,
  fClient2 in 'fClient2.pas' {Form1},
  dmClientLB in 'dmClientLB.pas' {dmMobile: TDataModule},
  dmCLServer in 'dmCLServer.pas' {dmAdapter: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMobile, dmMobile);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
