{a) Realizar un módulo que procese la información descripta anteriormente y genere una estructura donde para
cada cliente se guarde su DNI, nombre y apellido, dirección y las mascotas que tiene a su cargo. De cada
mascota interesa almacenar el identificador de la mascota, el tipo de animal, peso, fecha de ingreso a la
veterinaria y cantidad de intervenciones. Esta estructura debe estar ordenada por DNI del cliente y debe ser
eficiente para la búsqueda por dicho criterio.
Al finalizar el procesamiento de a), se pide:
b) Implementar un módulo que informe el domicilio del cliente que tiene la menor cantidad de intervenciones
entre todas sus mascotas.
c) Implementar un módulo que imprima los DNI, nombre y apellido de los clientes cuyo número de DNI está
entre 15000000 y 30000000. El listado debe estar ordenado por DNI de manera descendente.
d) Implementar un módulo que imprima, para cada cliente, su nombre y apellido junto al identificador y tipo de
mascota que pese más de 10 kg y que haya ingresado a la veterinaria entre los meses de Enero y Marzo
2023.
e) Realizar un programa que simule el llamado a los módulos realizados.
NOTA: Para poder representar valores de 8 dígitos en el DNI se puede utilizar el tipo de dato longint.}






program GiovannaGotusso;
const
    an=2023;

type

   fecha=record
     d:1..31;
     m:1..12;
     ano:integer;
   end;

    mascota = record
      identificador:integer;
      tipo:string;
      peso:real;
      fecha_ing:fecha;
      cant_int:integer;
    end;
    listaM = ^nodoM;
    nodoM=record
      dato:mascota;
      sig:listaM;
    end;

    dueno = record
       DNI:longint;
       nombre_apellido:string;
       direccion:string;
    end;

    arbol = ^nodoA;
    nodoA=record
      M:listaM;
      d:dueno;
      TOT:integer;
      HI:arbol;
      HD:arbol;
    end;
 procedure agregar_adelante(var M: ListaM;var t:integer ;ide:integer;TIP:string;p:real;f:fecha;cant:integer);
var
  aux: listaM;
begin
  new(aux);
  aux^.dato.identificador := ide;
  aux^.dato.tipo:=TIP;
  aux^.dato.peso:=p;
  aux^.dato.fecha_ing.d:=f.d;
  aux^.dato.fecha_ing.m:=f.m;
  aux^.dato.fecha_ing.ano:=an;
  aux^.dato.cant_int:=cant;
  t:=t + cant;
  aux^.sig := M;
  M:= aux;
end;


procedure insertar_ABB(var a:arbol;ide:integer;TIP:string;p:real;f:fecha;cant:integer;dni:longint;nom_ape:string;dire:string);
begin
  if(a=nil) then begin
     new(a);
     a^.d.DNI:=dni;
     a^.d.nombre_apellido:=nom_ape;
     a^.d.direccion:=dire;
     a^.TOT:=cant;
     a^.M:=nil;
     agregar_adelante(a^.M,a^.TOT,ide,TIP,p,f,cant);
     a^.HD:=nil;
     a^.HI:=nil;
  end
  else begin
     if(a^.d.DNI>dni)then
        insertar_ABB(a^.HI,ide,TIP,p,f,cant,dni,nom_ape,dire)
     else begin
         if(a^.d.DNI<dni)then
           insertar_ABB(a^.HD,ide,TIP,p,f,cant,dni,nom_ape,dire)
         else begin
              if(a^.d.DNI=dni)then
                 agregar_adelante(a^.M,a^.TOT,ide,TIP,p,f,cant);
     end;
  end;
end;
end;

procedure leeer_insertar(mas:mascota;due:dueno;a:arbol);
begin
     writeln('ingrese un dni: ');
     readln(due.DNI);
     while(due.DNI<> 90909090) do begin
       writeln('ingrese un nombre y apellido');
       readln(due.nombre_apellido) ;
       writeln('ingrese un direccion');
       readln(due.direccion);
       writeln('ingrese un identificador') ;
       readln(mas.identificador);
       writeln('ingrese un tipo de mascota') ;
       readln(mas.tipo);
       writeln('ingrese un peso') ;
       readln(mas.peso);
       writeln('ingrese fecha de ingreso') ;
       readln(mas.fecha_ing.d);
       readln(mas.fecha_ing.m);
       readln(mas.fecha_ing.ano);
       writeln('ingrese cantidad de intervenciones') ;
       readln(mas.cant_int);
       insertar_ABB(a,mas.identificador,mas.tipo,mas.peso,mas.fecha_ing,mas.cant_int,due.DNI,due.nombre_apellido,due.direccion);
       writeln('ingrese otro dni');
       readln(due.DNI);
     end;

end;
procedure min (a: arbol; var b:boolean);
var
   x:integer;

begin
  if (a = nil) then begin
    b:= true
  end
  else
  min(a^.HI,b);
  if (b) and (a <> nil) then begin
    x := a^.TOT;
    writeln('la direccion del cliente con la menor cantidad de intervencione es: ', a^.d.direccion);
    b:= false;
  end;
end;

procedure imprimirArbol(a : arbol);
begin
  {En Un EnOrden}
  if (a <> nil) then begin
    imprimirArbol(a^.HD);
    if(a^.d.DNI>=15000000)and(a^.d.DNI<=30000000) then begin
      writeln(a^.d.DNI);
      writeln(a^.d.nombre_apellido);
      writeln(' ');
    end;
    imprimirArbol(a^.HI);
end;
end;
procedure imprimirArbol2(a : arbol);
begin
  {En Un EnOrden}
  if (a <> nil) then begin
    imprimirArbol(a^.HI);
    if(a^.M^.dato.peso>10)and(a^.M^.dato.fecha_ing.m>=1)and (a^.M^.dato.fecha_ing.m<=3)then begin
      writeln(a^.d.nombre_apellido);
      writeln(a^.M^.dato.identificador);
      writeln(a^.M^.dato.tipo);
      writeln(' ');
    end;
    imprimirArbol(a^.HD);
  end;
end;

var
   a:arbol;
   mas:mascota;
   due:dueno;
   b:boolean;
begin
    b:=false;
    a:=nil;
    leeer_insertar(mas,due,a);
    min (a,b);
    imprimirArbol(a);
    imprimirArbol2(a);
end.
