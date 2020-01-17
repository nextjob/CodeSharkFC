{ This file is part of CodeSharkFC

  Copyright (C) 2020 Nextjob Solutions, LLC.

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,Boston, MA 02110 USA
}
unit ComonFunctions;

{$MODE Delphi}

interface
uses
  Windows, LCLIntf, LCLType, LMessages, ShlObj;

function GetAppDataPath: string;

const
  ComFunc_NOF = '--nof--';

implementation

function ShGetFolderPath(hWndOwner: HWnd; csidl: Integer; hToken: THandle;
  dwReserved: DWord; lpszPath: PChar): HResult; stdcall;
  external 'ShFolder.dll' name 'SHGetFolderPathW';

function GetAppDataPath: string;
var
  DataPath: array [0 .. MAX_PATH] of Char;
  success: Boolean;
begin
  success := ShGetFolderPath(0, CSIDL_LOCAL_APPDATA or
    $8000 { CSIDL_FLAG_CREATE } , 0, { SHGFP_TYPE_CURRENT } 0, DataPath) = S_OK;
  if success then
    Result := DataPath
  else
    Result := ComFunc_NOF;
end;
end.
