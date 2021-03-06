unit ClothesTypesReg.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Common.Types, Common.Form,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  Database.Types,
  Clothes.Classes, Clothes.ViewModel, Clothes.DataModule,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, FMX.EditBox, FMX.SpinBox;

type
  TfrmClothesTypeReg = class(TCommonForm)
    lbl1: TLabel;
    edtTitle: TEdit;
    spnOrderNo: TSpinBox;
    procedure btnOkClick(Sender: TObject);
  private
    FViewModel: TClothesViewModel;
    FClothesType: TClothesType;
    FOperation: TOperation;

    procedure SetCtrlVal;
    procedure GetCtrlVal;
    procedure SetOperation(const Value: TOperation);
    function GetClothesType: TClothesType;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AViewModel: TClothesViewModel; AnOperation: TOperation = opInsert); reintroduce;
    property Operation: TOperation read FOperation; // write SetOperation;
    property ClothesType: TClothesType read GetClothesType;
    { Public declarations }
  end;

//var
//  frmClothesTypeReg: TfrmClothesTypeReg;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

{ TfrmClothesTypeReg }

procedure TfrmClothesTypeReg.btnOkClick(Sender: TObject);
var
  fr: TFunctionResult;
begin
//  inherited;
  ModalResult := mrNone;
  GetCtrlVal;
  fr := FViewModel.SaveClothesTypesDataset;
  if fr.Successful then ModalResult := mrOk;
end;

constructor TfrmClothesTypeReg.Create(AOwner: TComponent;
  AViewModel: TClothesViewModel;
  AnOperation: TOperation);
begin
  inherited Create(AOwner);

  FViewModel := AViewModel;
  FOperation := AnOperation;
  FClothesType := FViewModel.ClothesType;

  btnOk.ModalResult := mrOk;
  btnClose.ModalResult := mrCancel;
end;

function TfrmClothesTypeReg.GetClothesType: TClothesType;
begin
  Result := FClothesType;
end;

procedure TfrmClothesTypeReg.GetCtrlVal;
begin
  FClothesType.Name    := edtTitle.Text;
  FClothesType.OrderNo := spnOrderNo.Text.ToInteger;
end;

procedure TfrmClothesTypeReg.SetCtrlVal;
begin
  edtTitle.Text   := FClothesType.Name;
  spnOrderNo.Text := FClothesType.OrderNo.ToString;
end;

procedure TfrmClothesTypeReg.SetOperation(const Value: TOperation);
begin
  FOperation := Value;
  if FOperation <> opInsert then SetCtrlVal;
end;

end.
