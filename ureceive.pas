unit uReceive;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Spin;

type

  { TfrmReceive }

  TfrmReceive = class(TForm)
    btnCancel: TButton;
    btnStart: TButton;
    edtTimeOut: TEdit;
    edtLnsRecd: TEdit;
    Label1: TLabel;
    lblTimeOut: TLabel;
    lblLnsRecd: TLabel;
    RecvTimout: TTimer;
    seMaxTimeOut: TSpinEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RecvTimoutTimer(Sender: TObject);

  private

  public
    TimeoutCount: integer; // Count of seconds (RecvTimout events) since last recv
    RecvCount: integer;    // lines received
  end;

var
  frmReceive: TfrmReceive;


implementation

uses srcmain;

{$R *.lfm}

{ TfrmReceive }

procedure TfrmReceive.btnStartClick(Sender: TObject);
  begin
  frmMain.SynEdit.Modified:=True;     // force prompt for save file
  try
    frmMain.Serial.Open;
    RecvCount := 0;
    TimeoutCount := 0;
    RecvTimout.Enabled := True;
  except
    on E: Exception do
    begin
      MessageDlg('Serial Error ' + E.ClassName + ' : ' + E.Message, mtError, [mbOK], 0);
      frmMain.Logger.Error(E.ClassName + ' : ' + E.Message);
    end;
  end;

end;

procedure TfrmReceive.btnCancelClick(Sender: TObject);
begin
  RecvTimout.Enabled := False;
  frmMain.Serial.Close;
end;

procedure TfrmReceive.FormShow(Sender: TObject);
begin
  RecvTimout.Enabled := False;
  TimeOutCount := 0;
  RecvCount := 0;
  edtTimeOut.Text := IntToStr(TimeoutCount);
  edtLnsRecd.Text := IntToStr(RecvCount);

end;

procedure TfrmReceive.RecvTimoutTimer(Sender: TObject);
begin
  // Check how many times this has fired since last recv
  if TimeoutCount > seMaxTimeOut.Value then
  begin
    RecvTimout.Enabled := False;
    MessageDlg('Receive TimeOut Timer Expired, Receive Ended',
      mtInformation, [mbOK], 0);
    frmMain.Serial.Close;
  end
  else
  begin
    Inc(TimeOutCount);
    RecvTimout.Enabled := True;
    edtTimeOut.Text := IntToStr(TimeOutCount);
  end;
end;

end.

