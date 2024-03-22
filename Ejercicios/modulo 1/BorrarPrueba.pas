program BorrarPrueba;
type
  arbol= ^nodo;
  nodo= record
    dato: integer;
    HD: arbol;
    HI: arbol;
  end;

procedure MinP (a: arbol; var min: arbol);
begin
  if (a^.HI <> nil) then
    MinP(a^.HI, min)
  else
    min:= a;
end;

procedure eliminar (var a: arbol; x: integer);
var aux,aux2: arbol;
begin

  if(a<> nil) then begin
    if (a^.dato < x) then
      eliminar(a^.HD,x)
    else begin
      if (a^.dato > x) then
        eliminar(a^.HI,x)
      else begin
        if (a^.HD = nil) then begin
          if (a^.HI = nil) then begin
            aux:= a;
            a:= nil;
            dispose(aux);
          end
          else begin
            aux:= a;
            a:= a^.HI;
            dispose(aux);
          end;
        end
        else begin
          if (a^.HI = nil) then begin
            aux:= a;
            a:= a^.HD;
            dispose(aux);
          end
          else begin
            MinP(a^.HD,aux);
            a^.dato:=aux^.dato;
            aux2:= aux;
            aux:= nil;
            dispose(aux2);
          end;
        end;
      end;
    end;
  end;
end;

procedure CargarArbol (var a:arbol; r: integer; var b: boolean);
begin
  if (a= nil) then begin
    new (a);
    a^.dato:=r;
    a^.HD:=nil;
    a^.HI:=nil;
  end
  else begin
    if (a^.dato > r) then
      CargarArbol(a^.HI,r,b)
    else begin
      if (a^.dato < r) then
        CargarArbol(a^.HD,r,b)
      else
        b:= false;
    end;
  end;
end;

procedure ImprimirPreOrden(a: arbol);
begin
  if (a<>nil)then begin
    writeln(' | ',a^.dato);
    ImprimirPreOrden(a^.HI);
    ImprimirPreOrden(a^.HD);
  end;
end;

procedure DisposeEnOrden(a: arbol);
begin
  if (a<>nil)then begin
    DisposeEnOrden(a^.HI);
    dispose(a);
    DisposeEnOrden(a^.HD);
  end;
end;

var
a: arbol; x,r: integer; b: boolean;
begin
randomize;
b:= true;
r:= random(50);
while (b) do begin
  CargarArbol(a,r, b);
  r:= random(50);
end;
writeln('Lista Inicial: ');
ImprimirPreOrden(a);
writeln('Nro A Borrar: ');
readln(x);
eliminar(a,x);
writeln('Lista Nueva: ');
ImprimirPreOrden(a);
DisposeEnOrden(a);
readln();
end.

