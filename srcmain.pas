{ CodeSharkFC editor portion based on:

SynEdit Plus

  Copyright (C) 2009 Dariusz Rorat drorat1@o2.pl

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
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}

// to do:
//   in src.main.pas  TfrmMain.FormCreate
//     figure out special folders and save app info in
//     in AppData (C:\Users\**username**\AppData\Local\CodeSharkFC)
//   in FreeCAD.pas
//   g code generated by path vs pick geometry, I and J values signs differ??
//     who is correct

unit srcmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, lazfileutils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, SynEdit, SynHighlighterAny, StdCtrls, Buttons,
  SynEditTypes, FindReplaceDialog,
  SourcePrinter, eventlog, editoroptions, LazUTF8, FreeCad;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    AutoCompleteBox: TComboBox;
    Logger: TEventLog;
    MnuContents: TMenuItem;
    MnuAbout: TMenuItem;
    MnuFCRun: TMenuItem;
    MnuFCSettings: TMenuItem;
    MnuFreeCAD: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    n2: TMenuItem;
    mnuSendToNotepad: TMenuItem;
    mnuInsertLastModification: TMenuItem;
    popDeleteSelection: TMenuItem;
    popSelectAll: TMenuItem;
    popPaste: TMenuItem;
    popCopy: TMenuItem;
    popCut: TMenuItem;
    popRedo: TMenuItem;
    popUndo: TMenuItem;
    mnuPrint: TMenuItem;
    mnyEditorSettings: TMenuItem;
    mnuInComment: TMenuItem;
    mnuBlock: TMenuItem;
    mnuReplace: TMenuItem;
    mnuFindNext: TMenuItem;
    mnuFind: TMenuItem;
    mnuConvertToLowercase: TMenuItem;
    mnuConvertToUppercase: TMenuItem;
    mnuConvert: TMenuItem;
    mnuInsertFilename: TMenuItem;
    mnuInsertTmestamp: TMenuItem;
    mnuInsert: TMenuItem;
    mnuCodeFolding: TMenuItem;
    mnuDeleteSelection: TMenuItem;
    mnuStatusBar: TMenuItem;
    mnuToolbar: TMenuItem;
    mnuHelp: TMenuItem;
    mnuSettings: TMenuItem;
    mnuView: TMenuItem;
    mnuSelectAll: TMenuItem;
    mnuPaste: TMenuItem;
    mnuCopy: TMenuItem;
    mnuCut: TMenuItem;
    mnuRedo: TMenuItem;
    mnuUndo: TMenuItem;
    mnuEdit: TMenuItem;
    mnuExit: TMenuItem;
    mnuReread: TMenuItem;
    EditPopupMenu: TPopupMenu;
    cboQuickSearch: TComboBox;
    Label1: TLabel;
    MainMenu: TMainMenu;
    mnuSaveAs: TMenuItem;
    mnuNew: TMenuItem;
    mnuSave: TMenuItem;
    mnuOpen: TMenuItem;
    mnuFile: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    btnNew: TSpeedButton;
    btnRedo: TSpeedButton;
    btnFind: TSpeedButton;
    btnReplace: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    btnOpen: TSpeedButton;
    btnSave: TSpeedButton;
    btnPrint: TSpeedButton;
    btnCut: TSpeedButton;
    btnCopy: TSpeedButton;
    btnPaste: TSpeedButton;
    btnDeleteSelection: TSpeedButton;
    btnUndo: TSpeedButton;
    StatusBar: TStatusBar;
    SynEdit: TSynEdit;
    ToolBar: TToolBar;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MnuAboutClick(Sender: TObject);
    procedure MnuContentsClick(Sender: TObject);
    procedure MnuFCRunClick(Sender: TObject);
    procedure MnuFCSettingsClick(Sender: TObject);

    procedure mnuUndoClick(Sender: TObject);
    procedure mnuPrintClick(Sender: TObject);

    procedure mnuConvertToUppercaseClick(Sender: TObject);
    procedure mnuConvertToLowercaseClick(Sender: TObject);
    procedure mnuCopyClick(Sender: TObject);

    procedure mnuNewClick(Sender: TObject);

    procedure mnuOpenClick(Sender: TObject);
    procedure mnuRedoClick(Sender: TObject);
    procedure mnuRereadClick(Sender: TObject);
    procedure mnyEditorSettingsClick(Sender: TObject);
    procedure mnuDeleteSelectionClick(Sender: TObject);
    procedure mnuCodeFoldingClick(Sender: TObject);
    procedure mnuPasteClick(Sender: TObject);
    procedure mnuToolbarClick(Sender: TObject);
    procedure mnuStatusBarClick(Sender: TObject);
    procedure mnuInsertLastModificationClick(Sender: TObject);
    procedure mnuInsertTmestampClick(Sender: TObject);
    procedure mnuInsertFilenameClick(Sender: TObject);
    procedure mnuCutClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuReplaceClick(Sender: TObject);
    procedure mnuSaveClick(Sender: TObject);
    procedure mnuSaveAsClick(Sender: TObject);
    procedure mnuSelectAllClick(Sender: TObject);
    procedure mnuFindClick(Sender: TObject);
    procedure mnuFindNextClick(Sender: TObject);
    procedure SynEditChange(Sender: TObject);
    procedure cboQuickSearchChange(Sender: TObject);

  private
    FileName: string;
    List: TStringList;
    procedure SetEditorOptions;
    procedure AddLastModify;
  public
    { public declarations }
     AppDataPath: string;
  end;

var
  frmMain: TfrmMain;
  MyFreeCADFrm : TFreeCadFrm;
  // flags set in SetFCparms, read from CodeSharkFC.ini
  LicenseRead: Boolean;      // if set do not show about screen on startup
  LicenseShown : Boolean;    // have we shown the license (about) at startup?

const
  MyAppName = 'CodeSharkFC';
  CurVersion = '0.0';
   //  custom script files found in AppData (C:\Users\**username**\AppData\Local\CodeSharkFC)
  StartupScript  = 'StartupScript.py';
  PanelViewScript = 'PanelViewScript.py';
  ObserverScript = 'ObserverScript.py';
  ShutdownScript = 'ShutdownScript.py';
  FileNameUndefined = 'Undefined';

implementation

uses
 commandline,SetFCparms, About;

{$R *.lfm}


function SIndexof(const S: string; List: TStrings): integer;
var
  i: integer;
  boolFound: boolean;
begin
  i := -1;
  repeat
    Inc(i);
    boolFound := (Pos(S, List.Strings[i]) <> 0);
  until boolFound or (i = List.Count - 1);
  if boolFound then
    Result := i
  else
    Result := -1;
end;


{ TfrmMain }


procedure TfrmMain.SetEditorOptions;
begin
  SynEdit.Options     := SynEditOptionsForm.Options;
  SynEdit.Options2    := SynEditOptionsForm.Options2;
  SynEdit.MaxUndo     := SynEditOptionsForm.UndoLimit;
  SynEdit.BlockIndent := SynEditOptionsForm.BlockIndent;
  SynEdit.TabWidth    := SynEditOptionsForm.TabWidth;
  SynEdit.RightEdge   := SynEditOptionsForm.RightMargin;
end;

procedure TfrmMain.AddLastModify;
var
  r: integer;
  s: string;
  CommentStr: string;
begin
  CommentStr := '//';
  s := Format('%sLast modification date: %s', [CommentStr, DateTimeToStr(Now)]);
  r := SIndexOf(CommentStr + 'Last modification date', SynEdit.Lines);
  if r = -1 then
    SynEdit.Lines.Add(s)
  else
    SynEdit.Lines.Strings[r] := s;
end;

procedure TfrmMain.mnuOpenClick(Sender: TObject);
begin

  if SynEdit.Modified then
    if MessageDlg('File ' + ExtractFileName(FileName) + ' was modified. Save?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      mnuSaveClick(Self);

  if OpenDialog.Execute then
  begin
    try
      FileName := OpenDialog.FileName;
      SynEdit.Lines.LoadFromFile(FileName);
      Caption := ExtractFileName(FileName) + ' - CodeSharkFC+';

    except
      on E: Exception do
      begin
        MessageDlg('Error while loading file.', mtError, [mbOK], 0);
        Logger.Error(E.ClassName + ' : ' + E.Message);
      end;
    end;
  end;

end;

procedure TfrmMain.mnuRedoClick(Sender: TObject);
begin
  SynEdit.Redo;
end;

procedure TfrmMain.mnuRereadClick(Sender: TObject);
begin
  try
    if FileExists(UTF8ToSys(FileName)) then
    begin
      SynEdit.Lines.LoadFromFile(UTF8ToSys(FileName));
      Caption := ExtractFileName(FileName) + ' - Synedit+';
    end;
  except
    on E: Exception do
    begin
      MessageDlg('Error while loading file.', mtError, [mbOK], 0);
      Logger.Error(E.ClassName + ' : ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.mnyEditorSettingsClick(Sender: TObject);
begin
  SynEditOptionsForm.ShowModal;
  if SynEditOptionsForm.ModalResult = mrOk then
  begin
    SetEditorOptions;
  end;
end;


procedure TfrmMain.mnuDeleteSelectionClick(Sender: TObject);
begin
  SynEdit.ClearSelection;
end;

procedure TfrmMain.mnuCodeFoldingClick(Sender: TObject);
begin
  mnuCodeFolding.Checked := not mnuCodeFolding.Checked;
  //SynEdit.Gutter.ShowCodeFolding:=mnuCodeFolding.Checked;
end;

procedure TfrmMain.mnuPasteClick(Sender: TObject);
begin
  SynEdit.PasteFromClipboard;
end;


procedure TfrmMain.mnuToolbarClick(Sender: TObject);
begin
  mnuToolbar.Checked := not mnuToolbar.Checked;
  ToolBar.Visible := mnuToolbar.Checked;
end;

procedure TfrmMain.mnuStatusBarClick(Sender: TObject);
begin
  mnuStatusBar.Checked := not mnuStatusBar.Checked;
  StatusBar.Visible := mnuStatusBar.Checked;
end;

procedure TfrmMain.mnuInsertLastModificationClick(Sender: TObject);
var
  D, C: string;
begin
  try
    C := '//';
    D := Format('%sLast modification: %s', [C, DateTimeToStr(Now)]);
    SynEdit.DoCopyToClipboard(D);
    SynEdit.PasteFromClipboard;
  except
    on E: Exception do
    begin
      MessageDlg('Error on last modification insert.', mtError, [mbOK], 0);
      Logger.Error(E.ClassName + ' : ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.mnuInsertTmestampClick(Sender: TObject);
var
  dtNow: string;
begin
  try
    DateTimeToString(dtNow, 'dd-mm-yyyy hh:mm:ss', NOW);
    SynEdit.DoCopyToClipboard(dtNow);
    SynEdit.PasteFromClipboard;
  except
    on E: Exception do
    begin
      MessageDlg('Error on timestamp inserting.', mtError, [mbOK], 0);
      Logger.Error(E.ClassName + ' : ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.mnuInsertFilenameClick(Sender: TObject);
begin
  try
    SynEdit.DoCopyToClipboard(FileName);
    SynEdit.PasteFromClipboard;
  except
    on E: Exception do
    begin
      MessageDlg('Error on filename inserting.', mtError, [mbOK], 0);
      Logger.Error(E.ClassName + ' : ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.mnuCutClick(Sender: TObject);
begin
  SynEdit.CutToClipboard;
end;

procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.mnuReplaceClick(Sender: TObject);
var
  synOptions: TSynSearchOptions;
begin
  synOptions := LazFindReplaceDialog.Options;
  with LazFindReplaceDialog do
  begin
    try
      Caption := 'Replace';
      Options := synOptions + [ssoReplace];
      ReplaceTextComboBox.Enabled := True;
      ReplaceWithLabel.Enabled := True;
      if ShowModal = mrOk then
        SynEdit.SearchReplace(LazFindReplaceDialog.FindText,
          LazFindReplaceDialog.ReplaceText,
          LazFindReplaceDialog.Options);
    except
      on E: Exception do
      begin
        MessageDlg('Error on replace text.', mtError, [mbOK], 0);
        Logger.Error(E.ClassName + ' : ' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FileName := 'Undefined';
  List := TStringList.Create;

//  AppDataPath  := ExtractFilePath(ParamStr(0));

  AppDataPath  := ExtractFilePath(ChompPathDelim(GetAppConfigDirUTF8(False)));

  AppDataPath := AppDataPath + MyAppName;
  // does the application's data directory exist?
  if not DirectoryExists(AppDataPath) then
  Begin
    ShowMessage(AppDataPath + ' Does not exist, Creating');
    CreateDir(AppDataPath);
  End;
//ShowMessage('AppDataPath: ' + AppDataPath);
  LicenseShown := False;
// nil our soon to be created FreeCad Interface Dialog
   MyFreeCADFrm := nil;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  List.Free;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  mr: integer;
begin
  if SynEdit.Modified then
  begin
    mr := MessageDlg('File ' + ExtractFileName(FileName) + ' was modified. Save?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if mr = mrYes then
      mnuSaveClick(Self)
    else if mr = mrCancel then
      CloseAction := caNone;
  end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  SetFCparmsFrm.LoadIni;
  if Not(LicenseShown) then
    If Not(LicenseRead) then AboutFrm.ShowModal;
  LicenseShown := True;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if ParamCount > 0 then
  begin
    FileName := SysToUTF8(Non_Flag_Param(1));
    SynEdit.Lines.LoadFromFile(UTF8ToSys(FileName));

  end;
  Caption := ExtractFileName(FileName) + ' - CodeSharkFC';
  SetEditorOptions;
end;

procedure TfrmMain.MnuAboutClick(Sender: TObject);
begin
  AboutFrm.ShowModal;
end;

procedure TfrmMain.MnuContentsClick(Sender: TObject);
begin

end;

procedure TfrmMain.MnuFCRunClick(Sender: TObject);
begin
{
    From  https://www.thoughtco.com/tform-createaowner-aowner-1057563
    When you create Delphi objects dynamically that inherit from TControl, such as a TForm (representing
     a form/window in Delphi applications), the constructor "Create" expects an "Owner" parameter:
    Modeless forms. Use "Application" as the owner:
    var
    myForm : TMyForm;
    ...
    myForm := TMyForm.Create(Application) ;

    Now, when you terminate (exit) the application,
    the "Application" object will free the "myForm" instance.

}
  if MyFreeCADFrm = nil then
  Begin
    SetFCparmsFrm.LoadIni; // make sure we have the setup info loaded for python
    MyFreeCADFrm :=TFreeCadFrm.Create(Application);
    try
     MyFreeCADFrm.Show;
    Except
    on E : Exception do
      ShowMessage(E.ClassName+' error raised on MyFreeCAD form creation, with message : '+E.Message);
    end;
  End
  else
    MyFreeCADFrm.Show;
end;

procedure TfrmMain.MnuFCSettingsClick(Sender: TObject);
begin
  SetFCparmsFrm.ShowModal;
end;


procedure TfrmMain.mnuUndoClick(Sender: TObject);
begin
  SynEdit.Undo;
end;

procedure TfrmMain.mnuPrintClick(Sender: TObject);
begin
  with TSourcePrinter.Create do
  begin
    try
      try
        ShowLineNumbers := False;
        Font := SynEdit.Font;
        Margin := 0;
        Execute(SynEdit.Lines);
      except
        on E: Exception do
        begin
          MessageDlg('Printer error', mtError, [mbOK], 0);
          Logger.Error(E.ClassName + ' : ' + E.Message);
        end;
      end;
    finally
      Free;
    end;
  end;
end;


procedure TfrmMain.mnuConvertToUppercaseClick(Sender: TObject);
begin
  SynEdit.SelText := UpCase(SynEdit.SelText);
end;

procedure TfrmMain.mnuConvertToLowercaseClick(Sender: TObject);
begin
  SynEdit.Seltext := LowerCase(SynEdit.SelText);
end;

procedure TfrmMain.mnuCopyClick(Sender: TObject);
begin
  SynEdit.CopyToClipboard;
end;

procedure TfrmMain.mnuNewClick(Sender: TObject);
begin
  if SynEdit.Modified then
    if MessageDlg('File ' + ExtractFileName(FileName) + ' was modified. Save?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      mnuSaveClick(Self);

  SynEdit.Lines.Clear;
  FileName := FileNameUndefined;
  Caption := ExtractFileName(FileName) + ' - CodeSharkFC';
end;

procedure TfrmMain.mnuSaveClick(Sender: TObject);
begin
  try
    if FileName = FileNameUndefined then
    begin
      SaveDialog.FileName := '';
      if SaveDialog.Execute then
      begin
        FileName := SaveDialog.FileName;
        //if (SynEditOptionsForm.CheckBox33.Checked) and (SynEdit.Modified) then
        // AddLastModify;

        SynEdit.Lines.SaveToFile(UTF8ToSys(FileName));
        SynEdit.Modified := False;
        Caption := ExtractFileName(FileName) + ' - CodeSharkFC';
      end;
    end
    else
    begin
      //if (SynEditOptionsForm.CheckBox33.Checked) and (SynEdit.Modified) then
      //AddLastModify;
      SynEdit.Lines.SaveToFile(UTF8ToSys(FileName));
      SynEdit.Modified := False;
      Caption := ExtractFileName(FileName) + ' - CodeSharkFC';
    end;
  except
    on E: Exception do
    begin
      MessageDlg('Error on saving file.', mtError, [mbOK], 0);
      Logger.Error(E.ClassName + ' : ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.mnuSaveAsClick(Sender: TObject);
begin
  if FileName = FileNameUndefined then FileName := '';
  try
    SaveDialog.FileName := FileName;
    if SaveDialog.Execute then
    begin
      FileName := SaveDialog.FileName;
      SynEdit.Lines.SaveToFile(UTF8ToSys(FileName));
      Caption := ExtractFileName(FileName) + ' - CodeSharkFC';
      SynEdit.Modified := False;
    end;
  except
    on E: Exception do
    begin
      MessageDlg('Error on saving file.', mtError, [mbOK], 0);
      Logger.Error(E.ClassName + ' : ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.mnuSelectAllClick(Sender: TObject);
begin
  SynEdit.SelectAll;
end;

procedure TfrmMain.mnuFindClick(Sender: TObject);
var
  synOptions: TSynSearchOptions;
begin
  synOptions := LazFindReplaceDialog.Options;
  with LazFindReplaceDialog do
  begin
    try
      Caption := 'Find';
      Options := synOptions - [ssoReplace];
      ReplaceTextComboBox.Enabled := False;
      ReplaceWithLabel.Enabled := False;
      if ShowModal = mrOk then
        SynEdit.SearchReplace(LazFindReplaceDialog.FindText,
          LazFindReplaceDialog.ReplaceText,
          LazFindReplaceDialog.Options);

    except
      on E: Exception do
      begin
        MessageDlg('Error on find text.', mtError, [mbOK], 0);
        Logger.Error(E.ClassName + ' : ' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmMain.mnuFindNextClick(Sender: TObject);
begin
  SynEdit.SearchReplace(LazFindReplaceDialog.FindText,
    LazFindReplaceDialog.ReplaceText,
    LazFindReplaceDialog.Options - [ssoEntireScope]);
end;

procedure TfrmMain.SynEditChange(Sender: TObject);
begin
  Caption := '*' + ExtractFileName(FileName) + ' - CodeSharkFC';
end;

procedure TfrmMain.cboQuickSearchChange(Sender: TObject);
begin
  SynEdit.SearchReplace(cboQuickSearch.Text, '', [ssoEntireScope]);
end;


initialization

end.

