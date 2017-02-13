unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtDlgs, ComCtrls;

type
  TIncodeMes = array of Integer;
  TForm4 = class(TForm)
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    OpenDialog2: TOpenDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4; DecryptString:string; DecryptFile:TStringStream; DecFile: TFileStream; EncryptName: char;

implementation

{$R *.dfm}
uses JPEG, uBits, ActiveX, uProcess, Unit2, math;

procedure TForm4.BitBtn1Click(Sender: TObject);
var i, k1, k2, Number:integer; FileNew:TextFile;

//File to Str
function LoadFileToStr(const sSource: TFileStream): String;
var
  FileStream : TFileStream;
begin
  FileStream:= sSource;
    try
     if FileStream.Size > 0 then
     begin
      SetLength(Result, FileStream.Size);
      FileStream.Read(Pointer(Result)^, FileStream.Size);
     end else
     Result:='';
    finally
     FileStream.Free;
    end;
end;

//Caesar Decrypt
function CaesarDecipher(toDecode: string; n:integer): string;
var i, T: integer;
begin
  for i := 1 to length(toDecode) do begin
    if (toDecode[i] <> ' ') then begin
    T := (Ord(toDecode[ i ]) - n);
    if T < 0 then Inc(T, 256);
    toDecode[ i ] := Chr(T);
    end;
  end;
  CaesarDecipher := toDecode;
end;

//Значение бита в двойном слове (32бита)
function Bit(Value, n: Integer): Boolean;
asm
   bt eax, edx
   setc al
   and eax, 0FFh
end;

//Функция быcтрого возведения в степень
function FastPower(a, b, n: integer): integer;
var i: integer;
    ai: extended;
begin
  ai := a;
  for I := Trunc(log2(b)) - 1 downto 0 do
  if Bit(b, i) then ai := Round(sqr(ai) * a) mod n else ai := Round(sqr(ai)) mod n;
  result := Round(ai);
end;

function DecryptRSA(s: string; e, n: integer): string;
  var i,f: Integer; DecMes:TIncodeMes; s1:string;
begin
  SetLength(Result, Length(s));
  SetLength(DecMes, length(s));
  i:=1;
  while (s <> '') do
    begin
     f:=1;
     s1:='';
      while (s[f] <> ' ') do
        begin
          s1:=s1+s[f];
          f:=f+1;
        end;
      DecMes[i]:=StrToInt(s1);
      Delete(s,1,f);
      i:=i+1;
    end;
  for I := 0 to Length(DecMes) - 1 do
      result[i + 1] := chr(FastPower(DecMes[i], e, n));
end;

procedure KeyGet(s:string; var n,d :integer);
var i,f:integer; s2:string;
begin
Delete(s,1,1);
EncryptName:=s[1];
s2:='';
case s[1] of
'Z': begin
  for i:=2 to length(s) do
     s2:=s2+s[i];
  n:=StrtoInt(s2);
  d:=0;
end;
'R':
begin
  i:=2;
  while (s[i] >= '0') and (s[i] <= '9') do
    begin
      s2:=s2+s[i];
      i:=i+1;
    end;
  n:=StrToInt(s2);
  delete(s,i,2);
  s2:='';
  for f:=i to length(s) do
    s2:=s2+s[f];
  d:=StrToInt(s2);
end;
end;
end;

procedure DekodLSB;
begin
  if OpenPictureDialog1.Execute and SaveDialog1.Execute then
    try
      try
        BitBtn1.Enabled:= False;
        ProgressBar1.Show;
        DeKod(OpenPictureDialog1.FileName, SaveDialog1.FileName, ProgressBar1);
      finally
       ProgressBar1.Hide;
        BitBtn1.Enabled:= True;
      end;
    except
      on e: Exception do
        MessageBox(Handle, PChar('Во время декодировки произошла ошибка.' + #13#10#13#10 + e.Message), 'StegaImage',  MB_OK + MB_ICONSTOP);
    end;
end;

function RSA_Decrypt(s:string; n,d:integer):string;
begin
  SetLength(Result, length(s));
  Result:= DecryptRSA(s, d , n);
end;

begin
 if (CheckBox1.Checked = true) then
  begin
  DekodLSB;
  DecFile:=TFileStream.Create(SaveDialog1.FileName,fmOpenRead);
  end;
  if (CheckBox1.Checked = false) then
    begin
      if (OpenDialog1.Execute) then
        DecFile:=TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
    end;
  DecryptString:=LoadFileToStr(DecFile);
  Number:=ComboBox1.ItemIndex;
  if (Number >=0) then
  begin
  KeyGet(Edit1.Text,k1,k2);
  case EncryptName of
    'Z': DecryptString:=CaesarDecipher(DecryptString, k1);
    'R': DecryptString:=RSA_Decrypt(DecryptString,k1,k2);
  end;
  end;
  if (Number >=1) then
  begin
  KeyGet(Edit2.Text,k1,k2);
    case EncryptName of
    'Z': DecryptString:=CaesarDecipher(DecryptString, k1);
    'R': DecryptString:=RSA_Decrypt(DecryptString,k1,k2);
  end;
  end;
  if (CheckBox1.Checked = false) then
  begin
  if (SaveDialog1.Execute) then
  begin
  AssignFile(FileNew, SaveDialog1.FileName);
    rewrite(FileNew);
    write(FileNew,DecryptString);
    closefile(FileNew);
    end;
    end
    else
    begin
  AssignFile(FileNew, SaveDialog1.FileName);
    rewrite(FileNew);
    write(FileNew,DecryptString);
    closefile(FileNew);
    end;
end;


procedure TForm4.ComboBox1Change(Sender: TObject);
var i:integer;
begin
i:=Combobox1.ItemIndex;
case i of
0: begin
Edit1.Visible:=true;
Label2.Visible:=true;
end;
1: begin
Edit1.Visible:=true;
Label2.Visible:=true;
Edit2.Visible:=true;
Label3.Visible:=true;
end;
2: begin
Edit1.Visible:=true;
Label2.Visible:=true;
Edit2.Visible:=true;
Label3.Visible:=true;
Edit3.Visible:=true;
Label4.Visible:=true;
end;
3: begin
Edit1.Visible:=true;
Label2.Visible:=true;
Edit2.Visible:=true;
Label3.Visible:=true;
Edit3.Visible:=true;
Label4.Visible:=true;
Edit4.Visible:=true;
Label5.Visible:=true;
end;
4: begin
Edit1.Visible:=true;
Label2.Visible:=true;
Edit2.Visible:=true;
Label3.Visible:=true;
Edit3.Visible:=true;
Label4.Visible:=true;
Edit4.Visible:=true;
Label5.Visible:=true;
end;
5: begin
Edit1.Visible:=true;
Label2.Visible:=true;
Edit2.Visible:=true;
Label3.Visible:=true;
Edit3.Visible:=true;
Label4.Visible:=true;
Edit4.Visible:=true;
end;
end;
end;

procedure TForm4.Button1Click(Sender: TObject);
var f:TextFile; key:string;
begin
if (OpenDialog2.Execute) then
begin
  AssignFile(f,OpenDialog2.FileName);
  reset(f);
  readln(f,key);
  Edit1.Text:=key;
  readln(f,key);
  Edit2.Text:=key;
  readln(f,key);
  Edit3.Text:=key;
  readln(f,key);
  Edit4.Text:=key;
  closefile(f);
end;
end;

end.
