unit Clothes.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Common.Form,
  Clothes.Classes, Clothes.DataModule, Clothes.ViewModel,
  ClothesReg.View, ClothesTypesReg.View,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox, FMX.Edit,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, FMX.Grid.Style,
  Fmx.Bind.Grid, Data.Bind.Grid, FMX.ScrollBox, FMX.Grid, Database.Types;

type
  TClothesForm = class(TCommonForm)
    btnSave: TButton;
    BindSourceDB1: TBindSourceDB;
    StringGridBindSourceDB1: TStringGrid;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    tlb1: TToolBar;
    btnNew: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
  private
    FClothesViewModel: TClothesViewModel;
    FItemIndex: Integer;
    { Private declarations }
  public
    procedure ClothesRegForm(const AnOperation: TOperation = opInsert);
    procedure ClothesTypeRegForm(const AnOperation: TOperation = opInsert);
    { Public declarations }
  end;

var
  ClothesForm: TClothesForm;

implementation

{$R *.fmx}

{ TForm2 }

procedure TClothesForm.btnNewClick(Sender: TObject);
begin
//  inherited;
  ClothesRegForm;
end;

procedure TClothesForm.ClothesRegForm(const AnOperation: TOperation);
var
  frmClothesReg: TfrmClothesReg;
  mr: TModalResult;
begin
  frmClothesReg := TfrmClothesReg.Create(Self, FClothesViewModel, AnOperation);
  try
    mr := frmClothesReg.ShowModal;
    FClothesViewModel.SaveClothesDataset(mr);
  finally
    FreeAndNil(frmClothesReg);
  end;
end;

procedure TClothesForm.ClothesTypeRegForm(const AnOperation: TOperation);
var
  frmClothesTypeReg: TfrmClothesTypeReg;
  mr: TModalResult;
begin
  frmClothesTypeReg := TfrmClothesTypeReg.Create(Self, FClothesViewModel, AnOperation);
  try
    mr := frmClothesTypeReg.ShowModal;
  finally
    FreeAndNil(frmClothesTypeReg);
  end;
end;

procedure TClothesForm.FormCreate(Sender: TObject);
begin
  FClothesViewModel := TClothesViewModel.GetInstance;
//  FClothesViewModel.FillComboBox(cbbClothesTypes);
end;

initialization
  RegisterClass(TClothesForm);

finalization
  UnRegisterClass(TClothesForm);

end.
