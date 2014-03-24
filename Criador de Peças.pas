program Criador_de_pecas; {M�rio Augusto Mota Martins e Vladimir Iuri Moreira Gon�alves}
uses crt;
type TRegistro=record
      grafico1,grafico2,grafico3,grafico4,grafico5:string[5];
	 x,y:integer;
     end;
     TArquivo=file of TRegistro; 
var pedra:TArquivo;
    aux:TRegistro;
    k,i,j:integer;
    num,nome:string;
begin
 writeln ('Valores de x e y da pedra:');
 writeln (' ___ ');
 writeln ('| x |');
 writeln ('|___|');
 writeln ('| y |');
 writeln ('|___|');
 k:=0;
 for i:=0 to 6 do
  begin
   for j:=i to 6 do
    begin
     k:=k+1;
     str(k,num);
     nome:=concat('C:\DominoPontaDe5\Pecas\Pedra_',num,'.arq');
     assign (pedra,nome);
     Rewrite (pedra);
     aux.x:=i;
     aux.y:=j;
	aux.grafico1:=' ___ ';
     str(aux.x,num);
	aux.grafico2:=concat('| ',num,' |');
 	aux.grafico3:='|___|';
 	str(aux.y,num);
     aux.grafico4:=concat('| ',num,' |');
     aux.grafico5:='|___|';
     write(pedra,aux);
     Close(pedra);
    end;
  end;
 assign(pedra,'C:\DominoPontaDe5\Pecas\Pedra_1.arq');
 reset(pedra);
 writeln(aux.grafico1);
 writeln(aux.grafico2);
 writeln(aux.grafico3);
 writeln(aux.grafico4);
 writeln(aux.grafico5);
 Close(pedra);
 readkey;
end.
     
  
