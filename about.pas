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
    'Copyright : ©1999-2017 by Nextjob Solutions, LLC.' +
    char(10) + char(10);
    Aboutlbl.caption := Aboutlbl.caption +
    'Redistribution and use in source and binary forms, with or without' +
    char(10) +
    'modification, are permitted provided that the following conditions are met:'
    + char(10) + char(10) +
    '1. Redistributions of source code must retain the above copyright notice,' + char(10) +
    '    this list of conditions and the following disclaimer. ' + char(10) + char(10) +
    '2. Redistributions in binary form must reproduce the above copyright notice,' + char(10) +
    '   this list of conditions and the following disclaimer ' + char(10) +
    '   in the documentation and/or other materials provided with the distribution.'
    + char(10) + char(10) +
    'THIS SOFTWARE IS PROVIDED BY THE AUTHOR  AND CONTRIBUTORS ''AS IS'' ' + char(10) +
    'AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, ' + char(10) +
    'THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE '+ char(10) +
    'ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, '+ char(10) +
    'INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES '+ char(10) +
    '(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;'+ char(10) +
    '  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) '+ char(10) +
    'HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,'+ char(10) +
    ' OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE '+ char(10) +
    'OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.' + char(10) + char(10) +
    'This Program Is Built With and or utilizes the following modules / code'+ char(10) + char(10) +
    ' SynEdit Plus,   Copyright (C) 2009 Dariusz Rorat drorat1@o2.pl' + char(10) +
    ' https://sourceforge.net/projects/syneditplus/'+ char(10) + char(10) +
    ' Python4delphi, Source Code Can Be Found At: ' + char(10) +
    ' https://github.com/pyscripter/python4delphi'+ char(10) + char(10) +
    ' PathKurveUtils.py & Pathselection.py , Copyright (c) 2015 Dan Falck <ddfalck@gmail.com> ' + char(10) +
    ' https://github.com/FreeCAD/FreeCAD';
end;

end.

