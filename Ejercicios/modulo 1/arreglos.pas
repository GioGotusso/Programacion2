program arreglos;

const
    dimF = 8;  {Dimensión física del vector}

type

    vector = array [1..dimF] of LongInt;

    dim = 0..dimF;


{-----------------------------------------------------------------------------
CARGARVECTOR - Carga nros aleatorios entre 0 y 100 en el vector hasta que
llegue el nro 99 o hasta que se complete el vector}
Procedure cargarVector ( var vec: vector; var dimL: dim);
var
   d: integer;
begin
     Randomize;  { Inicializa la secuencia de random a partir de una semilla}
     dimL := 0;
     d:= random(100);
     while (d <> 99)  and ( dimL < dimF ) do begin
           dimL := dimL + 1;
           vec[dimL] := d;
           d:= random(100);
     end;
End;



{-----------------------------------------------------------------------------
IMPRIMIRVECTOR - Imprime todos los nros del vector }
Procedure imprimirVector ( var vec: vector; var dimL: dim );
var
   i: dim;
begin
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     write (' ');
     for i:= 1 to dimL do begin
        if(vec[i] < 9)then
            write ('0');
        write(vec[i], ' | ');
     end;
     writeln;
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     writeln;
End;

function max(v:vector; ini,diml:dim): integer;
var
  x: integer;
begin
  if (ini = diml) then
      max:= v[ini]
  else begin
    x := max(v,(ini+1),diml);
    if (v[ini]< x ) then
      max:= x
    else
      max := v[ini];
  end;

end;

function min(v:vector; ini,diml:dim): integer;
var
  x: integer;
begin
  if (ini = diml) then
      min:= v[ini]
  else begin
    x := min(v,(ini+1),diml);
    if (v[ini]> x ) then
      min:= x
    else
      min := v[ini];
  end;

end;

function suma (v:vector; ini,diml:dim):integer;
var x : integer;
begin
  if (ini = diml) then
    suma:= v[ini]
  else
    suma:= v[ini] + suma(v,(ini+1),diml);
end;

{PROGRAMA PRINCIPAL}
var
   v: vector;
   dimL : dim;

begin

     cargarVector(v,dimL);

     writeln('Nros almacenados: ');
     imprimirVector(v, dimL);
     writeln('Nro Maximo ',max(v,1,dimL));
     writeln('Nro Minimo ', min(v,1,dimL));
     writeln('Suma ', suma(v,1,dimL));
     readln;
end.

