unit Common.Utils;

interface

uses
  Winapi.Windows, Winapi.TlHelp32;

function GetProcessByEXE(ExeName: string): THandle;

implementation

function GetProcessByEXE(ExeName: string): THandle;
var
  hSnapshoot: THandle;
  pe32: TProcessEntry32;
begin
  Result:= 0;
  hSnapshoot:= CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if (hSnapshoot = 0) then Exit;
  pe32.dwSize:= SizeOf(TProcessEntry32);
  if (Process32First(hSnapshoot, pe32)) then
  begin
    repeat
      if (pe32.szExeFile = ExeName) then
      begin
        Result:= pe32.th32ProcessID;
        Exit;
      end;
    until not Process32Next(hSnapshoot, pe32);
  end;
end;

end.
