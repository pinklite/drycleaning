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
  Data.Bind.DBScope, System.Actions, FMX.ActnList, FMX.DateTimeCtrls,
  Data.Bind.Grid;

type
  TfrmEmployeesReg = class(TCommonForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtLastName: TEdit;
    edtFirstName: TEdit;
    edtMiddleName: TEdit;
    chkIsActive: TCheckBox;
    actlst1: TActionList;
    actSave: TAction;
    edtBirthday: TDateEdit;
    procedure actSaveUpdate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure FormCreate(Sender: TObject);
    procedure edtEditChange(Sender: TObject);
  private
    FViewModel: TEmployeesViewModel;
    FEmployee: TEmployee;
    procedure SetViewModel(const Value: TEmployeesViewModel);

    procedure SetCtrlVal;
    procedure GetCtrlVal;
    procedure ClrCtrlVal;
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

procedure TfrmEmployeesReg.actSaveExecute(Sender: TObject);
begin
  inherited;
  GetCtrlVal;
  if FEmployee.IsValid then btnOk.ModalResult := mrOk;
end;

procedure TfrmEmployeesReg.actSaveUpdate(Sender: TObject);
begin
  inherited;
  actSave.Enabled := FEmployee.IsValid;
end;

procedure TfrmEmployeesReg.ClrCtrlVal;
begin
  edtLastName.Text      := '';
  edtFirstName.Text     := '';
  edtMiddleName.Text    := '';
  edtBirthday.Text      := '';
  chkIsActive.IsChecked := False;
end;

constructor TfrmEmployeesReg.Create(AOwner: TComponent;
  AViewModel: TEmployeesViewModel);

var
  gff: TGeneratorFieldDef;
  lcf: TLinkControlToField;
begin
  inherited Create(AOwner);

  FViewModel  := AViewModel;
  FEmployee   := FViewModel.GetEmployee;

//  btnOk.ModalResult := mrNone;

  SetCtrlVal;

  edtLastName.OnChange := edtEditChange;
  edtFirstName.OnChange := edtEditChange;
  edtMiddleName.OnChange := edtEditChange;
end;

procedure TfrmEmployeesReg.edtEditChange(Sender: TObject);
begin
  inherited;
  GetCtrlVal;
end;

procedure TfrmEmployeesReg.FormCreate(Sender: TObject);
begin
  inherited;
  btnOk.ModalResult := mrNone;
end;

procedure TfrmEmployeesReg.GetCtrlVal;
begin
  FEmployee.LastName    := edtLastName.Text;
  FEmployee.FirstName   := edtFirstName.Text;
  FEmployee.MiddleName  := edtMiddleName.Text;
  FEmployee.Birthday    := edtBirthday.Date;
  FEmployee.IsActive    := chkIsActive.IsChecked;
end;

procedure TfrmEmployeesReg.PrototypeBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  inherited;
  ABindSourceAdapter := TObjectBindSourceAdapter<TEmployee>.Create(Self, FEmployee);
  ABindSourceAdapter.AutoEdit := True;
  ABindSourceAdapter.AutoPost := True;
end;

procedure TfrmEmployeesReg.SetCtrlVal;
begin
  edtLastName.Text      := FEmployee.LastName;
  edtFirstName.Text     := FEmployee.FirstName;
  edtMiddleName.Text    := FEmployee.MiddleName;
  edtBirthday.Date      := FEmployee.Birthday;
  chkIsActive.IsChecked := FEmployee.IsActive;


end;

procedure TfrmEmployeesReg.SetViewModel(const Value: TEmployeesViewModel);
begin
  FViewModel := Value;
end;

end.
