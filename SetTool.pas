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
unit SetTool;

{$MODE Delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, ComCtrls,
  Dialogs, ExtCtrls, StdCtrls;

type

  { TSetToolFRM }

  TSetToolFRM = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    rbCW: TRadioButton;
    rbCCW: TRadioButton;
    rbOnLine: TRadioButton;
    rbRightofLine: TRadioButton;
    rbLeftofLine: TRadioButton;
    RadiusEdt: TLabeledEdit;
    VertFeedEdt: TLabeledEdit;
    HorzFeedEdt: TLabeledEdit;
    OffsetExtraEdt: TLabeledEdit;
    RapidSafeSpaceEdt: TLabeledEdit;
    ClearanceEdt: TLabeledEdit;
    StartDepthEdt: TLabeledEdit;
    StepdownEdt: TLabeledEdit;
    FinalDepthEdt: TLabeledEdit;

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

end.
