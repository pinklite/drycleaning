unit Connection.Types;

interface

//uses
//  Winapi.ShellAPI, Winapi.Windows,
//  System.SysUtils,
//  Data.SqlExpr,
//  Common.Types, Common.Consts, Common.Utils;

type
  TDbParm = record
    AHost: string;
    APort: string;
    ADatabase: string;
    ARemoted: Boolean;
    procedure Clear;
  end;

  TZebedeeParm = record
    Active: Boolean;
    Host: string;
    Port: string;
    Path: string;
    procedure Clear;
  end;


implementation

{ TDbParm }

procedure TDbParm.Clear;
begin
  AHost := '';
  APort := '';
  ADatabase := '';
  ARemoted := False;
end;

{ TZebedeeParm }

procedure TZebedeeParm.Clear;
begin
  Active := False;
  Host   := '';
  Port   := '';
  Path   := '';
end;

end.
