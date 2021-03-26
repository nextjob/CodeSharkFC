unit editoroptions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons, inifiles, synedit, ExtCtrls, Spin;

type

  { TSynEditOptionsForm }

  TSynEditOptionsForm = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    FontDialog: TFontDialog;
    GroupBox1: TGroupBox;
    IndentSizeBox: TComboBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lblFontColor: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtFont: TLabeledEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    PageControl: TPageControl;
    SpeedButton1: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    TabWidthBox: TComboBox;
    UndoLimitBox: TComboBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure ShowFont;
    function GetOptions: TSynEditorOptions;
    function GetOptions2: TSynEditorOptions2;
    function GetUndoLimit: integer;
    function GetBlockIndent: integer;
    function GetTabWidth: integer;
    function GetRightMargin: integer;
  public
    procedure ReadFromIniFile;
    procedure SaveToIniFile;

    property Options: TSynEditorOptions read GetOptions;
    property Options2: TSynEditorOptions2 read GetOptions2;
    property UndoLimit: integer read GetUndoLimit;
    property BlockIndent: integer read GetBlockIndent;
    property TabWidth: integer read GetTabWidth;
    property RightMargin: integer read GetRightMargin;
  end;

var
  SynEditOptionsForm: TSynEditOptionsForm;
  ini: TIniFile;

implementation

uses
  srcmain;

{ TSynEditOptionsForm }

procedure TSynEditOptionsForm.ReadFromIniFile;
begin
  with TIniFile.Create(FrmMain.AppDataPath + PathDelim + 'synedit.ini') do
  begin
    //Options
//    CheckBox21.Checked      := ReadBool('Options','eoAltSetsColumnMode',false);
    CheckBox6.Checked       := ReadBool('Options','eoAutoIndent',true);
//    CheckBox22.Checked      := ReadBool('Options','eoDragDropEditing',false);
    CheckGroup1.Checked[7]  := ReadBool('Options','eoEnhanceHomeKey',false);
    CheckBox2.Checked       := ReadBool('Options','eoGroupUndo',true);
    CheckBox4.Checked       := ReadBool('Options','eoHalfPageScroll',false);
    CheckBox10.Checked      := ReadBool('Options','eoKeepCaretX',false);
//    CheckBox23.Checked      := ReadBool('Options','eoRightMouseMovesCursor',false);
    CheckBox5.Checked       := ReadBool('Options','eoScrollByOneLess',false);
    CheckBox3.Checked       := ReadBool('Options','eoScrollPastEof',false);
    CheckBox25.Checked      := ReadBool('Options','eoScrollPastEol',true);
    CheckGroup1.Checked[0]  := ReadBool('Options','eoShowSpecialChars',false);
    CheckGroup1.Checked[9]  := ReadBool('Options','eoSmartTabs',true);
    CheckBox7.Checked       := ReadBool('Options','eoTabIndent',false);
    CheckBox9.Checked       := ReadBool('Options','eoTabsToSpaces',true);
    CheckGroup1.Checked[1]  := ReadBool('Options','eoTrimTrailingSpaces',true);
    CheckGroup1.Checked[10] := ReadBool('Options','eoBracketHighlight',true);
//    CheckBox24.Checked      := ReadBool('Options','eoDoubleClickSelectsLine',false);
    CheckBox30.Checked      := not ReadBool('Options','eoHideRightMargin',false);
    CheckBox11.Checked      := ReadBool('Options','eoPersistentCaret',false);
//    CheckBox26.Checked      := ReadBool('Options','eoShowCtrlMouseLinks',false);
    CheckGroup1.Checked[11] := ReadBool('Options','eoAutoIndentOnPaste',false);
    CheckGroup1.Checked[12] := ReadBool('Options','eoSpacesToTabs',false);
    //Options2
    CheckBox14.Checked      := ReadBool('Options2','eoCaretSkipsSelection',false);
    CheckBox15.Checked      := ReadBool('Options2','eoCaretSkipsTabs',false);
    CheckBox12.Checked      := ReadBool('Options2','eoAlwaysVisibleCaret',false);
    CheckGroup1.Checked[8]  := ReadBool('Options2','eoEnhanceEndKey',false);
    CheckGroup1.Checked[13] := ReadBool('Options2','eoFoldedCopyPaste',true);
    CheckBox18.Checked      := ReadBool('Options2','eoPersistentBlock',false);
    CheckBox19.Checked      := ReadBool('Options2','eoOverwriteBlock',true);
    CheckGroup1.Checked[14] := ReadBool('Options2','eoAutoHideCursor',false);

    UndoLimitBox.Text       := ReadString('Additional options','UndoLimit','32768');
    IndentSizeBox.Text      := ReadString('Additional options','IndentSize','2');
    TabWidthBox.Text        := ReadString('Additional options','TabWidth','4');
    SpinEdit1.Value         := ReadInteger('Additional options','RightMargin',80);
    // font
    frmMain.SynEdit.Font.Name :=  ReadString('Font Settings','Font',frmMain.SynEdit.Font.Name);
    frmMain.SynEdit.Font.Size :=  ReadInteger('Font Settings','Size',frmMain.SynEdit.Font.Size);
    Free;
  end;
end;

procedure TSynEditOptionsForm.SaveToIniFile;
begin
  with TIniFile.Create(FrmMain.AppDataPath + PathDelim + 'synedit.ini') do
  begin
    try
      //Options
//      WriteBool('Options','eoAltSetsColumnMode',CheckBox21.Checked);
      WriteBool('Options','eoAutoIndent',CheckBox6.Checked);
//      WriteBool('Options','eoDragDropEditing',CheckBox22.Checked);
      WriteBool('Options','eoEnhanceHomeKey',CheckGroup1.Checked[7]);
      WriteBool('Options','eoGroupUndo',CheckBox2.Checked);
      WriteBool('Options','eoHalfPageScroll',CheckBox4.Checked);
      WriteBool('Options','eoKeepCaretX',CheckBox10.Checked);
//      WriteBool('Options','eoRightMouseMovesCursor',CheckBox23.Checked);
      WriteBool('Options','eoScrollByOneLess',CheckBox5.Checked);
      WriteBool('Options','eoScrollPastEof',CheckBox3.Checked);
      WriteBool('Options','eoScrollPastEol',CheckBox25.Checked);
      WriteBool('Options','eoShowSpecialChars',CheckGroup1.Checked[0]);
      WriteBool('Options','eoSmartTabs',CheckGroup1.Checked[9]);
      WriteBool('Options','eoTabIndent',CheckBox7.Checked);
      WriteBool('Options','eoTabsToSpaces',CheckBox9.Checked);
      WriteBool('Options','eoTrimTrailingSpaces',CheckGroup1.Checked[1]);
      WriteBool('Options','eoBracketHighlight',CheckGroup1.Checked[10]);
//      WriteBool('Options','eoDoubleClickSelectsLine',CheckBox24.Checked);
      WriteBool('Options','eoHideRightMargin', not CheckBox30.Checked);
      WriteBool('Options','eoPersistentCaret',CheckBox11.Checked);
//      WriteBool('Options','eoShowCtrlMouseLinks',CheckBox26.Checked);
      WriteBool('Options','eoAutoIndentOnPaste',CheckGroup1.Checked[11]);
      WriteBool('Options','eoSpacesToTabs',CheckGroup1.Checked[12]);
      //Options2
      WriteBool('Options2','eoCaretSkipsSelection',CheckBox14.Checked);
      WriteBool('Options2','eoCaretSkipsTabs',CheckBox15.Checked);
      WriteBool('Options2','eoAlwaysVisibleCaret',CheckBox12.Checked);
      WriteBool('Options2','eoEnhanceEndKey',CheckGroup1.Checked[8]);
      WriteBool('Options2','eoFoldedCopyPaste',CheckGroup1.Checked[13]);
      WriteBool('Options2','eoPersistentBlock',CheckBox18.Checked);
      WriteBool('Options2','eoOverwriteBlock',CheckBox19.Checked);
      WriteBool('Options2','eoAutoHideCursor',CheckGroup1.Checked[14]);
      //additional options
      WriteString('Additional options','UndoLimit',UndoLimitBox.Text);
      WriteString('Additional options','IndentSize',IndentSizeBox.Text);
      WriteString('Additional options','TabWidth',TabWidthBox.Text);
      WriteInteger('Additional options','RightMargin', SpinEdit1.Value);
      // font
      WriteString('Font Settings','Font',frmMain.SynEdit.Font.Name);
      WriteInteger('Font Settings','Size',frmMain.SynEdit.Font.Size);
    finally
      Free;
    end;
  end;
end;

function TSynEditOptionsForm.GetOptions: TSynEditorOptions;
begin
  Result := [];
//  if CheckBox21.Checked then Include(Result, eoAltSetsColumnMode);
  if CheckBox6.Checked then Include(Result, eoAutoIndent);
//  if CheckBox22.Checked then Include(Result,eoDragDropEditing);
  if CheckGroup1.Checked[7] then Include(Result,eoEnhanceHomeKey);
  if CheckBox2.Checked then Include(Result,eoGroupUndo);
  if CheckBox4.Checked then Include(Result,eoHalfPageScroll);
  if CheckBox10.Checked then Include(Result,eoKeepCaretX);
//  if CheckBox23.Checked then Include(Result,eoRightMouseMovesCursor);
  if CheckBox5.Checked then Include(Result,eoScrollByOneLess);
  if CheckBox3.Checked then Include(Result,eoScrollPastEof);
  if CheckBox25.Checked then Include(Result,eoScrollPastEol);
  if CheckGroup1.Checked[0] then Include(Result,eoShowSpecialChars);
  if CheckGroup1.Checked[9] then Include(Result,eoSmartTabs);
  if CheckBox7.Checked then Include(Result,eoTabIndent);
  if CheckBox9.Checked then Include(Result,eoTabsToSpaces);
  if CheckGroup1.Checked[1] then Include(Result,eoTrimTrailingSpaces);
  if CheckGroup1.Checked[10] then Include(Result,eoBracketHighlight);
//  if CheckBox24.Checked then Include(Result,eoDoubleClickSelectsLine);
  if not CheckBox30.Checked then Include(Result,eoHideRightMargin);
  if CheckBox11.Checked then Include(Result,eoPersistentCaret);
//  if CheckBox26.Checked then Include(Result,eoShowCtrlMouseLinks);
  if CheckGroup1.Checked[11] then Include(Result,eoAutoIndentOnPaste);
  if CheckGroup1.Checked[12] then Include(Result,eoSpacesToTabs);
end;

function TSynEditOptionsForm.GetOptions2: TSynEditorOptions2;
begin
  Result := [];
  if CheckBox14.Checked then Include(Result,eoCaretSkipsSelection);
  if CheckBox15.Checked then Include(Result,eoCaretSkipTab);
  if CheckBox12.Checked then Include(Result,eoAlwaysVisibleCaret);
  if CheckGroup1.Checked[8] then Include(Result,eoEnhanceEndKey);
  if CheckGroup1.Checked[13] then Include(Result,eoFoldedCopyPaste);
  if CheckBox18.Checked then Include(Result,eoPersistentBlock);
  if CheckBox19.Checked then Include(Result,eoOverwriteBlock);
  if CheckGroup1.Checked[14] then Include(Result,eoAutoHideCursor);
end;

function TSynEditOptionsForm.GetUndoLimit: integer;
begin
  result:=StrToInt(UndoLimitBox.Text);
end;

function TSynEditOptionsForm.GetBlockIndent: integer;
begin
  result:=StrToInt(IndentSizeBox.Text);
end;

function TSynEditOptionsForm.GetTabWidth: integer;
begin
  result:=StrToInt(TabWidthBox.Text);
end;

function TSynEditOptionsForm.GetRightMargin: integer;
begin
  result:=SpinEdit1.Value;
end;

procedure TSynEditOptionsForm.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSynEditOptionsForm.FormCreate(Sender: TObject);
begin
  ReadFromIniFile;
end;

procedure TSynEditOptionsForm.FormShow(Sender: TObject);
begin
  ReadFromIniFile;
  ShowFont;
end;

procedure TSynEditOptionsForm.OKButtonClick(Sender: TObject);
begin
  SaveToIniFile;
  ModalResult := mrOk;
end;

procedure TSynEditOptionsForm.SpeedButton1Click(Sender: TObject);
begin
  if FontDialog.Execute then
  begin
    frmMain.SynEdit.Font.Name := FontDialog.Font.Name;
    frmMain.SynEdit.Font.Color :=  FontDialog.Font.Color;
    frmMain.SynEdit.Font.Size := FontDialog.Font.Size;
    ShowFont;
  end;
end;
procedure TSynEditOptionsForm.ShowFont;
begin
  txtFont.text := frmMain.SynEdit.Font.Name;
  lblFontColor.Caption := IntToStr(frmMain.SynEdit.Font.Size) + ' Font';
  lblFontColor.Font.Color := frmMain.SynEdit.Font.Color;
  lblFontColor.Font.Size := frmMain.SynEdit.Font.Size;
end;


initialization
  {$I editoroptions.lrs}

end.

