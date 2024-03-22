Program encomiendas;

Type

   encomienda = record
                  codigo: integer;
                  peso: integer;
                end;

    //lista de codigos
 codigo= ^nodoC;
 nodoC= record
     dato:integer;
     sig: codigo;
 end;

  // Lista de encomiendas
  lista = ^nodoL;
  nodoL = record
    dato: encomienda;
    sig: lista;
  end;
 // arbol de listas
 arbol=^nodoA;
   nodoA=record
     cod:codigo;
     peso:integer;
     HD: arbol;
     HI: arbol;
 end;

{--------------------------------------------------------------------------------
AgregarAdelante - Agrega una encomienda adelante en l}
procedure agregarAdelante(var l: Lista; enc: encomienda);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := enc;
  aux^.sig := l;
  l:= aux;
end;

procedure agregarAdelante2 (var cod: codigo; c:integer);
var
  aux: codigo;
begin
  new(aux);
  aux^.dato := c;
  aux^.sig := cod;
  cod:= aux;
end;

{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con datos de las encomiendas }
procedure crearLista(var l: Lista);
var
  e: encomienda;
  i: integer;
begin
 l:= nil;
 for i:= 1 to 20 do begin
   e.codigo := i;
   e.peso:= random (10);
   while (e.peso = 0) do e.peso:= random (10);
   agregarAdelante(L, e);
 End;
end;


{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista(l: Lista);
begin
 While (l <> nil) do begin
   writeln('Codigo: ', l^.dato.codigo, '  Peso: ', l^.dato.peso);
   l:= l^.sig;
 End;
end;

procedure imprimirlista2(l: codigo);
begin
 While (l <> nil) do begin
   writeln(l^.dato,',');
   l:= l^.sig;
 End;
end;

procedure insertar_sin_Repetidos(var a:arbol; p:integer; c:integer);
begin
    if(a=nil) then begin
      new(a);
      a^.peso:=p ;
      a^.cod:=nil;
      agregarAdelante2(a^.cod,c);
      a^.HD:=nil;
      a^.HI:=nil;
   end
   else begin
     if(a^.peso>p)then
        insertar_sin_Repetidos(a^.HI,p,c)
     else begin
         if(a^.peso<p)then
           insertar_sin_Repetidos(a^.HD,p,c)
         else begin
           if(a^.peso=p)then
              agregarAdelante2(a^.cod,c);

      end;
   end;
 end;
end;

procedure En_Orden(a:arbol) ;
begin
   if(a<>nil) then begin
       En_Orden(a^.HI);
       writeln('los codigos con peso=',a^.peso,'son: ');
       imprimirlista2(a^.cod);
       En_Orden(a^.HD)
  end;
end;
Var

 l: lista;
 a:arbol;

begin
 Randomize;

 crearLista(l);
 writeln ('Lista de encomiendas generada: ');
 imprimirLista(l);

 while(l<>nil) do begin
   insertar_sin_Repetidos(a,l^.dato.peso,l^.dato.codigo);
   l:=l^.sig;
 end;

 En_Orden(a);
 readln;
end.
