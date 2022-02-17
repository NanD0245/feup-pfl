:- dynamic round/4.

% round(RoundNumber, DanceStyle, Minutes, [Dancer1-Dancer2 | DancerPairs])
% round/4 indica, para cada ronda, o estilo de dança, a sua duração, e os pares de dançarinos participantes.
round(1, waltz, 8, [eugene-fernanda]).
round(2, quickstep, 4, [asdrubal-bruna,cathy-dennis,eugene-fernanda]).
round(3, foxtrot, 6, [bruna-dennis,eugene-fernanda]).
round(4, samba, 4, [cathy-asdrubal,bruna-dennis,eugene-fernanda]).
round(5, rhumba, 5, [bruna-asdrubal,eugene-fernanda]).

% tempo(DanceStyle, Speed).
% tempo/2 indica a velocidade de cada estilo de dança.
tempo(waltz, slow).
tempo(quickstep, fast).
tempo(foxtrot, slow).
tempo(samba, fast).
tempo(rhumba, slow).


% 1
% style_round_number(?DanceStyle, ?RoundNumber)
style_round_number(DanceStyle,RoundNumber) :-
    round(RoundNumber,DanceStyle,_,_).

% 2
% n_dancers(?RoundNumber, -NDancers)
n_dancers(RoundNumber,NDancers) :-
    round(RoundNumber,_,_,Dancers),
    length(Dancers,Len),
    NDancers is Len * 2.

% 3
% danced_in_round(?RoundNumber, ?Dancer)
danced_in_round(RoundNumber,Dancer) :-
    round(RoundNumber,_,_,Dancers),
    member(Dancer-_,Dancers).

danced_in_round(RoundNumber,Dancer) :-
    round(RoundNumber,_,_,Dancers),
    member(_-Dancer,Dancers).

% 4
% n_rounds(-NRounds)
n_rounds(NRounds) :-
    n_rounds_list([],L),
    length(L,NRounds).

n_rounds_list(Acc,L) :-
    round(A,_,_,_),
    \+ member(A,Acc),
    !,
    append(Acc,[A],New),
    n_rounds_list(New,L).

n_rounds_list(L,L).

% 5
% add_dancer_pair(+RoundNumber, +Dancer1, +Dancer2)
add_dancer_pair(RoundNumber,Dancer1,Dancer2) :-
    round(RoundNumber,D,M,Dancers),
    \+ danced_in_round(RoundNumber,Dancer1),
    \+ danced_in_round(RoundNumber,Dancer2),
    append(Dancers,[Dancer1-Dancer2],L),
    retract(round(RoundNumber,D,M,Dancers)),
    assert(round(RoundNumber,D,M,L)).

% 6
% total_dance_time(+Dancer,-Time)
total_dance_time(Dancer,Time) :-
    total_dance_time_aux(Dancer,[],Time).

total_dance_time_aux(Dancer,Acc,Time) :-
    danced_in_round(RoundNumber,Dancer),
    round(RoundNumber,_,M,_),
    \+ member(RoundNumber,Acc),
    !,
    append(Acc,[RoundNumber],New),
    total_dance_time_aux(Dancer,New,NTime),
    Time is NTime + M.

total_dance_time_aux(_,_,0).

% 7
% print_program/0
print_program :-
    round(_,D,M,L),
    length(L,Len),
    write(D), write(' ('), write(M), write(') - '), write(Len), nl,
    fail.

print_program.
    
% 8
% dancer_n_dancers(?Dancer, ?NDances)
dancer_n_dancers(Dancer,NDances) :-
    bagof(R, danced_in_round(R,Dancer), L),
    length(L,NDances).
    
% 9
% most_tireless_dancer(-Dancer)
most_tireless_dancer(Dancer) :-
    setof(Time-D,S^M^P^R^( % podia usar o findall (repetidos não interessam neste ex)
        round(R,S,M,P),
        danced_in_round(R,D),
        total_dance_time(D,Time)
    ),L),
    sort(L,[Dancer|_]).

% 10
predX([],0).
predX([X|Xs],N):-
    X =.. [_|T],
    length(T,2),
    !,
    predX(Xs,N1),
    N is N1 + 1.

predX([_|Xs],N):-
    predX(Xs,N).

% dado uma lista de termos, retorna em N o número de termos com dois argumentos

% 11
% Red Cut -> influência o resultado devido ao backtracking do predicado.

% 12
% e) A unificação produz sempre o mínimo de substituições possíveis para que X e Y sejam idênticos

% 13
% e) O uso de listas de diferença permite reimplementar certos predicados de complexidade temporal quadrática em tempo linear

% 14
% e) :- op(580, xfy, and)

% 15
% a) :- op(600, xfx, dances).

% 16
edge(a,b).
edge(a,c).
edge(a,d).
edge(b,e).
edge(b,f).
edge(c,b).
edge(c,d).
edge(c,e).
edge(d,a).
edge(d,e).
edge(d,f).
edge(e,f).

:- use_module(library(lists)).

% shortest_safe_path(+Origin, +Destination, +ProhibitedNodes, -Path)
shortest_safe_path(Origin,Destination,ProhibitedNodes,Path) :-
    \+ member(Origin,ProhibitedNodes),
    \+ member(Destination,ProhibitedNodes),
    bfs([[Origin]],Destination,ProhibitedNodes,InvPath),
    reverse(InvPath,Path).

bfs( [ [Nf|T]|_], Nf, _, [Nf|T]).
bfs( [ [Na|T]|Ns], Nf, PNs, Sol):-
    findall(
        [Nb,Na|T],
        (edge(Na,Nb), \+member(Nb, [Na|T]), \+member(Nb, PNs)),
        Ns1),
    append(Ns, Ns1, Ns2),
    bfs(Ns2, Nf, PNs, Sol).

% 17
% all_shortest_safe_paths(+Origin, +Destination, +ProhibitedNodes, -ListOfPaths)
all_shortest_safe_paths(Origin,Destination,ProhibitedNodes,ListOfPaths) :-
    shortest_safe_path(Origin,Destination,ProhibitedNodes,ShortestPath),
    !,
    length(ShortestPath,Len),
    findall(Path,(
        shortest_safe_path(Origin,Destination,ProhibitedNodes,Path),
        length(Path,Len)
    ),ListOfPaths).


connects_bfs([[F|T]|_], F, _, [F|T]).
connects_bfs([[S|T]|R], F, V, Sol):-
    findall([N,S|T],
        ( edge(S, N),
        \+ member(N, V),
        \+ member(N, [S|T])
    ), L),
    append(R, L, NR),
    connects_bfs(NR, F, [S|V],Sol).









