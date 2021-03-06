unit Departments.Classes;

interface

uses
  Data.DB;

type
  TDepartment = class
  private
    FTitle: string;
    FID: Integer;
    FIsActive: Boolean;
    FUpdateTime: TDateTime;
    procedure SetID(const Value: Integer);
    procedure SetTitle(const Value: string);
    function GetIsValid: Boolean;
    procedure SetIsActive(const Value: Boolean);
    procedure SetUpdateTime(const Value: TDateTime);
  public
    property ID: Integer read FID write SetID;
    property Title: string read FTitle write SetTitle;
    property IsActive: Boolean read FIsActive write SetIsActive;
    property UpdateTime: TDateTime read FUpdateTime write SetUpdateTime;

    property IsValid: Boolean read GetIsValid;

    procedure ClearValues;
    procedure AssignValues(ADataSet: TDataSet);
  end;

implementation

{ TDepartment }

procedure TDepartment.AssignValues(ADataSet: TDataSet);
begin
  FID         := ADataSet.FieldByName('ID').AsInteger;
  FTitle      := ADataSet.FieldByName('TITLE').AsString;
  FIsActive   := ADataSet.FieldByName('IS_ACTIVE').AsInteger=1;
  FUpdateTime := ADataSet.FieldByName('UPDTM').AsDateTime;
end;

procedure TDepartment.ClearValues;
begin
  FID         := 0;
  FTitle      := '';
  FIsActive   := False;
  FUpdateTime := 0;
end;

function TDepartment.GetIsValid: Boolean;
begin
   Result := Title <> '';
end;

procedure TDepartment.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TDepartment.SetIsActive(const Value: Boolean);
begin
  FIsActive := Value;
end;

procedure TDepartment.SetTitle(const Value: string);
begin
  FTitle:= Value;
end;

procedure TDepartment.SetUpdateTime(const Value: TDateTime);
begin
  FUpdateTime := Value;
end;

end.
