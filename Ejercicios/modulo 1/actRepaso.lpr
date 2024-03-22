Program actRepaso;
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

     arbol=^nodoA;
     nodoA=record
         nom:string;
         cod_U:integer;
         cant:integer;
         HI:arbol;
         HD:arbol;
     end;
   listaNivel = ^nodoN;
   nodoN = record
     info: arbol;
     sig: listaNivel;
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
   a: integer;
begin
     a:=0;
     t.codigoUsuario := random(20);
     if (t.codigoUsuario = 0) then begin
        t.codigoUsuario := 1;
        a:= a + 1;
     end;
     while (a <> 4) do Begin
          texto:= Concat(IntToStr(t.codigoUsuario), '-mensaje-', IntToStr(random (200)));
          t.nombreUsuario := Concat('Usuario-',IntToStr(t.codigoUsuario));
          t.mensaje := texto;
          t.esRetweet := (random(2)=0);
          agregarAdelante(l, t);
          t.codigoUsuario := random(20);
           if (t.codigoUsuario = 0) then begin
             t.codigoUsuario := 1;
             a:= a + 1;
           end;
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


procedure insertar_ABB(var a:arbol; S:string; C:integer);
begin
  if(a=nil) then begin
     new(a);
     a^.cod_U:=C;
     a^.nom:=S;
     a^.cant:=1;
     a^.HD:=nil;
     a^.HI:=nil;
  end
  else begin
     if(a^.cod_U>C)then
        insertar_ABB(a^.HI,S,C)
     else begin
         if(a^.cod_U<C)then
           insertar_ABB(a^.HD,S,C)
         else begin
              if(a^.cod_U=C)then
                 a^.cant:=a^.cant+1;
     end;
   end;
 end;
end;

procedure en_Orden(a:arbol);
var
   max:integer;
begin
     max:=-1;
     if(a<>nil)then begin
        en_Orden(a^.HI);
        if(a^.cant>max)then
           writeln('el nombre con mayor cantidad de tweets es: ',a^.nom);
        en_Orden(a^.HD);
     end;

end;

Procedure Recorrido_Acotado(a: arbol; inf:integer; sup:integer);
begin
  if (a <> nil) then
    if (a^.cod_U>= inf) then
      if (a^.cod_U<= sup) then begin
        write('cant tweets: ',a^.cant);
       Recorrido_Acotado(a^.hi, inf, sup);
       Recorrido_Acotado (a^.hd, inf, sup);
      end
      else
       Recorrido_Acotado(a^.hi, inf, sup)
    else
      Recorrido_Acotado(a^.hd, inf, sup);
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


{-----------------------------------------------------------------------------
AGREGARATRAS - Agrega un elemento atrás en l}

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
                      write (l^.info^.cod_U, ' - ');
                      write (l^.info^.nom, ' - ');
                      write (l^.info^.cant, ' - ');
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
   l: listaTweets;
   a:arbol;
begin
     Randomize;

     l:= nil;
     crearLista(l);
     writeln ('Lista generada: ');
     imprimirLista(l);

     {Completar el programa}
    {cargo el arbol con el codigo de usuario y con el nombre}
     while(l<>nil)do begin
          insertar_ABB(a,l^.dato.nombreUsuario,l^.dato.codigoUsuario);
          l:=l^.sig;
     end;
    writeln('el arbol generado es: ');
    imprimirpornivel(a);
    Recorrido_Acotado(a,100,700);

     en_Orden(a);



     writeln('Fin del programa');
     readln;
end.
