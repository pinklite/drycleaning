unit Common.DataModule;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.SqlExpr, Data.DB,
  Datasnap.DBClient, Datasnap.Provider;

type
  TDataModule4 = class(TDataModule)
    prv1: TDataSetProvider;
    cds1: TClientDataSet;
    sqlds1: TSQLDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule4: TDataModule4;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
