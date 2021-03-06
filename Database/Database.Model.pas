unit Database.Model;

interface

uses
  System.Classes, System.SysUtils,
  Data.DB, Data.SqlExpr,
  Common.Types,
  Connection.Model,
  Database.Types, Database.Datamodule;

type
  TDatabaseModel = class
  private
    class var FSQLConnection: TSQLConnection;
  public
    class function NewInstance: TObject; override;
    class function GetInstance: TDatabaseModel;
    class function GetCounter: Integer;

    class property SQLConnection: TSQLConnection read FSQLConnection;

//    constructor Create;

    procedure FreeInstance; override;

    function ExecSQLCmd(const ASQLCmd: string; AParams: TParams): TFunctionResult;

    function GetSequenceNextValue(ASequenceName: string): Integer;
    function GetDataset(const ASQLCmd: string; AParams: TParams = nil): TDataSet;
    function GetSQLResult(const ASQLCmd: string; AParams: TParams = nil; ADefaultValue: string = ''): string; overload;
    function GetSQLResult(const ASQLCmd: string; AParams: TParams = nil; ADefaultValue: Integer = 0): Integer; overload;
  end;

implementation

var
  AnInstance: TObject = nil;
  ACounter: Integer = 0;
  IsFinalized: Boolean = False;

{ TDatabaseModel }

//constructor TDatabaseModel.Create;
//begin
//  if AnInstance = nil then
//  begin
//    inherited Create;
//    FSQLConnection := TConnectionModel.SQLConnection;
//  end;
//end;

function TDatabaseModel.ExecSQLCmd(const ASQLCmd: string;
  AParams: TParams): TFunctionResult;
begin
  Result.Successful := False;
  try

    TConnectionModel.SQLConnection.Execute(ASQLCmd, AParams);

    Result.Successful := True;
  except
    on e: Exception do
    begin
      Result.MessageOnError := e.Message;
    end;
  end;
end;

procedure TDatabaseModel.FreeInstance;
begin
  Dec(ACounter);
  if IsFinalized then inherited FreeInstance;
end;

class function TDatabaseModel.GetCounter: Integer;
begin
  Result := ACounter;
end;

function TDatabaseModel.GetDataset(const ASQLCmd: string;
  AParams: TParams): TDataSet;
begin
  try
    FSQLConnection.Execute(ASQLCmd, AParams, Result);
  except
    on e: Exception do Result := nil;
  end;
end;

class function TDatabaseModel.GetInstance: TDatabaseModel;
begin
  Result := TDatabaseModel.Create;
end;

function TDatabaseModel.GetSequenceNextValue(ASequenceName: string): Integer;
begin
  Result := GetSQLResult('select next value for ' + ASequenceName + ' from RDB$DATABASE', nil, 0);
end;


function TDatabaseModel.GetSQLResult(const ASQLCmd: string; AParams: TParams;
  ADefaultValue: string): string;
var
  ds: TDataSet;
begin
  ds := GetDataset(ASQLCmd, AParams);
  if Assigned(ds) then
  begin
    Result := ds.Fields[0].AsString;
  end
  else
  begin
    Result := ADefaultValue;
  end;
end;

function TDatabaseModel.GetSQLResult(const ASQLCmd: string; AParams: TParams;
  ADefaultValue: Integer): Integer;
var
  ds: TDataSet;
begin
  ds := GetDataset(ASQLCmd, AParams);
  if Assigned(ds) then
  begin
    Result := ds.Fields[0].AsInteger;
  end
  else
  begin
    Result := ADefaultValue;
  end;
end;

class function TDatabaseModel.NewInstance: TObject;
begin
  Inc(ACounter);
  if AnInstance = nil then
  begin
    AnInstance := inherited NewInstance;
    FSQLConnection := TConnectionModel.SQLConnection;
    dmDatabase := TdmDatabase.Create(nil);
  end;
  Result := AnInstance;
end;

initialization
  TDatabaseModel.Create;

finalization
  IsFinalized := True;
  AnInstance.Free;

end.
