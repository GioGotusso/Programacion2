program Arbolesc4;
const
  limitel = 11;
type
  Arbol_Usuarios = ^nodoA ;
  nodoA = record
    dato: integer;
    hd: Arbol_Usuarios;
    hi: Arbol_Usuarios;
  end;
  lista = ^nodo;
  nodo= record
    dato: integer;
    sig: lista;
  end;
   listaNivel = ^nodoN;
  nodoN = record
    info: Arbol_Usuarios;
    sig: listaNivel;
  end;

procedure agregarAdelante(var l: Lista; nro: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := nro;
  aux^.sig := l;
  l:= aux;
end;
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
procedure imprimirl (l: lista);
begin
  if (l <> nil) then begin
     write(' ',l^.dato);
     imprimirl(l^.sig);
  end;
end;

procedure cargarA(var a: Arbol_Usuarios ; x: integer);
begin
  if (a= nil) then begin
    new(a);
    a^.dato:=x;
    a^.hd:=nil;
    a^.hi:=nil;
  end
  else begin
    if (x < a^.dato) then
       cargarA(a^.hi,x)
    else begin
       if (x > a^.dato)  then
          cargarA(a^.hi,x);
    end;
  end;
end;

procedure recorrer (var a: Arbol_Usuarios; l:lista);
begin
  while (l<> nil) do begin
    cargarA(a,l^.dato);
    l:= l^.sig;
  end;
end;

Procedure Recorrido_Acotado(a: Arbol_Usuarios; inf:integer; sup:integer);
begin
  if (a <> nil) then
    if (a^.dato>= inf) then
      if (a^.dato<= sup) then begin
       write('num: ',a^.dato);
       Recorrido_Acotado(a^.hi, inf, sup);
       Recorrido_Acotado (a^.hd, inf, sup);
      end
      else
       Recorrido_Acotado(a^.hi, inf, sup)
    else
      Recorrido_Acotado(a^.hd, inf, sup);
end;
Procedure AgregarAtras (var l, ult: listaNivel; a:Arbol_Usuarios);
 var nue:listaNivel;

 begin
 new (nue);
 nue^.info := a;
 nue^.sig := nil;
 if l= nil then l:= nue
           else ult^.sig:= nue;
 ult:= nue;
 end;
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
Procedure imprimirpornivel(a: Arbol_Usuarios);
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



var a:Arbol_Usuarios;
  l: lista;
  i,s: integer;
begin
  Randomize;
  a:=nil;
  i:=0;
  s:=0;
  crearLista(l);
  writeln('Lista Generada ');
  imprimirl(l);
  recorrer(a,l);
  imprimirpornivel(a);
  writeln ('Extremo Inferior: ');
  readln(i);
  writeln ('Extremo Superior: ');
  readln(s);
  writeln('Busqueda Acotada ');
  recorrido_Acotado(a,i,s);
  readln( );
end.
