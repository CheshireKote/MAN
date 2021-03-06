unit uBits;

interface

procedure SetBitAt(var variable: LongInt; Posit: Byte; value: Boolean); overload;
procedure SetBitAt(var variable: Byte; Posit: Byte; value: Boolean); overload;
function GetBitAt(variable: LongInt; Posit: Byte): Boolean;

implementation

procedure SetBitAt(var variable: Byte; Posit: Byte; value: Boolean);
begin
  if value then
    variable:= variable or (1 shl Posit)
  else
    variable:= variable and ((1 shl Posit) xor $FF);
end;

procedure SetBitAt(var variable: LongInt; Posit: Byte; Value: Boolean);
begin
  if value then
    variable:= variable or (1 shl Posit)
  else
    variable:= variable and ((1 shl Posit) xor $FFFFFFFF);
end;

function GetBitAt(variable: LongInt; Posit: Byte): Boolean;
begin
  if variable and (1 shl Posit) <> 0 then
    Result:= true
  else
    Result:= false;
end;

end.

