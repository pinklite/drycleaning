unit Departments.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Departments.ViewModel, System.Rtti, FMX.Grid.Style, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, Data.Bind.DBScope,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, FMX.Header,
  Common.Form, FMX.StdCtrls, Departments.Classes, Data.Bind.ObjectScope,
  Departments.DataModule, DepartmentsReg.View, FMX.Edit,
  Database.Types;

type
  TDepartmentsForm = class(TCommonForm)
    Header1: THeader;
    GridBindSourceDB1: TGrid;
    btnNew: TButton;
    btnEdit: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    edtID: TEdit;
    edtTitle: TEdit;
    edtUpdtm: TEdit;
    chkIsActive: TCheckBox;
    PrototypeBindSource1: TPrototypeBindSource;
    lnkcntrltfld1: TLinkControlToField;
    lnkcntrltfld2: TLinkControlToField;
    lnkcntrltfld3: TLinkControlToField;
    lnkcntrltfld4: TLinkControlToField;
    procedure btnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
  private
    FViewModel: TDepartmentsViewModel;
    procedure DepartmentReg(op: TOperation);
    { Private declarations }
  public
    procedure EditDepartment;
    procedure NewDepartment;
    { Public declarations }
  end;

var
  DepartmentsForm: TDepartmentsForm;

implementation

{$R *.fmx}

procedure TDepartmentsForm.btnEditClick(Sender: TObject);
begin
//  inherited;
  EditDepartment;
end;

procedure TDepartmentsForm.btnNewClick(Sender: TObject);
begin
//  inherited;
  NewDepartment;
end;

procedure TDepartmentsForm.DepartmentReg(op: TOperation);
begin
  if op = opUpdate
  then FViewModel.Model.AssignDepartmentValues
  else FViewModel.Department.ClearValues;

  frmDepartmentsReg := TfrmDepartmentsReg.Create(Self, FViewModel);
  try
    if frmDepartmentsReg.ShowModal = mrOk then
    begin
      FViewModel.Model.Save(FViewModel.Department, op)
    end;
  finally
    frmDepartmentsReg.Free;
  end;
end;

procedure TDepartmentsForm.EditDepartment;
begin
  DepartmentReg(opUpdate);
end;

procedure TDepartmentsForm.FormCreate(Sender: TObject);
begin
  inherited;
  FViewModel := TDepartmentsViewModel.Create;

end;

procedure TDepartmentsForm.NewDepartment;
begin
  DepartmentReg(opInsert);
end;

initialization
  RegisterClass(TDepartmentsForm);

finalization
  UnRegisterClass(TDepartmentsForm);

end.
