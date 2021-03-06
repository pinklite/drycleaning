unit Departments.Model;

interface

uses
  System.SysUtils,
  Data.DB, Data.SqlExpr, Data.DBXCommon,
  Common.Types,
  Database.Model, Database.Types,
  Departments.Classes, Departments.DataModule;

type
  TDepartmentModel = class
  private
    FDepartment: TDepartment;
    FDatabaseModel: TDatabaseModel;
    FDataModule: TdmDepartments;
    FDataSet: TDataSet;
  public
    constructor Create;
    property Department: TDepartment read FDepartment;
    property DataSet: TDataSet read FDataSet;
    function GetDepartmentsDataSet: TDataSet;

    function Save(ADepartment: TDepartment; const AnOperation: TOperation = opInsert): TFunctionResult;
    procedure AssignDepartmentValues;
  end;

implementation

var
  FDepartmentsSQL: string = 'select ID, TITLE, IS_ACTIVE, UPDTM from DEPARTMENTS';

{ TDepartmentModel }

procedure TDepartmentModel.AssignDepartmentValues;
begin
  FDepartment.AssignValues(FDataSet);
end;

constructor TDepartmentModel.Create;
begin
  FDepartment := TDepartment.Create;

  FDatabaseModel := TDatabaseModel.GetInstance;

  FDataModule := TdmDepartments.Create(nil);
  FDataModule.sqldsDepartments.CommandText := FDepartmentsSQL;
  FDataModule.cdsDepartments.Open;

  FDataSet := FDataModule.cdsDepartments; //TSQLDataSet.Create(nil);
//  FDataSet.SQLConnection  := TDatabaseModel.SQLConnection;
//  FDataSet.CommandText    := FDepartmentsSQL;
end;

function TDepartmentModel.GetDepartmentsDataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDepartmentModel.Save(ADepartment: TDepartment; const AnOperation: TOperation): TFunctionResult;
begin
  try
    Result.Successful := ADepartment.IsValid;

    if not ADepartment.IsValid then Exit;

    if AnOperation = opUpdate then
    begin
      if FDataSet.Locate('ID', ADepartment.ID, []) then
      begin
        FDataSet.Edit;
      end
      else  Exit;
    end
    else
    begin
      ADepartment.ID := FDatabaseModel.GetSequenceNextValue('SEQ_ID_DEPARTMENTS');
      FDataSet.Append;
      FDataSet.FieldByName('ID').AsInteger := ADepartment.ID;
    end;
    FDataSet.FieldByName('TITLE').AsString      := ADepartment.Title;
    FDataSet.FieldByName('IS_ACTIVE').AsInteger := ADepartment.IsActive.ToInteger;
    FDataSet.FieldByName('UPDTM').AsDateTime    := Now;
    FDataSet.Post;
  except
    on e: Exception do Result.MessageOnError := e.Message;
  end;
end;

end.
