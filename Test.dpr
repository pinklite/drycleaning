program Test;

uses
  System.StartUpCopy,
  FMX.Forms,
  Test.View in 'Test\Test.View.pas' {Form1},
  Connection.Model in 'Connection\Connection.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
