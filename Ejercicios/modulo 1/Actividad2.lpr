program Actividad2;

type

   libro=record
     titulo:string;
     ISBN:integer;
     c_Biblio:string;
   end;

  arbol=^nodoA;
  nodoA=record
    dato:libro;
    HI:arbol;
    HD:arbol;
  end;

procedure  cargar_Arbol(a:arbol; l:libro);
begin
     with l do
       witreln('ingrese un ISBN: ')
       readln(ISBN)
       while(ISBN<>0)do begin
         readln(titulo);
         readln(c_Biblio);
         insertar_ABB(a,ISBN,titulo,c_Biblio);
         readln(ISBN);
       end;
end;

procedure insertar_ABB(var a:arbol; l:libro);
begin
  if(a=nil) then begin
     new(a);
     a^.dato:=l;
     a^.HD:=nil;
     a^.HI:=nil;
  end
  else begin
     if(a^.dato.ISBN>l.ISBN)then
        insertar_ABB(a^.HI,l)
     else begin
         if(a^.dato.ISBN<l.ISBN)then
           insertar_ABB(a^.HD,l);
     end;
  end;
end;


begin
end.

