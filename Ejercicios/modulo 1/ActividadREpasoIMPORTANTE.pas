Program ActividadREpasoIMPORTANTE;
Uses
     sysutils, unit1;
Type
     str70= string[70];

     jugador = record
            DNI: longint;
	    nombre_apellido: str70;
            equipo: str70;
	    goles: integer;
     end;

     lista = ^nodoLista;
     nodoLista = record
	    dato: jugador;
	    sig: lista;
     end;

	fecha=record
		dia:1..31;
		mes:1..12;
		anio:integer;
	end;

    partido= record
		identificador: longint;
		local: str70;
		visitante: str70;
		fecha_partido: fecha;
        estadio: str70;
		goleadores: lista;
     end;

     listaPartidos = ^nodoPartidos;
     nodoPartidos = record
            dato: partido;
            sig: listaPartidos;
     end;

     nombres= array [1..20] of str70;

     {Completar con los tipos de datos necesarios}

// punto A
     listaGoles=^nodoGoles;
     nodoGoles= record
            sig: listaGoles;
            f: fecha;
            goles: integer  ;
     end;
     jug = record
            dni: longint ;
            nom: str70 ;
            equipo: str70;
            l: listaGoles;
            goles: integer;
     end;
     arbol = ^nodoA;
     nodoA = record
            dato: jug;
            HD: arbol;
            HI: arbol;
     end;

// Punto D
     listaNivel = ^nodoN;
       nodoN = record
         info: arbol;
         sig: listaNivel;
       end;



procedure cargarFecha(var f: fecha);
begin
  f.dia:= random(30)+1;
  f.mes := random(12)+1;
  if(f.mes = 2) and (f.dia > 28)then
	f.dia := 28
  else
	if((f.mes = 4) or (f.mes = 6) or (f.mes =9) or (f.mes = 11)) and (f.dia = 31)then
		f.dia := 30;
  f.anio:=2022;
end;

Procedure agregar(var l: listaPartidos; p: partido);
var
   aux: listaPartidos;
begin
     new(aux);
     aux^.dato := p;
     aux^.sig := l;
     l:= aux;
end;

Procedure agregarJugador(var l: lista; j: jugador);
var
   aux: lista;
begin
     new(aux);
     aux^.dato := j;
     aux^.sig := l;
     l:= aux;
end;

procedure cargarEquipos(var v:nombres );
begin
     v[1]:='Atletico Tucuman';
     v[2]:='Huracan';
     v[3]:='Gimnasia LP';
     v[4]:='Godoy Cruz';
     v[5]:='Argentino Juniors';
     v[6]:='River';
     v[7]:='Boca';
     v[8]:='Racing';
     v[9]:='Platense';
     v[10]:='San Lorenzo';
     v[11]:='Patronato';
     v[12]:='Estudiantes';
     v[13]:='Union';
     v[14]:='Newells';
     v[15]:='Barracas';
     v[16]:='Tigre';
     v[17]:='Arsenal';
     v[18]:='Sarmiento';
     v[19]:='Central';
     v[20]:='Colon';
end;

procedure cargarJugadores(var l: lista; local, visitante:str70);
var
   j: jugador;
   cant, i, pos, loc_vis: integer;
   v: nombres;
begin
     cant := random(2);
     v[1]:='Lionel Perez';
     v[2]:='Martin Fernandez';
     v[3]:='Mariano Gomez';
     v[4]:='Alejandro Gonzalez';
     v[5]:='Fermin Martinez';
     v[6]:='Nicolas Castro';
     v[7]:='Gonzalo Villareal';
     v[8]:='Tadeo Parodi';
     v[9]:='Juan Pablo Silvestre';
     v[10]:='Mariano Sanchez';
     v[11]:='Alejo Monden';
     v[12]:='Agustin Paz';
     v[13]:='Juan Salto';
     v[14]:='Matias Pidone';
     v[15]:='Luis Hernandez';
     v[16]:='Cristian Herrera';
     v[17]:='Santiago Manzur';
     v[18]:='Julian Darino';
     v[19]:='Victor Abila';
     v[20]:='Luciano Segura';
     if((local='Colon')or(visitante='Colon'))then
     begin
        with(j) do begin
           DNI := 34807474;
           nombre_apellido:='Leandro Romanut';
		   equipo:='Colon';
		   goles:=random(3)+1;
        end;
        agregarJugador(l, j);
     end;
     for i:=1 to cant do
     begin
       with(j) do begin
          DNI := random(18000000)+20000000;;
          pos:= random(20)+1;
          nombre_apellido:= v[pos];
          loc_vis:= random(2)+1;
          if(loc_vis=1)then
            equipo:=local
          else
            equipo:=visitante;
	      goles:=random(3)+1;
       end;
       agregarJugador(l, j);
     end;
end;

procedure crearLista(var l: listaPartidos);
var
   p: partido;
   cant,i,pos,loc,vis: integer;
   v, v2: nombres;
begin
     cant := random(20)+1;
     v[1]:= 'Antonio Vespucio Liberti';
     v[2]:= 'Mario Alberto Kempes';
     v[3]:= 'Alberto Armando';
     v[4]:= 'Ciudad de La Plata';
     v[5]:= 'Presidente Peron';
     v[6]:= 'Jose Amalfitani';
     v[7]:= 'Tomas Adolfo Duco';
     v[8]:= 'Libertadores de America';
     v[9]:= 'Pedro Bidegain';
     v[10]:= 'Nestor Diaz Perez';
     v[11]:= 'Marcelo Bielsa';
     v[12]:= 'Gigante de Arroyito';
     v[13]:= 'Malvinas Argentinas';
     v[14]:= 'Brigadier General Estanislao Lopez';
     v[15]:= 'Eduardo Gallardon';
     v[16]:= 'Jose Maria Minella';
     v[17]:= 'Florencio Sola';
     v[18]:= 'Monumental Jose Fierro';
     v[19]:= 'Nueva España';
     v[20]:= 'Nuevo Francisco Urbano';
     cargarEquipos(v2);
     for i:=1 to cant do
     begin
          with(p) do begin
               identificador:= random (100000)+1;
               pos:= random(20)+1;
               estadio:= v[pos];
               loc:= random(20)+1;
               local:=v2[loc];
               vis:= random(20)+1;
               visitante:=v2[vis];
               while(local=visitante)do
               begin
                   vis:= random(20)+1;
                   visitante:=v2[vis];
               end;
               cargarFecha(fecha_partido);
               goleadores:= nil;
               cargarJugadores(goleadores, local, visitante);
          end;
          agregar(l, p);
       end;
end;


procedure imprimirJugador(j: jugador);
begin
     with (j) do begin
          writeln('JUGADOR: ', nombre_apellido, ' | DNI: ',DNI, ' | EQUIPO: ', equipo, ' | GOLES: ', goles);
     end;
end;

procedure imprimirJugadores(l: lista);
begin
     while (l <> nil) do begin
          imprimirJugador(l^.dato);
          l:= l^.sig;
     end;
end;

procedure imprimir(p: partido);
begin
     with (p) do begin
          writeln('');
          writeln('PARTIDO: ', identificador, ' | EQ. LOCAL: ',local, ' | EQ. VISITANTE: ', visitante, ' | FECHA: ', fecha_partido.dia,'/',fecha_partido.mes,'/',fecha_partido.anio, ' | ESTADIO: ', estadio);
          imprimirJugadores(goleadores);
     end;
end;

procedure imprimirLista(l: listaPartidos);
begin
     while (l <> nil) do begin
          imprimir(l^.dato);
          l:= l^.sig;
     end;
end;

// Punto A

procedure cargarlistita(var l: listaGoles; f:fecha; p:integer);
var
aux: listaGoles;
begin
new(aux);
aux^.f.anio := f.anio;
aux^.f.mes := f.mes;
aux^.f.dia := f.dia;
aux^.goles := p;
aux^.sig := l;
l:= aux;
end;

procedure insertar_en_ABO (var a:arbol; j:jugador; f:fecha);
begin
 if(a=nil)then begin
   new(a);
   a^.dato.dni:=j.DNI;
   a^.dato.nom:=j.nombre_apellido;
   a^.dato.equipo:=j.equipo;
   a^.dato.l:=nil;
   cargarlistita(a^.dato.l,f,j.goles);
   a^.HI:=nil;
   a^.HD:=nil;
   a^.dato.goles:=j.goles;
 end
 else begin
   if(a^.dato.dni>j.DNI)then begin
     insertar_en_ABO(a^.HI,j,f);
   end
   else begin
      if(a^.dato.dni<j.DNI)then
        insertar_en_ABO(a^.HD,j,f)
      else begin
        cargarlistita(a^.dato.l,f,j.goles);
        a^.dato.goles:=a^.dato.goles + j.goles;
      end;
   end;
 end;
end;

procedure recorrer_lista_jugadores(var a:arbol; l:lista; f:fecha);
begin
  while(l<>nil)do begin
      insertar_en_ABO(a,l^.dato,f);
      l:=l^.sig;
  end;
end;

procedure Recorrer_lista_de_listas (var a:arbol; l:listaPartidos);

begin
  while (l<>nil)do begin
      recorrer_lista_jugadores(a,l^.dato.goleadores,l^.dato.fecha_partido);
      l:=l^.sig;
  end;
end;

// Punto B
procedure Maximo (a: arbol; var equipo: str70; var max: integer);
begin
  if (a<>nil) then begin
    Maximo(a ^.HI, equipo, max);
    Maximo(a ^.HD, equipo, max);
    if (a^.dato.goles > max ) then begin
      max:= a^.dato.goles;
      equipo:= a^.dato.equipo;
    end;
  end;
end;

// Punto C

procedure recorrer_acotado (a:arbol; Inf,Sup:longint);
begin
  if (a <> nil) then
    if (a^.dato.dni >= Inf) then
      if (a^.dato.dni<= Sup) then begin
        recorrer_acotado(a^.hi,Inf,Sup);
        writeln(' DNI', a^.dato.dni,' Nombre : ',a^.dato.nom);
        recorrer_acotado (a^.hd,Inf,Sup);
      end
      else
        recorrer_acotado(a^.hi,Inf,Sup)
    else
      recorrer_acotado(a^.hd,Inf,Sup);
end;

// Punto D

procedure min (a: arbol; var x: longint; var b: boolean);
begin
  if (a = nil) then begin
    b:= true
  end
  else
  min(a^.HI,x,b);
  if (b) and (a <> nil) then begin
    x := a^.dato.dni;
    b:= false;
  end;
end;

procedure borrarElemento ( var a: arbol; x: longint; var res: boolean);
var
   aux:arbol; b: boolean; D: integer;
begin
  if (a= nil) then
    res:= false
  else begin
    if (a^.dato.dni > x) then
      borrarElemento (a^.HI,x,res)
    else begin
      if (a^.dato.dni < x) then
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
            a^.dato.dni:=D;
            borrarElemento(a^.HD,D,b);
          end;
        end;
        res:= true;
      end;
    end;
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
                      write (l^.info^.dato.dni, ' - ');
                      write (l^.info^.dato.nom, ' - ');
                      write (l^.info^.dato.equipo, ' - ');
                      write (l^.info^.dato.goles, ' - ');
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

var
   l: listaPartidos; b:boolean; max: integer; a: arbol; equipo: str70;
begin
     max:= -1;
     Randomize;

     l:= nil;
     crearLista(l); {carga automatica de la estructura disponible}
     writeln ('LISTA GENERADA: ');
     imprimirLista(l);

     {Completar el programa}

     writeln('Jugadores con DNI ');
     Recorrer_lista_de_listas(a,l);

     Maximo(a,equipo, max);
     writeln('Equipo del jugador con mas goles ', equipo, ' con ', max, ' goles' );

     recorrer_acotado(a,28000000,32000000 );

     imprimirpornivel(a);
     borrarElemento(a,34807474,b);
     imprimirpornivel(a);

     writeln('Fin del programa');
     readln;
end.


