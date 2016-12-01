unit Database.Utils;

interface

uses
  System.Classes, System.SysUtils,
  Common.Types, Datasnap.DBClient, Data.DB;

function CancelDataset(ds: TDataSet): TFunctionResult;
function SaveCdsData(cds: TClientDataSet): TFunctionResult;

implementation

function CancelDataset(ds: TDataSet): TFunctionResult;
begin
  Result.Successful := True;
  try
    if ds.State in dsEditModes then ds.Cancel;
  except
    on e: Exception do
    begin
      Result.Successful := False;
      Result.MessageOnError := e.Message;
    end;
  end;
end;

function SaveCdsData(cds: TClientDataSet): TFunctionResult;
begin
  Result.Successful := True;

  if cds.State in dsEditModes then cds.Post;

  try
    if cds.ChangeCount > 0 then
    begin
      cds.ApplyUpdates(-1);
    end;
  except
    on e: Exception do
    begin
      Result.Successful := False;
      Result.MessageOnError := e.Message;
    end;
  end;
end;

end.
