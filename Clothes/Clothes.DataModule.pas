unit Clothes.DataModule;

interface

uses
  System.SysUtils, System.Classes,
  Connection.Model,
  Database.Types, Database.Datamodule, Database.Model, Database.Utils,
  Clothes.Classes, Clothes.Model,
  Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider, Data.DB,
  Data.SqlExpr;

type
  TdmClothes = class(TDataModule)
    sqldsClothesTypes: TSQLDataSet;
    prvClothesTypes: TDataSetProvider;
    cdsClothesTypes: TClientDataSet;
    sqldsClothes: TSQLDataSet;
    prvClothes: TDataSetProvider;
    cdsClothes: TClientDataSet;
    cdsClothesTypesID: TLargeintField;
    cdsClothesTypesTITLE: TWideStringField;
    cdsClothesTypesORDER_NO: TSmallintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsClothesTypesBeforePost(DataSet: TDataSet);
    procedure cdsClothesBeforePost(DataSet: TDataSet);
    procedure cdsClothesTypesAfterPost(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsClothesAfterPost(DataSet: TDataSet);
  private
    FClothesModel: TClothesModel;
    procedure SetClothesModel(const Value: TClothesModel);
    { Private declarations }
  public
    FDatabaseModel: TDatabaseModel;
    property ClothesModel: TClothesModel read FClothesModel write SetClothesModel;

    procedure CancelClothesDataset;
    procedure CancelClothesTypesDataset;

    procedure SaveClothes(AClothes: TClothes; AnOperation: TOperation = opInsert);
    procedure SaveClothesTypes(AClothesType: TClothesType; AnOperation: TOperation = opInsert);
    { Public declarations }
  end;

var
  dmClothes: TdmClothes;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmClothes.CancelClothesDataset;
begin
  CancelDataset(cdsClothes);
end;

procedure TdmClothes.CancelClothesTypesDataset;
begin
  CancelDataset(cdsClothesTypes);
end;

procedure TdmClothes.cdsClothesAfterPost(DataSet: TDataSet);
begin
  SaveCdsData(cdsClothes);
end;

procedure TdmClothes.cdsClothesBeforePost(DataSet: TDataSet);
begin
//  if cdsClothes.State = dsInsert then
//  begin
//    cdsClothes.FieldByName('ID').AsInteger := FClothesModel.GetClothesNextId;
//  end;
end;

procedure TdmClothes.cdsClothesTypesAfterPost(DataSet: TDataSet);
begin
  SaveCdsData(cdsClothesTypes);
end;

procedure TdmClothes.cdsClothesTypesBeforePost(DataSet: TDataSet);
begin
//  if cdsClothesTypes.State = dsInsert then
//  begin
//    cdsClothesTypes.FieldByName('ID').AsInteger := FClothesModel.GetClothesTypeNextId;
//  end;
end;

procedure TdmClothes.DataModuleCreate(Sender: TObject);
begin
  FDatabaseModel := TDatabaseModel.GetInstance;
  FClothesModel  := TClothesModel.GetInstance;

  cdsClothesTypes.Open;
  cdsClothes.Open;
end;

procedure TdmClothes.DataModuleDestroy(Sender: TObject);
begin
  SaveCdsData(cdsClothes);
  SaveCdsData(cdsClothesTypes);
end;

procedure TdmClothes.SaveClothes(AClothes: TClothes; AnOperation: TOperation);
var
  ACds: TClientDataSet;
begin
  ACds := cdsClothes;

  if ACds.Locate('SN', AClothes.SN, []) then
  begin
    Exit;
  end;

  if AnOperation = opInsert then
  begin
    AClothes.ID := FClothesModel.GetClothesNextId;

    ACds.Insert;
    ACds.FieldByName('ID').AsInteger := AClothes.ID;
    ACds.FieldByName('REGTM').AsDateTime := Now;
  end
  else
  begin
    cdsClothesTypes.Edit;
  end;
  ACds.FieldByName('SN').AsString := AClothes.SN;
  ACds.FieldByName('TYPE_ID').AsInteger := AClothes.ClothesType.ID;
  ACds.FieldByName('UPDTM').AsDateTime := Now;
  ACds.Post;
end;

procedure TdmClothes.SaveClothesTypes(AClothesType: TClothesType; AnOperation: TOperation);
begin
  if cdsClothesTypes.Locate('TITLE', AClothesType.Name, []) then
  begin
    Exit;
  end;

  if AnOperation = opInsert then
  begin
    AClothesType.ID := FClothesModel.GetClothesTypeNextId;

    cdsClothesTypes.Insert;
    cdsClothesTypes.FieldByName('ID').AsInteger :=  AClothesType.ID;
  end
  else
  begin
    cdsClothesTypes.Edit;
  end;
  cdsClothesTypes.FieldByName('TITLE').AsString := AClothesType.Name;
  cdsClothesTypes.FieldByName('ORDER_NO').AsInteger := AClothesType.OrderNo;
  cdsClothesTypes.Post;
end;

procedure TdmClothes.SetClothesModel(const Value: TClothesModel);
begin
  FClothesModel := Value;
end;

end.
