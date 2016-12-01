unit Employees.ViewModel;

interface

uses
  System.SysUtils,
  Employees.Classes, Employees.Model, Employees.DataModule;

type
  TEmployeesViewModel = class
  private
    FModel: TEmployeesModel;
    FEmployee: TEmployee;
    procedure SetEmployee(const Value: TEmployee);
  public
    property Model: TEmployeesModel read FModel;
    property Employee: TEmployee read FEmployee write SetEmployee;
    constructor Create;
    destructor Destroy; override;
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

procedure TEmployeesViewModel.SetEmployee(const Value: TEmployee);
begin
  FEmployee := Value;
end;

end.
