program Calculator;

uses
  System.StartUpCopy,
  FMX.Forms,
  Home in 'Home.pas' {FormHome},
  UDM in 'UDM.pas' {DM: TDataModule},
  Splash in 'Splash.pas' {FormSplash},
  UOpenURL in 'UOpenURL.pas',
  GPS in 'GPS.pas' {FormGPS};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormSplash, FormSplash);
  Application.CreateForm(TFormGPS, FormGPS);
  Application.Run;
end.
