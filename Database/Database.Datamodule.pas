unit Database.Datamodule;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.DB, Data.SqlExpr,
  Common.Types, Connection.Model;

type
  TdmDatabase = class(TDataModule)
    sqlconFirebird: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDatabase: TdmDatabase;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmDatabase.DataModuleCreate(Sender: TObject);
begin
  TConnectionModel.SetSQLConnectionParams(sqlconFirebird)
end;

end.
