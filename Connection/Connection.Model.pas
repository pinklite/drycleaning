unit Connection.Model;

interface

uses
  System.SysUtils, System.IniFiles,
  Data.DB, Data.SqlExpr, Data.DBXFirebird,
  Common.Consts, Common.Types, Common.Model,
  Connection.Types, Connection.Utils;

type
  TConnectionModel = class
  private
    class var FHost: string;
    class var FPort: Word;
    class var FDatabase: string;

    class var FSQLConnection: TSQLConnection;

    class procedure SetHost(const Value: string); static;
    class procedure SetPort(const Value: Word); static;
    class procedure SetDatabase(const Value: string); static;

    class procedure Init;

  public
    class property Host: string read FHost write SetHost;
    class property Port: Word read FPort write SetPort;
    class property Database: string read FDatabase write SetDatabase;

    class property SQLConnection: TSQLConnection read FSQLConnection;

    class function GetSQLConnection: TSQLConnection;
    class procedure SetSQLConnectionParams(ASQLConnection: TSQLConnection);
  end;

implementation

{ TConnectionModel }

class function TConnectionModel.GetSQLConnection: TSQLConnection;
begin
  Result := FSQLConnection;
end;

class procedure TConnectionModel.Init;
var
  AConfFile: TIniFile;
begin
  AConfFile := TIniFile.Create(TCommonModel.ConfigFileName);
  try
    FHost := AConfFile.ReadString(CONF_FILE_DB_SECTION, 'Host', 'localhost');
    FPort := AConfFile.ReadInteger(CONF_FILE_DB_SECTION, 'Port', 3050);
    FDatabase := AConfFile.ReadString(CONF_FILE_DB_SECTION, 'Database', '');
  finally
    AConfFile.Free;
  end;

  SetSQLConnectionParams(FSQLConnection);
end;

class procedure TConnectionModel.SetDatabase(const Value: string);
begin
  FDatabase := Value;
end;

class procedure TConnectionModel.SetHost(const Value: string);
begin
  FHost := Value;
end;

class procedure TConnectionModel.SetPort(const Value: Word);
begin
  FPort := Value;
end;

class procedure TConnectionModel.SetSQLConnectionParams(
  ASQLConnection: TSQLConnection);
var
  dbp: TDbParm;
  zbdp: TZebedeeParm;
  fr: TFunctionResult;
begin
  dbp.AHost := FHost;
  dbp.APort := IntToStr(FPort);
  dbp.ADatabase := FDatabase;

  FSQLConnection := TSQLConnection.Create(nil);
  fr := SetSQLConParm(dbp, zbdp, FSQLConnection);
end;

initialization
  TConnectionModel.Init;

end.
