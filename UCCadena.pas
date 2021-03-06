unit UCCadena;

interface
 uses sysutils,math,Vcl.Dialogs;
 Const MaxC = 1024;
       separadores= [' ','.',',',';',':'];
       letras = ['A'..'Z','a'..'z'];
       numeros = ['1','2','3','4','5','6','7','8','9'];
 type
   Cadena = class
     private
       longitud : word;
       caracteres : array [1..Maxc] of char;
       Nombres:array [1..Maxc] of string;
     public
//-------------------------------------------------------------
//Nivel caracter
       function LongCadena(c:string):word;
       procedure AdicionarCaracter (c:char);
       procedure InsertarCaracter (p:byte;c:char);
       Procedure EliminarCaracter (p:byte);
       Procedure EliminarCaracter2 (c:char);
       procedure ModificarCaracter(p:byte;c:char);
       function ObtenerCaracter (p:word):char;
//--------------------------------------------------------------
       procedure ModificarString(s: string);
       function ToStr : string;
//--------------------------------------------------------------
      //darwin
       {procesos}
       procedure CargarCadena(x : String);
       procedure setLongitud(x : word);
       procedure InvertirPalabras;
       procedure DeletePos(posicion, cantidad : word);
       procedure DeleteAllPalabra(palabraBusc : String);
       procedure Remplazar(var pos:word; palabraRempl:String);
       procedure Mover(var pos:word; a, b :word);

       {funciones}
       function GetLongitud : word;
       function nextWord (var i:word):string; overload;
       function nextWord (var a:word; b: word ):string; overload;

       function BuscarPalabra(p:string):word;overload; //Devuelve posici?n
       function BuscarPalabra(a, b :word; palabraBusc: String):word;overload;
       function Posicion( buscPalabra: String): word; overload;
       function Posicion(a, b :word; buscPalabra: String): word; overload;
       function BuscarCaracter(a, b :word; buscCaracter: char): word; overload;
       function EsSubCadena(a, b :word; subCadena: String) : boolean;
       function verifRango(a, b :word; mensaje:String) : boolean;
       {Modelo 2021_1}
       procedure DeleteAllSubPalabra(subPalabra : String);
       procedure DeleteAllSubPalabra2(subPalabra : String);
       procedure DeleteAllSubPalabra3(subPalabra : String);
//--------------------------------------------------------------
//nivel palabra
       Function PalabraN(n:word):string;
       procedure AdicionarPalabra(pal:string);
       procedure InsertarPalabra(pos:byte; pal:string);
       procedure EliminarPalabra(pos,long:word);
       procedure EliminarPalabra2 (c:string);
       procedure BuscarReemplazar(pal1:string ;pal2:String);


       procedure SacarPalabra(var pos:byte; var palabra:string);


       Function CantidadPalabras:byte;

//--------------------------------------------------------------
       function CantidadConsonantes:word;
       procedure InvertirCadena;

       procedure Intercambiar(a,b:word);

       procedure UpperCase;
       Procedure LowerCase;

//----------------------------------------------------------------
        Function Suma:Integer;
        function NextNumero(var i :word):string;
        function Polinomio(x:integer):integer;
        Function CantidadNumeros:byte;
        procedure Prueba();

//-----------------------------------------------------------------
       Function ConvertirHora(c:string):string;
       function Literal2D(n: byte): String;
       function Nextnum (var i :word):string;

       Function FechaMenor :string;      //Sin Terminar
       Function FechaNum (cad:string):cardinal;
       function Nextnumfecha(var i : word):string;

       function RepeteatedNumber :string;

       function LongestWord :string;
       Function RepeatedWord :string;

       Procedure ElimPalVocRep;
       function VerifPalVocRep(pal:string):boolean;

       Procedure OrdenarNombres;       //Corregir
       Function VerifPalMenor:string;
       function NextPal(var i:byte):string;
       procedure EliminarNombre(nom: string);

       Function ConvertirAHoraLitera:string;
       Function ANumeral(cad :string):byte;
//--------------------------------------------------------------------
 //num?ricos
       Function BinarioMayor :string;
       Function ADecimal (cad:string):Cardinal;
//-------------------------------------------------------------------
       Function SumaReal (NDecimales:byte):string;
       Function redondeo(var d:integer; dec:integer; decimales:byte):string;

       procedure ElimPalSubCad (Subcadena:string);
       function VerifSubCad(sub:string;pal:string):boolean;


       procedure DelSubCadena(x: string);


   end;
implementation

{ Cadena }

function Cadena.LongCadena(c:string): word;
begin
   result:=longitud;
end;





procedure Cadena.AdicionarCaracter(c: char);
begin
   longitud:= longitud+1;
   caracteres[longitud]:= c;
end;

procedure Cadena.AdicionarPalabra(pal: string);
var i:word;
begin
  for I := 1 to length(pal) do begin
      inc(longitud);
      caracteres[longitud]:=pal[i];
  end;
end;



procedure Cadena.InsertarCaracter(p: byte; c: char);
var
  i: Word;
begin
 if(p>0) and (p<=longitud) then
 begin
   longitud:=longitud+1;
    for i := longitud downto p+1 do
         caracteres[i]:=caracteres[i-1];
    caracteres[p]:=c;
 end else raise Exception.Create('Posici?n fuera de rango');
end;

procedure Cadena.InsertarPalabra(pos: byte; pal: string);
var i,n,k:word;
begin
if (pos>0) and (pos<=longitud) then
begin
n:=length(pal);
  longitud:=longitud+n;
  for I := longitud downto pos+n do
         caracteres[i]:=caracteres[i-n];
  k:=1;
  for I := pos to pos-1+n do begin
         caracteres[i]:=pal[k];
         inc(k);
  end;
  dec(longitud);
end else raise Exception.Create('Posici?n fuera de rango');

end;

procedure Cadena.EliminarCaracter(p: byte);
var i:byte;
begin
 if (p>0) and (p<=Longitud) then
    begin
    for i := p to longitud-1 do
         caracteres[i]:=caracteres[i+1];
     longitud:=longitud-1;
 end else raise Exception.Create('Posici?n fuera de rango');

end;

procedure Cadena.ModificarCaracter(p: byte; c: char);
begin
if (p>0) and (p<=longitud) then  begin
caracteres[p]:=c;
end else raise Exception.Create('Posici?n fuera de Rango')
end;


function Cadena.ObtenerCaracter(p: word): char;
begin
if (p>0) and (p<=longitud) then
  result:= caracteres[p]
else
  raise Exception.Create('Posici?n fuera de rango');
end;


//----------------------------------------------
procedure Cadena.ModificarString(s: string);
var
  I: Integer;
begin
   longitud := length(s);
   for I := 1 to longitud do
       caracteres[i]:= s [i];
end;



procedure Cadena.Mover(var pos: word; a, b: word);
var  i : word;
     n : integer;
begin
  n := b-a+1;
  if (n > 0) and (pos < longitud) then
  begin
    for i := a to b do
    begin
      caracteres[pos] := caracteres[i];  
      inc(pos)
    end;
  end;
end;

function Cadena.ToStr: string;
var s:string;   i:word;
begin
s:='';
for I := 1 to longitud do
     s:=s+caracteres[i] + ', ';
result:=s;
end;

//-----------------------------------------------

function Cadena.CantidadConsonantes: word;
var i,cont:word;
begin
cont:=0;
   for I := 1 to longitud do
    begin
    if ((caracteres[i] in ['b'..'z']) and not (caracteres[i] in ['e','i','o','u']))
         OR (caracteres[i] in ['B'..'Z']) and not (caracteres[i] in ['E','I','O','U'])  then
       inc(cont);
    end;
 result:=cont;
end;



procedure Cadena.InvertirCadena;
var i,r:word;
begin
r:=longitud;
   for i := 1 to (longitud div 2) do
      begin
        intercambiar(i,r);
        dec(r);
      end;
end;

{
"hola como estas" --> "estas como hola "
}
procedure Cadena.InvertirPalabras;
var i : word;
    pal, aux : String;
begin
  i := 1;
  aux := '';
  while (i <= longitud) do begin
    pal := nextWord(i);
    aux := pal +' '+ aux;
  end;
  //insertar aux en el vector
  CargarCadena(aux);
  longitud := longitud - 1;
end;

{
 CargarCadena("hola como") --> "[caracteres] = "hola como"
}
procedure Cadena.CargarCadena(x: String);
var i : byte;
begin
  longitud := x.Length;
   for I := 1 to longitud do
    caracteres[i] := x[i];
//    Inc(longitud);
end;

procedure Cadena.Intercambiar(a, b: word);
var aux:char;
begin
  aux:=caracteres[a];
  caracteres[a]:=caracteres[b];
  caracteres[b]:=aux;
end;

procedure Cadena.UpperCase;
var
  I: Integer;  //A may?sculas
begin
 for I := 1 to longitud do
   begin
     if caracteres[i] in ['a'..'z'] then
     begin
        caracteres[i]:=  chr(ord(caracteres[i])-32);
     end;

     case caracteres[i] of
          '?':caracteres[i]:='?';
          '?':caracteres[i]:='?';
          '?':caracteres[i]:='?';
          '?':caracteres[i]:='?';
          '?':caracteres[i]:='?';
          '?':caracteres[i]:='?';
     end;

      end;
end;

procedure cadena.LowerCase;    //a minusculas
var
    i:word;
begin
    for I := 1 to longitud do
    begin
     if caracteres[i] in ['A'..'Z'] then
       begin
         caracteres[i]:= chr(ord(caracteres[i])+32)       //(chr(ord(caracteres[i]))+32);
       end;
       //if caracteres[i] = '?' then caracteres[i]:= '?';
       case caracteres[i] of
         '?':caracteres[i]:='?';
         '?':caracteres[i]:='?';
         '?':caracteres[i]:='?';
         '?':caracteres[i]:='?';
         '?':caracteres[i]:='?';
         '?':caracteres[i]:='?';
         end;
    end;
end;

function Cadena.CantidadPalabras: byte;
var
  I: Integer; contador:byte;
begin
 i:=1;
 contador:=0;
while i<longitud do
  begin
     if not (caracteres[i] in Separadores) and
     (caracteres[i+1] in Separadores) then begin
         inc(Contador);
     end;
     inc(i);
  end;
  if not (caracteres[i] in Separadores) then
    inc(contador);

result:=contador;
end;




{
 [h,o,l,a, ,c,o,m,o, ,e,s,t,a,s]
 PalabraN(n = 2)--> "como"
}
function Cadena.PalabraN(n: word): string;
var k:word;   pal:string;
begin
  if (n>0) and (n<= CantidadPalabras) then
  begin
     k:=1;
     while n>0 do     //n = 2, 1, 0
       begin
         pal:=nextWord(k); //hola, como
         dec(n);
       end;
       result:=pal;
  end
  else raise Exception.Create('La posici?n no es v?lida');


end;
//----------------------------------------------------------------------
procedure Cadena.EliminarPalabra(pos, long: word);
var i:word;
begin
inc(longitud);
 if (pos>0) and (pos<=Longitud) then
    begin
    for i := pos to longitud-long do
         caracteres[i]:=caracteres[i+long];
     longitud:=longitud-long;
 end else
 raise Exception.Create('Posici?n fuera de rango o no existe tal palabra');

end;

procedure Cadena.EliminarCaracter2(c: char);
var
  k: Integer;
begin
  for k := 1 to longitud do
   begin
     if caracteres[k] = c then eliminarcaracter(k);
   end;
end;



procedure Cadena.EliminarPalabra2(c: string);
var t:byte;
begin
    repeat
     t:=buscarpalabra(c);
       if t>0 then eliminarPalabra(t,length(c));
    until (t=0)    ;
end;






//-----------------------------------------------------------------------










Function Cadena.BuscarPalabra(p: string): word;    //retorna la posici?n inicial
var
    i, pos  : word;
    palabra :string;
begin
   i := 1; pos := 0;
  repeat
    palabra:= nextWord(i);
  until (not(i <= longitud)) or (palabra = p);
  if palabra = p then
    pos:=i-length(p);
  result:=pos;
end;
//--------------------------------------------------------------
function Cadena.BuscarCaracter(a, b: word; buscCaracter: char): word;
var pos : word;
begin
  if verifRango(a, b, 'BuscarCaracter') then begin
    pos := 0;
    while (a <= b) and (caracteres[a] <> buscCaracter) do
      inc(a);
    if a <= b then
      pos := a;
    Result := pos;
  end;

end;

function Cadena.BuscarPalabra(a, b: word; palabraBusc: String): word;
var
     pos  : word;
    palabra :string;
begin
  pos := 0;
  if (a >= 1) and (b <= longitud) then begin
    repeat
      palabra:= nextWord(a, b);
    until (not(a <= b)) or (palabra = palabraBusc);
    if palabra = palabraBusc then
      pos := a-length(palabraBusc);
    result:=pos;
  end else raise Exception.Create('BuscarPalabra: Posici?n fuera de rango');
end;

procedure Cadena.BuscarReemplazar(pal1:string; pal2: String);
var pos,long1:word;
begin
   pos:=buscarPalabra(pal1);
   long1:=length(pal1);
   eliminarPalabra(pos,long1);
   insertarPalabra(pos,pal2);
end;

//-----------------------------------------------------------------------


function cadena.nextWord(var i: word): string;
var p:string;  a:word;
begin
if (i>0) and (i<=longitud) then begin
  while (i<=longitud) and (caracteres[i] in separadores) do
      inc(i);
  p:='';
  while (i<=longitud) and not (caracteres[i] in separadores) do
  begin
      p:=p+caracteres[i];
      inc(i);
  end;
   result:=p;
end else raise Exception.Create('fin')

end;


//-----------------------------------------------------------------------
  //polinomio

function Cadena.Polinomio(x: integer): integer;
var a,k,h:byte; suma,pc:integer;  i:word;   sublongitud:byte;   p:string;
begin
  while a<=longitud do begin     //elimina 'x' y ' ' para que solo sume
      if caracteres[a] in [' '] then begin
       EliminarCaracter(a);
       dec(a);
      end;
    inc(a);
  end;
suma:=0;
i:=1;
h:=1;
k:=cantidadNumeros;
  while h<=k do begin

     p:=(NextNumero(i));
     sublongitud:=length(p);
     if (p[sublongitud] = 'x') and (p[sublongitud-1] in ['0'..'9']) then begin
       delete(p,sublongitud,1);
       pc:= StrToInt(p)* x ;
       p:=IntToStr(pc);
     end;

     if (p[sublongitud] = 'x') and (p[sublongitud-1] = 'x')
     or (p[sublongitud-2] in ['0'..'9']) then begin
       delete(p,sublongitud-1,2);
        if p='' then  p:='1';
        if p='-' then  p:='-1';

       pc:= StrToInt(p)* x * x ;
       p:=IntToStr(pc);
     end;

     if p= '-x'  then begin pc:=-1*x; p:=IntToStr(pc);
     end;
     if (p ='+x') or (p = 'x')  then begin pc:=x; p:=IntToStr(pc);
     end;


       suma:=suma+ StrToInt(p);
       inc(h);
  end;
  result:=suma;
end;



{Retorna la posicion donde encontro la sub cadena
 "hola como estas": Posicion(buscPalabra='como') ==> 6
 "hola como estas": Posicion(buscPalabra='ta') ==> 13
 "hola como estas": Posicion(buscPalabra='xo') ==> 0
 }
function Cadena.Posicion(a, b: word; buscPalabra: String): word;
var
    p : word;
begin
  if verifRango(a,b,'Posicion(a,b)') then begin
    p := 0;
    repeat
      p := BuscarCaracter(a+p, b, buscPalabra[1]);//13
    until(p = 0)or ((p > 0) and (EsSubCadena(p, b, buscPalabra)));
    result := p;
  end;
end;

{Retorna la posicion donde encontro la sub cadena
 "hola como estas": Posicion(buscPalabra='como') ==> 6
 "hola como estas": Posicion(buscPalabra='es') ==> 11
 }
function Cadena.Posicion(buscPalabra: String): word;
var p, k, i, n : word;
       palabra : string;
begin
  i := 1;  k := 1;  p := 0;
  n := buscPalabra.Length;
  while (i <= longitud)and(k <= n) do begin
    while (k <= n)  and (caracteres[i+k-1] = buscPalabra[k]) do
      inc(k);

    if ( (k <= n)) then k := 1 else  p := i;
    inc(i);
  end;
  result := p;
end;

function Cadena.NextNumero(var i: word): string;   // revisar
var p:string;  a:word;
begin

  p:=caracteres[i];
  inc(i);
if (i>0) and (i<=longitud) then
begin
  while (i<=longitud) and not (caracteres[i] in [' ',',','.']) do
  begin
      p:=p+caracteres[i];
      inc(i);
  end;
  a:=length(p);
  if p[a]=' ' then delete(p,a,1);
   if p[1]=' ' then delete(p,1,1);

   result:=p;
end else raise Exception.Create('Fin')
end;



function Cadena.CantidadNumeros: byte;
var
  I: Integer; contador:byte;
begin
 i:=1;
 contador:=0;
while i<longitud do
  begin
     if not (caracteres[i] in ['+','-']) and
     (caracteres[i+1] in ['+','-']) then begin
         inc(Contador);
     end;
     inc(i);
  end;
  if not (caracteres[i] in ['+','-']) then
    inc(contador);

result:=contador;

end;

procedure Cadena.Prueba;
var a:byte;
begin
  a := 1;
  while a<=longitud do begin
      if caracteres[a] in [' '] then begin
       EliminarCaracter(a);
       dec(a);
      end;
    inc(a);
  end;

end;





//--------------------------------------------------------------------
function Cadena.Literal2D(n: byte): String;
Const
unidades:array [0..15] of string =
('','uno','dos','tres','cuatro','cinco','seis','siete','ocho','nueve','diez',
'once','doce','trece','catorce','quince');
Veinte:array [1..2] of string = ('dieci','veinti');
decenas:array [2..9] of string = ('veinte','treinta',
'cuarenta','cincuenta','sesenta','setenta','ochenta','noventa');
begin
  if n<16 then   result:= unidades[n];
  if (n>=16) and (n<20) then result :=veinte[n div 10]+unidades[n mod 10];
  if (n>=21) and (n<30) then  result:= veinte[n div 10]+unidades[n mod 10];
  if (n>=30) then result := decenas[n div 10]+' y '+ unidades[n mod 10];
  if n in [20,30,40,50,50,70,80,90] then result:= decenas[n div 10];
end;



function Cadena.ConvertirHora(c: string): string;
var i:word; hora,minuto,segundos:byte;
    reloj,lithora,litminuto,litsegundo:string;
begin
i:=1;
  hora:= StrToInt(nextnum(i));      lithora:=literal2d(hora);
  minuto:= StrToInt(nextnum(i));    litminuto:=literal2d(minuto);
  segundos:= StrToInt(nextnum(i));   litsegundo:=literal2d(segundos);

  reloj:= lithora+' horas con '+ litminuto+' minutos y '+litsegundo+' segundos';

  if ((hora >= 0) and( hora < 24)) and ((minuto>=0) and (minuto<60)) and
  ((segundos>=0) and (segundos<60)) then
   result:=reloj
  else raise Exception.Create('Hora no v?lida');
end;

//----------------------------------------------------------------


{Elimina una palabra de todo el vector
"hola como hola": DeleteAllPalabra(palabraBusc='hola')
 "hola o estas"}
procedure Cadena.DeleteAllPalabra(palabraBusc: String);
var pos : word;
begin
  pos := 1;
  repeat
    pos := Posicion(pos, longitud, palabraBusc);
    if pos > 0 then
      DeletePos(pos, palabraBusc.Length);
  until (pos = 0);
end;
{Elimina toda la sub cadena de todo el vector
"hola como hola": DeleteAllSubPalabra(subPalabra='ho')
 "como"}
procedure Cadena.DeleteAllSubPalabra(subPalabra: String);
var i, posInicialPalabra : word;
aux : Cadena;
begin
  aux := Cadena.Create;
  i := 1;
  while i <= longitud do begin
    aux.CargarCadena(nextWord(i));
    if (aux.Posicion(subPalabra) > 0) then begin  //encontro la sub cadena
      posInicialPalabra := i - aux.longitud;
      DeletePos(posInicialPalabra, i);
      i := posInicialPalabra;
    end;
  end;
end;

//falta terminar
procedure Cadena.DeleteAllSubPalabra2(subPalabra: String);
var 
    i,  posInicialDeLaPalabra, k, a, b : word;
    palabra : String;
begin
  i := 1; 
  k := 0;
  while (i <= longitud) do begin
    palabra := nextWord(i);  
    posInicialDeLaPalabra := i - length(palabra);
    if (posicion(posInicialDeLaPalabra,i-1, subPalabra) > 0) then begin
        if (posInicialDeLaPalabra > 1)  then begin
          mover(k,a, posInicialDeLaPalabra-1 );        
        end;
        a := i;    
    end;
  end;
  if ( k <> 0) then
    longitud := k-1;
end;


procedure Cadena.DeleteAllSubPalabra3(subPalabra: String);
var i, posInicialDeLaPalabra : word;
    palabra : string;
begin
  i := 1;
  while i <= longitud do begin
    palabra := nextWord(i);
    posInicialDeLaPalabra := i - length(palabra);
    if (posicion(posInicialDeLaPalabra,i-1, subPalabra) > 0) then begin //encontro la sub cadena
      DeletePos(posInicialDeLaPalabra, length(palabra));
      i :=  posInicialDeLaPalabra;
    end;
  end;
end;

//----------------------------------------------------------------

{Elimina desde una posicion la cantidad de elementos
 "hola como estas": DeletePos(posicion=6, cantidad=3)
 "hola o estas" }
procedure Cadena.DeletePos(posicion, cantidad : word);
var i: word;
begin
  if (posicion >= 1)and(posicion <= longitud) then begin
    if (posicion+cantidad) > longitud then begin
      longitud := posicion - 1;
    end else begin
      for i := posicion+cantidad to longitud do
        caracteres[i-cantidad] := caracteres[i];
      longitud := longitud - cantidad;
    end;
  end;
end;

//----------------------------------------------------------------
function Cadena.FechaMenor: string;
var i:word;    menor,fecha2:string;
begin
i:=1;
   menor:=nextword(i);
   while i<=longitud do
    begin
      fecha2:=nextword(i);
      if (FechaNum(fecha2))< (fechaNum(menor)) then
          menor:=fecha2;
    end;
result:=menor;
end;

function Cadena.FechaNum(cad: string): cardinal;
var n,i: Byte;
      r, resultado:string;
begin
  n := Length(cad);
  resultado := '';
  for I := 1 to n do begin
    if cad[i]<>'-' then begin
      r := r +cad[i]   //r =10
    end else begin
      resultado := r + resultado;
      r:=''
    end;
  end;
  result := StrToInt(r+resultado);
end;

{Retorna la cantidad de elementos que tiene el vector}
function Cadena.GetLongitud: word;
begin
result :=longitud;
end;

{var i,k:word;  fecha,r,resultado:string;
begin
resultado:='';
fecha:='';
  for I := 1 to length(cad) do
  begin
       if cad[i] <> '-' then begin
          r:= r+cad[i]
     end else begin
          resultado:=r+resultado;
          r:='';
     end;
  end;
  result:=StrtoInt(r+resultado);
end;
{fecha:='';
i:=1;
  for k := 1 to 3 do
     fecha:=Nextnumfecha(i)+fecha;
result:=StrToInt(fecha);
end;}

function Cadena.Nextnumfecha(var i: word): string;
var p:string;
begin

 while (i<=longitud) and (caracteres[i] in ['-',' ']) do
        inc(i);
 p:='';
 while (i<=longitud) and (caracteres[i] in ['0'..'9']) do begin
        p:=p+caracteres[i];
        inc(i);
 end;
  result:=p;
end;



//--------------------------------------------------
function Cadena.LongestWord: string;
var k:word;   mayor,siguiente:string;
begin
  k:=1;
  mayor:=nextword(k);
  while k <=longitud do begin
     siguiente:=nextword(k);
     if length(siguiente) > length(mayor) then
        mayor:=siguiente;
  end;
 result:=mayor;
end;


procedure Cadena.Remplazar(var pos: word; palabraRempl: String);
var i, n :word;
begin
  i := pos;  
  n := Length(palabraRempl);
  while ((pos>=1) and(pos<=longitud)) and ((pos-i+1)<=n) do begin
     ModificarCaracter(pos,palabraRempl[pos-i+1]);
     inc(pos);
  end;
end;

function Cadena.RepeatedWord: string;
var i ,k,Veces,CantRep:word;
repetida,siguiente,pal:string;
begin

 veces:=0;
 for i := 1 to cantidadPalabras do
   begin
      //pal := nextword(i);
      CantRep:=0;
      for k := 1 to CantidadPalabras do
        begin
//          siguiente:=nextword(k);
          if pal = siguiente then
            begin
                inc(CantRep);
            end;
        end;
      if CantRep >= veces then       //si es la primera m?s repetida >
       begin                        //si es la ?ltima m?s repetida >=
         veces:=CantRep;
         Repetida:=pal;
       end;

   end;
  result:=repetida;
end;

procedure Cadena.ElimPalSubCad(Subcadena: string);
var  i:word; pal:string;
begin
//i:=1;
//inc(longitud); caracteres[longitud]:=' ';
while i<=longitud do
  begin
   pal:=nextword(i);
    //if length(subcadena)< length(pal) then
    //begin
     if (VerifSubCad(Subcadena,pal))  then
         begin
          EliminarPalabra2(pal);  i:=1;
         end;
    //end;

  end;
end;

function Cadena.VerifSubCad(sub: string; pal:string): boolean;
var a,c,k:byte;   verif:byte;
    b:boolean;
begin
b:=false;
       //sub= na  pal=una
 a:=1;   c:=1;
  while (c <= length(pal) ) do begin
     if sub[1] = pal[a] then
      c:= length(pal)+1
      else inc(a);
  end;
  verif:=0;
  for k := 1 to length(sub) do
     if sub[k]= pal[a] then   inc(verif);

 if verif = length(sub) then b:=true;


  result:=b;
end;


procedure Cadena.ElimPalVocRep;
var  i:word; pal:string;
begin
i:=1;
inc(longitud); caracteres[longitud]:=' ';
while i<=longitud do
  begin
   pal:=nextword(i);
     if verifPalVocRep(pal) then
      begin
           EliminarPalabra2(pal);  i:=1;
      end;
  end;
end;



function Cadena.VerifPalVocRep(pal: string): boolean;
var CA,CE,CI,CO,CU,long,k:byte;

begin
  long:=length(pal); CA:=0; CE:=0; CI:=0;CO:= 0; CU:=0;

  for k := 1 to long do
   Begin
    if pal[k] in ['a','A','?','?'] then  inc(CA);
    if pal[k] in ['e','E','?','?'] then  inc(CE);
    if pal[k] in ['i','I','?','?'] then  inc(CI);
    if pal[k] in ['o','O','?','?'] then  inc(CO);
    if pal[k] in ['u','U','?','?','?','?'] then  inc(CU);
   End;
  if (CA>1) or (CE>1) or (CI>1)or (CO>1) or (CU>1) then
     result:=true
     else result:=false;
end;


function Cadena.verifRango(a, b: word; mensaje:String): boolean;
begin
  if (a >= 1) and (b <= longitud) then begin
    result := true;
  end else raise Exception.Create(mensaje + ': Fuera del rango')
end;

procedure Cadena.OrdenarNombres;
var z ,m,k,Cant:word; construir,menor:string;  extra:string;

begin
m:=1;
construir:='';
Cant:= CantidadPalabras+1;   //5
//while caracteres[longitud] in separadores do
//dec(longitud);    // elimina basura del final
//longitud:=longitud+4;
extra:=' zzz';
for z := 1 to 4 do begin
    inc(longitud);
    caracteres[longitud]:=extra[z];
end;

  while (m<= Cant) {or (i<=longitud)} do
   begin
     menor:=verifPalMenor;
     ShowMessage(menor);
     Construir:=construir+menor+' ';
     EliminarPalabra2(menor);
     ShowMessage(construir);
     inc(m);
   end;
      //Carlos, Pedro, Luis, Sof?a, Ana
   longitud:=1;
  for k := 1 to length(Construir)-3  do  begin
     caracteres[k]:=construir[k];
     inc(longitud);
  end;
end;

function Cadena.NextPal(var i: byte): string;
begin
    result:=nombres[i];
end;

function Cadena.nextWord(var a: word; b: word): string;
var p:string;
begin
  if (a>=1) and (b<=longitud) then begin
    while (a<=b) and (caracteres[a] in separadores) do
        inc(a);
    p:='';
    while (a<=b) and not (caracteres[a] in separadores) do
    begin
        p:=p+caracteres[a];
        inc(a);
    end;
     result:=p;
  end else raise Exception.Create('nextWord: Fuera de rango')

end;

procedure Cadena.EliminarNombre(nom: string);
begin
   //nada
end;

function Cadena.VerifPalMenor: string;
var i:word;  menor,siguiente:string;
begin
i:=1;
menor:=nextword(i);
  while i<=longitud do
   begin
      siguiente:=nextword(i);
      if siguiente < menor then
          menor:=siguiente;
   end;
   result:= menor;
end;

function Cadena.RepeteatedNumber: string;
var veces,i,k,CantRep:word; num,siguiente,repetida:string;
begin
  veces:=0;
  for I := 1 to longitud do //-1 do
    begin
       num:=caracteres[i]; //+caracteres[i+1];
       cantRep:=0;
       for K := 1 to longitud do //-1 do
        begin
           siguiente:= caracteres[k];//+ caracteres[k+1];
           if num =siguiente then
              inc(CantRep);
        end;
        if cantRep > veces then
           begin
             veces:=CantRep;
             repetida:=num;
           end;
    end;
result:=repetida;
end;
//--------------------------------------------------------------
{
 "hola como estas"   EsSubCadena(1, 4, ho)
}
function Cadena.EsSubCadena(a, b: word; subCadena: String): boolean;
var
    k, n : word;
    sw : boolean;
begin
  if verifRango(a, b,'EsSubCadena') then begin
    sw := false;
    k := 1;
    n := Length(subCadena);
    while(a <= b) and (k <= n)and(caracteres[a] = subCadena[k]) do begin
      inc(a);
      inc(k);
    end;
    if (k > n) then
      sw := true;
    result := sw;
  end;
end;

function Cadena.ConvertirAHoraLitera: string;
var i:word; hora,minuto,segundo,pal:string;
begin
   i:=1;
   hora:=nextword(i);
   pal:=nextword(i);
   pal:=nextword(i);
   minuto:='';
   while ((pal <> 'con') and (i<=longitud)) do
    begin
       minuto:=minuto+pal;
       pal:=nextword(i);
    end;
    segundo:='';
    while i<=longitud do
      begin
        segundo:=segundo+nextword(i);
      end;
 result:= IntToStr(ANumeral(hora))+':'+ IntToStr(ANumeral(minuto)) +':'+ IntToStr(ANumeral(Segundo));
end;

function Cadena.ANumeral(cad: string): byte;
var num:byte;
begin
    num:=0;
     if cad='uno' then   num:=1
     else if cad='dos' then   num:=2
     else if cad='tres' then   num:=3
     else if cad='cuatro' then   num:=4
     else if cad='cinco' then   num:=5
     else if cad='seis' then   num:=6
     else if cad='siete' then   num:=7
     else if cad='ocho' then   num:=8
     else if cad='nueve' then   num:=9
     else if cad='diez' then   num:=10
     else if cad='once' then   num:=11
     else if cad='doce' then   num:=12
     else if cad='trece' then   num:=13
     else if cad='catorce' then   num:=14
     else if cad='quince' then   num:=15
     else if cad='dieciseis' then   num:=16
     else if cad='diecisiete' then   num:=17
     else if cad='dieciocho' then   num:=18
     else if cad='diecinueve' then   num:=19
     else if cad ='veinte' then   num:=20
     else if cad ='veintiuno' then   num:=21
     else if cad ='veintidos' then   num:=22
     else if cad ='veintitres' then   num:=23
     else if cad ='veinticuatro' then   num:=24
     else if cad ='veinticinco' then   num:=25
     else if cad ='veintiseis' then   num:=26
     else if cad ='veintisiete' then   num:=27
     else if cad ='veintiocho' then   num:=28
     else if cad ='veintinueve' then   num:=29
     else if cad ='treinta' then   num:=30
     else if cad ='treintayuno' then   num:=31
     else if cad ='treintaydos' then   num:=32
     else if cad ='treintaytres' then   num:=33
     else if cad ='treintaycuatro' then   num:=34
     else if cad ='treintaycinco' then   num:=35
     else if cad ='treintayseis' then   num:=36
     else if cad ='treintaysiete' then   num:=37
     else if cad ='treintayocho' then   num:=38
     else if cad ='treintaynueve' then   num:=39
     else if cad ='cuarenta' then  num:=40
     else if cad ='cuarentayuno' then  num:=41
     else if cad ='cuarentaydos' then  num:=42
     else if cad ='cuarentaytres' then  num:=43
     else if cad ='cuarentaycuatro' then  num:=44
     else if cad ='cuarentaycinco' then  num:=45
     else if cad ='cuarentayseis' then  num:=46
     else if cad ='cuarentaysiete' then  num:=47
     else if cad ='cuarentayocho' then  num:=48
     else if cad ='cuarentaynueve' then  num:=49
     else if cad ='cincuenta' then   num:=50
     else if cad ='cincuentayuno' then   num:=51
     else if cad ='cincuentaydos' then   num:=52
     else if cad ='cincuentaytres' then   num:=53
     else if cad ='cincuentaycuatro' then   num:=54
     else if cad ='cincuentaycinco' then   num:=55
     else if cad ='cincuentayseis' then   num:=56
     else if cad ='cincuentaysiete' then   num:=57
     else if cad ='cincuentayocho' then   num:=58
     else if cad ='cincuentaynueve' then   num:=59 ;

 result:=num;
end;

//--------------------------------------------------------------

{
function Cadena.FechaMenor: string;   ---
var i:word;    menor,fecha2:string;
begin
i:=1;
   menor:=nextword(i);
   while i<=longitud do
    begin
      fecha2:=nextword(i);
      if (FechaNum(fecha2))< (fechaNum(menor)) then
          menor:=fecha2;
    end;
result:=menor;
end;}

function Cadena.BinarioMayor: string;
var mayor,siguiente:cardinal ; i:word;
begin
i:=1;
 mayor:=ADecimal(NextNum(i)); //1001
 //showMessage (IntToStr(i));
 while i<=longitud do  //i=5
   begin
     siguiente:=ADecimal(nextNum(i));  //1110
     //showMessage (IntToStr(siguiente));
    //      14     >    9
     if siguiente > mayor then
       begin
        mayor:=siguiente;  //14
       end;
   end;
 result:=IntToStr(mayor);
end;

function Cadena.ADecimal(cad: string): Cardinal;
var num:cardinal; a:integer; p:byte;
begin
p:=0;
num:=0;
a:=length(cad);
 // for I :=  length(cad) downto 1  do begin
   while p<length(cad) do
    begin
    num:=(StrToInt(cad[a]) * trunc(power(2,p)))+num;
    dec(a);
    inc(p);
  end;
result:=num;

end;

function Cadena.SumaReal(NDecimales: byte): string;
var i:word; b:boolean; num,dec,ent,real,d:integer;
begin
i:=1;
b:=true;
dec:=0; ent:=0;
real := 0;
 while i<= longitud do
 begin
 num:=StrToInt(nextnum(i));
   if (caracteres[i] = '.') or (b) then
     begin
       real:=num;
       Ent:=ent+real;
       b:=false;
     end else
     begin
       // ConvertirDec(num); ( si hay negativo son 9 char (8 num y el '-')
       //si es positivo solo son (8 digitos))
        if real<0 then dec:= dec + num*-1
        else dec:=dec+num;
        b:=true;
     end;
 end;
  d:=0;
 dec:=StrToInt(redondeo (d,dec,NDecimales));
  ent:=ent+d;
 result:= IntToStr(ent)+'.'+IntToStr(dec); //IntToStr(sumaEntera)+'.'+IntToStr(SumaDecimal);
end;
function Cadena.redondeo(var d: integer; dec: integer; decimales: byte): string;
var cad:string;       i:byte;
begin
  i := 1;
  while i <= decimales do

    cad:=IntToStr(dec); // -123
     if not (cad[1] in ['0'..'9']) then begin
      d:=StrToInt(cad[1]+cad[2]);
      i:=3;
     end else
      begin
        d:=StrToInt(cad[1]);
        i:=2;
      end;


    result:='1';
end;

function Cadena.Suma: Integer;    //falta agregar la resta
var i,num:word; suma:integer;
begin
i:=1;
suma:=0;
   while i<=longitud do
   begin
     num:=StrToInt(NextNumero(i));

      suma:=suma+num;
   end;
result:=suma;
end;


function Cadena.Nextnum(var i: word): string;
var p:string;
begin
if (i>0) and (i<=longitud) then begin
  while (i<=longitud) and (caracteres[i] in separadores) do
      inc(i);
  p:='';
  while (i<=longitud) and not (caracteres[i] in separadores) do
  begin
      p:=p+caracteres[i];
      inc(i);
  end;
  //a:=length(p);
  //if p[a]=' ' then delete(p,a,1);
  // if not ( p[1] in ['a'..'z','A'..'Z']) then delete(p,1,1);

   result:=p;
end else raise Exception.Create('fin')
end;
{

}
procedure Cadena.DelSubCadena(x: string);
var i, j, p:Byte;
    pal : string;
begin
  i := 1;
  pal := '';
  p := 0;
  while (i <= longitud) do begin
     SacarPalabra(i, pal);
     if pal<> '' then begin
        if Pos(x, pal) = 0 then begin //no encontro la palabra
          for j := 1 to length(pal) do begin  //cargamos la palabra
            caracteres[p+j] := pal[j];
          end;
          p := p + Length(pal)+1;
          caracteres[p] := ' ';
        end;

     end;
  end;
  longitud := p;
end;


procedure Cadena.SacarPalabra(var pos: byte; var palabra: string);
begin
   palabra:='';
    while (pos<=longitud) and (caracteres[pos] in separadores) do
        inc(pos);
    while (pos<=longitud) and (not (caracteres[pos] in separadores)) do
      begin
        palabra:=palabra+ caracteres[pos];
        inc(pos);
      end;

end;

procedure Cadena.setLongitud(x: word);
begin
  longitud := x;
end;

end.
