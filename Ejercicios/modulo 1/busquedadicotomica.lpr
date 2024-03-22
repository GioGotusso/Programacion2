program busquedadicotomica;

uses Unit1;

const
    dimF = 8;  {Dimensión física del vector}

type

    vector = array [1..dimF] of integer;

    dim = 0..dimF;

{-----------------------------------------------------------------------------
CARGARVECTORORDENADO - Carga ordenadamente nros aleatorios entre 0 y 100 en el
vector hasta que llegue el nro 99 o hasta que se complete el vector}

procedure busqueda_dicotomica(vec:vector; ult,pri:integer;x:integer;var encontre:boolean);
  var medio:integer;
begin
    writeln(' ultimo ',ult, ' primero ', pri, '  entre al busqueda dicotomica ');
    readln();
    if(pri>ult)then begin
        writeln(' ultimo ',ult, ' primero ', pri, '  entre al (pri > ult) ');
        readln();
        encontre:=false
    end
    else begin
       medio:=(pri+ult)div 2;
       if(vec[medio]=x) then  begin
           encontre:=true ;
           writeln(' ultimo ',ult, ' primero ', pri, '  entre al ( x = vec[medio]) ');
           readln();
       end
       else begin
          if(x<vec[medio]) then begin
             ult:=medio-1 ;
             writeln(' ultimo ',ult, ' primero ', pri, '  entre al ( x < vec[medio]) ');
             readln();
              busqueda_dicotomica(vec,ult,pri,x,encontre);
          end
          else begin
              pri:=medio+1 ;
              writeln(' ultimo ',ult, ' primero ', pri, ' no  entre al ( x < vec[medio]) ');
              readln();
              busqueda_dicotomica(vec,ult,pri,x,encontre);
          end;
       end;
    end;
end;

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

{PROGRAMA PRINCIPAL}
var
   v: vector;
   dimL : dim;
   x,pri,ult:integer;
   encontre:boolean;
begin
     encontre:=false;
     cargarVectorOrdenado(v,dimL);
     pri:=1;
     ult:=diml;
     writeln('Nros almacenados: ');
     imprimirVector(v, dimL);

     writeln ('el numero a buscar es: ') ;
     readln(x);
     busqueda_dicotomica(v,ult,pri,x,encontre);
     writeln(encontre);
     readln;
end.
