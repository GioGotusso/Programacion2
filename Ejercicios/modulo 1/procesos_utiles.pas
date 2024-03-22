program procesos_utiles;

const
  NumeroAleatorioParaCargaAleatoria = 15;
  limiteCantidadStrings= 10;

type

  rangoNumericoStrings = 0 .. limiteCantidadStrings;
  conjuntoStrings = set of rangoNumericoStrings;

  datos = record
    destino: string;
    km: integer;
    pasajesVen: integer;
  end;

  lista= ^nodoLista;
  nodoLista= record
    dato: datos;
    sig: lista;
  end;

  arbol= ^nodoArbol;
  nodoArbol= record
    dato: datos;
    hd: arbol;
    hi: arbol;
  end;

  listaNivel = ^nodoNivel;
  nodoNivel = record
    info: arbol;
    sig: listaNivel;
  end;


{Procesos Para Copiar Datos}
procedure cargarDatos(var DatosArbol: datos; DatosACargar: datos);
begin
  DatosArbol.destino:=DatosACargar.destino;
  DatosArbol.km:=DatosACargar.km;
  DatosArbol.pasajesVen:=DatosACargar.pasajesVen;
end;

{Procesos Para Cargar Datos En Un Arbol}
procedure cargarArbol(var a: arbol; d: datos);
begin
  if (a = nil) then begin
    {Cargar El Primer Dato}
    new(a);
    a^.hd:=nil;
    a^.hi:=nil;
    {Parte Modificable}
    cargarDatos(a^.dato,d)

  end
  else begin
    if (d.destino < a^.dato.destino) then
      cargarArbol(a^.hi,d)
    else begin
      if (d.destino > a^.dato.destino) then
        cargarArbol(a^.hd,d)
      else
        {que Hacer Con Datos Repetidos}
        a^.dato.pasajesVen:= a^.dato.pasajesVen + d.pasajesVen;

    end;
  end;
end;

{Proceso Para Cargar Datos En Una Lista}
Procedure AgregarAdelante (var l: lista; DatoACargar: datos);
Var nuevo: lista;
  Begin
    New(nuevo);
    nuevo^.sig:=l;
    cargarDatos(nuevo^.dato,DatoACargar);
    l:=nuevo;
  End;

procedure agregarAtras( var l,ult: lista; d: datos);
var nuevo: lista;
begin
  new (nuevo);
  nuevo^.sig:= nil;
  nuevo^.dato:= d;
  if (l = nil) then
    l:= nuevo
  else
    ult^.sig:=nuevo;
  ult:= nuevo;
end;

Procedure AgregarAtrasListaNivel (var l, ult: listaNivel; a:arbol);
 var nuevo:listaNivel;
 begin
   new (nuevo);
   nuevo^.info := a;
   nuevo^.sig := nil;
   if l= nil then
     l:= nuevo
   else
     ult^.sig:= nuevo;
   ult:= nuevo;
 end;

procedure agregarOrdenado(var pri:lista ; x:datos);
var
   nue, anterior, actual: lista;
begin
     new (nue);
     cargarDatos(pri^.dato,x);
     nue^.sig := nil;
     if (pri = nil) then
          pri := nue
     else
     begin
          actual := pri;
          anterior := pri;
          while (actual<>nil) and (actual^.dato.destino < nue^.dato.destino) do begin
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

{Funcion Contar Elementos De Una Lista}
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

{Proceso Dispose Arbol}
procedure DisposeArbol(var a: arbol);
begin
  {Es Un PostOrden}
  if (a <> nil) then begin
    DisposeArbol(a^.hi);
    DisposeArbol(a^.hd);
    dispose(a);
  end;
end;

procedure disposeLista(var l: lista);
var aux: lista;
begin
  while (l<> nil) do begin
    aux:= l;
    l:=aux^.sig;
    dispose(aux);
  end;
end;

{Procesos Para Imprimir}
procedure imprimirDatos (d : datos );
begin
  write('Destino: ',d.destino, '; ');
  write('KM: ',d.km, '; ');
  write('Pasajes Vendidos: ',d.pasajesVen, '; ');
end;

procedure imprimirArbol(a : arbol);
begin
  {En Un EnOrden}
  if (a <> nil) then begin
    imprimirArbol(a^.hi);
    imprimirDatos(a^.dato);
    writeln(' ');
    imprimirArbol(a^.hd);
  end;
end;

procedure imprimirLista (l: lista);
begin
  if (l<> nil) then begin
    imprimirDatos(l^.dato);
    imprimirLista(l^.sig);
  end;
end;

Procedure imprimirPorNivel(a: arbol);
var
   l, aux, ult: listaNivel;
   nivel, cant, i: integer;
begin
   l:= nil;
   if(a <> nil)then begin
                 nivel:= 0;
                 agregarAtrasListaNivel (l,ult,a);
                 while (l<> nil) do begin
                    nivel := nivel + 1;
                    cant:= contarElementos(l);
                    write ('Nivel ', nivel, ': ');
                    for i:= 1 to cant do begin
                      imprimirDatos(l^.info^.dato);
                      if (l^.info^.HI <> nil) then
                        agregarAtrasListaNivel (l,ult,l^.info^.HI);
                      if (l^.info^.HD <> nil) then
                        agregarAtrasListaNivel (l,ult,l^.info^.HD);
                      aux:= l;
                      l:= l^.sig;
                      dispose (aux);
                     end;
                     writeln();
                 end;
               end;
end;

{Procesos Para Buscar}
procedure buscarMinimoDeUnDato (a: arbol; var d: datos);
begin
  {Es Un PostOrden}
  if (a <> nil) then begin
    buscarMinimoDeUnDato(a^.hi,d);
    buscarMinimoDeUnDato(a^.hd,d);
    if (a^.dato.km < d.km) then
      cargarDatos(d,a^.dato);
  end;
end;

procedure busquedaAcotada(a: arbol; limiterInferior,limiteSuperior: string);
begin
  if (a <> nil) then begin
    if (a^.dato.destino >= limiterInferior) then begin
      if (a^.dato.destino <= limiteSuperior) then begin
        writeln(a^.dato.destino);
        busquedaAcotada(a^.hd,limiterInferior,limiteSuperior);
        busquedaAcotada(a^.hi,limiterInferior,limiteSuperior);
      end
      else
        busquedaAcotada(a^.hi,limiterInferior,limiteSuperior);
    end
    else
      busquedaAcotada(a^.hd,limiterInferior,limiteSuperior);
  end;
end;

  {Busca Un Dato Con El Que Se Haya Ordenado El Arbol}
procedure buscarDatoOrdenado(a: arbol; destino: string; var aux: arbol);
begin
  if (a <> nil) then begin
    if (a^.dato.destino = destino ) then
      {Devuelve El Puntero Al Dato En Un Auxiliar}
      aux:= a
    else begin
        if (destino < a^.dato.destino) then
          BuscarDatoOrdenado(a^.hi,destino,aux)
        else
          BuscarDatoOrdenado(a^.hd,destino,aux);
    end;
  end;
end;

procedure minimoDatoOrdenado(a: arbol; var x: datos; var b: Boolean);
begin
  if (a = nil)then
    b:= true
  else
    minimoDatoOrdenado(a^.hi,x,b);
    if (b) then begin
      b:= false;
      cargarDatos(x,a^.dato);
    end;
end;

{Proceso Para Borrar Un Dato De Un Arbol}
procedure borrarNodoArbol(var a: arbol; x: string);
var aux: arbol;
  b: boolean;
  d: datos;
begin
   if (a <> nil) then begin
     {Busca El Dato}
     if (x < a^.dato.destino) then
       borrarNodoArbol(a^.hi,x)
     else begin
       if (x > a^.dato.destino) then
         borrarNodoArbol(a^.hd,x)
       else begin
         {Lo Encuetra Al Dato}
          if (a^.hi <> nil) then begin
            if (a^.hd <> nil) then begin
               {caso 2 hijos}
               minimoDatoOrdenado(a^.hd,d,b);
               cargarDatos(a^.dato,d);
               borrarNodoArbol(a^.hd,x);
            end
            else begin
             {solo hijo hi}
              aux:= a;
              a:= aux^.hi ;
              dispose(aux);
            end;
          end
          else begin
            if (a^.hd = nil) then begin
              {ningun hijo}
              dispose(a);
              a:= nil;
            end
            else begin
              {solo hijo hd}
              aux:= a;
              a:= aux^.hd ;
              dispose(aux);
            end;
          end;
          {Borro El Dato Correctamente}
          b:= true;
       end;
     end;
   end
   else
     {No Encotro El Dato}
     b:= false;
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
procedure opcionesStrings(var des: string; i: rangoNumericoStrings);
begin
  case i of
      1 : des:= 'D1';
      2 : des:= 'D2';
      3 : des:= 'D3';
      4 : des:= 'D4';
      5 : des:= 'D5';
      6 : des:= 'D6';
      7 : des:= 'D7';
      8 : des:= 'D8';
      9 : des:= 'D9';
      10 : begin
             des:= 'D10';
             write();
           end;
  end;
end;

procedure cargaAleatoriaArbol(var a: arbol);
var d: datos;
    i: integer;
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
    d.pasajesVen:= (i + e) + 2;
    d.km:=((i * e)*10) + (e * 10);
    {Carga Aleatorio Sin Repetir Strings}
    stringAleatorio(e,conStrings,vacio);
    opcionesStrings(d.destino,e);
    cargarArbol(a,d);
    e:= random((limiteCantidadStrings + 1));
  end;
end;

procedure cargarListaAleatoria(var l: lista);
var d: datos;
    i: integer;
    e: rangoNumericoStrings;
begin
  randomize;
  e:= random((limiteCantidadStrings + 1));
  while (e <> 0) do begin
    {Carga SemiAleAtorio Datos Integers}
    i:= random(NumeroAleatorioParaCargaAleatoria);
    d.pasajesVen:= (i + e) + 2;
    d.km:=((i * e)*10) + (e * 10);
    {Carga Aleatorio Repitiendo Strings}
    opcionesStrings(d.destino,e);
    AgregarAdelante(l,d);
    e:= random((limiteCantidadStrings + 1));
  end;
end;

begin
  readln();
end.

