unit FormularioCadena;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls, UCCadena;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    CADENA11: TMenuItem;
    AdicionarPalabra1: TMenuItem;
    InvertirPalabras1: TMenuItem;
    descargar1: TMenuItem;
    Examenes1: TMenuItem;
    DelSubCadena1: TMenuItem;
    SetLongitud1: TMenuItem;
    GetLongitud1: TMenuItem;
    BuscarPalabra1: TMenuItem;
    Delete1: TMenuItem;
    EliminarTodalapalabra1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    BuscarPalabra2: TMenuItem;
    Edit3: TEdit;
    Label1: TLabel;
    BuscarCaracter1: TMenuItem;
    remplazarpalabra1: TMenuItem;
    moverposab1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure AdicionarPalabra1Click(Sender: TObject);
    procedure descargar1Click(Sender: TObject);
    procedure InvertirPalabras1Click(Sender: TObject);
    procedure DelSubCadena1Click(Sender: TObject);
    procedure SetLongitud1Click(Sender: TObject);
    procedure GetLongitud1Click(Sender: TObject);
    procedure BuscarPalabra1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure EliminarTodalapalabra1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BuscarPalabra2Click(Sender: TObject);
    procedure BuscarCaracter1Click(Sender: TObject);
    procedure remplazarpalabra1Click(Sender: TObject);
    procedure moverposab1Click(Sender: TObject);
  private
    { Private declarations }
    cadena1 : Cadena;
  public
    { Public declarations }
    procedure descargar(obj : cadena; v : TStringGrid);
  end;

var
  Form1: TForm1;

implementation
  //procedure cargar(obj : cadena; v : TStringGrid);
{$R *.dfm}

procedure TForm1.AdicionarPalabra1Click(Sender: TObject);
begin
  cadena1.CargarCadena(Edit1.Text);
end;

procedure TForm1.BuscarCaracter1Click(Sender: TObject);
begin
 Label1.Caption := IntToStr(cadena1.BuscarCaracter(StrToInt(Edit1.Text), StrToInt(Edit2.Text), Edit3.Text[1]));

end;

procedure TForm1.BuscarPalabra1Click(Sender: TObject);
begin
 Label1.Caption := IntToStr(cadena1.Posicion(StrToInt(Edit1.Text), StrToInt(Edit2.Text), Edit3.Text));
end;

procedure TForm1.BuscarPalabra2Click(Sender: TObject);
begin
   //edit2.Text := IntToStr(cadena1.BuscarPalabra(Edit1.Text));
   Label1.Caption := IntToStr(cadena1.BuscarPalabra(StrToInt(Edit1.Text), StrToInt(Edit2.Text), Edit3.Text));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  cadena1.CargarCadena(Edit1.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  descargar(cadena1, StringGrid1);
end;

procedure TForm1.Delete1Click(Sender: TObject);
begin
  cadena1.DeletePos(StrToInt(Edit1.Text), StrToInt(Edit2.Text));
end;

procedure TForm1.DelSubCadena1Click(Sender: TObject);
begin
 // cadena1.DelSubCadena(Edit1.Text);
 cadena1.DeleteAllSubPalabra3(Edit1.Text);
end;

procedure TForm1.descargar1Click(Sender: TObject);
begin
  //Edit2.Text := cadena1.ToStr;
  descargar(cadena1, StringGrid1);
end;

procedure TForm1.EliminarTodalapalabra1Click(Sender: TObject);
var  x: String;
begin
  x := Edit1.Text;
  cadena1.DeleteAllPalabra(x);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   cadena1 := Cadena.Create;
// edit1.SetFocus;
end;

procedure TForm1.GetLongitud1Click(Sender: TObject);
begin
  Edit2.Text := IntToStr(cadena1.GetLongitud);
end;

procedure TForm1.InvertirPalabras1Click(Sender: TObject);
begin
  cadena1.InvertirPalabras;
end;

procedure TForm1.moverposab1Click(Sender: TObject);
var i : word;
begin
  i := StrToInt(Edit1.Text);
  cadena1.Mover(i, StrToInt(Edit2.Text), StrToInt(Edit3.Text));
end;

procedure TForm1.remplazarpalabra1Click(Sender: TObject);
var i : word;
begin
  i := StrToInt(Edit1.Text);
  cadena1.Remplazar(i, Edit3.Text);
end;

procedure TForm1.SetLongitud1Click(Sender: TObject);
begin
  cadena1.setLongitud(StrToInt(Edit1.Text));
end;

{ TForm1 }


procedure TForm1.descargar(obj: cadena; v: TStringGrid);
var i : word;
begin
  v.Cells[0, 0] := '';
  v.Cells[0, 1] := '';
  v.ColCount := obj.GetLongitud;
  for i := 1 to obj.GetLongitud do begin
    v.Cells[i-1, 0] := obj.ObtenerCaracter(i);
    v.Cells[i-1, 1] := IntToStr(i);
  end;

end;

end.
