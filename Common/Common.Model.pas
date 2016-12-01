unit Common.Model;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  Common.Consts;

type
  TCommonModel = class
  protected
  private
    class var FComputerName: string;
    class var FConfigFileName: TFileName;
    class procedure Init;
  public
    class property ConfigFileName: TFileName read FConfigFileName;
    class property ComputerName: string read FComputerName;
  end;

implementation

{ TCommonModel }

class procedure TCommonModel.Init;
var
  buffer: array [0..255] of Char;
  size: DWORD;
begin
  if Winapi.Windows.GetComputerName(buffer, size) then FComputerName := buffer else FComputerName := '';
  FConfigFileName := ChangeFileExt(ParamStr(0), CONF_FILE_EXT);
end;

initialization
  TCommonModel.Init;

end.
