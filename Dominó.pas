program domino_ponta_de_5;  {Mário Augusto Mota Martins}
uses crt;
type TPedra=record
      grafico1,grafico2,grafico3,grafico4,grafico5:string[5];
	 x,y:integer;
     end;
     TArquivo=file of TPedra;
     TPlayer=array[1..7] of TPedra;
     TPecas=array[1..28] of TPedra;
     TMesa=record
      numero:integer;
	 coluna:integer;
	 linha:integer;
	end;
var score1,score2,score3,score4,Npedras1,Npedras2,Npedras3,Npedras4,i,vez,t1,t2,t3,t4,jogada,bC,bL:integer;
    num,nome:string;
    mesa:array[1..4] of TMesa;
    pedraArq:array[1..28] of TArquivo;
    pedras,auxP:TPecas; {vetor de pe�as e vetor auxiliar que tambem vai guardar as pe�as mas vai ser alterado pelo subprograma croupier}
    Player1,Player2,Player3,Player4:TPlayer;
    procedure titulo;
    begin
     textcolor(yellow);
	gotoxy(29,1);
     writeln ('Domino Ponta de 5');
     gotoxy(26,1);
     write(chr(177));
     gotoxy(48,1);
     write(chr(177));
     for i:=26 to 48 do
      begin
       gotoxy(i,2);
       write(chr(177));
      end;
     textcolor(white);
    end;
    procedure pontuacao(score1,score2,score3,score4:integer);
    begin
     gotoxy(1,3);
     if vez=1 then
	 begin
	  textcolor(yellow);
	  write(chr(16),'Player1:',score1);
	  textcolor(white);
	 end
	else
	 write(chr(16),'Player1:',score1);
     gotoxy(13,3);
     if vez=2 then
	 begin
	  textcolor(yellow);
	  write('Player2:',score2);
	  textcolor(white);
	 end
	else
	 write('Player2:',score2);
     gotoxy(13,6);
     if vez=3 then
      begin
	  textcolor(yellow);
	  write('Player3:',score3);
	  textcolor(white);
	 end
     else
      write('Player3:',score3);
     gotoxy(13,9);
     if vez=4 then
      begin
	  textcolor(yellow);
	  write('Player4:',score4);
	  textcolor(white);
	 end
     else
      write('Player4:',score4);
    end;
    procedure impressao_para_player(player:TPlayer;u,Npedras:integer); {Imprime as pedras dispon�veis de um player a baixo do score do mesmo}
    var i,x,j:integer;
    begin
     x:=-2;
     j:=0;
	for i:=1 to Npedras do
      begin
	  x:=x+6;
	  gotoxy(u,x);
	  write (player[i].grafico1);
       gotoxy(u,x+1);
	  write (player[i].grafico2);
       gotoxy(u,x+2);
	  write (player[i].grafico3);
       gotoxy(u,x+3);
	  write (player[i].grafico4);
       gotoxy(u,x+4);
	  write (player[i].grafico5);
	  j:=j+6;
	  gotoxy(u+6,j);
	  write (i);
      end;
     if Npedras<7 then
      begin
       for i:=Npedras to 6 do
	   begin
	    x:=x+6;
	    gotoxy(u,x);
	    write ('     ');
         gotoxy(u,x+1);
	    write ('     ');
         gotoxy(u,x+2);
	    write ('     ');
         gotoxy(u,x+3);
	    write ('     ');
         gotoxy(u,x+4);
	    write ('     ');
	    j:=j+6;
	    gotoxy(u+6,j);
	    write(' ');
	   end;
	 end;
    end;
    procedure croupier(auxP:TPecas); {O subprograma Croupier separa as pedras para os jogadores e come�a o jogo identificando quem est� com a buxa 6-6 e iniciando o jogo a partir dele}
    var i,j,n:integer;
    begin
     n:=28;
     for i:=1 to 7 do
  	 begin
	  randomize;
	  Player1[i]:=auxP[random(n)];
	  j:=1;
	  while ((auxP[j].x<>Player1[i].x) or (auxP[j].y<>Player1[i].y)) and (j<=n) do
	   j:=j+1;
	  if j<>n then
	   auxP[j]:=auxP[n];
	  n:=n-1;        
	 end;
	for i:=1 to 7 do
	 begin
	  if (Player1[i].x=6) and (Player1[i].y=6) then
	   begin
	    if i<>7 then
	     Player1[i]:=Player1[7];
	    Npedras1:=Npedras1-1;
	    vez:=1;
	   end;
	 end;
	for i:=1 to 7 do
	 begin
	  randomize;
	  Player2[i]:=auxP[random(n)];
	  j:=1;
	  while ((auxP[j].x<>Player2[i].x) or (auxP[j].y<>Player2[i].y)) and (j<=n) do
	   j:=j+1;
       if j<>n then
	   auxP[j]:=auxP[n];
       n:=n-1;
      end;
     for i:=1 to 7 do
	 begin
	  if (Player2[i].x=6) and (Player2[i].y=6) then
	   begin
	    if i<>7 then
	     Player2[i]:=Player2[7];
	    Npedras2:=Npedras2-1;
	    vez:=2;
	   end;
	 end;
     for i:=1 to 7 do
	 begin
	  randomize;
	  Player3[i]:=auxP[random(n)];
	  j:=1;
	  while ((auxP[j].x<>Player3[i].x) or (auxP[j].y<>Player3[i].y)) and (j<=n) do
	   j:=j+1;
	  if j<>n then
	   auxP[j]:=auxP[n];
	  n:=n-1;
	 end;
	for i:=1 to 7 do
	 begin
	  if (Player3[i].x=6) and (Player3[i].y=6) then
	   begin
	    if i<>7 then
	     Player3[i]:=Player3[7];
	    Npedras3:=Npedras3-1;
	    vez:=3;
	   end;
	 end;
	for i:=1 to 7 do
	 Player4[i]:=auxP[i];
	for i:=1 to 7 do
	 begin
	  if (Player4[i].x=6) and (Player4[i].y=6) then
	   begin
	    if i<>7 then
	     Player4[i]:=Player4[7];
	    Npedras4:=Npedras4-1;
	    vez:=4;
	   end;
	 end;
	 pontuacao(score1,score2,score3,score4);
	 impressao_para_player(Player1,1,Npedras1);
    end;
    procedure posicao(aux:TMesa); {procedimento para impressao da posicao em que o player deseja jogar}
    begin
     if (aux.coluna=mesa[2].coluna) and (aux.linha=mesa[2].linha) then
      begin
	  gotoxy(aux.coluna+2,aux.linha+4);
       textcolor(green);
       write ('2');
       textcolor(white);
      end
     else
      begin
	  gotoxy(aux.coluna+2,aux.linha+1);
       textcolor(green);
       if (aux.coluna=mesa[1].coluna) and (aux.linha=mesa[1].linha) then
	   write ('1')
	  else
	   if (aux.coluna=mesa[3].coluna) and (aux.linha=mesa[3].linha) then
	    write('3')
	   else
         write('4');
       textcolor(white);
      end
    end;
    function arrumacao_de_mesa1(aux:TMesa;pedra:TPedra):TMesa;
     begin
	 if (aux.coluna=mesa[2].coluna) and (aux.linha=mesa[2].linha) then
	  begin
	   if mesa[2].linha=4 then
	    begin
	     arrumacao_de_mesa1.coluna:=55;
	     arrumacao_de_mesa1.linha:=49;
	    end
	   else
	    begin
	     arrumacao_de_mesa1.coluna:=aux.coluna;
          arrumacao_de_mesa1.linha:=aux.linha-5;
         end;
        arrumacao_de_mesa1.numero:=pedra.x;
       end
      else
       begin
	   if aux.linha>=64 then
         begin
          arrumacao_de_mesa1.linha:=4;
		if (aux.coluna=mesa[1].coluna) and (aux.linha=mesa[1].linha) then
		 arrumacao_de_mesa1.coluna:=49
		else
		 if (aux.coluna=mesa[3].coluna) and (aux.linha=mesa[3].linha) then
            arrumacao_de_mesa1.coluna:=61
		 else
		  if (aux.coluna=mesa[4].coluna) and (aux.linha=mesa[4].linha) then 
		   arrumacao_de_mesa1.coluna:=67;
	    end
	   else
	    begin
	     arrumacao_de_mesa1.coluna:=aux.coluna;
          arrumacao_de_mesa1.linha:=aux.linha+5;
         end;
        arrumacao_de_mesa1.numero:=pedra.y;
       end
     end;
    function arrumacao_de_mesa2(aux:TMesa;pedra:TPedra):TMesa;
     begin
	 if (aux.coluna=mesa[2].coluna) and (aux.linha=mesa[2].linha) then
	  begin
	   if mesa[2].linha=4 then
	    begin
	     arrumacao_de_mesa2.coluna:=55;
	     arrumacao_de_mesa2.linha:=49;
	    end
	   else
	    begin
	     arrumacao_de_mesa2.coluna:=aux.coluna;
          arrumacao_de_mesa2.linha:=aux.linha-5;
         end;
        arrumacao_de_mesa2.numero:=pedra.y;
	  end
      else
       begin
        if aux.linha>=64 then
         begin
          arrumacao_de_mesa2.linha:=4;
		if (aux.coluna=mesa[1].coluna) and (aux.linha=mesa[1].linha) then
		 arrumacao_de_mesa2.coluna:=49
		else
		 if (aux.coluna=mesa[3].coluna) and (aux.linha=mesa[3].linha) then
            arrumacao_de_mesa2.coluna:=61
		 else
		  if (aux.coluna=mesa[4].coluna) and (aux.linha=mesa[4].linha) then 
		   arrumacao_de_mesa2.coluna:=67;
	    end
	   else
	    begin
	     arrumacao_de_mesa2.coluna:=aux.coluna;
          arrumacao_de_mesa2.linha:=aux.linha+5;
         end;
        arrumacao_de_mesa2.numero:=pedra.x;
       end
     end;
    procedure impressao_mesa1(m:integer;pedra:TPedra);
    begin 
	gotoxy(mesa[m].coluna,mesa[m].linha);
	write (pedra.grafico1);
	gotoxy(mesa[m].coluna,mesa[m].linha+1);
	write (pedra.grafico2);
	gotoxy(mesa[m].coluna,mesa[m].linha+2);	  
	write (pedra.grafico3);
	gotoxy(mesa[m].coluna,mesa[m].linha+3);
	write (pedra.grafico4);
	gotoxy(mesa[m].coluna,mesa[m].linha+4);
	write (pedra.grafico5);
     mesa[m]:=arrumacao_de_mesa1(mesa[m],pedra);
     posicao(mesa[m]);
    end;
    procedure impressao_mesa2(m:integer;pedra:TPedra);
    begin 
     gotoxy(mesa[m].coluna,mesa[m].linha);
	write (pedra.grafico1);
	gotoxy(mesa[m].coluna,mesa[m].linha+1);
	write (pedra.grafico4);
	gotoxy(mesa[m].coluna,mesa[m].linha+2);	  
	write (pedra.grafico3);
	gotoxy(mesa[m].coluna,mesa[m].linha+3);
	write (pedra.grafico2);
	gotoxy(mesa[m].coluna,mesa[m].linha+4);
	write (pedra.grafico5);
     mesa[m]:=arrumacao_de_mesa2(mesa[m],pedra);
     posicao(mesa[m]);
    end;
    procedure pedras_players(i,Npedras:integer;pedra:TPedra);
    var u:integer;
    begin
	if i<>Npedras then
	 begin
	  u:=1;
	  while (u<Npedras) do
	   begin
	    if (Player1[u].x=pedra.x) and (Player1[u].y=pedra.y) then
	     Player1[u]:=Player1[Npedras]
	    else
          if (Player2[u].x=pedra.x) and (Player2[u].y=pedra.y) then
	      Player2[u]:=Player2[Npedras]
	     else
	      if (Player3[u].x=pedra.x) and (Player3[u].y=pedra.y) then
	       Player3[u]:=Player3[Npedras]
	      else
	       if (Player4[u].x=pedra.x) and (Player4[u].y=pedra.y) then
	        Player4[u]:=Player4[Npedras]
	       else
	        u:=u+1;
	   end;
      end;
    end;
    function Num_pedras(Npedras:integer):integer;
    begin
     Num_pedras:=Npedras-1;
    end;
    function ponto(score:integer):integer;
    begin
     if (mesa[1].numero+mesa[2].numero+mesa[3].numero+mesa[4].numero)mod 5=0 then
      ponto:=score+(mesa[1].numero+mesa[2].numero+mesa[3].numero+mesa[4].numero)
     else
      ponto:=score;
    end;
    procedure automatico(player:TPlayer;Npedras:integer); {subprograma que manipula os 3 jogadores da m�quina}
    var j,i:integer;
        pedra:TPedra;
    begin
     j:=0;
     jogada:=0;
	while (j<=4) and (jogada=0) do
	 begin
	  j:=j+1;
	  i:=1;
	  while (player[i].x<>mesa[j].numero) and (player[i].y<>mesa[j].numero) and (i<=Npedras) do
	   i:=i+1;
	  if player[i].x=mesa[j].numero then
	   begin
	    pedra:=player[i];
	    pedras_players(i,Npedras,pedra);
	    jogada:=1;
         if j=2 then
	     impressao_mesa2(j,pedra)
	    else
	     impressao_mesa1(j,pedra);
	   end
	  else
	   if player[i].y=mesa[j].numero then
	    begin
		pedra:=player[i];
	     pedras_players(i,Npedras,pedra);
	     jogada:=1;	     
		if j=2 then
	      impressao_mesa1(j,pedra)
	     else
	      impressao_mesa2(j,pedra);
	    end
	 end;
	delay(1000);
    end;
    procedure jogador(player:TPlayer;Npedras:integer); {subprograma que administra as jogadas do Player principal)}
    var aux1,aux2,n,t,j,i,a:integer;
        pedra:TPedra;
    begin
     jogada:=0;
	j:=0;
	t:=0;
	while j<=4 do
      begin
	  j:=j+1;
	  for i:=1 to Npedras do
	   begin
	    if (player[i].x=mesa[j].numero) or (player[i].y=mesa[j].numero) then
          begin
	      t:=t+1;
	      a:=j;
	      n:=i;
	     end;
        end;
      end;
     if t=1 then
      begin
       gotoxy(49,1);
       write (chr(16),'Apenas uma opcao.              ');
       pedra:=player[n];
	  pedras_players(n,Npedras,pedra);
	  jogada:=1;
	  if a=2 then
	   begin
	    if player[n].x=mesa[a].numero then
	     impressao_mesa2(a,pedra)
	     else
	      if player[n].y=mesa[a].numero then
	       impressao_mesa1(a,pedra);
	   end
	  else
	   begin
	    if player[n].x=mesa[a].numero then
	     impressao_mesa1(a,pedra)
	    else
	     if player[n].y=mesa[a].numero then
	      impressao_mesa2(a,pedra);
	   end;
	  delay(500);
	  gotoxy(49,1);
	  write('                      ');
	 end
	else
	 if t>0 then
	  begin
	   repeat
	    gotoxy(49,1);
	    write (chr(16),'Qual a pedra que deseja jogar?');
	    gotoxy(49,2);
	    write ('-> ');
         read (aux1);
         gotoxy(49,3);
         write ('                             ');
         gotoxy(49,2);
	    write ('    ');
	    gotoxy(49,3);
	    n:=0;
	    if (aux1<0) or (aux1>Npedras) then
          write ('Informe uma pedra existente!')
	    else
	     if (aux1>0) and (aux1<=Npedras) then
	      begin
		  for i:=1 to 4 do
         	   begin
              if (player[aux1].x=mesa[i].numero) or (player[aux1].y=mesa[i].numero) then
           	begin
		      n:=n+1;
		 	 a:=i;
		 	end;
		   end;
		 end;
         gotoxy(49,3);
	    if n=0 then
          write ('Informe uma pedra valida!');
	   until n>0;
        if n=1 then
         begin
	     pedra:=player[aux1];
	     pedras_players(aux1,Npedras,pedra);
	     jogada:=1;
		if a=2 then
	      begin
	       if player[aux1].x=mesa[a].numero then
	        impressao_mesa2(a,pedra)
	       else
	        if player[aux1].y=mesa[a].numero then
	         impressao_mesa1(a,pedra);
	      end
	     else
	      begin
	       if player[aux1].x=mesa[a].numero then
	        impressao_mesa1(a,pedra)
	       else
	        if player[aux1].y=mesa[a].numero then
	         impressao_mesa2(a,pedra);
	      end;
	     delay(500);
	    end
	   else
	    begin
	     repeat
		 gotoxy(49,1);
	      write (chr(16),'Posicao na mesa?                ');
	      gotoxy(49,2);
	      write ('-> ');
           read (aux2);
           gotoxy(49,2);
	      write ('    ');
           gotoxy(49,2);
           write ('                              ');
           gotoxy(49,2);
           if (player[aux1].x<>mesa[aux2].numero) and (player[aux1].y<>mesa[aux2].numero) then
            write ('Informe uma posicao valida!');
          until (player[aux1].x=mesa[aux2].numero) or (player[aux1].y=mesa[aux2].numero);
	     pedra:=player[aux1];
	     pedras_players(aux1,Npedras,pedra);
	     jogada:=1;
		if aux2=2 then
	      begin
	       if player[aux1].x=mesa[aux2].numero then
	        impressao_mesa2(aux2,pedra)
	       else
	        if player[aux1].y=mesa[aux2].numero then
	         impressao_mesa1(aux2,pedra);
	      end
	     else
	      begin
	       if player[aux1].x=mesa[aux2].numero then
	        impressao_mesa1(aux2,pedra)
	       else
	        if player[aux1].y=mesa[aux2].numero then
	         impressao_mesa2(aux2,pedra);
	      end;
	     delay(500);
         end;
        gotoxy(49,1);
	   write ('                                  ');
	   gotoxy(49,2);
	   write ('       ');
	  end;
    end;
    procedure final;
    begin
	repeat
      textbackground(red);
      clrscr;
	 titulo;
	 pontuacao(score1,score2,score3,score4);
	 gotoxy(27,11);
	 if score1>=100 then
	  write('PARABENS VOCE GANHOU!')
      else
	  write ('FIM DE JOGO, VOCE PERDEU!');
	 delay(500);
	 textbackground(yellow);
	 clrscr;
	 titulo;
	 pontuacao(score1,score2,score3,score4);
	 gotoxy(27,11);
	 if score1>=100 then
	  write('PARABENS VOCE GANHOU!')
      else
	  write ('FIM DE JOGO, VOCE PERDEU!');
	 delay(500);
	until readkey<>' ';
    end;
Begin
 textbackground(red);
 clrscr;
 highvideo;
 score1:=0;
 score2:=0;
 score3:=0;
 score4:=0;
 titulo;
 gotoxy(27,11);
 writeln ('Bem Vindo ao Jogo!');
 gotoxy(11,12);
 writeln ('(pressione qualquer tecla para comecar uma partida)');
 readkey;
 repeat
  textbackground(red);
  clrscr;
  Npedras1:=7;
  Npedras2:=7;
  Npedras3:=7;
  Npedras4:=7;
  titulo;
  gotoxy(27,11);
  writeln ('Destribuindo pedras...');
  for i:=1 to 28 do
   begin
    str(i,num);
    nome:=concat('C:\DominoPontaDe5\Pecas\Pedra_',num,'.arq');
    assign(pedraArq[i],nome);
    reset(pedraArq[i]);
    read(pedraArq[i],pedras[i]);
    Close(pedraArq[i]);
   end;
  for i:=1 to 28 do
   auxP[i]:=pedras[i];
  delay(2000);
  textbackground(red);
  clrscr;
  titulo;
  gotoxy(27,11);
  writeln ('Carregando Cenario...');
  delay(2000);
  textbackground(red);
  clrscr;
  titulo;
  croupier(auxP);
  textcolor(yellow);
  for i:=3 to 46 do {Um contorno pelo espa�o onde as pedras do player 1 e os scores de todos est�o situados}
   begin
    gotoxy(26,i);
    write(chr(177));
   end;
  for i:=1 to 26 do
   begin
    gotoxy(i,46);
    write(chr(177));
   end;
  textcolor(white);
  bC:=34;
  bL:=34;
  for i:=1 to 4 do
   mesa[i].numero:=6;
  textcolor(green);
  mesa[1].coluna:=bC-5;
  mesa[1].linha:=bL;
  gotoxy(bC-1,bL+1);
  write ('1');
  mesa[2].coluna:=bC+2;
  mesa[2].linha:=bL-5;
  gotoxy(bC+4,bL-1);
  write ('2');
  mesa[3].coluna:=bC+9;
  mesa[3].linha:=bL;
  gotoxy(bC+9,bL+1);
  write ('3');
  mesa[4].coluna:=bC+2;
  mesa[4].linha:=bL+3;
  gotoxy(bC+4,bL+3);
  write ('4');
  textcolor(white);
  gotoxy(bC,bL); {primeira pe�a do jogo}
  write (' ___ ___ ');
  gotoxy(bC,bL+1);
  write ('| 6 | 6 |');
  gotoxy(bC,bL+2);
  write ('|___|___|');
  t1:=1;   {variaveis em booleano para identificar se o jogo travou}
  t2:=1;
  t3:=1;
  t4:=1;
  repeat {O jogo em s�, manipula��o das atividades dos players}
   jogada:=0;
   if vez<4 then
    vez:=vez+1
   else
    vez:=1;
   if vez=1 then
    begin
     pontuacao(score1,score2,score3,score4);
	jogador(Player1,Npedras1);
 	if (jogada=1) then
	 begin
	  Npedras1:=Num_pedras(Npedras1);
	  impressao_para_player(Player1,1,Npedras1);
	  score1:=ponto(score1);
	  t1:=1;
	 end
	else
	 t1:=0;
	pontuacao(score1,score2,score3,score4);
    end
   else
    if vez=2 then
     begin
      pontuacao(score1,score2,score3,score4);
	 automatico(Player2,Npedras2);
	 if (jogada=1) then
	  begin
	   Npedras2:=Num_pedras(Npedras2);
	   score2:=ponto(score2);
	   t2:=1;
	  end
	 else
	  t2:=0;
      pontuacao(score1,score2,score3,score4);
	end
    else
     if vez=3 then
      begin
       pontuacao(score1,score2,score3,score4);
	  automatico(Player3,Npedras3);
	  if (jogada=1) then
	   begin
	    Npedras3:=Num_pedras(Npedras3);
	    score3:=ponto(score3);
	    t3:=1;
	   end
       else
	   t3:=0;
	  pontuacao(score1,score2,score3,score4);
	 end
     else
      if vez=4 then
       begin
        pontuacao(score1,score2,score3,score4);
	   automatico(Player4,Npedras4);
	   if (jogada=1) then
	    begin
		Npedras4:=Num_pedras(Npedras4);
	     score4:=ponto(score4);
	     t4:=1;
	    end
        else
	    t4:=0;
	   pontuacao(score1,score2,score3,score4);
	  end;
  until (score1>=100) or (score2>=100) or (score3>=100) or (score4>=100) or (Npedras1=0) or (Npedras2=0) or (Npedras3=0) or (Npedras4=0) or ((t1=0) and (t2=0) and (t3=0) and (t4=0));
  gotoxy(49,1);
  write ('FIM DE PARTIDA! Pressione uma');
  gotoxy(49,2);
  write ('tecla para continuar o jogo.');
  readkey;
 until (score1>=100) or (score2>=100) or (score3>=100) or (score4>=100);
 final;
 normvideo;
End.
