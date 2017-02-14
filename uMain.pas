unit uMain;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Buttons, XPMan, ExtCtrls, ExtDlgs,
  TeEngine, Series, TeeProcs, Chart, DbChart, TeeFunci, Graphics;

type
  TIncodeMes = array of Integer;
  TForm1 = class(TForm)
    xpmnfst1: TXPManifest;
    dlgOpenPic1: TOpenPictureDialog;
    dlgOpen1: TOpenDialog;
    dlgSavePic1: TSavePictureDialog;
    dlgSave1: TSaveDialog;
    bbtnEncrypt: TBitBtn;
    pb1: TProgressBar;
    edtBPC: TEdit;
    udBitsPerChannel: TUpDown;
    lblBPC: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ComboBox8: TComboBox;
    Label12: TLabel;
    UpDown1: TUpDown;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    CheckBox1: TCheckBox;
    Label11: TLabel;
    Label13: TLabel;
    CheckBox2: TCheckBox;
    Button2: TButton;
    DBChart1: TDBChart;
    Series2: TBarSeries;
    procedure bbtnEncryptClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
      FMes: TIncodeMes;
  public
  end;

var
  Form1: TForm1; GraphFile:TStringStream; SourceFile: TFileStream; SourceString, Encrypt1,Encrypt2,Encrypt3,Encrypt4: string;

implementation
{$R *.dfm}

uses JPEG, uBits, uProcess, ActiveX, Unit2, math;


procedure TForm1.bbtnEncryptClick(Sender: TObject);
var SourceEncrypt, KeyEncrypt:TextFile;

begin
if (CheckBox1.Checked = false) then
begin
  if (dlgSave1.Execute) then
  begin
  AssignFile(SourceEncrypt, dlgSave1.FileName);
  rewrite(SourceEncrypt);
  write(SourceEncrypt, SourceString);
  closefile(SourceEncrypt);
  end;
end;
  if (CheckBox2.Checked = false) then
MessageBox(Handle, PChar('Ключ першого методу кодування: '+Encrypt1+#13#10+'Ключ другого методу кодування: '+Encrypt2+#13#10+'Ключ третього методу кодування: '+Encrypt3+#13#10+'Ключ четвертого методу кодування: '+Encrypt4), 'Hidden words', MB_OK+MB_ICONINFORMATION)
   else
   begin
     AssignFile(KeyEncrypt, 'key_save.txt');
  Rewrite(KeyEncrypt);
  if (Encrypt4 <> '') then
  writeln(KeyEncrypt, Encrypt4);
  if (Encrypt3 <> '') then
  writeln(KeyEncrypt, Encrypt3);
  if (Encrypt2 <> '') then
  writeln(KeyEncrypt, Encrypt2);
  if (Encrypt1 <> '') then
  writeln(KeyEncrypt, Encrypt1);
  closefile(KeyEncrypt);
   MessageBox(Handle, PChar('Ключи кодування містяться у документі key_save.txt'+#13#10+'Рекомендується видалити файл з ключам після їх запам''ятовування'), 'Hidden words', MB_OK+MB_ICONINFORMATION)
   end;
//SourceFile.Free;
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
var i:integer;
begin
i:=Combobox1.ItemIndex;
case i of
0: begin
ComboBox2.Visible:=true;
Label5.Visible:=true;
end;

1: begin
ComboBox2.Visible:=true;
ComboBox3.Visible:=true;
Label5.Visible:=true;
Label6.Visible:=true;
end;

2: begin
ComboBox2.Visible:=true;
ComboBox3.Visible:=true;
ComboBox4.Visible:=true;
Label5.Visible:=true;
Label6.Visible:=true;
Label7.Visible:=true;
end;

3: begin
ComboBox2.Visible:=true;
ComboBox3.Visible:=true;
ComboBox4.Visible:=true;
ComboBox5.Visible:=true;
Label8.Visible:=true;
Label5.Visible:=true;
Label6.Visible:=true;
Label7.Visible:=true;
end;

4: begin
ComboBox2.Visible:=true;
ComboBox3.Visible:=true;
ComboBox4.Visible:=true;
ComboBox5.Visible:=true;
ComboBox6.Visible:=true;
Label8.Visible:=true;
Label5.Visible:=true;
Label6.Visible:=true;
Label7.Visible:=true;
Label9.Visible:=true;
end;

5: begin
ComboBox2.Visible:=true;
ComboBox3.Visible:=true;
ComboBox4.Visible:=true;
ComboBox5.Visible:=true;
ComboBox6.Visible:=true;
ComboBox7.Visible:=true;
Label8.Visible:=true;
Label5.Visible:=true;
Label6.Visible:=true;
Label7.Visible:=true;
Label9.Visible:=true;
Label10.Visible:=true;
end;
end;
end;

procedure simplegen(var prp,prt:word);
var simp:boolean;
    i,j:byte;
    prq:word;
begin
randomize; prp:=0;
repeat
simp:=true;
prq:=random(100)+prt;  j:=2;
for i:=2 to trunc(sqrt(prq)) do
begin
if ((prq mod j)=0) then  simp:=false;
inc(j);
end
until (simp=true);
prp:=prq;
end;

function NOD(e:word;n:longword):longword;
var q,r:integer;
begin
repeat
q:= n div e;
r:= n mod e;
n:=e;
e:=r
until r=0;
NOD:=n;
end;

procedure TForm1.Button1Click(Sender: TObject);
var log:boolean;
    p,q,e,d:word;
    n,m:longword;
begin
  randomize;
  // генерация простых чисел
  e:=1;
  simplegen(p,e);
  randomize;  e:=2;
  simplegen(q,e); e:=0;
  //вычисление произведения простых и функции Эйлера
  n:=p*q; m:=(p-1)*(q-1);
  //генерация числа, взаимно простого с m
  log:=true;
  while log do
  begin
  e:=trunc(random(99))+2;
  if NOD(e,m)=1 then log:=false;
  randomize;
  end;
  // находим d
  log:=true; d:=2;
  while log do
  begin
  if ((d*e)mod m)=1 then log:=false
                    else inc(d);
  end;
  Edit2.Text:=InttoStr(d);
  Edit3.Text:=InttoStr(e);
  Edit4.Text:=InttoStr(n);
end;

{---------------Parameters placing--------------}

procedure TForm1.ComboBox2Change(Sender: TObject);
var i:integer;
begin
i:=ComboBox2.ItemIndex;
case i of
0: begin
ComboBox8.Visible:=true; ComboBox8.Top:=ComboBox2.Top; ComboBox8.Left:=ComboBox2.Left + 640;
Label12.Visible:=true; Label12.Top:=ComboBox2.Top; Label12.Left:=ComboBox2.Left+800;
Edit1.Visible:=true; Edit1.Top:=ComboBox2.Top; Edit1.Left:=ComboBox2.Left +880;
UpDown1.Visible:=true; UpDown1.Top:=ComboBox2.Top; UpDown1.Left:=ComboBox2.Left +905;
//Quiet others buttons
if (Edit2.Top = ComboBox2.Top) then
begin
Edit2.Visible:=false;
Edit3.Visible:=false;
Edit4.Visible:=false;
Button1.Visible:=false;
end;
{-------------}
if (lblBPC.Top = ComboBox2.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
1: begin
Edit2.Visible:=true; Edit2.Top:=ComboBox2.Top; Edit2.Left:=ComboBox2.Left + 630;
Edit3.Visible:=true; Edit3.Top:=ComboBox2.Top; Edit3.Left:=ComboBox2.Left + 694;
Edit4.Visible:=true; Edit4.Top:=ComboBox2.Top; Edit4.Left:=ComboBox2.Left + 758;
Button1.Visible:=true; Button1.Top:=ComboBox2.Top; Button1.Left:=ComboBox2.Left + 820;
//Quiet others buttons
if (ComboBox8.Top = ComboBox2.Top) then
begin
ComboBox8.Visible:=False;
Label12.Visible:=false;
Edit1.Visible:=false;
UpDown1.Visible:=false;
end;
{-------------}
if (lblBPC.Top = ComboBox2.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
end;
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
var i:integer;
begin
i:=ComboBox3.ItemIndex;
case i of
0: begin
ComboBox8.Visible:=true; ComboBox8.Top:=ComboBox3.Top; ComboBox8.Left:=ComboBox3.Left + 640;
Label12.Visible:=true; Label12.Top:=ComboBox3.Top; Label12.Left:=ComboBox3.Left+800;
Edit1.Visible:=true; Edit1.Top:=ComboBox3.Top; Edit1.Left:=ComboBox3.Left +880;
UpDown1.Visible:=true; UpDown1.Top:=ComboBox3.Top; UpDown1.Left:=ComboBox3.Left +905;
//Quiet others buttons
if (Edit2.Top = ComboBox3.Top) then
begin
Edit2.Visible:=false;
Edit3.Visible:=false;
Edit4.Visible:=false;
Button1.Visible:=false;
end;
{-------------}
if (lblBPC.Top = ComboBox3.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
1: begin
Edit2.Visible:=true; Edit2.Top:=ComboBox3.Top; Edit2.Left:=ComboBox3.Left + 630;
Edit3.Visible:=true; Edit3.Top:=ComboBox3.Top; Edit3.Left:=ComboBox3.Left + 694;
Edit4.Visible:=true; Edit4.Top:=ComboBox3.Top; Edit4.Left:=ComboBox3.Left + 758;
Button1.Visible:=true; Button1.Top:=ComboBox3.Top; Button1.Left:=ComboBox3.Left + 820;
//Quiet others buttons
if (ComboBox8.Top = ComboBox3.Top) then
begin
ComboBox8.Visible:=False;
Label12.Visible:=false;
Edit1.Visible:=false;
UpDown1.Visible:=false;
end;
{------------}
if (lblBPC.Top = ComboBox3.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
end;
end;

procedure TForm1.ComboBox4Change(Sender: TObject);
var i:integer;
begin
i:=ComboBox4.ItemIndex;
case i of
0: begin
ComboBox8.Visible:=true; ComboBox8.Top:=ComboBox4.Top; ComboBox8.Left:=ComboBox4.Left + 640;
Label12.Visible:=true; Label12.Top:=ComboBox4.Top; Label12.Left:=ComboBox4.Left+800;
Edit1.Visible:=true; Edit1.Top:=ComboBox4.Top; Edit1.Left:=ComboBox4.Left +880;
UpDown1.Visible:=true; UpDown1.Top:=ComboBox4.Top; UpDown1.Left:=ComboBox4.Left +905;
//Quiet others buttons
if (Edit2.Top = ComboBox4.Top) then
begin
Edit2.Visible:=false;
Edit3.Visible:=false;
Edit4.Visible:=false;
Button1.Visible:=false;
end;
{-------------}
if (lblBPC.Top = ComboBox4.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
1: begin
Edit2.Visible:=true; Edit2.Top:=ComboBox4.Top; Edit2.Left:=ComboBox4.Left + 630;
Edit3.Visible:=true; Edit3.Top:=ComboBox4.Top; Edit3.Left:=ComboBox4.Left + 694;
Edit4.Visible:=true; Edit4.Top:=ComboBox4.Top; Edit4.Left:=ComboBox4.Left + 758;
Button1.Visible:=true; Button1.Top:=ComboBox4.Top; Button1.Left:=ComboBox4.Left + 820;
//Quiet others buttons
if (ComboBox8.Top = ComboBox4.Top) then
begin
ComboBox8.Visible:=False;
Label12.Visible:=false;
Edit1.Visible:=false;
UpDown1.Visible:=false;
end;
{------------}
if (lblBPC.Top = ComboBox4.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
end;
end;

procedure TForm1.ComboBox5Change(Sender: TObject);
var i:integer;
begin
i:=ComboBox5.ItemIndex;
case i of
0: begin
ComboBox8.Visible:=true; ComboBox8.Top:=ComboBox5.Top; ComboBox8.Left:=ComboBox5.Left + 640;
Label12.Visible:=true; Label12.Top:=ComboBox5.Top; Label12.Left:=ComboBox5.Left+800;
Edit1.Visible:=true; Edit1.Top:=ComboBox5.Top; Edit1.Left:=ComboBox5.Left +880;
UpDown1.Visible:=true; UpDown1.Top:=ComboBox5.Top; UpDown1.Left:=ComboBox5.Left +905;
//Quiet others buttons
if (Edit2.Top = ComboBox5.Top) then
begin
Edit2.Visible:=false;
Edit3.Visible:=false;
Edit4.Visible:=false;
Button1.Visible:=false;
end;
{-------------}
if (lblBPC.Top = ComboBox5.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
1: begin
Edit2.Visible:=true; Edit2.Top:=ComboBox5.Top; Edit2.Left:=ComboBox5.Left + 630;
Edit3.Visible:=true; Edit3.Top:=ComboBox5.Top; Edit3.Left:=ComboBox5.Left + 694;
Edit4.Visible:=true; Edit4.Top:=ComboBox5.Top; Edit4.Left:=ComboBox5.Left + 758;
Button1.Visible:=true; Button1.Top:=ComboBox5.Top; Button1.Left:=ComboBox5.Left + 820;
//Quiet others buttons
if (ComboBox8.Top = ComboBox5.Top) then
begin
ComboBox8.Visible:=False;
Label12.Visible:=false;
Edit1.Visible:=false;
UpDown1.Visible:=false;
end;
{------------}
if (lblBPC.Top = ComboBox5.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
end;
end;

procedure TForm1.ComboBox6Change(Sender: TObject);
var i:integer;
begin
i:=ComboBox6.ItemIndex;
case i of
0: begin
ComboBox8.Visible:=true; ComboBox8.Top:=ComboBox6.Top; ComboBox8.Left:=ComboBox6.Left + 640;
Label12.Visible:=true; Label12.Top:=ComboBox6.Top; Label12.Left:=ComboBox6.Left+800;
Edit1.Visible:=true; Edit1.Top:=ComboBox6.Top; Edit1.Left:=ComboBox6.Left +880;
UpDown1.Visible:=true; UpDown1.Top:=ComboBox6.Top; UpDown1.Left:=ComboBox6.Left +905;
//Quiet others buttons
if (Edit2.Top = ComboBox6.Top) then
begin
Edit2.Visible:=false;
Edit3.Visible:=false;
Edit4.Visible:=false;
Button1.Visible:=false;
end;
{-------------}
if (lblBPC.Top = ComboBox6.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
1: begin
Edit2.Visible:=true; Edit2.Top:=ComboBox6.Top; Edit2.Left:=ComboBox6.Left + 630;
Edit3.Visible:=true; Edit3.Top:=ComboBox6.Top; Edit3.Left:=ComboBox6.Left + 694;
Edit4.Visible:=true; Edit4.Top:=ComboBox6.Top; Edit4.Left:=ComboBox6.Left + 758;
Button1.Visible:=true; Button1.Top:=ComboBox6.Top; Button1.Left:=ComboBox6.Left + 820;
//Quiet others buttons
if (ComboBox8.Top = ComboBox6.Top) then
begin
ComboBox8.Visible:=False;
Label12.Visible:=false;
Edit1.Visible:=false;
UpDown1.Visible:=false;
end;
{------------}
if (lblBPC.Top = ComboBox6.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
end;

end;

procedure TForm1.ComboBox7Change(Sender: TObject);
var i:integer;
begin
i:=ComboBox7.ItemIndex;
case i of
0: begin
ComboBox8.Visible:=true; ComboBox8.Top:=ComboBox7.Top; ComboBox8.Left:=ComboBox7.Left + 640;
Label12.Visible:=true; Label12.Top:=ComboBox7.Top; Label12.Left:=ComboBox7.Left+800;
Edit1.Visible:=true; Edit1.Top:=ComboBox7.Top; Edit1.Left:=ComboBox7.Left +880;
UpDown1.Visible:=true; UpDown1.Top:=ComboBox7.Top; UpDown1.Left:=ComboBox7.Left +905;
//Quiet others buttons
if (Edit2.Top = ComboBox7.Top) then
begin
Edit2.Visible:=false;
Edit3.Visible:=false;
Edit4.Visible:=false;
Button1.Visible:=false;
end;
{-------------}
if (lblBPC.Top = ComboBox7.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
1: begin
Edit2.Visible:=true; Edit2.Top:=ComboBox7.Top; Edit2.Left:=ComboBox7.Left + 630;
Edit3.Visible:=true; Edit3.Top:=ComboBox7.Top; Edit3.Left:=ComboBox7.Left + 694;
Edit4.Visible:=true; Edit4.Top:=ComboBox7.Top; Edit4.Left:=ComboBox7.Left + 758;
Button1.Visible:=true; Button1.Top:=ComboBox7.Top; Button1.Left:=ComboBox7.Left + 830;
//Quiet others buttons
if (ComboBox8.Top = ComboBox7.Top) then
begin
ComboBox8.Visible:=False;
Label12.Visible:=false;
Edit1.Visible:=false;
UpDown1.Visible:=false;
end;
{------------}
if (lblBPC.Top = ComboBox7.Top) then
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;

end;
end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ComboBox2.Visible:=false;
  ComboBox3.Visible:=false;
  ComboBox4.Visible:=false;
  ComboBox5.Visible:=false;
  ComboBox6.Visible:=false;
  ComboBox7.Visible:=false;
  ComboBox8.Visible:=false;
  Label5.Visible:=false;
  Label6.Visible:=false;
  Label7.Visible:=false;
  Label8.Visible:=false;
  Label9.Visible:=false;
  Label10.Visible:=false;
  Label12.Visible:=false;
  Edit1.Visible:=false;
  Edit2.Visible:=false;
  Edit3.Visible:=false;
  Edit4.Visible:=false;
  edtBPC.Visible:=false;
  lblBPC.Visible:=false;
  udBitsPerChannel.Visible:=false;
  UpDown1.Visible:=false;
  Button1.Visible:=false;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if (CheckBox1.Checked) then
begin
lblBPC.Visible:=true; lblBPC.Top:=CheckBox1.Top; lblBPC.Left:=CheckBox1.Left + 104;
edtBPC.Visible:=true; edtBPC.Top:=CheckBox1.Top; edtBPC.Left:=CheckBox1.Left + 204;
udBitsPerChannel.Visible:=true; udBitsPerChannel.Top:=CheckBox1.Top; udBitsPerChannel.Left:=CheckBox1.Left+231;
end else
begin
lblBPC.Visible:=false;
edtBPC.Visible:=false;
udBitsPerChannel.Visible:=false;
end;
end;


{-----------------------------------------------------}
procedure TForm1.Button2Click(Sender: TObject);
var a:array[1..6] of integer; SourceEncrypt, KeyEncrypt:TextFile; i, weight:longint;

{---------------------------------------}

procedure MetodLSB;
begin
if dlgOpenPic1.Execute and dlgSavePic1.Execute then
    try
      try
        bbtnEncrypt.Enabled:= False;
        lblBPC.Enabled:= False;
        edtBPC.Enabled:= False;
        udBitsPerChannel.Enabled:= False;
        pb1.Show;


        Kod(dlgOpenPic1.FileName, dlgSavePic1.FileName, GraphFile,  udBitsPerChannel.Position, pb1);

        MessageBox( Application.Handle, PChar('Кодування минуло вдало!' + #13#10#13#10 + 'Файл "' +
                    dlgSavePic1.FileName + '" было створено.'),
                    'Hidden words', MB_OK + MB_ICONINFORMATION);
      finally
        pb1.Hide;
        bbtnEncrypt.Enabled:= True;
        lblBPC.Enabled:= True;
        edtBPC.Enabled:= True;
        udBitsPerChannel.Enabled:= True;
      end;
    except
     on e: Exception do
       MessageBox(Handle, PChar('Во время кодировки произошла ошибка.' + #13#10#13#10 + e.Message), 'Hidden words', MB_OK + MB_ICONSTOP);
    end;
end;

procedure  KodZez;
var c:integer;

function CaesarEncipher(toCode: string; n:integer): string;
var i, T: integer;
begin
  for i := 1 to length(toCode) do begin
    if (toCode[i] <> ' ') then begin
    T := (Ord(toCode[ i ]) + n);
    if T >= 256 then dec(T, 256);
    toCode[ i ] := Chr(T);
    end;
  end;
  CaesarEncipher := toCode;
end;

begin
  c:= UpDown1.Position;
  SourceString := CaesarEncipher(SourceString,c);
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

function Encrypt(s: string; e, n: integer): TIncodeMes;
  var I: Integer;
begin
  SetLength(result, length(s));
  for I := 0 to Length(s) - 1 do
    result[i] := FastPower(ord(s[i + 1]), e, n)
end;

function Decrypt(s: array of integer; e, n: integer): string;
  var i: Integer;
begin
  SetLength(Result, Length(s));
  for I := 0 to Length(s) - 1 do
    result[i + 1] := chr(FastPower(s[i], e, n))
end;

//Шифрование текста в SourceFile
procedure RSA_Encrypt;
  var i, n, e: Integer;
begin
  n := StrToInt(Edit4.Text);
  e := StrToInt(Edit3.Text);
  FMes := Encrypt(SourceString, e, n);
  SourceString:='';
  for i := 0 to High(FMes) do
      SourceString:= SourceString + IntToStr(FMes[i])+' ';
end;

procedure  ShifrVi;
begin

end;

procedure  Metod3D;
begin
end;
{--------------------------------------------}

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

begin
if dlgOpen1.Execute then
SourceFile:=TFileStream.Create(dlgOpen1.FileName, fmOpenRead);
SourceString:=LoadFileToStr(SourceFile);
Series2.Clear;
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'Початковий Файл', clGreen);
Encrypt1:='';
Encrypt2:='';
Encrypt3:='';
Encrypt4:='';
if (Combobox1.ItemIndex <> -1)then begin
a[1]:=Combobox2.ItemIndex;
case a[1] of
0: begin
KodZez; Encrypt1:= 'EZ'+IntToStr(UpDown1.Position);
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'Цезар', clRed);
end;
1: begin
RSA_Encrypt; Encrypt1:='ER'+Edit4.Text+'PR'+Edit2.Text;
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'RSA', clRed);
end;
2: begin ShifrVi; Encrypt1:='EV'; end;
3: begin Metod3D; Encrypt1:='EE'; end;
end;
end;

if (Combobox2.ItemIndex <> -1)then begin
a[2]:=Combobox3.ItemIndex;
case a[2] of
0: begin
KodZez; Encrypt2:= 'EZ'+IntToStr(UpDown1.Position);
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'Цезар', clRed);
end;
1: begin
RSA_Encrypt; Encrypt2:='ER'+Edit4.Text+'PR'+Edit2.Text;
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'RSA', clRed);
end;
2: begin ShifrVi; Encrypt2:='EV'; end;
3: begin Metod3D; Encrypt2:='EE'; end;
end;
end;

if (Combobox3.ItemIndex <> -1)then begin
a[3]:=Combobox4.ItemIndex;
case a[3] of
0: begin
KodZez; Encrypt3:= 'EZ'+IntToStr(UpDown1.Position);
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'Цезар', clRed);
end;
1: begin
RSA_Encrypt; Encrypt3:='ER'+Edit4.Text+'PR'+Edit2.Text;
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'RSA', clRed);
end;
2: begin ShifrVi; Encrypt3:='EV'; end;
3: begin Metod3D; Encrypt3:='EE'; end;
end;
end;

if (Combobox4.ItemIndex <> -1)then begin
a[4]:=Combobox5.ItemIndex;
case a[4] of
0: begin
KodZez; Encrypt4:= 'EZ'+IntToStr(UpDown1.Position);
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'Цезар', clRed);
end;
1: begin
RSA_Encrypt; Encrypt4:='ER'+Edit4.Text+'PR'+Edit2.Text;
weight:=0;
for i:=1 to length(SourceString) do
  if (ord(SourceString[i]) > 128) then weight:=weight+2 else inc(weight,1);
Series2.AddBar(weight, 'RSA', clRed);
end;
2: begin ShifrVi; Encrypt4:='EV'; end;
3: begin Metod3D; Encrypt4:='EE'; end;
end;
end;
{

if (Combobox5.ItemIndex <> -1)then begin
a[5]:=Combobox6.ItemIndex;
case a[5] of
0: KodZez;
1: RSA_Encrypt;
2: ShifrVi;
3: Metod3D;
end;
end;

if (Combobox6.ItemIndex <> -1)then begin
a[6]:=Combobox7.ItemIndex;
case a[6] of
0: KodZez;
1: RSA_Encrypt;
2: ShifrVi;
3: Metod3D;
end;
end;
}
  if (CheckBox1.Checked = true) then
  begin
  GraphFile:=TStringStream.Create(SourceString);
  //  GraphFile:=TFileStream.Create('C:\Users\Admin\Desktop\graph_save.txt',fmOpenRead);
  MetodLSB;
  end;
end;

initialization
  OleInitialize(nil);

finalization
  OleUninitialize;

end.

