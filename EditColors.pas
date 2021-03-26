unit EditColors;

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ColorBox, ExtCtrls;

type

  { TFrmColors }

  TFrmColors = class(TForm)
    CCmboCom: TColorBox;
    CCmboZ: TColorBox;
    CCmboT: TColorBox;
    CCmboO: TColorBox;
    CCmboM: TColorBox;
    CCmboG1: TColorBox;
    CCmboOtherG: TColorBox;
    CBHighlight: TCheckBox;
    PanBot: TPanel;
    ButOK: TButton;
    ButCancel: TButton;
    CCmboOther: TColorBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure ButCancelClick(Sender: TObject);
    procedure ButOKClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmColors: TFrmColors;

implementation

{$R *.lfm}

procedure TFrmColors.ButCancelClick(Sender: TObject);
begin
 self.hide;
end;

procedure TFrmColors.ButOKClick(Sender: TObject);
begin
 self.hide;
end;


end.
