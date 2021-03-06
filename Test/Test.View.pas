unit Test.View;

interface

uses
  Winapi.Windows,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Data.FMTBcd,
  System.Rtti, FMX.Grid.Style, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.Grid, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  Data.Bind.DBScope, Datasnap.Provider, Datasnap.DBClient, Data.DB,
  Database.Model, Data.SqlExpr, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    sqlqry1: TSQLQuery;
    cds1: TClientDataSet;
    prv1: TDataSetProvider;
    BindSourceDB1: TBindSourceDB;
    StringGridBindSourceDB1: TStringGrid;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    FDatabaseModel: TDatabaseModel;
    procedure ShowPackageForm(APackageName, AClassName: string); //(const AMenuItem: TCfgMenuItem; const ACaption: string = ''; const ANewOne: boolean = False);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btn1Click(Sender: TObject);
begin
  ShowPackageForm('Departments.bpl', 'TDepartmentsForm');
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  ShowPackageForm('Clothes.bpl', 'TClothesForm');
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  ShowPackageForm('Employees.bpl', 'TEmployeesForm');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDatabaseModel := TDatabaseModel.Create;
  sqlqry1.SQLConnection := FDatabaseModel.SQLConnection;
  cds1.Active := True;
end;

procedure TForm1.ShowPackageForm;
var
  i: Integer;
  AClass: TPersistentClass;
  AForm: TForm;
  APackage: HModule;
//  APackagesDir,
//  APackageName, AClassName,
//  AParams: string;
//  prms: TParams;
begin
//  APackageName := 'Departments.bpl'; //AMenuItem.PkgName;
//  AClassName   := 'TDepartmentsForm'; //AMenuItem.FrmName;
//  AParams      := AMenuItem.Params;

//  if not ANewOne then
  for i:= 0 to Screen.FormCount-1 do
  begin
    if Screen.Forms[i].ClassName = AClassName then
    begin
      Exit;
//      if Screen.Forms[i].Caption = ACaption then
//      begin
//        if Screen.Forms[i].WindowState = wsMinimized then Screen.Forms[i].WindowState := wsNormal;
//        Screen.Forms[i].BringToFront;
//        Exit;
//      end;
    end;
  end;

  AForm := nil;

  Cursor := crHourGlass;
//  LockClientWindowUpdate;
//  LockWindowUpdate(Handle);
  try
    if not Assigned(AForm) then
    begin
      APackage := GetModuleHandle( PWideChar( APackageName ));

      if APackage = 0 then
      begin
        APackage := LoadPackage(APackageName);
      end;

      if APackage <> 0 then
      begin
        {
        if FindClass(AClassName) = nil then
        begin
          UnloadPackage(APackage);
          APackage := 0;
          MessageDlg(sClsNotFound, mtError, [mbOk], 0);
        end;
        }

        AClass := GetClass(AClassName);

        if AClass <> nil then AForm := TComponentClass(AClass).Create(Application) as TForm;

//        if Assigned(AForm) then
//        begin
//          APackagesList.Add(APackageName);
//        end
//        else
//        begin
//          UnloadPackage(APackage);
//        end;
      end;
    end;

    if Assigned(AForm) then
    begin
//      if ACaption <> '' then AForm.Caption := ACaption;
//      if Supports(AForm, ICommonForm) then
      begin
//        (AForm as ICommonForm).CfgMenuItem := AMenuItem;
        {
        if (AParams <> '') then
        begin
          prms := TParams.Create;
          FParamsList.Add(prms);
          try
            prms.CreateParam(ftString, 'Params', ptInput).Value := AParams;
            begin
              (AForm as ICommonForm).Parameters := prms;
              //CreateParam(ftString, 'Params', ptInputOutput).Value := AParams;
            end;
          finally
            prms := nil;
          end;
        end;
        }
      end;
      AForm.Show
    end
    else
    begin
      MessageDlg('sModuleNotAvail', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    end;

  finally
//    UnlockClientWindowUpdate;
//    LockWindowUpdate(0);
    Cursor := crDefault;
  end;
end;

end.
