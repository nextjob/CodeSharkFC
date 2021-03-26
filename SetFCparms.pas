{ This file is part of CodeSharkFC

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <https://unlicense.org>
}

unit SetFCparms;
{
 ***  This is how I understand things, could be wrong, but seems to make things work for now ***
 There are diffeneces in the way Linux and Windows are setup in regards to python.

 For Windows, we use the python interpreter packaged with FreeCAD (and found in the FreeCAD
 directory). We also need to assign PYTHONHOME environment variable to this python's installation.
 The path of PYTHONHOME is also where we will find the Pythonxy.dll file (where xy is the version ie 3.7)
 used by Python4Delphi.  We will assign this path and file name to the PythonEngine component properties (DllPath and DllName)
 We also need to assign to sys.path the path to the FreeCAD Mod directory in our startup script.
 Therefore, we expect the user to locate these directories and save the paths with the Setup Parameters Dialog
 (SetFCparmsFrm)

 For Linux things appear to behave a little differently.
 We have no need to set PYTHONHOME.
 We do however need to find where the Python interface library used by Python4Delphi is located and the library name.
 We will assign this path and file name to the PythonEngine component properties (DllPath and DllName)
 On the linux system (Mint 19.3) / FreeCAD 18.4 the following location and file are used:
 DllPath: /usr/lib/python3.6/config-3.6m-x86_64-linux-gnu
 DllName: libpython3.6m.so
 it may be worth noting that the file in the above directory was actualyy a link to the file in
  /usr/lib/x86_64-linux-gnu/libpython3.6m.so.1
  which was a link to  /usr/lib/x86_64-linux-gnu/libpython3.6m.so.1.0
}

{$MODE Delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls,PythonEngine, Inifiles;

type

  { TSetFCparmsFrm }

  TSetFCparmsFrm = class(TForm)
    cbOverWriteScript: TCheckBox;
    cbFreeCADWarnDisable: TCheckBox;
    cbPyVersions: TComboBox;
    Label2: TLabel;
    PyDllName: TEdit;
    Label1: TLabel;
    PythonHome: TLabeledEdit;
    FreeCadMod: TLabeledEdit;
    cbCustStart: TCheckBox;
    cbCustPanel: TCheckBox;
    cbCustSelectObs: TCheckBox;
    cbCustWindowAction: TCheckBox;
    procedure cbPyVersionsSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  PyRegVersion : string;
  ExtraDebugging: Boolean;   // if set output extra debug info to editor window
  FormatForPathDisplay: Boolean;      // add G1 to output (so we can send to path and evaluted with  p = Path.Path(editor lines)


implementation

{$R *.lfm}

uses srcMain;

Const
  // ini file section names
  PathSection = 'Paths';
  ScriptsSection = 'Scripts';
  WarningsSection = 'Warnings';

  {$IFDEF LINUX}
  PythonHomeCaption = 'Python Interface Lib Path';
  PythonHomeHint = 'Python Interface Lib Path (typically: /usr/lib/pythonX.Y/config-X.Y-x86_64-linux-gnu)';
  FreeCADModLibCaption = 'FreeCAD Python Libraries';
  FreeCADModLibHint = 'FreeCAD Python Libraries Path (typically: /usr/lib/freecad-python3/lib)';
  {$ELSE}
  PythonHomeCaption = 'PythonHome Env Value';
  PythonHomeHint = 'PythonHome Path (typically: ..\FreeCad\bin)';
  FreeCADModLibCaption = 'FreeCad Mod Path';
  FreeCADModLibHint = 'FreeCad Mod Directory (typically: ..\FreeCad\Mod)';
  {$ENDIF}
procedure TSetFCparmsFrm.FormClose(Sender: TObject; var Action: TCloseAction);
Begin
  SaveIni;
end;



procedure TSetFCparmsFrm.FormShow(Sender: TObject);

begin
  LoadIni;
// requirements for what we need to pass for path in python script
// vary between Windows and Linux
// Change dialog captions accordingly
   FreeCadMod.EditLabel.Caption:= FreeCADModLibCaption;
   PythonHome.EditLabel.Caption := PythonHomeCaption;
end;


procedure TSetFCparmsFrm.cbPyVersionsSelect(Sender: TObject);
begin
 // cbPyVersions.ItemIndex index to selected python verstion
  PyDllName.Text := PYTHON_KNOWN_VERSIONS[cbPyVersions.ItemIndex+1].DllName;
  PyRegVersion := PYTHON_KNOWN_VERSIONS[cbPyVersions.ItemIndex+1].RegVersion;
end;

procedure TSetFCparmsFrm.FormCreate(Sender: TObject);
var
  PyEngineVersion : TPythonVersionProp;
// create a dropdown list of python versions currently defined in Pythom4delphi engine

begin
   for PyEngineVersion in PYTHON_KNOWN_VERSIONS do
    cbPyVersions.Items.Add(PyEngineVersion.DllName);


end;


procedure TSetFCparmsFrm.LoadIni;

var
  Inif: TCustomIniFile;

begin

  // read in the ini file
  Try
    Inif := TMemIniFile.Create(FrmMain.AppDataPath + PathDelim + MyAppName + '.ini');
    PythonHome.Text := Inif.ReadString(PathSection, 'PythonHome', '');
    PyDllName.Text := Inif.ReadString(PathSection, 'PythonDllName', '');
    PyRegVersion := Inif.ReadString(PathSection, 'RegVersion', '');
    FreeCadMod.Text := Inif.ReadString(PathSection, 'FreeCadMod', '');

    cbCustStart.Checked := Inif.ReadBool(ScriptsSection,'Custom_Start_Script',cbCustStart.Checked);
    cbCustPanel.Checked := Inif.ReadBool(ScriptsSection,'Custom_View_Panel_Script', cbCustPanel.Checked);
    cbCustSelectObs.Checked := Inif.ReadBool(ScriptsSection,'Custom_Selection_Observer_Script', cbCustSelectObs.Checked);
    cbCustWindowAction.Checked := Inif.ReadBool(ScriptsSection,'Custom_Shutdown_Script', cbCustWindowAction.Checked);
    cbOverWriteScript.Checked := Inif.ReadBool(ScriptsSection,'Overwrite_Custom_Scripts', cbOverWriteScript.Checked);

    cbFreeCADWarnDisable.Checked := Inif.ReadBool(WarningsSection,'Disable_FreeCAD_Window_Warning', cbFreeCADWarnDisable.Checked);
    LicenseRead := Inif.ReadBool(WarningsSection,'LicenseRead', False);
    ExtraDebugging := Inif.ReadBool(WarningsSection,'ExtraDebugging', False);
    FormatForPathDisplay := Inif.ReadBool(WarningsSection,'FormatForPathDisplay', False);

  Finally
    Inif.Free;
  End;

end;

procedure TSetFCparmsFrm.SaveIni;

var
  Inif: TCustomIniFile;

begin
  Try
    Inif := TMemIniFile.Create(FrmMain.AppDataPath + PathDelim + MyAppName + '.ini');


    if (Length(PythonHome.Text) > 0) and (DirectoryExists(PythonHome.Text))
    then
      Inif.WriteString(PathSection, 'PythonHome', PythonHome.Text)
    else
      showMessage(PythonHomeCaption + ' not found, ' + PythonHome.Text);


    if (Length(PyDllName.Text) > 0) then
      Inif.WriteString(PathSection, 'PythonDllName', PyDllName.Text)
    else
      showMessage('Python Dll Name not set');

    if (Length(PyRegVersion) > 0) then
      Inif.WriteString(PathSection, 'RegVersion', PyRegVersion)
    else
      showMessage('Python Registered Version not set');

    if (Length(FreeCadMod.Text) > 0) and (DirectoryExists(FreeCadMod.Text))
    then
      Inif.WriteString(PathSection, 'FreeCadMod', FreeCadMod.Text)
    else
      showMessage(FreeCADModLibCaption +' not found, ' + FreeCadMod.Text );

    Inif.WriteBool(ScriptsSection, 'Custom_Start_Script', cbCustStart.Checked);
    Inif.WriteBool(ScriptsSection, 'Custom_View_Panel_Script',cbCustPanel.Checked);
    Inif.WriteBool(ScriptsSection, 'Custom_Selection_Observer_Script',cbCustSelectObs.Checked);
    Inif.WriteBool(ScriptsSection, 'Custom_Shutdown_Script',cbCustWindowAction.Checked);
    Inif.WriteBool(ScriptsSection, 'Overwrite_Custom_Scripts',cbOverWriteScript.Checked);

    Inif.WriteBool(WarningsSection, 'Disable_FreeCAD_Window_Warning',cbFreeCADWarnDisable.Checked);
    Inif.WriteBool(WarningsSection, 'LicenseRead', LicenseRead);
    Inif.WriteBool(WarningsSection, 'ExtraDebugging',ExtraDebugging);
    Inif.WriteBool(WarningsSection, 'FormatForPathDisplay',FormatForPathDisplay);

  Finally
    Inif.UpdateFile;
    Inif.Free;
  End;

end;


procedure TSetFCparmsFrm.FreeCadModClick(Sender: TObject);
var
  RDir: string;
  ADir: String;
begin
  if Length(FreeCadMod.Text) <> 0 then
    RDir := FreeCadMod.Text
  else
{$IFDEF WINDOWS}
    RDir := 'C:\';
{$ELSE}
    RDir := '\usr';
{$ENDIF}

  if SelectDirectory(FreeCADModLibHint,RDir, ADir)
  then
    FreeCadMod.Text := ADir;
end;

procedure TSetFCparmsFrm.PythonHomeClick(Sender: TObject);
var
  RDir: string;
  ADir: string;
begin
  if Length(PythonHome.Text) <> 0 then
    RDir := PythonHome.Text
  else
{$IFDEF WINDOWS}
    RDir := 'C:\';
{$ELSE}
        RDir := '\usr';
{$ENDIF}

  if SelectDirectory(PythonHomeHint,RDir, ADir) then
    PythonHome.Text := ADir;
end;

end.
