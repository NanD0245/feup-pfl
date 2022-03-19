% Infos
:- dynamic(participant/3).

% participant(RaceID, PilotName, Laps)
participant(1, asdrubal, [4,5,3,2,1]).
participant(1, bruno,    [1,2,3]).
participant(1, cathy,    [4,5,3,2,6]).
participant(1, dennis,   [5,5,1,1,1]).

participant(2, bruno,    [4,3,2,1]).

% race(RaceID, City, NumberOfLaps)
race(1, porto,  5).
race(2, napoli, 4).
race(3, lyon,   5).

% 1
% raced_in_city(?PilotName, ?City)
raced_in_city(PilotName,City) :-
    participant(RaceID,PilotName,_),
    race(RaceID,City,_).

% 2
% beat_this_time(+RaceID, +PilotName, +MaxTime)
beat_this_time(RaceID,PilotName,MaxTime) :-
    participant(RaceID,PilotName,Laps),
    member(Time,Laps),
    Time < MaxTime.

% 3
% total_time(?RaceID, ?PilotName, ?TotalTime)
total_time(RaceID,PilotName,TotalTime) :-
    participant(RaceID,PilotName,Laps),
    total_time_aux(Laps,TotalTime).

total_time_aux([],0).
total_time_aux([H|T],TotalTime) :-
    total_time_aux(T,NTotalTime),
    TotalTime is NTotalTime + H.

% 4
% register_lap(+RaceID, +PilotName, +LapTime)
register_lap(RaceID,PilotName,LapTime) :-
    participant(RaceID,PilotName,Laps),
    race(RaceID,_,MaxLaps),
    \+ length(Laps,MaxLaps),
    !,
    append(Laps,[LapTime],New),
    retract(participant(RaceID,PilotName,Laps)),
    assert(participant(RaceID,PilotName,New)).


% 5
% count_racers(+RaceID, ?NRacers)
count_racers(RaceID,NRacers) :-
    count_racers_aux(RaceID,[],Racers),
    length(Racers,NRacers).

count_racers_aux(RaceID,Acc,Racers) :-
    participant(RaceID,Name,_),
    \+ member(Name,Acc),
    !,
    append(Acc,[Name],New),
    count_racers_aux(RaceID,New,Racers).

count_racers_aux(_,R,R).

% 6
% most_laps(?City, ?NLaps)
most_laps(City,NLaps) :-
    most_laps_aux([],L,NLaps),
    member(NLaps-City,L).

most_laps_aux(Acc,L,NLaps) :-
    race(_,City,Laps),
    \+ member(Laps-City,Acc),
    !,
    append(Acc,[Laps-City], New),
    most_laps_aux(New,L,NLaps).

most_laps_aux(L,L,NLaps) :-
    keysort(L,Sorted),
    append(_,[NLaps-_],Sorted).

% 7
% print_race(+RaceID)
print_race(RaceID) :-
    participant(RaceID,Name,Laps),
    total_time(RaceID,Name,Time),
    length(Laps,Len),
    write(Name), write(' - '), write(Time), write(' ('), write(Len), write(')'), nl,
    fail.

print_race(_).

% 8
% cities_raced(?PilotName, ?Cities)
cities_raced(PilotName,Cities) :-
    bagof(City,City^RaceID^Laps^NLaps^(
        participant(RaceID,PilotName,Laps),
        race(RaceID,City,NLaps)
    ),Cities).

% 9
% final_rank(?RaceID, ?Pilots)
final_rank(RaceID,Pilots) :-
    participant(RaceID,_,_),
    findall(Time-Name,(
        participant(RaceID,Name,Laps),
        race(RaceID,_,NLaps),
        length(Laps,NLaps),
        total_time(RaceID,Name,Time)
    ), L),!,
    keysort(L,Sorted),
    clean_list(Sorted,Pilots).

clean_list([],[]) :- !.

clean_list([_K-V|T],L2) :-
    clean_list(T,NL2),
    append([V],NL2,L2).

% Info
predX([], _, []).
predX([H|T], A, [H1|T1]):-
    H =.. [_|B],
    H1 =.. [A|B],
    !,
    predX(T, A, T1).

/* 10
Dado uma lista de termos (e.g. [ola(1,4),ole(2,5),oli(3,6)]) e o nome de um termo (e.g. oi), o predicado percorre a 
lista dos termos e altera o nome de cada um (os argumentos mantém-se).
Assim, obtém uma nova lista de termos na qual todos os termos presentes têm o nome dado no 2º argumento (e.g. [oi(1,4),oi(2,5),oi(3,6)])

11 - True

12 - False

13 - A ordenação ideal (em tempo de pesquisa) dos objetivos no corpo de uma regra depende do contexto da aplicação.

14 - É possível definir dois operadores diferentes com o mesmo átomo (símbolo).

15 - É possível definir predicados em Prolog que quebram o paradigma declarativo.
*/

% Infos
task(1, a, 1).
task(1, b, 2).

task(2, a, 2).
task(2, b, 2).
task(2, c, 3).
task(2, d, 1).
task(2, e, 4).
task(2, f, 5).

% O projeto 1 de exemplo não tem precedências

precedence(2, a, b).
precedence(2, a, c).
precedence(2, b, d).
precedence(2, c, d).
precedence(2, d, e).
precedence(2, d, f).

% 17
% generate_order(+Project, ?Order)
generate_order(Project,Order) :-
    findall(A,task(Project,A,_),Tasks),
    length(Tasks,Len),
    generate_order_aux(Project,Len,[],[],Order).

generate_order_aux(Project,Len,Done,Acc,L) :-
    \+ length(Acc,Len),
    findall(Activity,(
        task(Project,Activity,_),
        \+ member(Activity, Done),
        findall(A, (
            precedence(Project,A,Activity),
            \+ member(A, Done)
        ),L),
        length(L,0)
    ),List),
    permutation(List,Permutation),
    append(Acc,Permutation,New),
    append(Done,Permutation,NewDone),
    generate_order_aux(Project,Len,NewDone,New,L).

generate_order_aux(_,Len,_,Acc,L) :- length(Acc,Len), L = Acc.

% 18
% project_tightness(+Project, -Tightness)
project_tightness(Project,Tightness) :-
    findall(Order, generate_order(Project,Order), OrderList),
    findall(Activity, task(Project,Activity,_), L),
    findall(Permutation, permutation(L,Permutation),Permutations),
    length(OrderList,Len1),
    length(Permutations,Len2),
    Tightness is Len1/Len2.
