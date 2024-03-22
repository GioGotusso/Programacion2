Program arboles_Insertar;
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

Procedure Recorrido_Acotado(a: arbol; inf:integer; sup:integer);
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

procedure min (a: arbol; var x: longint; var b: boolean);
begin
  if (a = nil) then begin
    b:= true
  end
  else
  min(a^.HI,x,b);
  if (b) and (a <> nil) then begin
    x := a^.dato;
    b:= false;
  end;
end;

procedure borrarElemento ( var a: arbol; x: integer ; var res: boolean);
var
   aux:arbol; b: boolean; D: integer;
begin
  if (a= nil) then
    res:= false
  else begin
    if (a^.dato > x) then
      borrarElemento (a^.HI,x,res)
    else begin
      if (a^.dato < x) then
        borrarElemento (a^.HD,x,res)
      else begin
        if (a^.HI = nil) then begin
          if (a^.HD = nil) then begin
            aux:= a;
            a:= nil;
            dispose(aux);
          end
          else begin
            aux:=a;
            a:=a^.HD;
            dispose(aux);
          end;
        end
        else begin
          if (a^.HD = nil) then begin
            aux:=a;
            a:=a^.HI;
            dispose(aux);
          end
          else begin
            b:= false;
            min(a^.HD,D,b);
            a^.dato:=D;
            borrarElemento(a^.HD,D,b);
          end;
        end;
        res:= true;
      end;
    end;
  end;
end;


Var

 l: lista;
 a:arbol;
 x,inf,sup:integer;
 res:boolean;
begin

 inf:=1;
 sup:=10;
 x:=18;
 Randomize;

 crearLista(l);
 writeln ('Lista generada: ');
 imprimirLista(l);
 while(l<>nil) do begin
  insertar_ABB(a,l^.dato);
  l:=l^.sig
 end;

 writeln('el arbol generado es: ');
 imprimirpornivel(a);
 Recorrido_Acotado(a,inf,sup);


 borrarElemento(a,x,res);
 writeln('el arbol final es: ');
 imprimirpornivel(a);
 readln;
end.
