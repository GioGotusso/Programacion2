Program listas;
Type
  Lista= ^Nodo;
  Nodo= Record
           Datos: integer;
           Sig: Lista;
        End;
Var
 L: Lista;
 n: integer;

Procedure AgregarAdelante (var L:lista; num:integer);
Var nue:Lista;
  Begin
    New(nue);
    nue^.datos:=num;
    nue^.sig:=L;
    L:=nue;
  End;


Procedure Imprimir (pri:lista);
Begin
   while (pri <> NIL) do begin
     write (pri^.datos, ' ');
     pri:= pri^.sig
  end;
  writeln;
end;

function min (act: Lista): integer;
var x: integer;
begin
  if (act = nil) then
    min:= 9999
  else begin
    x:= min(act^.Sig);
    if (x < act^.Datos ) then
      min:= x
    else
      min:= act^.Datos;
  end;
end;

procedure print (act:Lista);
begin
  if (act <> nil) then begin
    write(' ',act^.Datos );
    print(act^.Sig);
  end
  else
    write(' nil');
end;

begin
 L:=nil;
 randomize;
 n := random (100);
 While (n<>0) do Begin
   AgregarAdelante (L, n);
   n := random (100);
 End;
 writeln ('Lista generada: ');
 imprimir (L);
 writeln('Nro minimo ', min(L));
 print(L);
 readln;
end.

