unit ClothesReg.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Common.Form, FMX.Edit, FMX.StdCtrls, FMX.ListBox, FMX.Controls.Presentation,
  Database.Types,
  Clothes.Classes, Clothes.DataModule, Clothes.ViewModel, ClothesTypesReg.View,
  Data.Bind.Components, Data.Bind.DBScope, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, FMX.Grid.Style,
  Fmx.Bind.Grid, Data.Bind.Grid, FMX.ScrollBox, FMX.Grid;

type
  TfrmClothesReg = class(TCommonForm)
    cbbClothesTypes: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    edtSN: TEdit;
    btnNew: TSpeedButton;
    grpEmployee: TGroupBox;
    edt1: TEdit;
    btn1: TSpeedButton;
    procedure btnNewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FViewModel: TClothesViewModel;
    FClothes: TClothes;
    FOperation: TOperation;

    procedure GetCtrlVals;

    procedure ClothesTypeRegForm(const AnOperation: TOperation = opInsert);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AViewModel: TClothesViewModel; AnOperation: TOperation = opInsert); reintroduce;
    { Public declarations }
  end;

var
  frmClothesReg: TfrmClothesReg;

implementation

{$R *.fmx}

{ TForm3 }

procedure TfrmClothesReg.btnCloseClick(Sender: TObject);
begin
  GetCtrlVals;
  inherited;
end;

procedure TfrmClothesReg.btnNewClick(Sender: TObject);
begin
  inherited;
  ClothesTypeRegForm();
end;

procedure TfrmClothesReg.ClothesTypeRegForm(const AnOperation: TOperation);
var
  frmClothesTypeReg: TfrmClothesTypeReg;
  mr: TModalResult;
begin
  frmClothesTypeReg := TfrmClothesTypeReg.Create(Self, FViewModel);
  try
    mr := frmClothesTypeReg.ShowModal;
//    FViewModel.SaveClothesTypesDataset(mr);
    if mr = mrOk  then
    begin
      cbbClothesTypes.Items.AddObject(frmClothesTypeReg.ClothesType.Name, frmClothesTypeReg.ClothesType);
      cbbClothesTypes.ItemIndex := cbbClothesTypes.Items.IndexOf(frmClothesTypeReg.ClothesType.Name);
    end;
  finally
    FreeAndNil(frmClothesTypeReg);
  end;
end;

constructor TfrmClothesReg.Create(AOwner: TComponent;
  AViewModel: TClothesViewModel;
  AnOperation: TOperation = opInsert);
begin
  inherited Create(AOwner);
  FViewModel := AViewModel;
  FClothes := FViewModel.Clothes;
  FOperation := AnOperation;

  FViewModel.FillComboBox(cbbClothesTypes);
end;

procedure TfrmClothesReg.GetCtrlVals;
begin
  FClothes.SN := edtSN.Text;
  FClothes.ClothesType := TClothesType(cbbClothesTypes.Items.Objects[cbbClothesTypes.ItemIndex]);
end;

end.
