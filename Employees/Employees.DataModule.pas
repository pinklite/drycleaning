unit Employees.DataModule;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr,
  Database.Utils, Database.Model, Database.Datamodule,
  Employees.Model;

type
  TdmEmployees = class(TDataModule)
    sqldsEmployees: TSQLDataSet;
    prvEmployees: TDataSetProvider;
    cdsEmployees: TClientDataSet;
    srcEmployees: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsEmployeesBeforePost(DataSet: TDataSet);
    procedure cdsEmployeesAfterPost(DataSet: TDataSet);
  private
    FModel: TEmployeesModel;
    FDatabaseModel: TDatabaseModel;

    procedure SaveDataChanges;
    { Private declarations }
  public
    property Model: TEmployeesModel read FModel;
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

procedure TdmEmployees.cdsEmployeesBeforePost(DataSet: TDataSet);
begin
  if cdsEmployees.State in [dsInsert] then
  begin
    cdsEmployees.FieldByName('ID').AsInteger := FDatabaseModel.GetSequenceNextValue('SEQ_ID_EMPLOYEES');
  end;
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
