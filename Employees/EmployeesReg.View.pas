unit EmployeesReg.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Bindings.Helper, System.Bindings.Expression,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Common.Form, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  Employees.Classes, Employees.ViewModel, Employees.DataModule,
  Data.Bind.Components, Data.Bind.ObjectScope, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.DBScope;

type
  TfrmEmployeesReg = class(TCommonForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtLastName: TEdit;
    edtFistName: TEdit;
    edtMiddleName: TEdit;
    edtBirthday: TEdit;
    chkIsActive: TCheckBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
  private
    FViewModel: TEmployeesViewModel;

    procedure SetViewModel(const Value: TEmployeesViewModel);
    { Private declarations }
  public
    property ViewModel: TEmployeesViewModel read FViewModel; // write SetViewModel;

    constructor Create(AOwner: TComponent; AViewModel: TEmployeesViewModel); reintroduce;
    { Public declarations }
  end;

var
  frmEmployeesReg: TfrmEmployeesReg;

implementation

{$R *.fmx}

constructor TfrmEmployeesReg.Create(AOwner: TComponent;
  AViewModel: TEmployeesViewModel);
begin
  inherited Create(AOwner);
  FViewModel := AViewModel;
  btnOk.ModalResult := mrOk;
end;

procedure TfrmEmployeesReg.SetViewModel(const Value: TEmployeesViewModel);
begin
  FViewModel := Value;
end;

end.
