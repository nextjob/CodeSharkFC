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

unit SetFCparms;

{$MODE Delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Inifiles;

type

  { TSetFCparmsFrm }

  TSetFCparmsFrm = class(TForm)
    cbOverWriteScript: TCheckBox;
    cbFreeCADWarnDisable: TCheckBox;
    Label1: TLabel;
    PythonHome: TLabeledEdit;
    FreeCadMod: TLabeledEdit;
    cbCustStart: TCheckBox;
    cbCustPanel: TCheckBox;
    cbCustSelectObs: TCheckBox;
    cbCustShutdown: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure PythonHomeClick(Sender: TObject);
    procedure FreeCadModClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    procedure LoadIni;
    procedure SaveIni;
  end;

var
  SetFCparmsFrm: TSetFCparmsFrm;


implementation

{$R *.lfm}

uses srcMain, ComonFunctions;

Const
  // ini file section names
  PathSection = 'Paths';

procedure TSetFCparmsFrm.FormClose(Sender: TObject; var Action: TCloseAction);
Begin
  SaveIni;
end;



procedure TSetFCparmsFrm.FormShow(Sender: TObject);

begin
  LoadIni;
end;


procedure TSetFCparmsFrm.LoadIni;

var
  Inif: TCustomIniFile;

begin

  // read in the ini file
  Try
    Inif := TMemIniFile.Create(FrmMain.AppDataPath + '\' + MyAppName + '.ini');
    PythonHome.Text := Inif.ReadString(PathSection, 'PythonHome', '');
//    PyDllPath.Text := Inif.ReadString(PathSection, 'PythonDllPath', '');
//    PyDllName.Text := Inif.ReadString(PathSection, 'PythonDllName', '');
//    RegVersion.Text := Inif.ReadString(PathSection, 'RegVersion', '');
//
//    FreeCadBin.Text := Inif.ReadString(PathSection, 'FreeCadBin', '');
    FreeCadMod.Text := Inif.ReadString(PathSection, 'FreeCadMod', '');

  Finally
    Inif.Free;
  End;

end;

procedure TSetFCparmsFrm.SaveIni;

var
  Inif: TCustomIniFile;

begin
  Try
    Inif := TMemIniFile.Create(FrmMain.AppDataPath + '\' + MyAppName + '.ini');

    if (Length(PythonHome.Text) > 0) and (DirectoryExists(PythonHome.Text))
    then
      Inif.WriteString(PathSection, 'PythonHome', PythonHome.Text)
    else
      showMessage('Python Home not set, ' + PythonHome.Text + ' not found');

  {  if (Length(PyDllPath.Text) > 0) and (TDirectory.Exists(PyDllPath.Text)) then
      Inif.WriteString(PathSection, 'PythonDllPath', PyDllPath.Text)
    else
      showMessage('Python Dll Path not set, ' + PyDllPath.Text + ' not found');

    if (Length(PyDllName.Text) > 0) and
      (FileExists(PyDllPath.Text + '\' + PyDllName.Text)) then
      Inif.WriteString(PathSection, 'PythonDllName', PyDllName.Text)
    else
      showMessage('Python Dll Name not set, ' + PyDllPath.Text + '\' +
        PyDllName.Text + ' not found');

    if (Length(RegVersion.Text) > 0) then
      Inif.WriteString(PathSection, 'RegVersion', RegVersion.Text)
    else
      showMessage('Python Registered Version not set');

    if (Length(FreeCadBin.Text) > 0) and (TDirectory.Exists(FreeCadBin.Text))
    then
      Inif.WriteString(PathSection, 'FreeCadBin', FreeCadBin.Text)
    else
      showMessage('FreeCad Bin Directory Path not set, ' + FreeCadBin.Text +
        ' not found');

  }
    if (Length(FreeCadMod.Text) > 0) and (DirectoryExists(FreeCadMod.Text))
    then
      Inif.WriteString(PathSection, 'FreeCadMod', FreeCadMod.Text)
    else
      showMessage('FreeCad Mod Directory Path not set, ' + FreeCadMod.Text +
        ' not found');

  Finally
    Inif.UpdateFile;
    Inif.Free;
  End;

end;


{procedure TSetFCparmsFrm.FreeCadBinChange(Sender: TObject);
var
  RDir: string;
  ADir: TArray<string>;
begin
  if Length(FreeCadBin.Text) <> 0 then
    RDir := FreeCadBin.Text
  else
    RDir := 'C:\';

  if FileCtrl.SelectDirectory(RDir, ADir, [],
    'Select FreeCad Bin Directory', 'FreeCad Bin Directory (typically: ..\FreeCad\bin)')
  then
    FreeCadBin.Text := ADir[0];
end;
}

procedure TSetFCparmsFrm.FreeCadModClick(Sender: TObject);
var
  RDir: string;
  ADir: String;
begin
  if Length(FreeCadMod.Text) <> 0 then
    RDir := FreeCadMod.Text
  else
    RDir := 'C:\';

  if SelectDirectory('FreeCad Mod Directory (typically: ..\FreeCad\Mod)',RDir, ADir)
  then
    FreeCadMod.Text := ADir;
end;

{procedure TSetFCparmsFrm.PyDllNameClick(Sender: TObject);
var
  RDir, Fn: string;
begin
  if Length(PyDllName.Text) <> 0 then
    RDir := ExtractFilePath(PyDllName.Text)
  else
    RDir := 'C:\';

  if PromptForFileName(Fn, 'Dll files (*.dll)|*.dll|All files (*.*)', '',
    'Select Python Dll (typically: ..\FreeCad\bin\pythonxx.dll)', RDir, False) then
    PyDllName.Text := ExtractFileName(Fn);
end;}

{procedure TSetFCparmsFrm.PyDllPathClick(Sender: TObject);
var
  RDir: string;
  ADir: TArray<string>;
begin
  if Length(PyDllPath.Text) <> 0 then
    RDir := PyDllPath.Text
  else
    RDir := 'C:\';

  if FileCtrl.SelectDirectory(RDir, ADir, [],
    'Select Python Dll Path ', 'Python Dll Path (typically: ..\FreeCad\bin)') then
    PyDllPath.Text := ADir[0];
end; }

procedure TSetFCparmsFrm.PythonHomeClick(Sender: TObject);
var
  RDir: string;
  ADir: string;
begin
  if Length(PythonHome.Text) <> 0 then
    RDir := PythonHome.Text
  else
    RDir := 'C:\';

  if SelectDirectory('PythonHome Path (typically: ..\FreeCad\bin)',RDir, ADir) then
    PythonHome.Text := ADir;
end;

end.
