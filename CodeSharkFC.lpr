{ SynEdit Plus

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
program CodeSharkFC;

{$mode objfpc}{$H+}
{$IFDEF WINDOWS}
{$apptype gui}
{$ENDIF}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, srcmain, FindReplaceDialog, editoroptions,
  RunTimeTypeInfoControls, Printer4Lazarus, FreeCad, SetFCparms, SetTool, About,
  EditColors, LazSerialPort, uReceive, uSend;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TSynEditOptionsForm, SynEditOptionsForm);
  Application.CreateForm(TLazFindReplaceDialog, LazFindReplaceDialog);
  Application.CreateForm(TSetFCparmsFrm, SetFCparmsFrm);
  Application.CreateForm(TSetToolFRM, SetToolFRM);
  Application.CreateForm(TAboutFrm, AboutFrm);
  Application.CreateForm(TFrmColors, FrmColors);
  Application.CreateForm(TfrmReceive, frmReceive);
  Application.CreateForm(TfrmSend, frmSend);
  Application.Run;
end.

