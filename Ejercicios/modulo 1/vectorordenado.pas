program vectorordenado;

const
    dimF = 8;  {Dimensión física del vector}

type

    vector = array [1..dimF] of integer;

    dim = 0..dimF;

{-----------------------------------------------------------------------------
CARGARVECTORORDENADO - Carga ordenadamente nros aleatorios entre 0 y 100 en el
vector hasta que llegue el nro 99 o hasta que se complete el vector}

Procedure cargarVectorOrdenado ( var vec: vector; var dimL: dim);
var
   d, pos, j: integer;
begin
    Randomize;  { Inicializa la secuencia de random a partir de una semilla}
    dimL := 0;
    d:= random(100);
    while (d <> 99)  and ( dimL < dimF ) do begin
       pos:= 1;
       while (pos <= dimL) and (vec[pos]< d) do pos:= pos + 1;
       for  j:= dimL downto pos do vec[j+1]:= vec[j] ;
       vec[pos]:= d;
       dimL := dimL + 1;
       d:= random(100)
     end;
end;

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

{-----------------------------------------------------------------------------
ORDENAR VECTOR}
function ordenarv (v:vector; x, ini, diml: integer): integer;
var
  j: integer;
begin
  j:= ((diml - ini) div 2) + ini;
  if (x= v[j]) then
    ordenarv := j
  else begin
    if ((diml - ini)= 0) then
      ordenarv:= 0
    else begin
      if (x < v[j]) then
        ordenarv:= ordenarv(v,x,ini,(j-1))
      else
        ordenarv:= ordenarv(v,x,(j+1),diml);
    end;
  end;
end;

procedure ordenarvec (v:vector; x, pos, diml: integer; var g: integer);       {como prceso el modulo funciona correctamente}
var
  j: integer;
begin
  j:= ((diml - pos) div 2) + pos;
  if (x= v[j]) then
    g := j
  else begin
    if ((diml - pos)= 0) then
      g := 0
    else begin
      if (x < v[j]) then
        ordenarvec(v,x,pos,(j-1),g)
      else
        ordenarvec(v,x,(j+1),diml,g);
    end;
  end;
end;

{PROGRAMA PRINCIPAL}
var
   v: vector;
   dimL : dim;
   x: integer;
   pos: Integer;
begin
     pos:= 0;
     cargarVectorOrdenado(v,dimL);
     writeln('Nros almacenados: ');
     imprimirVector(v, dimL);
     writeln('Buscar Nro');
     readln(x);
     repeat
       {ordenarvec(v,x,1,dimL,pos);}
       writeln ('Nro ',x, ' posicion ', {pos} ordenarv(v,x,1,dimL));
       writeln('Buscar Nro');
       readln(x);
     until (x = -1);
     readln;
end.

