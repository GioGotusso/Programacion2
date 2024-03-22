program parcial_pancho;
const
  finLectura = 90909090;
  LimiteInferior = 15000000;
  LimiteSuperior = 30000000;
  ConsMes1 = 1;
  ConsMes2 = 3;
  ConsAnio = '2023';
  ConsPeso = 10;

type
  fechas = record
    dia: string;
    mes: integer;
    anio: string;
  end;

  datosM = record
    iden: string;
    peso: real;
    tipo: string;
    fecha: fechas;
    cantIntervenciones: integer;
  end;

  datosD = record
    dni: longint;
    nombre: string;
    apellido: string;
    direccion: string;
  end;

  lista = ^nodoL;
  nodoL = record
    dato: datosM;
    sig: lista;
  end;

  arbol = ^nodoA;
  nodoA = record
    mascotasACargo: lista;
    dato: datosD;
    totalIntervenciones: integer;
    hd: arbol;
    hi: arbol;
  end;


procedure cargarDatos(var DatosArbol: datosD; DatosACargar: datosD);
begin
  with DatosACargar do begin
    DatosArbol.dni:=dni;
    DatosArbol.nombre:=nombre;
    DatosArbol.apellido:=apellido;
    DatosArbol.direccion:= direccion;
  end;
end;

procedure cargarDatosF(var DatosArbol: fechas; DatosACargar: fechas);
begin
  with DatosACargar do begin
    DatosArbol.anio:=anio;
    DatosArbol.dia:=dia;
    DatosArbol.mes:=mes;
  end;
end;

procedure cargarDatosM(var DatosArbol: datosM; DatosACargar: datosM);
begin
  with DatosACargar do begin
    DatosArbol.cantIntervenciones:=cantIntervenciones;
    DatosArbol.iden:=iden;
    DatosArbol.peso:=peso;
    DatosArbol.tipo:=tipo;
    cargarDatosF(DatosArbol.fecha,DatosACargar.fecha);
  end;
end;

  {Proceso Para Cargar Datos En Una Lista}
Procedure AgregarAdelante (var l: lista; DatoACargar: datosM);
  Var nuevo: lista;
    Begin
      New(nuevo);
      nuevo^.sig:=l;
      cargarDatosM(nuevo^.dato,DatoACargar);
      l:=nuevo;
    End;

  {Procesos Para Cargar Datos En Un Arbol}
procedure cargarArbol(var a: arbol; d: datosD; m: datosM);
  begin
    if (a = nil) then begin
      {Cargar El Primer Dato}
      new(a);
      a^.hd:=nil;
      a^.hi:=nil;
      {Parte Modificable}
      cargarDatos(a^.dato,d);
      a^.mascotasACargo:=nil;
      agregarAdelante(a^.mascotasACargo,m);
      a^.totalIntervenciones:= m.cantIntervenciones;

    end
    else begin
      if (d.dni < a^.dato.dni) then
        cargarArbol(a^.hi,d,m)
      else begin
        if (d.dni > a^.dato.dni) then
          cargarArbol(a^.hd,d,m)
        else begin
          {que Hacer Con Datos Repetidos}
          AgregarAdelante(a^.mascotasACargo,m);
          a^.totalIntervenciones:= a^.totalIntervenciones + m.cantIntervenciones;
        end;
      end;
    end;
  end;

procedure buscarMinimoDeUnDato (a: arbol; var d: datosD; var cantIntervencionesMinimas: integer);
begin
  {Es Un PostOrden}
  if (a <> nil) then begin
    buscarMinimoDeUnDato(a^.hi,d,cantIntervencionesMinimas);
    buscarMinimoDeUnDato(a^.hd,d,cantIntervencionesMinimas);
    if (a^.totalIntervenciones < cantIntervencionesMinimas) then begin
      cargarDatos(d,a^.dato);
      cantIntervencionesMinimas:= a^.totalIntervenciones;
    end;
  end;
end;

procedure ImprimirDatos(d: datosD);
begin
writeln('Apellido: ',d.apellido,'; ');
writeln('Nombre: ',d.nombre,'; ');
end;

procedure ImprimirDatosM(d: datosM);
begin
writeln('Tipo: ',d.tipo,'; ');
writeln('Identificador: ',d.iden,'; ');
end;

procedure busquedaAcotada(a: arbol; limiteInferior,limiteSuperior: longint);
begin
  if (a <> nil) then begin
    if (a^.dato.dni  >= limiteInferior) then begin
      if (a^.dato.dni <= limiteSuperior) then begin
        busquedaAcotada(a^.hd,limiteInferior,limiteSuperior);
        writeln('DNI: ',a^.dato.dni,'; ');
        ImprimirDatos(a^.dato);
        busquedaAcotada(a^.hi,limiteInferior,limiteSuperior);
      end
      else
        busquedaAcotada(a^.hd,limiteInferior,limiteSuperior);
    end
    else
      busquedaAcotada(a^.hd,limiteInferior,limiteSuperior);
  end;
end;

procedure BuscarEnLista(l: lista; mes1,mes2: integer; anio: String; peso: real; duenio : datosD);
var b: boolean;
begin
  b := true;
  while (l <> nil) do begin
    if (((l^.dato.fecha.anio = anio) and ((l^.dato.fecha.mes > mes1) and
    (l^.dato.fecha.mes < mes2))) and (l^.dato.peso > peso)) then begin
      if b then
        ImprimirDatos(duenio);
      ImprimirDatosM(l^.dato);
      writeln(' / ' );
      b := false;
    end;
    l:= l^.sig;
  end;
end;

{Busca Un Dato Con El Que Se Haya Ordenado El Arbol}
procedure buscarDatoOrdenado(a: arbol; mes1,mes2: integer; anio: String; peso: real);
begin
  if (a <> nil) then begin
      BuscarEnLista(a^.mascotasACargo,mes1,mes2,anio,peso,a^.dato);
      buscarDatoOrdenado(a^.hd,ConsMes1,ConsMes2,ConsAnio,ConsPeso);
      buscarDatoOrdenado(a^.hi,ConsMes1,ConsMes2,ConsAnio,ConsPeso);
  end;
end;

procedure leerDatosD(var d: datosD; fin: longint);
begin
  writeln('DNI: ');
  readln(d.dni);
  write('; ');
  if (d.dni <> fin) then begin
    writeln('Nombre: ');
    readln(d.nombre);
    write('; ');
    writeln('Apellido: ');
    readln(d.apellido);
    write('; ');
    writeln('Direccion: ');
    readln(d.direccion);
    write('; ');
  end;
end;

procedure leerDatosM(var d: datosM);
begin
  writeln('Peso: ');
  readln(d.peso);
  write('; ');
  writeln('Tipo: ');
  readln(d.tipo);
  write('; ');
  writeln('Cantidad De Intervenciones: ');
  readln(d.cantIntervenciones);
  write('; ');
  writeln('Identificador: ');
  readln(d.iden);
  write('; ');
  writeln('Anio: ');
  readln(d.fecha.anio);
  write('; ');
  writeln('Mes: ');
  readln(d.fecha.mes);
  write('; ');
  writeln('Dia: ');
  readln(d.fecha.dia);
  write('; ');
end;

var a: arbol;
    d: datosD;
    m: datosM;
    min: integer;
begin
  randomize;
  min:= 9999;
  a:=nil;
  leerDatosD(d,finLectura);
  while (d.dni <> finLectura) do begin
    leerDatosM(m);
    cargarArbol(a,d,m);
    leerDatosD(d,finLectura);
  end;
  buscarMinimoDeUnDato(a,d,min);
  if (a <> nil) then
    Writeln('Domicilio Del Cliente Con Menor Total De Intervenciones: ', d.direccion);
  writeln('Clientes Con Dni Entre ',LimiteInferior,' y ',LimiteSuperior,': ');
  busquedaAcotada(a,LimiteInferior,LimiteSuperior);
  Writeln('lista de mascotas con mas de 10kg  ');
  buscarDatoOrdenado(a,ConsMes1,ConsMes2,ConsAnio,ConsPeso);
  readln();
end.
