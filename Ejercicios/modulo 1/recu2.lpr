program recu2;

type

  fecha=record
     dia:integer;
     mes:integer;
     anio:integer;
  end;

  jugador=record
     nombre:string;
     apellido:string;
     posicion:string;
     pais:string;
     cantG:string;
  end;

  partido=record
    nombreP1:string;
    nombreP2:string;
    nombreE:string;
    f:fecha;
  end;

  listadoJ=^nodoJ;
  nodoJ=record
    nombre:string;
    apellido:string;
    posicion:string;
    cantG:integer; //lista de fechas con sus goles?
    f:fecha;
  end;

  arbol=^nodoA;
  nodoA=record
    pais:string;
    J:listadoJ;
    golesTOT:integer;
    HI:arbol;
    HD:arbol;
  end;

procedure leerPartido(var p:partido);
begin
   writeln('ingrese un anio');
   readln(p.f.anio);
   if(p.f.anio<>2023)then
     writeln('ingrese un dia');
     readln(p.f.dia);
     writeln('ingrese un mes');
     readln(p.f.mes);
     writeln('ingrese el nombre del pais 1');
     readln(p.nombreP1);
     writeln('ingrese el nombre del pais 2');
     readln(p.nombreP2);
     writeln('ingrese el nombre del estadio');
     readln(p.nombreE);
end;

procedure leerJugador(var j:jugador);
begin
    writeln('ingrese un nombre de jugador');
    readln(j.nombre);
    writeln('ingrese el apellido');
    readln(j.apellido);
    writeln('ingrese la posicion de jugador');
    readln(j.posicion);
    writeln('ingrese el pais del jugador');
    readln(j.pais);
    writeln('ingrese la cantidad de goles');
    readln(j.cantG);
end;


Procedure AgregarAdelante (var j: listadoJ; J:jugador; f:fecha);
  Var nue: listadoJ;
    Begin
      New(nue);
      nue^.sig:=j;
      nue^.nombre:=J.nombre;
      nue^.apellido:=J.apellido;
      nue^.posicion:=J.posicion;
      nue^.cantG:=J.cantG;
      nue^.f:=f;
      j:=nue;
    End;

procedure cargarArbol(var a: arbol; p:partido; j:jugador);
  begin
    if (a = nil) then begin
      {Cargar El Primer Dato}
      new(a);
      a^.hd:=nil;
      a^.hi:=nil;
      {Parte Modificable}
      a^.pais:=j.pais;
      a^.j=nil;
      agregarAdelante(a^.j,j,p.f);
      a^.golesTOT:=j.cantG;
    end
    else begin
      if (j.pais < a^.pais) then
        cargarArbol(a^.hi,p,j)
      else begin
        if (j.pais > a^.pais) then
          cargarArbol(a^.hd,p,j)
        else begin
          {que Hacer Con Datos Repetidos}
          AgregarAdelante(a^.alu,j,p.Fecha);
          a^.golesTOT:= a^.golesTOT+j.cantG;
        end;
      end;
    end;
  end;

{modulo a}
procedure buscarMaxDeUnDato (a: arbol; var cantMax: integer; var PMax: string);
begin
  {Es Un PostOrden}
  if (a <> nil) then begin
    buscarMaxDeUnDato(a^.hi,cantMax,PMAX);
    buscarMaxDeUnDato(a^.hd,cantMax,PMax);
    if (a^.golesTOT>cantMax) then begin
      PMax:=a^.pais;
      cantMax:= a^.golesTOT;
    end;
  end;
end;

procedure calcular(l:listadoJ;var cant:integer);
begin
  while(l<>nil)do begin
      res =0
while (aux<>nil)
fechaactual=aux.dato.fecha
while(aux <>nil)and (fechaactual.mes=aux.dato.fecha.mes)and(fechaactual.dia=aux.dato.fecha.dia) do
  aux=aux.sig
end
res = res+1
end
  end;
end;

{modulo c}  //es una busqueda acotada
procedure informar(a:arbol);
var cant:integer;
begin
  cant:=0;
  if(a<>nil)then begin
     informar(a^.HD);
     if(a^.pais>'Belgica')and(a^.pais<'Qatar')then
           calcular(a^.J,cant);
           writeln(cant);
           writeln(a^.pais);
     informar(a^.HI)
  end;

end;
{modulo d}

procedure recorrerlista(l:listadoJ;var cantg);
begin
  while(l<>nil) do begin
      if(l^.f.anio=2022) then begin
         if(l^.f.mes>=11)and(l^.f.mes<=12) then
            if((l^.f.mes=11)and(l^.f.dia>=20)or(l^.f.mes=12)and(l^.f.dia<=02)) then
               cantg:=cantg+l^.cantG;
      l:=l^.sig;
      end;
  end;
end;

procedure cantG(a:arbol);
var cantg:integer;

begin
  cantg:=0;
  if(a<>nil) then begin
     if(a^.pais='Argentina')then
            recorerlista(a^.J,cantg);
     writeln(cantg);
  end;

end;
begin
end.
