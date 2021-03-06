unit Common.Form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TCommonForm = class(TForm)
    pnlFooter: TPanel;
    btnClose: TButton;
    btnOk: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CommonForm: TCommonForm;

implementation

{$R *.fmx}

procedure TCommonForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCommonForm.FormCreate(Sender: TObject);
begin
  btnOk.ModalResult     := mrOk;
  btnClose.ModalResult  := mrCancel;
end;

end.
