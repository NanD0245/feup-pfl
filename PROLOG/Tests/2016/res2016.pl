% participant(id, age, performance)
participant(1234,17,'Pé coxinho').
participant(3423,21,'Programar com os pés').
participant(3788,20,'Sing a Bit').
participant(4865,22,'Pontes de esparguete').
participant(8937,19,'Pontes de pen-drives').
participant(2564,20,'Moodle hack').

% performance(id,times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

% 1
% madeItThrough(+Participant)
madeItThrough(Participant) :-
    performance(Participant,Times),
    member(120, Times).
    
% 2
% juriTimes(+Participant,+JuriMember,-Times,-Total)
juriTimes([],_,[],0).

juriTimes([H|T],JuriMember,Times,Total) :-
    juriTimes(T,JuriMember,NTimes,NTotal),
    performance(H,L),
    Len is JuriMember - 1,
    length(L1, Len),
    append(L1,[Time|_],L),
    append([Time],NTimes,Times),
    Total is NTotal + Time.

% 3    
% patientJuri(+JuriMember)
patientJuri(JuriMember) :-
    patientJuriAux(JuriMember,[],Count),
    Count >= 2.

patientJuriAux(JuriMember, Acc, Count) :-
    performance(A,Times),
    \+ member(A,Acc),
    !,
    append(Acc,[A],New),
    patientJuriAux(JuriMember, New, NCount),
    Len is JuriMember - 1,
    length(L1, Len),
    append(L1,[Time|_],Times),
    (Time =:= 120 -> 
        Count is NCount + 1
    ;
        Count is NCount
    ).

patientJuriAux(_,_,0).

% 4
% bestParticipant(+P1,+P2,P)
bestParticipant(P1,P2,P) :-
    performance(P1,Times1),
    performance(P2,Times2),
    getSumTime(Times1,Time1),
    getSumTime(Times2,Time2),
    !,
    (Time1 > Time2 ->
        P = P1
    ; Time1 < Time2 ->
        P = P2
    ).

getSumTime([],0).
getSumTime([H|T], Time) :-
    getSumTime(T,NTime),
    Time is NTime + H.

% 5
% allPerfs/0
allPerfs :-
    performance(P,Times),
    participant(P,_,PName),
    write(P),write(':'),write(PName),write(';'),write(Times),nl,
    fail.

allPerfs.


% 6
% nSuccessfulParticipants(-T)
nSuccessfulParticipants(T) :-
    findall(P,(
        participant(P,_,_),
        performance(P,Times),
        checkTimes(Times)
    ),L),
    length(L,T).

checkTimes([]).
checkTimes([H|T]) :-
    H =:= 120,
    checkTimes(T).

:- use_module(library(lists)).

% 7
% juriFans(-L)
juriFans(L) :-
    findall(ID-Juris,(
        performance(ID,Times),
        findall(A,nth1(A,Times,120),Juris)
    ),L).

% 8
eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

% nextPhase(+N, -Participants)
nextPhase(N,Participants) :-
    setof(TT-Id-Perf,_Age^(
        participant(Id,_Age,Perf),
        eligibleOutcome(Id,Perf,TT)
    ),L),
    sort(L, Sorted),
    reverse(Sorted,L1),
    length(Participants,N),
    append(Participants, _, L1).

% 9
predX(Q, [R | Rs], [P | Ps]) :-
    participant(R,I,P),
    I =< Q,
    predX(Q,Rs,Ps).

predX(Q, [R | Rs], Ps) :-
    participant(R,I,_),
    I > Q,
    predX(Q,Rs,Ps).

predX(_,[],[]).

% predicado que recebe uma idade (Q) e uma lista de participantes ([R|Rs]) 
% que retorna lista com o nome da atuação dos participantes com idade menor
% ou igual a Q

% Green Cut pois não influência o resultado, apenas melhora eficiência diminuindo
% o backtracking do predicado

% 10
impoe(X,L) :-
    length(Mid,X),
    append(L1, [X|_], L),
    append(_,[X|Mid], L1).

% predicado sucede se existe uma sublista de tamanho X em que o elemento 
% anterior e seguinte da sublista é X (e.g. X = 2, [2,1,1,2])

% 11
% langford(+N,-L)
langford(N,L) :- 
    Len is N*2,
    length(L,Len),
    langfordAux(N,L).

langfordAux(0,_).
langfordAux(N,L) :-
    impoe(N,L),
    N1 is N - 1,
    langfordAux(N1,L).










