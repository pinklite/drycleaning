unit DepartmentsReg.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Common.Form, FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation,
  Departments.Classes, Departments.ViewModel, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TfrmDepartmentsReg = class(TCommonForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    edtID: TEdit;
    edtTitle: TEdit;
    edtUpdtm: TEdit;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    lnkcntrltfld1: TLinkControlToField;
    lnkcntrltfld2: TLinkControlToField;
    lnkcntrltfld4: TLinkControlToField;
    chkIsActive: TCheckBox;
    lnkcntrltfld3: TLinkControlToField;
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    FViewModel: TDepartmentsViewModel;
    { Private declarations }
  public
    { Public declarations }
    property ViewModel: TDepartmentsViewModel read FViewModel;
    constructor Create(AOwner: TComponent; AViewModel: TDepartmentsViewModel); reintroduce;
  end;

var
  frmDepartmentsReg: TfrmDepartmentsReg;

implementation

{$R *.fmx}

constructor TfrmDepartmentsReg.Create(AOwner: TComponent;
  AViewModel: TDepartmentsViewModel);
begin
  FViewModel := AViewModel;
  inherited Create(AOwner);
end;

procedure TfrmDepartmentsReg.PrototypeBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
//  inherited;
  if FViewModel <> nil then
  begin
    ABindSourceAdapter := TObjectBindSourceAdapter<TDepartment>.Create(PrototypeBindSource1,
                                                                 FViewModel.Department,
                                                                 False);
    ABindSourceAdapter.AutoPost := True;
  end;
end;

end.
