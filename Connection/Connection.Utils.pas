unit Connection.Utils;

interface

uses
  Winapi.ShellAPI, Winapi.Windows,
  System.SysUtils,
  Data.SqlExpr,
  Common.Types, Common.Consts, Common.Utils,
  Connection.Types;

function SetSQLConParm(const DbParm: TDbParm; const ZebedeeParm: TZebedeeParm; SQLCon: TSQLConnection): TFunctionResult;

implementation

function ZbdRun(const ADbParm: TDbParm; const AZebedeeParm: TZebedeeParm): TFunctionResult;
begin
  Result.Successful := False;
  try
    if GetProcessByEXE('zebedee.exe') = 0 then
    begin
      ShellExecute(0, 'open', 'zebedee',
                   PWideChar(AZebedeeParm.Port + ':' + ADbParm.AHost + ':' + ADbParm.APort),
                   PWideChar(AZebedeeParm.Path),
                   SW_HIDE);
    end;
    Result.Successful := True;
  except
    on e: Exception do Result.MessageOnError := e.Message;
  end;
end;


function CloseSQLCon(SQLCon: TSQLConnection): TFunctionResult;
begin
  Result.Successful := False;
  try
    if SQLCon.Connected then
    begin
      SQLCon.CloseDataSets;
      SQLCon.Close;
    end;
    Result.Successful := True;
  except
    on e: Exception do
    begin
      Result.MessageOnError := e.Message;
    end;
  end;
end;

function SetSQLConParm(const DbParm: TDbParm; const ZebedeeParm: TZebedeeParm; SQLCon: TSQLConnection): TFunctionResult;
var
  sDbConn: string;
begin
  Result := CloseSQLCon(SQLCon);
  if Result.Successful then
  try
    if DbParm.ARemoted and ZebedeeParm.Active then
    begin
      ZbdRun(DbParm, ZebedeeParm);
      sDbConn := Format('%s/%s:%s', [ZebedeeParm.Host, ZebedeeParm.Port, DbParm.ADatabase]);
    end
    else
    begin
      if ((DbParm.AHost = 'localhost') or (DbParm.AHost = '127.0.0.1')) and (DbParm.APort = '3050')
      then sDbConn := DbParm.ADatabase
      else sDbConn := Format('%s/%s:%s', [DbParm.AHost, DbParm.APort, DbParm.ADatabase]);
    end;

    SQLCon.DriverName     := 'Firebird';
    SQLCon.ConnectionName := 'FBSQLConnection';

    SQLCon.Params.Values['Database']       := sDbConn;
    SQLCon.Params.Values['User_name']      := DB_USR;
    SQLCon.Params.Values['Password']       := DB_PWD;
    SQLCon.Params.Values['ServerCharSet']  := DB_CHARSET;
    SQLCon.Params.Values['SQLDialect']     := '3';

    SQLCon.LoginPrompt    := False;
  except
    on e: Exception do
    begin
      Result.Successful     := False;
      Result.MessageOnError := e.Message;
    end;
  end;
end;

end.
