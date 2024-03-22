 {Una casa de venta de pastas frescas lee la información de las
ventas que se realizaron durante un determinado mes.
De cada venta se conoce: el código de pasta, cantidad (en kilos), fecha y número de cliente.
Dicha información se procesa hasta que se lee el número de cliente “0000”. }

program colaborativaact;

type
        Fecha=record
        dia:1..31;
        mes:1..12;
      end;

      venta=record
        cod_P:integer;
        cantidad:real;
        fecha:Fecha;
        num_C:integer;
      end;

    Kg=^nodoK ;
    nodoK=record
     dato:real;
     sig:Kg;
    end;

   arbol=^nodoA;
   nodoA=record
     cod:integer;
     cant_V:integer;
     cant_Kg:Kg;
     HD: arbol;
     HI: arbol;
 end;
 listaNivel = ^nodoN;
       nodoN = record
         info: arbol;
         sig: listaNivel;
       end;

procedure min (a: arbol; var x: real; var b: boolean);
begin
  if (a = nil) then begin
    b:= true;
  end
  else
  min(a^.HI,x,b);
  if (b) then begin
    x := a^.cant_Kg^.dato;
    b:= false;
  end;
end;

procedure informar_min(a:arbol);
var x:real;
    b:boolean;

 begin
     b:=false;
     if(a<>nil) then
        min(a,x,b);
     writeln('el minimo es: ',x);

 end;



procedure agregarAdelante3 (var can:Kg; k:real);
var
  aux: Kg;
begin
  new(aux);
  aux^.dato := k;
  aux^.sig := can;
  can:= aux;
end;

procedure inicializar(a:arbol);
begin
  a:=nil;
end;


procedure insertar_sin_Repetidos(var a:arbol; c:integer;var cant:integer ;k:real);
begin
    if(a=nil) then begin
      new(a);
      a^.cod:=c ;
      a^.cant_Kg:=nil;
      a^.cant_v:=cant+1;
      agregarAdelante3(a^.cant_Kg,k);
      a^.HD:=nil;
      a^.HI:=nil;
   end
   else begin
     if(a^.cod>c)then
        insertar_sin_Repetidos(a^.HI,c,cant,k)
     else begin
         if(a^.cod<c)then
           insertar_sin_Repetidos(a^.HD,c,cant,k)
         else begin
           if(a^.cod=c)then
              a^.cant_v:=cant+1;
              agregarAdelante3(a^.cant_Kg,k);

      end;
   end;
 end;
end;
procedure Leer_Y_Cargararbol(v:venta; var a:arbol);
 var
   cant:integer;
begin
    cant:=0;
    writeln('inserte num de cliente: ');
    readln(v.num_C);
    if(v.num_C<>0)then begin
        readln(v.cod_P);
        readln(v.cantidad);
        readln(v.fecha.dia);
        readln(v.fecha.mes);
        insertar_sin_Repetidos(a,v.cod_P,cant,v.cantidad);
        readln(v.num_C);
   end;
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
Procedure imprimirpornivel( a: arbol);
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
                      write (l^.info^.cod, ' - ');
                      write (l^.info^.cant_V, ' - ');
                      write (l^.info^.cant_Kg^.dato, ' - ');
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


procedure en_orden(a:arbol);
begin
    if(a<>nil) then begin
      en_orden(a^.HI);
      if(a^.cant_Kg^.dato>10)then
         writeln(a^.cod,'; ');
      en_orden(a^.HD)

  end;
end;

procedure leerdatos();
begin
    writeln('Menu:');
    writeln('1. inicializar estructuras');
    writeln('2. leer una venta y agregarla');
    writeln('3. imprimir');
    writeln('4. calcular la pasta menos vendida');
    writeln('5. imprimir las pastas que hallan vendido mas de 10kg');
    writeln('6. reeleer opciones');
    writeln('7. Exit');
    write('ingresar opcion: ');

end;

procedure cargarListaAleatoria(var l: lista);
var
    peso: real;
    i: integer;
    e: rangoNumericoStrings;
begin
  randomize;
  e:= random((limiteCantidadStrings + 1));
  while (e <> 0) do begin
    {Carga SemiAleAtorio Datos Integers}
    i:= random(NumeroAleatorioParaCargaAleatoria);
    peso:= (i*3 + e) + 2;
    agregarAdelante3(l,peso);
    e:= random((limiteCantidadStrings + 1));
  end;
end;


{Devuelve El Numero De La Posicion(En Un Case) De Un String, Para Que No Se Repita;
 Esto Lo Hace Con Un Conjunto}
procedure stringAleatorio(var i: rangoNumericoStrings; var conStrings: conjuntoStrings; vacio : conjuntoStrings);
var r: integer;
begin
  if ((not(conStrings = vacio)) and (not(i in conStrings))) then begin
    r:= random(2);
    if (r = 0) then
      r:= -1;
    while (not(i in conStrings)) do begin
      i:= i + r;
      if ((i+r) > limiteCantidadStrings)then
        r:= -1
      else begin
        if ((i+r) < 1) then
          r:= 1;
      end;
    end;
  end;
  exclude(conStrings,i);
end;

 {Opciones De Strings Para Agregar De Forma Aleatorea}
procedure opcionesStrings(var des: integer; i: rangoNumericoStrings);
begin
  case i of
      1 : des:= 1000;
      2 : des:= 2000;
      3 : des:= 3000;
      4 : des:= 4000;
      5 : des:= 5000;
      6 : des:= 6000;
      7 : des:= 7000;
      8 : des:= 8000;
      9 : des:= 9000;
      10 : des:= 1100;
  end;
end;

procedure cargaAleatoriaArbol(var a: arbol);
var l: Kg;
    i,cod,cant: integer;
    e: rangoNumericoStrings;
    conStrings, vacio: conjuntoStrings;
begin
  vacio:= [];
  conStrings:= [1..limiteCantidadStrings];
  randomize;
  e:= random((limiteCantidadStrings + 1));
  while ((e <> 0) and (not(conStrings = vacio))) do begin
    {Carga SemiAleAtorio Datos Integers}
    i:= random(NumeroAleatorioParaCargaAleatoria);
    cant:= (i + e) + 2;
    {Carga Aleatorio Sin Repetir Strings}
    stringAleatorio(e,conStrings,vacio);
    opcionesStrings(cod,e);
    insertar_sin_Repetidos(a,cod,cad,l);
    cargarArbol(a,d);
    e:= random((limiteCantidadStrings + 1));
  end;
end;

var
  opcion: integer;
  a:arbol;
  v:venta;

begin
  leerdatos();
  repeat
    readln(opcion);

    case opcion of
      1: inicializar(a);
      2: Leer_Y_Cargararbol(v,a);
      3: imprimirpornivel(a);
      4: informar_min(a);
      5: en_orden(a);
      6: leerdatos();
      7: writeln('chao!');
      else writeln('opcion invalida');
    end;
    writeln;
    until opcion= 7;
  readln();
end.
