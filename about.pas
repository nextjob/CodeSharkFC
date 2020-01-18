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

unit about;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TAboutFrm }

  TAboutFrm = class(TForm)
    Aboutlbl: TLabel;
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  AboutFrm: TAboutFrm;

implementation

{$R *.lfm}

{ TAboutFrm }

procedure TAboutFrm.FormActivate(Sender: TObject);
begin
    Aboutlbl.caption :=
    'Copyright (C) 2020 Nextjob Solutions, LLC.' +
    char(10) + char(10);
    Aboutlbl.caption := Aboutlbl.caption +
    'This source is free software; ' + char(10) +
    'you can redistribute it and /or modify it under' + char(10) +
    'the terms of the GNU General Public License as published by the Free' + char(10) +
    'Software Foundation; either version 2 of the License, or (at your option) ' + char(10) +
    'any later version. ' +
     char(10) + char(10) +
    'This code is distributed in the hope that it will be useful, but WITHOUT ANY' + char(10) +
    'WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS' + char(10) +
    'FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more '+ char(10) +
    'details. ' +
     char(10) + char(10) +
    'A copy of the GNU General Public License is available on the World Wide Web' + char(10) +
    'at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing'+ char(10) +
    'to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,Boston, MA 02110 USA'+
     char(10) + char(10) +
    'This Program Is Built With and or utilizes the following modules / code'+ char(10) + char(10) +
    ' SynEdit Plus,   Copyright (C) 2009 Dariusz Rorat drorat1@o2.pl' + char(10) +
    ' https://sourceforge.net/projects/syneditplus/'+ char(10) + char(10) +
    ' Python4delphi, Source Code Can Be Found At: ' + char(10) +
    ' https://github.com/pyscripter/python4delphi'+ char(10) + char(10) +
    ' PathKurveUtils.py & Pathselection.py , Copyright (c) 2015 Dan Falck <ddfalck@gmail.com> ' + char(10) +
    ' https://github.com/FreeCAD/FreeCAD';
end;

end.

