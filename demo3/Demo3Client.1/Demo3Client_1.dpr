program Demo3Client_1;

uses
  System.StartUpCopy,
  FMX.Forms,
  fClient2 in 'fClient2.pas' {Form1},
  dmClientLB in 'dmClientLB.pas' {dmMobile: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMobile, dmMobile);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
