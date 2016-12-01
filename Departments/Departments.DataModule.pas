unit Departments.DataModule;

interface

uses
  System.SysUtils, System.Classes,
  Data.FMTBcd, Data.DB, Data.SqlExpr, Datasnap.DBClient, Datasnap.Provider,
  Database.Model;

type
  TdmDepartments = class(TDataModule)
    sqldsDepartments: TSQLDataSet;
    prvDepartments: TDataSetProvider;
    cdsDepartments: TClientDataSet;
    srcDepartments: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsDepartmentsAfterPost(DataSet: TDataSet);
  private
    FDatabaseModel: TDatabaseModel;
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  dmDepartments: TdmDepartments;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmDepartments.cdsDepartmentsAfterPost(DataSet: TDataSet);
begin
  if cdsDepartments.ChangeCount > 0 then
  begin
    cdsDepartments.ApplyUpdates(-1);
  end;
end;

procedure TdmDepartments.DataModuleCreate(Sender: TObject);
begin
  FDatabaseModel := TDatabaseModel.Create;
  sqldsDepartments.SQLConnection := FDatabaseModel.SQLConnection;
end;

end.
