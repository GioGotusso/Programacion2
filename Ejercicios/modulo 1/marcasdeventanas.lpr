{Un negocio de puertas y ventanas dispone de una lista de los productos que tiene
para la venta. De cada producto se conoce el código, la marca, el nombre, el año de fabricación y el precio.
Esta información está ordenada, dentro de una lista simple, primero por marca y dentro de cada marca por año. }
program marcasdeventanas;

type
  sub= 2000 .. 2022;
  st20= string[20];
  datos= record
    cod:integer;
    mar:st20;
    nom: st20;
    a:sub;
    pre:integer;
  end;

  lista=^nodo;
  nodo= record
    dato: datos;
    sig: lista;
  end;

function ordenar (l: lista; act: lista): lista;
var
  ant: lista;
begin
  while ( l<>nil ) and (l^.dato.mar < act^.dato.mar) do begin
    ant:= l;
    l:=l^.sig;
  end;
  while (l<> nil) and ((l^.dato.mar <= act^.dato.mar) and (l^.dato.a < act^.dato.a)) do begin
    ant:= l;
    l:=l^.sig;
  end;
  ordenar:= ant;
end;


procedure cargar (var l: lista);
var
  r: integer; act: lista; ant: lista;
begin
  randomize;
  r:= random(10);
  while (r<>0) do begin
    new(act);
    case r of
      1:act^.dato.mar:= 'roble'     ;  2:act^.dato.mar:= 'alamo'     ;
      3:act^.dato.mar:= 'pino'      ;  4:act^.dato.mar:= 'abeto'     ;
      5:act^.dato.mar:= 'cactus'    ;  6:act^.dato.mar:= 'vidrio'    ;
      7:act^.dato.mar:= 'hierro'    ;  8:act^.dato.mar:= 'algarrobo' ;
      9:act^.dato.mar:= 'plastico'  ;  10:act^.dato.mar:= 'nogal'     ;
    end;
    r:=random(9);
    case r of
      1:act^.dato.nom:= 'marron'    ;  2:act^.dato.nom:= 'violeta'   ;
      3:act^.dato.nom:= 'beige'     ;  4:act^.dato.nom:= 'celeste'   ;
      5:act^.dato.nom:= 'azul'      ;  6:act^.dato.nom:= 'rosa'      ;
      7:act^.dato.nom:= 'roja'      ;  8:act^.dato.nom:= 'negra'     ;
      9:act^.dato.nom:= 'verde'     ;  0:act^.dato.nom:= 'blanco'    ;
    end;
    r:= random(22);
    act^.dato.a:= 2000+ r;
    r:= random(300);
    act^.dato.cod:= 2000+ r;
    r:= random(99);
    act^.dato.pre:=1+ r;

    ant:= ordenar(l,act);
    if (ant= l )then begin
      act^.sig:= l^.sig;
      l:= act;
    end
    else begin
      act^.sig:= ant^.sig;
      ant^.sig:= act;
    end;
    randomize;
    r:= random(10);
  end;
end;

procedure imprimir (l: lista);
begin
  while (l<> nil) do begin
    write(' | Marca ', l^.dato.mar, ' Año ', l^.dato.a);
    l:= l^.sig;
  end;
    write(' | nil ');
end;

var
  l:lista;


begin
  l:= nil;
  cargar(l);
  imprimir(l);
end.

