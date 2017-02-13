unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit2, uMain, Unit4;

{$R *.dfm}

procedure TForm3.BitBtn3Click(Sender: TObject);
begin
Form2.Show;
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
Form1.Show;
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
begin
Form4.Show;
end;

end.
