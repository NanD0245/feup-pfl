% airport(Name, ICAO, Country)
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

% company (ICAO, Name, Year, Country)
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A.', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

% flight (Designation, Origin, Destination, DepartureTime, Duration, Company)
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').


flight('TP842', 'LPPT', 'LIRF', 150, 195, 'TAP').
% 1
% short(+Flight)
short(Flight) :- 
    flight(Flight,_,_,_,Duration,_),
    Duration < 90.

% 2
% shorter(+Flight1, +Flight2, -ShorterFlight)
shorter(Flight1, Flight2, ShorterFlight) :-
    flight(Flight1,_,_,_,D1,_),
    flight(Flight2,_,_,_,D2,_),
    D1 =\= D2, !,
    (D1 < D2 -> 
        ShorterFlight = Flight1
        ;
        ShorterFlight = Flight2
    ).

% 3
% arrivalTime(+Flight, -ArrivalTime)
arrivalTime(Flight,ArrivalTime) :-
    flight(Flight,_,_,Start,Dur,_),
    timeToMinutes(Start,Minutes),
    M is Dur mod 60,
    H is Dur // 60,
    Total is Minutes + H*60 + M,
    minutesToTime(Total,ArrivalTime).

timeToMinutes(Time,Minutes) :-
    H is Time // 100,
    M is Time mod 100,
    Minutes is H * 60 + M.

minutesToTime(Minutes,Time) :-
    H is Minutes // 60,
    M is Minutes mod 60,
    Time is H * 100 + M.

% 4
% countries(+Company, -ListOfCountries)
countries(Company, ListOfCountries) :- countriesAux(Company,[],ListOfCountries).

countriesAux(Company,Acc,ListOfCountries) :-
    airport(_,_,C),
    \+ member(C,Acc),
    companyCountry(Company,C), !,
    append(Acc,[C],New),
    countriesAux(Company,New,ListOfCountries).

countriesAux(_,L,L).

companyCountry(Company, Country) :- 
    flight(_,Origin,Dest,_,_,Company),
    airport(_,Origin,C1),
    airport(_,Dest,C2),
    member(Country, [C1,C2]).
    
% 5
% pairableFlights/0
pairableFlights :- \+ pairableFlightsAux.

pairableFlightsAux :-
    flight(F1,_,Airport,_,_,_),
    flight(F2,Airport,_,DepTime,_,_),
    arrivalTime(F1,ArrivalTime),
    timeToMinutes(ArrivalTime,M1),
    timeToMinutes(DepTime,M2),
    Diff is M2 - M1,
    Diff >= 30, Diff =< 90,
    write(Airport), write(' - '), write(F1), write(' \\ '), write(F2), nl,
    fail.

% 6
% tripDays(+Trip,+Time,-FlightTimes,-Days)
tripDays(Trip,Time,FlightTimes,Days) :-
    tripDaysAux(Trip,Time,[],1,FlightTimes,Days), !.

tripDaysAux([_C|[]],_,T,D,T,D).

tripDaysAux([Origin,Dest|T],Time, AccTimes, AccDays, FlightTimes,Days) :- 
    next(Origin,Dest,Time,Flight),!,
    flight(Flight,_,_,DepTime,_,_),
    append(AccTimes,[DepTime],New),
    arrivalTime(Flight,ArrivalTime),
    tripDaysAux([Dest|T],ArrivalTime, New, AccDays, FlightTimes,Days).

tripDaysAux([Origin,Dest|T], _, AccTimes, AccDays, FlightTimes,Days) :-
    NDays is AccDays + 1,
    airport(_,Code1,Origin), airport(_,Code2,Dest), !, flight(_,Code1,Code2,_,_,_), % confirma se existe voo
    tripDaysAux([Origin,Dest|T], 0, AccTimes, NDays, FlightTimes,Days), !.

next(Origin,Dest,Time,Flight) :-
    getOptions(Origin,Dest,Time,[],Options),
    keysort(Options, Sorted), !,
    append([_-Flight],_L1,Sorted).

getOptions(Origin,Dest,Time,Acc,Options) :-
    airport(_,Code1,Origin),
    airport(_,Code2,Dest),
    flight(F,Code1,Code2,Start,_,_),
    timeToMinutes(Time,T1),
    timeToMinutes(Start,T2),
    Diff is T2 - T1,
    Diff >= 30,
    \+ member(Diff-F,Acc), !,
    append(Acc,[Diff-F], New),
    getOptions(Origin,Dest,Time,New,Options).

getOptions(_,_,_,L,L).

:- use_module(library(lists)).

% 7
% avgFlightLenghtFromAirport(+Airport,-AvgLenght)
avgFlightLengthFromAirport(Airport,AvgLenght) :-
    findall(Dur,flight(_,Airport,_,_,Dur,_),L),
    length(L,Len),
    sumlist(L,Sum),
    AvgLenght is Sum / Len.

% 8
% mostInternational(+ListOfCompanies)
mostInternational(ListOfCompanies) :-
    findall(Len-Company,(company(Company,_,_,_), countries(Company,Countries), length(Countries,Len)),L),
    sort(L,Sorted),
    reverse(Sorted,List),
    List = [Best-_|_],
    best(List,Best,[],ListOfCompanies).

best([Best-Company|T],Best,Acc,ListOfCompanies) :-
    append(Acc,[Company],New),
    best(T,Best,New,ListOfCompanies),!.

best(_,_,L,L).

% 9 -> tirar cut (!) ao predicado make_pairs
% 10
make_pairs(L,P,[X-Y | Zs]) :-
    select(X,L,L2),
    select(Y,L2,L3),
    G =.. [P, X, Y], 
    G,
    make_pairs(L3, P, Zs).

make_pairs(L,P,Zs) :-
    select(_X,L,L2),
    select(_Y,L2,L3),
    make_pairs(L3, P, Zs).

make_pairs([],_,[]).
make_pairs([_],_,[]).

dif_max_2(X,Y) :- X < Y, X >= Y - 2.

% 11
% make_max_pairs(+L,+P,-S)
make_max_pairs(L,P,S) :- 
    findall(L1,make_pairs(L,P,L1),List),
    List = [H|T],
    length(H,Len),
    longerList(T,Len,H,S).

longerList([],_,L,L).

longerList([H|T],Len,_Acc,S) :-
    length(H,L),
    L > Len, !,
    longerList(T,L,H,S).

longerList([_H|T],Len,Acc,S) :-
    longerList(T,Len,Acc,S).

