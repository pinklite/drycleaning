unit Clothes.Model;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  Common.Types,
  Clothes.Classes,
  Database.Types, Database.Model;

type
  TClothesTypeModel = class
  private
    class var FSQLCmd: string;
    class procedure Init;
  private
    FDatabaseModel: TDatabaseModel;
//    FClothesType: TClothesType;
    FClothesTypes: TList<TClothesType>;
  public
    class property SQLCmd: string read FSQLCmd;

//    property ClothesType: TClothesType read FClothesType;

    property ClothesTypes: TList<TClothesType> read FClothesTypes;
    procedure LoadFromDatabase(AClothesTypeName: string);
    procedure SaveToDatabase(AClothesType: TClothesType);

    constructor Create;
  end;

  TClothesModel = class
  private
    class var FDatabaseModel: TDatabaseModel;
    class var FSQLCmd: string;
    class procedure Init;
  private
    FClothes: TClothes;
    procedure SetClothes(const Value: TClothes);
  public
    class function NewInstance: TObject; override;
    class function GetInstance: TClothesModel;

    class property SQLCmd: string read FSQLCmd;

    procedure FreeInstance; override;

    property Clothes: TClothes read FClothes write SetClothes;
    procedure LoadFromDatabase(AClothesName: string);
    function SaveToDatabase(AClothes: TClothes; AnOperation: TOperation = opInsert): TFunctionResult; overload;
    function SaveToDatabase(AClothesType: TClothesType; const SerNo: string; AnOperation: TOperation = opInsert): TFunctionResult; overload;

    function GetClothesTypeNextId: Integer;
    function GetClothesNextId: Integer;
  end;

implementation

var
  AnInstance: TObject = nil;
  ACounter: Integer = 0;
  IsFinalized: Boolean = False;

{ TClotheModel }

procedure TClothesModel.FreeInstance;
begin
  Dec(ACounter);
  if IsFinalized then inherited FreeInstance;
end;

function TClothesModel.GetClothesNextId: Integer;
begin
  Result := FDatabaseModel.GetSequenceNextValue('SEQ_ID_CLOTHES');
end;

function TClothesModel.GetClothesTypeNextId: Integer;
begin
  Result := FDatabaseModel.GetSequenceNextValue('SEQ_ID_CLOTHES_TYPE');
end;

class function TClothesModel.GetInstance: TClothesModel;
begin
  Result := TClothesModel.Create;
end;

class procedure TClothesModel.Init;
begin
end;

procedure TClothesModel.LoadFromDatabase(AClothesName: string);
begin

end;

class function TClothesModel.NewInstance: TObject;
begin
  if AnInstance = nil then
  begin
    AnInstance     := inherited NewInstance;
    FDatabaseModel := TDatabaseModel.GetInstance;
    FSQLCmd        := 'select ID, SN, TYPE_ID from CLOTHES';
  end;
  Inc(ACounter);
  Result := AnInstance;
end;

function TClothesModel.SaveToDatabase(AClothes: TClothes; AnOperation: TOperation): TFunctionResult;
var
  ASQLCmd: string;
  AParams: TParams;
begin
  AParams := TParams.Create;
  try
    case AnOperation of
      opInsert:
      begin
        ASQLCmd := 'insert into CLOTHES (ID, SN, TYPE_ID) values (:ID, :SN, :TYPE_ID)';
        AClothes.ID := GetClothesNextId;
      end;
      opUpdate: ASQLCmd := 'update CLOTHES set SN = :SN, TYPE_ID = :TYPE_ID where ID = :ID';
//      opDelete: ASQLCmd := 'delete from CLOTHES where ID = :ID';
    end;

    AParams.CreateParam(ftInteger, 'ID', ptInput).Value := AClothes.ID;
    AParams.CreateParam(ftString, 'SN', ptInput).Value := AClothes.SN;
    AParams.CreateParam(ftInteger, 'TYPE_ID', ptInput).Value := AClothes.ClothesType.ID;

    FDatabaseModel.ExecSQLCmd(ASQLCmd, AParams);

    Result.Successful := True;
  except
    on e: Exception do
    begin
      Result.Successful := False;
      Result.MessageOnError := e.Message;
    end;
  end;
end;

function TClothesModel.SaveToDatabase(AClothesType: TClothesType;
  const SerNo: string; AnOperation: TOperation): TFunctionResult;
var
  AClothes: TClothes;
begin
  AClothes := TClothes.Create(0, '', SerNo, AClothesType);
  try
    Result := SaveToDatabase(AClothes,  AnOperation);
  finally
    AClothes.ClothesType := nil;
    AClothes.Free;
  end;
end;

procedure TClothesModel.SetClothes(const Value: TClothes);
begin
  FClothes := Value;
end;

{ TClothesType }

constructor TClothesTypeModel.Create;
var
  ds: TDataSet;
begin
  inherited Create;

  FClothesTypes := TList<TClothesType>.Create;

  FDatabaseModel := TDatabaseModel.GetInstance; //Create;

  ds := FDatabaseModel.GetDataset('select ID, TITLE, ORDER_NO from CLOTHES_TYPES');
  while not ds.Eof do
  begin
    FClothesTypes.Add(
      TClothesType.Create(
        ds.FieldByName('ID').AsInteger,
        ds.FieldByName('TITLE').AsString,
        ds.FieldByName('ORDER_NO').AsInteger
      )
    );
    ds.Next;
  end;
end;

class procedure TClothesTypeModel.Init;
begin
  FSQLCmd := 'select ID, TITLE from CLOTHES_TYPES order by ORDER_NO';
end;

procedure TClothesTypeModel.LoadFromDatabase;
begin

end;

procedure TClothesTypeModel.SaveToDatabase(AClothesType: TClothesType);
begin

end;

initialization
  TClothesModel.Create;
  TClothesTypeModel.Init;

finalization
  IsFinalized := True;
  AnInstance.Free;

end.
