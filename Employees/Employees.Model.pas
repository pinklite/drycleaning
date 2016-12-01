unit Employees.Model;

interface

uses
  System.Variants, System.SysUtils, System.Math,
  Data.DB,
  Database.Types, Database.Model,
  Employees.Classes;

type
  TEmployeesModel = class
  private
    class var FSQLCmd: string;
  private
    FDatabaseModel: TDatabaseModel;
//    FEmployee: TEmployee;
    constructor Create;
  public
    class property SQLCmd: string read FSQLCmd;
    class function GetInstance: TEmployeesModel;

    function GetNewEmployeeId: Integer;

    procedure SaveEmployee(AEmployee: TEmployee; ADataSet: TDataSet; AnOperation: TOperation = opInsert);
    procedure LoadEmployee(var AEmployee: TEmployee; ADataSet: TDataSet);
  public

  end;

implementation

var
  AnInstance: TEmployeesModel = nil;
  SQLCmd: string = 'select ID, FIRSTNAME, MIDDLENAME, LASTNAME, BIRTHDAY, DEPARMENT_ID, IS_ACTIVE, UPDTM, REGTM, USER_ID from EMPLOYEES';

{ TEmployeesModel }

constructor TEmployeesModel.Create;
begin
  inherited Create;
  FDatabaseModel := TDatabaseModel.GetInstance;
//  FEmployee := TEmployee.Create;
end;

class function TEmployeesModel.GetInstance: TEmployeesModel;
begin
  if AnInstance = nil then AnInstance := TEmployeesModel.Create;
  Result := AnInstance;
end;

function TEmployeesModel.GetNewEmployeeId: Integer;
begin
  Result := FDatabaseModel.GetSequenceNextValue('SEQ_ID_EMPLOYEES');
end;

procedure TEmployeesModel.LoadEmployee(var AEmployee: TEmployee;
  ADataSet: TDataSet);
begin
  AEmployee.LastName      := ADataSet.FieldByName('LASTNAME').AsString;
  AEmployee.FirstName     := ADataSet.FieldByName('FIRSTNAME').AsString;
  AEmployee.MiddleName    := ADataSet.FieldByName('MIDDLENAME').AsString;
  AEmployee.Birthday      := ADataSet.FieldByName('BIRTHDAY').AsDateTime;
  AEmployee.DepartmentID  := ADataSet.FieldByName('DEPARMENT_ID').AsInteger;
  AEmployee.IsActive      := ADataSet.FieldByName('IS_ACTIVE').AsInteger=1;
end;

procedure TEmployeesModel.SaveEmployee(AEmployee: TEmployee;
  ADataSet: TDataSet; AnOperation: TOperation);
begin
  if not AEmployee.IsValid then Exit;

  if (AnOperation = opInsert)
     and
     ADataSet.Locate('LASTNAME;FIRSTNAME;MIDDLENAME',
                     VarArrayOf([AEmployee.LastName,
                                     AEmployee.FirstName,
                                     AEmployee.MiddleName]),
                         [])
  then Exit;

  if AnOperation = opInsert then
  begin
    AEmployee.ID := GetNewEmployeeId;

    ADataSet.Insert;
    ADataSet.FieldByName('ID').AsInteger := AEmployee.ID;
    ADataSet.FieldByName('REGTM').AsDateTime := Now;
  end
  else
  begin
    ADataSet.Edit;
  end;

  ADataSet.FieldByName('LASTNAME').Value := AEmployee.LastName;
  ADataSet.FieldByName('FIRSTNAME').Value := AEmployee.FirstName;
  ADataSet.FieldByName('MIDDLENAME').Value := AEmployee.MiddleName;
  ADataSet.FieldByName('BIRTHDAY').Value := AEmployee.Birthday;
  ADataSet.FieldByName('DEPARMENT_ID').Value := AEmployee.DepartmentID;
  ADataSet.FieldByName('IS_ACTIVE').AsInteger := ifthen(AEmployee.IsActive, 1, 0);
  ADataSet.FieldByName('UPDTM').Value := Now;

  ADataSet.Post;
end;

initialization
  TEmployeesModel.FSQLCmd := 'select '
                          + 'ID, '
                          + 'FIRSTNAME, '
                          + 'MIDDLENAME, '
                          + 'LASTNAME, '
                          + 'BIRTHDAY, '
                          + 'DEPARMENT_ID, '
                          + 'IS_ACTIVE, '
                          + 'UPDTM, '
                          + 'REGTM, '
                          + 'USER_ID '
                          + 'from EMPLOYEES';

finalization
  if AnInstance<>nil then AnInstance.Free;
  

end.
