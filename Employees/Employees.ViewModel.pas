unit Employees.ViewModel;

interface

uses
  System.SysUtils,
  Database.Types,
  Employees.Classes, Employees.Model, Employees.DataModule;

type
  TEmployeesViewModel = class
  private
    FModel: TEmployeesModel;
    FEmployee: TEmployee;
    FOperation: TOperation;
    procedure SetEmployee(const Value: TEmployee);
    procedure SetOperation(const Value: TOperation);
  public
    property Model: TEmployeesModel read FModel;
    property Employee: TEmployee read FEmployee write SetEmployee;
    property Operation: TOperation read FOperation write SetOperation;

    constructor Create;
    destructor Destroy; override;

    function GetEmployee: TEmployee;

    procedure SaveEmployee(AnOperation: TOperation = opInsert);
  end;

implementation

{ TEmployeesViewModel }

constructor TEmployeesViewModel.Create;
begin
  inherited Create;
  FModel := TEmployeesModel.GetInstance;
  dmEmployees := TdmEmployees.Create(nil);

//  FEmployee := TEmployee.Create(
//    1, 'Aliev', 'Gani', 'Valievich', StrToDate('01/01/1977'), True, 1
//  );
end;

destructor TEmployeesViewModel.Destroy;
begin
  dmEmployees.Free;
  inherited;
end;

function TEmployeesViewModel.GetEmployee: TEmployee;
begin
  if FEmployee <> nil then FEmployee.Free;
  FEmployee := TEmployee.Create(0, '', '', '', 0, False, 0);
  if FOperation <> opInsert then FModel.LoadEmployee(FEmployee, dmEmployees.cdsEmployees);
  Result := FEmployee;
end;

procedure TEmployeesViewModel.SaveEmployee(AnOperation: TOperation);
begin
  FModel.SaveEmployee(FEmployee, dmEmployees.cdsEmployees, FOperation);
end;

procedure TEmployeesViewModel.SetEmployee(const Value: TEmployee);
begin
  FEmployee := Value;
end;

procedure TEmployeesViewModel.SetOperation(const Value: TOperation);
begin
  FOperation := Value;

end;

end.
