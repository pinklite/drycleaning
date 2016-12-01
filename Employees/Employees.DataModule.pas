unit Employees.DataModule;

interface

uses
  System.SysUtils, System.Classes, System.Variants,
  Data.FMTBcd, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr,
  Database.Types, Database.Utils, Database.Model, Database.Datamodule,
  Employees.Classes, Employees.Model;

type
  TdmEmployees = class(TDataModule)
    sqldsEmployees: TSQLDataSet;
    prvEmployees: TDataSetProvider;
    cdsEmployees: TClientDataSet;
    srcEmployees: TDataSource;
    cdsEmployeesID: TLargeintField;
    cdsEmployeesFIRSTNAME: TWideStringField;
    cdsEmployeesMIDDLENAME: TWideStringField;
    cdsEmployeesLASTNAME: TWideStringField;
    cdsEmployeesBIRTHDAY: TDateField;
    cdsEmployeesDEPARMENT_ID: TLargeintField;
    cdsEmployeesIS_ACTIVE: TSmallintField;
    sqltmstmpfldEmployeesUPDTM: TSQLTimeStampField;
    sqltmstmpfldEmployeesREGTM: TSQLTimeStampField;
    cdsEmployeesUSER_ID: TLargeintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsEmployeesAfterPost(DataSet: TDataSet);
  private
    FModel: TEmployeesModel;
    FDatabaseModel: TDatabaseModel;
    procedure SaveDataChanges;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmEmployees: TdmEmployees;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmEmployees.cdsEmployeesAfterPost(DataSet: TDataSet);
begin
  SaveDataChanges;
end;

procedure TdmEmployees.DataModuleCreate(Sender: TObject);
begin
  FDatabaseModel := TDatabaseModel.GetInstance;

//  sqldsEmployees.SQLConnection := TDatabaseModel.SQLConnection;
//  sqldsEmployees.CommandText := TEmployeesModel.SQLCmd;

  cdsEmployees.Open;
end;

procedure TdmEmployees.SaveDataChanges;
begin
  SaveCdsData(cdsEmployees);
end;

end.
