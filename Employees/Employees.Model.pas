unit Employees.Model;

interface

uses
  Employees.Classes;

type
  TEmployeesModel = class
  private
    class var FSQLCmd: string;
  private
    constructor Create;
  public
    class property SQLCmd: string read FSQLCmd;
    class function GetInstance: TEmployeesModel;
  public

  end;

implementation

var
  AnInstance: TEmployeesModel = nil;
  SQLCmd: string = 'select ID, FIRSTNAME, MIDDLENAME, LASTNAME, BIRTHDAY, DEPARMENT_ID, IS_ACTIVE, UPDTM, REGTM, USER_ID from EMPLOYEES';

{ TEmployeesModel }

{ TEmployeesModel }

constructor TEmployeesModel.Create;
begin
  inherited Create;
end;

class function TEmployeesModel.GetInstance: TEmployeesModel;
begin
  if AnInstance = nil then AnInstance := TEmployeesModel.Create;
  Result := AnInstance;
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
