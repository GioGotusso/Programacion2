Program borrarelemento;
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

 procedure crearlistaordenada(var pri:lista; t:integer);
var
   nuevo, anterior, actual: lista;
begin
     new (nuevo);
     nuevo^.dato:= t;
     nuevo^.sig := nil;
     if (pri = nil) then
          pri := nuevo
     else
     begin
          actual := pri;
          anterior := pri;
          while (actual<>nil) and (actual^.dato < nuevo^.dato) do begin
               anterior := actual;
               actual:= actual^.sig;
          end;
          if (anterior = actual) then
               pri := nuevo
          else
               anterior^.sig := nuevo;
          nuevo^.sig := actual;
     end;
end;

procedure insertar (var a:arbol;d:integer);
begin
 if (a=nil) then begin
    new(a);
    a^.dato:=d;
    a^.HI:=nil;
    a^.HD:=nil;
    a:=a;
 end
 else begin
   if (a^.dato>d) then
      insertar(a^.HI,d)
   else  begin
      if (a^.dato<d) then
         insertar (a^.HD,d);
      end;
   end;
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
function Minimo(a:arbol):integer;
begin
     if (a<>nil) then
        minimo(a^.HI)
     else
         minimo:=a^.dato;
end;
procedure borrarElemento (var a:arbol; d:integer; var r:boolean);
var
  aux:arbol;
begin
     aux:=a;
     if (a=nil) then
        writeln('no se encontro el dato')
     else
         if (a^.dato>d) then
            borrarelemento(a^.HI,d,r)
         else
             if (a^.dato<d) then
                borrarelemento(a^.HD,d,r)
             else begin
             r:=true;
             if (a^.HI= nil) and (a^.HD<>nil) then begin
                a:=a^.HI;
                dispose(aux);
             end
             else
                 if (a^.HD=nil) and (a^.HI<>nil) then begin
                    a:=a^.HD;
                    dispose(aux);
                 end
                 else begin
                   a^.dato:=minimo(a^.HD);
                   borrarElemento(a^.HD,a^.dato,r);
                 end;
             end;
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

Var
 a: arbol;
 l: lista;
 aux: lista;
 act: lista;
 b:integer;
 encontre:boolean;

begin
 Randomize;
 act:= nil;
 crearLista(l);
 aux:=l;
 writeln ('Lista generada: ');
 imprimirLista(l);
 {while(aux<>nil)do begin
   crearlistaordenada(act,aux^.dato);
   aux:=aux^.sig;
 end;
 writeln(' ');
 writeln('---------------------------------------------------------------------');
 writeln('Lista Ordenada');}
 imprimirLista(act);
 while(aux<>nil)do begin
   insertar(a,aux^.dato);
   aux:=aux^.sig;
 end;
 writeln(' ');
 writeln('---------------------------------------------------------------------');
 writeln('Arbol impreso por nivel');
 imprimirpornivel(a);
 writeln('escribi el numero a borrar');
 readln(b);
 borrarElemento(a,b,encontre);
 imprimirpornivel(a);
 readln();
end.
