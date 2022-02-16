jogo(1,sporting,porto,1-2).
jogo(1,maritimo,benfica,2-0).
jogo(2,sporting,benfica,0-2).
jogo(2,porto,maritimo,1-0).
jogo(3,maritimo,sporting,1-1).
jogo(3,benfica,porto,0-2).

treinadores(porto,[[1-3]-sergio_conceicao]).
treinadores(sporting,[[1-2]-silas,[3-3]-ruben_amorim]).
treinadores(benfica,[[1-3]-bruno_lage]).
treinadores(maritimo,[[1-3]-jose_gomes]).

% 1
% n_treinadores(?Equipa, ?Numero)
n_treinadores(Equipa,Numero) :- 
    treinadores(Equipa,Treinadores),
    length(Treinadores, Numero).
    
% 2
% n_jornadas_treinador(?Treinador, ?NumeroJornadas)
n_jornadas_treinador(Treinador,NumeroJornadas) :-
    treinadores(_,Treinadores),
    append(_,[[Start-End]-Treinador | _],Treinadores),
    NumeroJornadas is End - Start + 1.
    
% 3
% ganhou(?Jornada, ?EquipaVencedora, ?EquipaDerrotada)
ganhou(Jornada,EquipaVencedora,EquipaDerrotada) :-
    jogo(Jornada,EquipaVencedora,EquipaDerrotada,G1-G2), 
    G1 > G2.

ganhou(Jornada,EquipaVencedora,EquipaDerrotada) :-
    jogo(Jornada,EquipaDerrotada,EquipaVencedora,G1-G2),
    G2 > G1.

% 4
% c)

% 5
% e)

% 6
:- op(180,fx,o).
:- op(200,xfx,venceu).

o X venceu o Y :- 
    jogo(_,X,Y,GX-GY),
    GX > GY.

o X venceu o Y :- 
    jogo(_,Y,X,GY-GX),
    GX > GY.

% 7
% predX(?N, +A, +B)
predX(N,N,_).
predX(N,A,B) :-
    A \= B,
    A1 is A + sign(B - A),
    predX(N,A1,B).

% a) Se N for um argumento então verifica se N está dentro dos limites [A,B].
% Caso contrário, N tem o valor de A inicialmente, e a cada Redo faz-se uma aproximação
% de A até B somando 1 ou -1 até que N = A = B

% b) Green Cut -> não altera resultado da função, apenas diminui o backtracking
% tornando a função mais eficiente

% 8
% treinador_bom(?Treinador)
treinador_bom(Treinador) :-
    treinadores(Equipa,Treinadores),
    append(_,[[Start-End]-Treinador | _],Treinadores),
    checkOnlyWins(Equipa,Start,End).

checkOnlyWins(_,Start,End) :- Start > End, !.
checkOnlyWins(Equipa,Start,End) :-
    jogo(Start, Equipa,_, G1-G2),
    !,
    G1 > G2,
    Next is Start + 1,
    checkOnlyWins(Equipa,Next,End).

checkOnlyWins(Equipa,Start,End) :-
    jogo(Start,_, Equipa,G2-G1),
    !,
    G1 > G2,
    Next is Start + 1,
    checkOnlyWins(Equipa,Next,End).

% 9
imprime_totobola(1, '1').
imprime_totobola(0, 'X').
imprime_totobola(-1, '2').

imprime_texto(X,'vitoria da casa') :- X = 1.
imprime_texto(X,'empate') :- X = 0.
imprime_texto(X,'derrota da casa') :- X = -1.

% imprime_jogos(+F)
imprime_jogos(F) :- 
    jogo(Jornada,Casa,Fora,G1-G2),
    write('Jornada '), write(Jornada), write(': '),
    write(Casa), write(' x '), write(Fora), write(' - '),
    (G1 =:= G2 -> 
        X =.. [F,0,A]
    ; G1 > G2 ->
        X =.. [F,1,A]
    ;
        X =.. [F,-1,A]
    ), X,
    write(A), nl, fail.

imprime_jogos(_).

% 10
% e)

% 11
% e)

% 12
% lista_treinadores(?L)
lista_treinadores(L) :-
    findall(Treinador, (
        treinadores(_,Treinadores),
        member(_-Treinador, Treinadores)
    ) , L).

:- use_module(library(lists)).

% 13
% duracao_treinadores(?L)
duracao_treinadores(L) :-
    findall(NumeroJornadas-Treinador, (
        treinadores(_,Treinadores),
        member(_-Treinador, Treinadores),
        n_jornadas_treinador(Treinador,NumeroJornadas)
    ) , List),
    sort(List, Sorted),
    reverse(Sorted,L).

% 14
% pascal(+N, -L)
pascal(1,[1]).
pascal(2,[1,1]).
pascal(N,L) :-
    N1 is N - 1,
    pascal(N1,L1), !,
    pascalAux(L1,[1],L).

pascalAux([_A|[]],Next,Row) :- 
    append(Next,[1],Row). 

pascalAux([A,B|T],Next,Row) :-
    Elem is A + B,
    append(Next,[Elem],New),
    pascalAux([B|T],New,Row).
