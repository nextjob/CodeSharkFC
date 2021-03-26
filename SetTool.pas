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
unit SetTool;

{$MODE Delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, ComCtrls,
  Dialogs, ExtCtrls, StdCtrls;

type

  { TSetToolFRM }

  TSetToolFRM = class(TForm)
    ClearanceEdt: TLabeledEdit;
    FinalDepthEdt: TLabeledEdit;
    HorzFeedEdt: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    {$IFDEF FPC}
    Label3: TLabel;
    Label4: TLabel;
    StartXEdt: TLabeledEdit;
    StartYEdt: TLabeledEdit;
    StartZEdt: TLabeledEdit;
    {$ENDIF}
    OffsetExtraEdt: TLabeledEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel3: TPanel;
    RadiusEdt: TLabeledEdit;
    RapidSafeSpaceEdt: TLabeledEdit;
    rbCW: TRadioButton;
    rbCCW: TRadioButton;
    rbLeftofLine: TRadioButton;
    rbOnLine: TRadioButton;
    rbRightofLine: TRadioButton;
    StartDepthEdt: TLabeledEdit;
    StepdownEdt: TLabeledEdit;
    VertFeedEdt: TLabeledEdit;
    procedure GenericEditExit(Sender: TObject);
    procedure GenericEditExitP(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetToolFRM: TSetToolFRM;

implementation

{$R *.lfm}

{ TSetToolFRM }
// use val function procedure Val(Const S: string; var V; var Code: Word) to validate tool values

procedure TSetToolFRM.GenericEditExit(Sender: TObject);
Var
Value : Double;
begin
  with Sender as TLabeledEdit do
  begin
    if Not(TryStrToFloat(Text, Value)) then
    Begin
      ShowMessage('Value Entered for ' + EditLabel.Caption + ': ' + Text + ' Is Invalid, Retry');
      Setfocus;
    End;
  end;
end;

procedure TSetToolFRM.GenericEditExitP(Sender: TObject);
Var
Value : Double;
begin
  with Sender as TLabeledEdit do
  begin
    if Not(TryStrToFloat(Text, Value)) then
      Begin
        ShowMessage('Value Entered for ' + EditLabel.Caption + ': ' + Text + ' Is Invalid, Retry');
        Setfocus;
      End
    Else
      if Value < 0  then
      Begin
        ShowMessage('Value Entered for ' + EditLabel.Caption + ': ' + Text + ' Cannot Be Negative, Retry');
        Setfocus;
      End
  end;
end;
end.
