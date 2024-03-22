program abb_ordenado;
Type

  // Lista de enteros
  lista = ^nodoL;
  nodoL = record
    dato: integer;
    sig: lista;
  end;

  // Arbol de enteros
  arbol= ^nodoA;
  nodoA = Record
    dato: integer;
    HI: arbol;
    HD: arbol;
  End;

  // Lista de Arboles
  listaNivel = ^nodoN;
  nodoN = record
    info: arbol;
    sig: listaNivel;
  end;


{-----------------------------------------------------------------------------
AgregarAdelante - Agrega nro adelante de l}
procedure agregarAdelante(var l: Lista; nro: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := nro;
  aux^.sig := l;
  l:= aux;
end;



{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con números aleatorios }
procedure crearLista(var l: Lista);
var
  n: integer;
begin
 l:= nil;
 n := random (20);
 While (n <> 0) do Begin
   agregarAdelante(L, n);
   n := random (20);
 End;
end;


{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista(l: Lista);
begin
 While (l <> nil) do begin
   write(l^.dato, ' - ');
   l:= l^.sig;
 End;
end;

{-----------------------------------------------------------------------------
CONTARELEMENTOS - Devuelve la cantidad de elementos de una lista l }

function ContarElementos (l: listaNivel): integer;
  var c: integer;
begin
 c:= 0;
 While (l <> nil) do begin
   c:= c+1;
   l:= l^.sig;
 End;
 contarElementos := c;
end;


{-----------------------------------------------------------------------------
AGREGARATRAS - Agrega un elemento atrás en l}

Procedure AgregarAtras (var l, ult: listaNivel; a:arbol);
 var nue:listaNivel;

 begin
 new (nue);
 nue^.info := a;
 nue^.sig := nil;
 if l= nil then l:= nue
           else ult^.sig:= nue;
 ult:= nue;
 end;


{-----------------------------------------------------------------------------
IMPRIMIRPORNIVEL - Muestra los datos del árbol a por niveles }

Procedure imprimirpornivel(a: arbol);
var
   l, aux, ult: listaNivel;
   nivel, cant, i: integer;
begin
   l:= nil;
   if(a <> nil)then begin
                 nivel:= 0;
                 agregarAtras (l,ult,a);
                 while (l<> nil) do begin
                    nivel := nivel + 1;
                    cant:= contarElementos(l);
                    write ('Nivel ', nivel, ': ');
                    for i:= 1 to cant do begin
                      write (l^.info^.dato, ' - ');
                      if (l^.info^.HI <> nil) then agregarAtras (l,ult,l^.info^.HI);
                      if (l^.info^.HD <> nil) then agregarAtras (l,ult,l^.info^.HD);
                      aux:= l;
                      l:= l^.sig;
                      dispose (aux);
                     end;
                     writeln;
                 end;
               end;
end;

procedure insertar_ABB(var a:arbol; x:integer);
begin
  if(a=nil) then begin
     new(a);
     a^.dato:=x;
     a^.HD:=nil;
     a^.HI:=nil;
  end
  else begin
     if(a^.dato>x)then
        insertar_ABB(a^.HI,x)
     else begin
         if(a^.dato<x)then
           insertar_ABB(a^.HD,x);
     end;
  end;
end;

procedure agregarOrdenado(var pri:lista ; x:integer);
var
   nue, anterior, actual: lista;
begin
     new (nue);
     nue^.dato:= x;
     nue^.sig := nil;
     if (pri = nil) then
          pri := nue
     else
     begin
          actual := pri;
          anterior := pri;
          while (actual<>nil) and (actual^.dato < nue^.dato) do begin
               anterior := actual;
               actual:= actual^.sig;
          end;
          if (anterior = actual) then
               pri := nue
          else
               anterior^.sig := nue;
          nue^.sig := actual;
     end;
end;

procedure generarNuevaEstructura (l:lista; VAR l2: lista);
begin
     while(l <> nil) do begin
          agregarOrdenado(l2, l^.dato);
          l := l^.sig;
     end;
end;

var
   l:lista;
   l2:lista;
   a:arbol;

begin
  Randomize;

 crearLista(l);
 writeln ('Lista generada: ');
 imprimirLista(l);

 generarNuevaEstructura(l,l2);
 writeln('la lista ordenada es: ');
 imprimirLista(l2);

 while(l2<>nil)do begin
    insertar_ABB(a,l2^.dato);
    l2:=l2^.sig;
 end;

 imprimirpornivel(a);

end.

