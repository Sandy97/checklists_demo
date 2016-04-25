program tstsave;

uses
  System.StartUpCopy,
  FMX.Forms,
  uViewM in 'uViewM.pas' {Form5},
  uSrvData in 'uSrvData.pas' {dmSrvData: TDataModule},
  uLocalData in 'uLocalData.pas' {dmMobile: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TdmSrvData, dmSrvData);
  Application.CreateForm(TdmMobile, dmMobile);
  Application.Run;
end.
