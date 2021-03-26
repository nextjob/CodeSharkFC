unit uSend;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Spin;

type

  { TfrmSend }

  TfrmSend = class(TForm)
    btnCancel: TButton;
    btnSend: TButton;
    edtLnsToSend: TEdit;
    edtLnsSent: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    rbCR: TRadioButton;
    rbLF: TRadioButton;
    rbCRLF: TRadioButton;
    seDelay: TSpinEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmSend: TfrmSend;
  SendCancel : Boolean;    // did we cancel this send attempt?

implementation

uses
  srcmain;

{$R *.lfm}

{ TfrmSend }

procedure TfrmSend.btnCancelClick(Sender: TObject);
begin
  frmMain.Serial.Close;
  btnSend.Enabled:=True;
  SendCancel := True;
end;

procedure TfrmSend.btnSendClick(Sender: TObject);
  var
  DataStr: string;
  LineTerm : string;
  LnCount: integer;
begin
  if frmMain.SynEdit.Lines.Count < 1 then
    MessageDlg('Error, Nothing to Send', mtError, [mbOK], 0)
  else
  begin
    btnSend.Enabled:=False;
    SendCancel :=False;
    // set then gcode block terminating character(s)
    if rbCR.Checked then
      LineTerm := #13
    else if rbLF.Checked then
      LineTerm := #10
    else
      LineTerm := #13#10;

    try
      frmMain.Serial.Open;
      //  For LnCount := 0 to KHexEditor1.LineCount Do
      for LnCount := 0 to frmMain.SynEdit.Lines.Count do
      begin
        if SendCancel then
          exit;
        DataStr := frmMain.SynEdit.Lines[LnCount] + LineTerm;
        frmMain.Serial.WriteData(DataStr);
        // looks like he delays at each of the last 3 lines?
        // Maybe add a delay at end of loop?
        // Also add code for inter line delay or send null - see Aysnc Pro

        {    If (LnCount >= Memo.Lines.Count - 3) Then
         Begin
           Sleep(100);
         End; }
         If seDelay.Value > 0 then    // inter line delay
           sleep(seDelay.value);

         if LnCount mod 100 = 0 then
           begin
             application.ProcessMessages;
             edtLnsSent.Text := IntToStr(LnCOunt);
           end;
      end;
      frmMain.Serial.Close;
      edtLnsSent.Text := IntToStr(LnCOunt);
      MessageDlg('Send Completed', mtInformation, [mbOK], 0)
    except
      on E: Exception do
      begin
        MessageDlg('Serial Error ' + E.ClassName + ' : ' + E.Message, mtError, [mbOK], 0);
        frmMain.Logger.Error(E.ClassName + ' : ' + E.Message);
      end;
    end;
    btnSend.Enabled:=True;
  end;
end;

procedure TfrmSend.FormShow(Sender: TObject);
begin
   edtLnsSent.Text := '0000';
   edtLnsToSend.Text := IntToStr(frmMain.SynEdit.Lines.Count);
end;

end.

