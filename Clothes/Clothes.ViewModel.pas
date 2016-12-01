unit Clothes.ViewModel;

interface

uses
  Data.DB,
  System.UITypes, System.SysUtils,
  Common.Types,
  Clothes.Classes, Clothes.Model, Clothes.DataModule,
  FMX.ListBox;

type
  TClothesViewModel = class
  private
    constructor Create; reintroduce;
  private
    FClothesModel: TClothesModel;
    FClothesTypeModel: TClothesTypeModel;
    FDataModule: TdmClothes;
    FClothesType: TClothesType;
    FClothes: TClothes;
    function GetClothesTypesDataset: TDataSet;
    procedure SetClothes(const Value: TClothes);
    procedure SetClothesType(const Value: TClothesType);
  public
    class function GetInstance: TClothesViewModel;

    procedure FillComboBox(AComboBox: TComboBox);
    procedure SaveClothes(AClothesType: TClothesType; const SerNo: string);

    property ClothesTypesDataset: TDataSet read GetClothesTypesDataset;
    procedure AppendClothesTypesDataset;
    procedure SaveClothesDataset(AModalResult: TModalResult);
    function SaveClothesTypesDataset: TFunctionResult;

    property Clothes: TClothes read FClothes write SetClothes;
    property ClothesType: TClothesType read FClothesType write SetClothesType;
  end;

implementation

var
  ViewModel: TClothesViewModel = nil;

{ TClothesViewModel }

procedure TClothesViewModel.AppendClothesTypesDataset;
begin
//  dmClothes.cdsClothesTypes.Insert;
end;

constructor TClothesViewModel.Create;
begin
  inherited Create;
  FClothesModel := TClothesModel.Create;
  FClothesTypeModel := TClothesTypeModel.Create;
  dmClothes := TdmClothes.Create(nil);
  FDataModule := dmClothes;

  FClothesType := TClothesType.Create(0, '', 0);
  FClothes := TClothes.Create(0, '', '', FClothesType);
end;

procedure TClothesViewModel.FillComboBox(AComboBox: TComboBox);
var
  AClothesType: TClothesType;
begin
  for AClothesType in FClothesTypeModel.ClothesTypes do
  begin
    AComboBox.Items.AddObject(AClothesType.Name, AClothesType);
  end;
end;

function TClothesViewModel.GetClothesTypesDataset: TDataSet;
begin
  Result := dmClothes.cdsClothesTypes;
end;

class function TClothesViewModel.GetInstance: TClothesViewModel;
begin
  if ViewModel = nil then
  begin
    ViewModel := TClothesViewModel.Create;
  end;
  Result := ViewModel;
end;

procedure TClothesViewModel.SaveClothes(AClothesType: TClothesType;
  const SerNo: string);
begin
   FClothesModel.SaveToDatabase(AClothesType, SerNo);
end;

procedure TClothesViewModel.SaveClothesDataset(AModalResult: TModalResult);
begin
  if AModalResult = mrOk then
  begin
    FDataModule.SaveClothes(FClothes);
  end
  else
  begin
    FDataModule.CancelClothesTypesDataset;
  end;
end;

function TClothesViewModel.SaveClothesTypesDataset: TFunctionResult;
begin
  try
    FDataModule.SaveClothesTypes(FClothesType);
    Result.Successful := True;
  except
    on e: Exception do
    begin
      FDataModule.CancelClothesTypesDataset;

      Result.Successful := False;
      Result.MessageOnError := e.Message;
    end;
  end;
end;

procedure TClothesViewModel.SetClothes(const Value: TClothes);
begin
  FClothes := Value;
end;

procedure TClothesViewModel.SetClothesType(const Value: TClothesType);
begin
  FClothesType := Value;
end;

initialization
  ViewModel := TClothesViewModel.Create;

finalization
  if ViewModel <> nil then
  begin
    ViewModel.Free;
    ViewModel := nil;
  end;

end.
