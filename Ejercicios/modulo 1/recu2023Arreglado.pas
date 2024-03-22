program recu2023Arreglado;

type

 fecha=record
   dia:integer;
   mes:integer;
   anio:integer;
 end;

materia=record
   codigo:integer;
   nombre:string;
   nota:integer;
   Fecha:fecha;
 end;

 alumnos=record
   nombre:string;
   apellido:string;
   legajo:string;
   carrera:string;
   Materia:materia;
 end;

Alu=record
  nombre:string;
  apellido:string;
  legajo:string;
  carrera:string;
  Fecha:fecha;
  nota:integer;
end;

 listaA=^nodoL;
 nodoL=record
   dato:Alu;
   sig:listaA;
 end;

 materia0=record
    nombre:string;
    codigo:integer;
 end;

 arbol=^nodoA;
 nodoA=record
    dato:materia0;
    alu:listaA;
    cantA:integer;
    HD:arbol;
    HI:arbol;
 end;

procedure leerDatos(var a: alumnos);
begin
    writeln('legajo ');
    readln(a.legajo);
    if(a.legajo<>'0000/0') then begin
       writeln('nombre');
       readln(a.nombre);
       writeln('apellido');
       readln(a.apellido);
       writeln('carrera');
       readln(a.carrera);
   end;
end;

procedure leerDatosM(var m:materia);
begin
    writeln('nombre Materia');
    readln(m.nombre);
    writeln('codigo');
    readln(m.codigo);
    writeln('nota');
    readln(m.nota);
    writeln('dia');
    readln(m.Fecha.dia);
    writeln('mes');
    readln(m.Fecha.mes);
    writeln('anio');
    readln(m.Fecha.anio);
 end;

Procedure AgregarAdelante (var l: listaA; a:alumnos; nota:integer;f:fecha);
  Var nue: listaA;
    Begin
      New(nue);
      nue^.sig:=l;
      nue^.dato.legajo:=a.legajo;
      nue^.dato.nombre:=a.nombre;
      nue^.dato.apellido:=a.apellido;
      nue^.dato.carrera:=a.carrera;
      nue^.dato.nota:=nota;
      nue^.dato.Fecha:=f;
      l:=nue;
    End;

procedure cargarArbol(var a: arbol; m:materia; al:alumnos);
  begin
    if (a = nil) then begin
      {Cargar El Primer Dato}
      new(a);
      a^.hd:=nil;
      a^.hi:=nil;
      {Parte Modificable}
      a^.dato.nombre:=m.nombre;
      a^.dato.codigo:=m.codigo;
      a^.alu:=nil;
      agregarAdelante(a^.alu,al,m.nota,m.Fecha);
      a^.cantA:=a^.cantA+1;
    end
    else begin
      if (m.codigo < a^.dato.codigo) then
        cargarArbol(a^.hi,m,al)
      else begin
        if (m.codigo > a^.dato.codigo) then
          cargarArbol(a^.hd,m,al)
        else begin
          {que Hacer Con Datos Repetidos}
          AgregarAdelante(a^.alu,al,m.nota,m.Fecha);
          a^.cantA:=a^.cantA+1;
        end;
      end;
    end;
  end;

{modulo b}
procedure informar(a:arbol;var total:integer);
var
   porcentaje:real;
   cant:integer;
   l:listaA;
begin
   porcentaje:=0;
   cant:=0;
   if(a<>nil) then begin
     l:=a^.alu;
     while(l<>nil) do begin
       if(l^.dato.carrera='LS') then begin
          if(l^.dato.nota>7) then
             cant:=cant+1;
           total:=total+1;
       l:=l^.sig;
     if(total<>0) then
        porcentaje:=(cant/total)*100;
        writeln(a^.dato.nombre);
        writeln(porcentaje);
     informar(a^.HI,total);
     informar(a^.HD,total);
   end;
end;
end;
end;

{modulo c}

procedure recorrerLista(l:listaA;var total:integer);
begin

while(l<>nil) do begin
   if(l^.dato.Fecha.mes>=04)and(l^.dato.Fecha.mes<=06)then
         total:=total+1;
   l:=l^.sig;
 end;
end;

procedure busquedaAcotada(a: arbol; inf,sup:integer;var total:integer);
var l:listaA;
begin
  if (a <> nil) then begin
    if (a^.dato.codigo  >= inf) then begin
      if (a^.dato.codigo<= sup) then begin
        l:=a^.alu;
        busquedaAcotada(a^.hd,inf,sup,total);
        recorrerLista(l,total);
        busquedaAcotada(a^.hi,inf,sup,total);
      end
      else
        busquedaAcotada(a^.hd,inf,sup,total);
    end
    else
      busquedaAcotada(a^.hd,inf,sup,total);
  end;
end;

{modulo d}
procedure buscarMaxDeUnDato (a: arbol; var cantMax: integer; var codMax: integer);
begin
  {Es Un PostOrden}
  if (a <> nil) then begin
    buscarMaxDeUnDato(a^.hi,cantMax,codMAX);
    buscarMaxDeUnDato(a^.hd,cantMax,codMax);
    if (a^.cantA>cantMax) then begin
      codMax:=a^.dato.codigo;
      cantMax:= a^.cantA;
    end;
  end;
end;

Procedure enOrden( a: arbol );
begin
if ( a <> nil ) then begin
  enOrden (a^.HI);
  write (a^.dato.nombre, '   ');
  write (a^.dato.codigo, '   ');
  write (a^.Alu^.dato.nombre, '   ');
  write (a^.Alu^.dato.apellido, '   ');
  write (a^.Alu^.dato.legajo, '   ');
  write (a^.Alu^.dato.carrera, '   ');
  write (a^.Alu^.dato.nota, '   ');
  write (a^.Alu^.dato.Fecha.dia, '   ');
  write (a^.Alu^.dato.Fecha.mes, '   ');
  write (a^.Alu^.dato.Fecha.anio ,'   ');
  enOrden (a^.HD)
end;
end;
  //tener cuidado en usar la lista del arbol, ya que esta no esta inicializada!!
var a: arbol;
    mat: materia;
    max: integer;
    codMax:integer;
    total:integer;
    al:alumnos;
begin
  max:=-1;
  total:=0;
  a:=nil;
  leerDatos(al);
  while (al.legajo <> '0000/0') do begin
    leerDatosM(mat);
    cargarArbol(a,mat,al);
    //hacer un postOrden
    enOrden(a);
    leerDatos(al);
  end;
  informar(a,total);
  buscarMaxDeUnDato(a,max,codMax);
  writeln('el  codigo de la materia con mayor cantidad de aprobados es: ',codMax);
  busquedaAcotada(a,25,33,total);
  writeln('el total de aprobados de los codigos entre 25 y 33 son: ',total)
end.

