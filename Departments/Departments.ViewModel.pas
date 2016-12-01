unit Departments.ViewModel;

interface

uses
  Data.DB,
  Departments.Classes, Departments.Model;

type
  TDepartmentsViewModel = class
  private
    FModel: TDepartmentModel;
    FDepartment: TDepartment;
  public
    constructor Create; //(AModel: TDepartmentModel);
    property Model: TDepartmentModel read FModel;
    property Department: TDepartment read FDepartment;
    function GetDataset: TDataSet;
  end;

implementation

{ TDepartmentsViewModel }

constructor TDepartmentsViewModel.Create; //(AModel: TDepartmentModel);
begin
  inherited Create;
  FModel := TDepartmentModel.Create;
  FDepartment := FModel.Department;
end;

function TDepartmentsViewModel.GetDataset: TDataSet;
begin
  Result := FModel.DataSet;
end;

end.
