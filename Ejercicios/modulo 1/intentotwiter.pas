Program twitter2;
Uses
     sysutils;
Type
     tweet = record
	      codigoUsuario: integer;
	      nombreUsuario: string;
	      mensaje: string;
	      esRetweet: boolean;
     end;

     listaTweets = ^nodoLista;
     nodoLista = record
               dato: tweet;
               sig: listaTweets;
     end;
     {estreuctura de la nueva lista}
     listasMensajes = ^mensajes;
     mensajes = record
              texto: string;
              esRestweet: boolean;
              sig: listasMensajes;
     end;
     listaUsuarios= ^usuario;
     usuario= record
              codigoUsuario: integer;
	      nombreUsuario: string;
              sig: listaUsuarios;
              mensaje: listasMensajes;
     end;

     {Completar agregando aquí las estructuras de datos necesarias en el ejercicio}

{agregarAdelante - Agrega nro adelante de l}
Procedure agregarAdelante(var l: listaTweets; t: tweet);
var
   aux: listaTweets;
begin
     new(aux);
     aux^.dato := t;
     aux^.sig := l;
     l:= aux;
end;



{crearLista - Genera una lista con tweets aleatorios}
procedure crearLista(var l: listaTweets);
var
   t: tweet;
   texto: string;
   v : array [1..10] of string;
begin
     v[1]:= 'juan';
     v[2]:= 'pedro';
     v[3]:= 'carlos';
     v[4]:= 'julia';
     v[5]:= 'mariana';
     v[6]:= 'gonzalo';
     v[7]:='alejandro';
     v[8]:= 'silvana';
     v[9]:= 'federico';
     v[10]:= 'ruth';

     t.codigoUsuario := random(11);
     while (t.codigoUsuario <> 0) do Begin
          texto:= Concat(v[t.codigoUsuario], '-mensaje-', IntToStr(random (200)));
          t.nombreUsuario := v[t.codigoUsuario];
          t.mensaje := texto;
          t.esRetweet := (random(2)=0);
          agregarAdelante(l, t);
          t.codigoUsuario := random(11);
     end;
end;


{imprimir - Muestra en pantalla el tweet}
procedure imprimir(t: tweet);
begin
     with (t) do begin
          write('Tweet del usuario @', nombreUsuario, ' con codigo ',codigoUsuario, ': ', mensaje, ' RT:');
          if(esRetweet)then
               writeln(' Si')
          else
               writeln('No ');
     end;
end;


{imprimirLista - Muestra en pantalla la lista l}
procedure imprimirLista(l: listaTweets);
begin
     while (l <> nil) do begin
          imprimir(l^.dato);
          l:= l^.sig;
     end;
end;


{agregarElemento - Resuelve la inserción de la estructura ordenada}
procedure agregarOrdenado(var pri:listaTweets; t:tweet);
var
   nuevo, anterior, actual: listaTweets;
begin
     new (nuevo);
     nuevo^.dato:= t;
     nuevo^.sig := nil;
     if (pri = nil) then
          pri := nuevo
     else
     begin
          actual := pri;
          anterior := pri;
          while (actual<>nil) and (actual^.dato.nombreUsuario < nuevo^.dato .nombreUsuario) do begin
               anterior := actual;
               actual:= actual^.sig;
          end;
          if (anterior = actual) then
               pri := nuevo
          else
               anterior^.sig := nuevo;
          nuevo^.sig := actual;
     end;
end;


{generarNuevaEstructura - Resuelve la generación estructura ordenada}
procedure generarNuevaEstructura (lT: listaTweets; VAR listaOrdenada: listaTweets);
begin
     listaOrdenada := nil;
     while(lT <> nil) do begin
          agregarOrdenado(listaOrdenada, lT^.dato);
          lT := lT^.sig;
     end;
end;
   {modulos para la nueva lista}
procedure agregarU ( var lu:listaUsuarios; lt:listaTweets );
var aux1:listaUsuarios ;
begin
     if(lt <> nil) then
         new(aux1);
         aux1^.codigoUsuario := lt^.dato.codigoUsuario;
         aux1^.nombreUsuario := lt^.dato.nombreUsuario;
         aux1^.mensaje := nil;
         aux1^.sig:= lu;
         lu := aux1;
end;
procedure agregarM ( var lM:listasMensajes; lt:listaTweets );
var aux1:listasMensajes ;
begin
     if(lt <> nil) then
         new(aux1);
         aux1^.esRestweet := lt^.dato.esRetweet ;
         aux1^.texto := lt^.dato.mensaje;
         aux1^.sig := lM;
         lM := aux1;
end;

procedure recorrerNuevaLista( var lu:listaUsuarios; lt:listaTweets )  ;
begin
     while(lt <> nil) do begin
         agregarU(lu,lt);
         agregarM(lu^.mensaje,lt);
         lt:=lt^.sig;
         while ((lt <> nil) and (lu^.codigoUsuario= lt^.dato.codigoUsuario)) do begin
                agregarM(lu^.mensaje,lt);
                lt:=lt^.sig;
         end;
     end;
end;
procedure imprimirM (l:listasMensajes)  ;
begin
     while(l<> nil ) do begin
            write(' - texto : ' , l^.texto);
            write(' retweet : ' , l^.esRestweet);
            l:=l^.sig;
     end;
end;
procedure imprimirU (l:listaUsuarios);
begin
     while(l<> nil) do begin
         writeln('  nom : ' , l^.nombreUsuario);
         write('  /  cod : ' , l^.codigoUsuario);
         imprimirM(l^.mensaje);
         l:=l^.sig;
         writeln(' ');
     end;
end;

var
   lt,l_ordenada: listaTweets;
   lu:listaUsuarios;
begin
     Randomize;
     lu:=nil;
     lt:= nil;
     crearLista(lt);
     writeln ('Lista generada: ');
     imprimirLista(lt);

     {Se crea la estructura ordenada}
     l_ordenada:= nil;
     generarNuevaEstructura(lt,l_ordenada);
     writeln ('Lista ordenada: ');
     imprimirLista(l_ordenada);  
     recorrerNuevaLista(lu,l_ordenada);
     {Completar el programa}
     imprimirU(lu);
     writeln('Fin del programa');
     readln;
end.

