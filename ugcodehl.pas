unit uGCodeHL;

(*
  uGCodeHL based on simlehl.pas included as an example highlighter found in
  ..\lazarus\examples\SynEdit\NewHighlighterTutorial
  See comments below and http://wiki.lazarus.freepascal.org/SynEdit_Highlighter

  How it works:

  - Creation
    The Highlighter creates Attributes that it can return the Words and Spaces.

  - SetLine
    Is called by SynEdit before a line gets painted (or before highlight info is needed)
    This is also called, each time the text changes fol *all* changed lines
    and may even be called for all lines after the change up to the end of text.

    After SetLine was called "GetToken*" should return information about the
    first token on the line.
    Note: Spaces are token too.

  - Next
    Scan to the next token, on the line that was set by "SetLine"
    "GetToken*"  should return info about that next token.

  - GetEOL
    Returns True, if "Next" was called while on the last token of the line.

  - GetTokenEx, GetTokenAttribute
    Provide info about the token found by "Next"

  - Next, GetEOL. GetToken*
    Are used by SynEdit to iterate over the Line.
    Important: The tokens returned for each line, must represent the original
    line-text (mothing added, nothing left out), and be returned in the correct order.

    They are called very often and should perform ath high speed.

  - GetToken, GetTokenPos, GetTokenKind
    SynEdit uses them e.g for finding matching brackets. If GetTokenKind returns different values per Attribute,
    then brackets only match, if they are of the same kind
    (e.g, if there was a string attribute, brackets outside a string would not match brackets inside a string)


*)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, SynEditTypes, SynEditHighlighter;

type

  { TGCodeHl }


//  TGCodeHl = class(TSynCustomHighlighter)
  TGCodeHl = class(TSynCustomHighlighter)
  private
    fSpecialAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;

    //
    // setup gcodes we are going to highlight
    // G1 G2 G3
    // G other
    // M
    // O
    // T
    // Z
    fG123Attri: TSynHighlighterAttributes;
    fGAttri: TSynHighlighterAttributes;
    fMAttri: TSynHighlighterAttributes;
    fOAttri: TSynHighlighterAttributes;
    fTAttri: TSynHighlighterAttributes;
    fZAttri: TSynHighlighterAttributes;


    procedure SetIdentifierAttri(AValue: TSynHighlighterAttributes);
    procedure SetSpaceAttri(AValue: TSynHighlighterAttributes);
    procedure SetSpecialAttri(AValue: TSynHighlighterAttributes);

    procedure SetG123Attri(AValue: TSynHighlighterAttributes);
    procedure SetGAttri(AValue: TSynHighlighterAttributes);
    procedure SetMAttri(AValue: TSynHighlighterAttributes);
    procedure SetOAttri(AValue: TSynHighlighterAttributes);
    procedure SetTAttri(AValue: TSynHighlighterAttributes);
    procedure SetZAttri(AValue: TSynHighlighterAttributes);


  protected
    // accesible for the other examples
    FTokenPos, FTokenEnd: integer;
    FLineText: string;
  public
    procedure SetLine(const NewValue: string; LineNumber: integer); override;
    procedure Next; override;
    function GetEol: boolean; override;
    procedure GetTokenEx(out TokenStart: PChar; out TokenLength: integer); override;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
  public
    function GetToken: string; override;
    function GetTokenPos: integer; override;
    function GetTokenKind: integer; override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes; override;
    constructor Create(AOwner: TComponent); override;
  published
    (* Define 4 Attributes, for the different highlights. *)
    property SpecialAttri: TSynHighlighterAttributes
      read fSpecialAttri write SetSpecialAttri;
    property IdentifierAttri: TSynHighlighterAttributes
      read fIdentifierAttri write SetIdentifierAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write SetSpaceAttri;

    property G123Attri: TSynHighlighterAttributes read fG123Attri write SetG123Attri;
    property GAttri: TSynHighlighterAttributes read fGAttri write SetGAttri;
    property MAttri: TSynHighlighterAttributes read fMAttri write SetMAttri;
    property OAttri: TSynHighlighterAttributes read fOAttri write SetOAttri;
    property TAttri: TSynHighlighterAttributes read fTAttri write SetTAttri;
    property ZAttri: TSynHighlighterAttributes read fZAttri write SetZAttri;

  end;

implementation

constructor TGCodeHl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  (* Create and initialize the attributes *)
  fSpecialAttri := TSynHighlighterAttributes.Create('special', 'special');
  AddAttribute(fSpecialAttri);
  //  fSpecialAttri.Style := [fsBold];
  fSpecialAttri.Background := clLtGray;

  fIdentifierAttri := TSynHighlighterAttributes.Create('ident', 'ident');
  AddAttribute(fIdentifierAttri);

  fSpaceAttri := TSynHighlighterAttributes.Create('space', 'space');
  AddAttribute(fSpaceAttri);
  //fSpaceAttri.FrameColor := clSilver;
  //fSpaceAttri.FrameEdges := sfeAround;

  // g code G1 G2 G3
  fG123Attri := TSynHighlighterAttributes.Create('G123', 'G123');
  AddAttribute(fG123Attri);
  //  fG123Attri.Style := [fsBold];
  fG123Attri.Background := clTeal ;
  // g codes G other
  fGAttri := TSynHighlighterAttributes.Create('Gblocks', 'Gblocks');
  AddAttribute(fGAttri);
  //  fGAttri.Style := [fsBold];
  fGAttri.Background := clLime;
  // g codes M
  fMAttri := TSynHighlighterAttributes.Create('Mblocks', 'Mblocks');
  AddAttribute(fMAttri);
  //  fMAttri.Style := [fsBold];
  fMAttri.Background := clYellow;
  // gcodes O
  fOAttri := TSynHighlighterAttributes.Create('Oblocks', 'Oblocks');
  AddAttribute(fOAttri);
  //  fOAttri.Style := [fsBold];
  fOAttri.Background := clAqua;
    // g codes T
  fTAttri := TSynHighlighterAttributes.Create('Tblocks', 'Tblocks');
  AddAttribute(fTAttri);
  //  fTAttri.Style := [fsBold];
  fTAttri.Background := clRed;
  // gcodes Z
  fZAttri := TSynHighlighterAttributes.Create('Zblocks', 'Zblocks');
  AddAttribute(fZAttri);
  //  fOAttri.Style := [fsBold];
  fZAttri.Background :=clSilver ;

  // Ensure the HL reacts to changes in the attributes. Do this once, if all attributes are created
  SetAttributesOnChange(@DefHighlightChange);
end;

(* Setters for attributes / This allows using in Object inspector*)
procedure TGCodeHl.SetIdentifierAttri(AValue: TSynHighlighterAttributes);
begin
  fIdentifierAttri.Assign(AValue);
end;

procedure TGCodeHl.SetG123Attri(AValue: TSynHighlighterAttributes);
begin
  fG123Attri.Assign(AValue);
end;
procedure TGCodeHl.SetGAttri(AValue: TSynHighlighterAttributes);
begin
  fGAttri.Assign(AValue);
end;
procedure TGCodeHl.SetMAttri(AValue: TSynHighlighterAttributes);
begin
  fMAttri.Assign(AValue);
end;
procedure TGCodeHl.SetOAttri(AValue: TSynHighlighterAttributes);
begin
  fOAttri.Assign(AValue);
end;
procedure TGCodeHl.SetZAttri(AValue: TSynHighlighterAttributes);
begin
  fZAttri.Assign(AValue);
end;
procedure TGCodeHl.SetTAttri(AValue: TSynHighlighterAttributes);
begin
  fTAttri.Assign(AValue);
end;

procedure TGCodeHl.SetSpaceAttri(AValue: TSynHighlighterAttributes);
begin
  fSpaceAttri.Assign(AValue);
end;

procedure TGCodeHl.SetSpecialAttri(AValue: TSynHighlighterAttributes);
begin
  fSpecialAttri.Assign(AValue);
end;

procedure TGCodeHl.SetLine(const NewValue: string; LineNumber: integer);
begin
  inherited;
  FLineText := NewValue;
  // Next will start at "FTokenEnd", so set this to 1
  FTokenEnd := 1;
  Next;
end;

procedure TGCodeHl.Next;
var
  lineLen: integer;

begin
  // FTokenEnd should be at the start of the next Token (which is the Token we want)
  FTokenPos := FTokenEnd;
  // assume empty, will only happen for EOL
  FTokenEnd := FTokenPos;

  // Scan forward
  // FTokenEnd will be set 1 after the last char. That is:
  // - The first char of the next token
  // - or past the end of line (which allows GetEOL to work)


  // I think this is the code that we need to modify to get out g code tokens defined!
  // ie what starts a token [A..Z] and what ends a token (either Space, eol or [A..Z]
  // rem to force text to upper case

  lineLen := length(FLineText);
  if FTokenPos > lineLen then
    // At line end
    exit
  else
  if FLineText[FTokenEnd] in [#9, ' '] then
    // At Space? Find end of spaces
    while (FTokenEnd <= lineLen) and (FLineText[FTokenEnd] in [#0..#32]) do
      Inc(FTokenEnd)
  else
  if FLineText[FTokenEnd] = '('  then  // start of comment, parse until end
  begin
    while True do
    begin
      if (FTokenEnd > lineLen) then
        Exit;
      if FLineText[FTokenEnd] = ')' then
      begin
        inc(FTokenEnd);
        Exit;
      end;
      Inc(FTokenEnd);
    end;
  end
  else
    //  Find end of G Code Address Block (either a space or another G code)
  begin
    if FTokenPos = FTokenEnd then
      Inc(FTokenEnd);
    while True do
    begin
      if (FTokenEnd > lineLen) then
        Exit;
      if upCase(FLineText[FTokenEnd]) in ['A'..'Z',' ','('] then
        Exit;
      Inc(FTokenEnd);
    end;
  end;
end;

function TGCodeHl.GetEol: boolean;
begin
  Result := FTokenPos > length(FLineText);
end;

procedure TGCodeHl.GetTokenEx(out TokenStart: PChar; out TokenLength: integer);
begin
  TokenStart := @FLineText[FTokenPos];
  TokenLength := FTokenEnd - FTokenPos;
end;

function TGCodeHl.GetTokenAttribute: TSynHighlighterAttributes;
var
  Gcode : String;
begin
  // Match the text, specified by FTokenPos and FTokenEnd

  if FLineText[FTokenPos] in [#9, ' '] then
    Result := SpaceAttri
  else
  if FLineText[FTokenPos] = '(' then    // start of G Code comment
    Result := SpecialAttri
  else
  Begin
    Gcode :=  upCase(Copy(FLineText,FTokenPos,(FTokenEnd - FTokenPos)));
    if (Gcode = 'G1') or (Gcode = 'G2') or (Gcode = 'G3') then
      Result := G123Attri
    else
    if (Gcode = 'G01') or (Gcode = 'G02') or (Gcode = 'G03') then    // catch other valid style
      Result := G123Attri
    else
    if  upCase(FLineText[FTokenPos]) = 'G' then
      Result := GAttri
    else
    if upCase(FLineText[FTokenPos]) = 'M' then
      Result := MAttri
    else
    if  upCase(FLineText[FTokenPos]) = 'O' then
      Result := OAttri
    else
    if upCase(FLineText[FTokenPos]) = 'T' then
      Result := TAttri
    else
    if upCase(FLineText[FTokenPos]) = 'Z' then
      Result := ZAttri
    else
      Result := IdentifierAttri;
  END;
end;

function TGCodeHl.GetToken: string;
begin
  Result := copy(FLineText, FTokenPos, FTokenEnd - FTokenPos);
end;

function TGCodeHl.GetTokenPos: integer;
begin
  Result := FTokenPos - 1;
end;

function TGCodeHl.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  // Some default attributes
  case Index of
    SYN_ATTR_COMMENT: Result := fSpecialAttri;
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
    else
      Result := nil;
  end;
end;

function TGCodeHl.GetTokenKind: integer;
var
  a: TSynHighlighterAttributes;
begin
  // Map Attribute into a unique number
  a := GetTokenAttribute;
  Result := 0;
  if a = fSpaceAttri then
    Result := 1
  else
  if a = fSpecialAttri then
    Result := 2
  else
  if a = fIdentifierAttri then
    Result := 3
  else
  if a = fG123Attri then
    Result := 4
  else
  if a = fGAttri then
    Result := 5
  else
  if a = fMAttri then
    Result := 6
  else
  if a = fOAttri then
    Result := 7
  else
  if a = fTAttri then
    Result := 8
  else
  if a = fZAttri then
    Result := 9;
end;

end.
