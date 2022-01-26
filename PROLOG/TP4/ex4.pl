% utils
invert(L1,L2) :- reverse(L1,L2,[]).

reverse([],L2,L2).
reverse([H|T],L2,Acc) :- reverse(T,L2,[H|Acc]).

equal(X,X).

:- dynamic male/1, female/1.

% EX1
% a)
add_person :-   write('Gender? (male/female)'),nl,
                read(Gender),
                write('Name?'),nl,
                read(Name),
                save_person(Gender,Name).

save_person(male,Name) :- assert(male(Name)).
save_person(female,Name) :- assert(female(Name)).

% b)
:- dynamic parent/2.

add_parents(Person) :-  write('Father name? (male/female)'),nl,
                        read(FName),
                        write('Mother name? (male/female)'),nl,
                        read(MName),
                        save_person(male,FName),
                        save_person(female,MName),
                        assert(parent(FName,Person)),
                        assert(parent(MName,Person)).

% c)
remove_person :-    write('Name?'),nl,
                    read(Name),
                    retractall(male(Name)),
                    retractall(female(Name)),
                    retractall(parent(Name,_)).

% EX2
%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).
flight(paris, ola, lufthansa, lh1111, 1111, 111).

% a)
get_all_nodes(L) :- setof(Orig, Dest^Comp^Code^Hour^Dur^flight(Orig,Dest,Comp,Code,Hour,Dur),L).

% b)
company_flights(Company,N) :-   findall(Company, flight(_,_,Company,_,_,_), L),
                                length(L,N).

most_diversified(Company) :-    setof(Comp-N, Dest^Orig^Code^Hour^Dur^(flight(Orig,Dest,Comp,Code,Hour,Dur), company_flights(Comp,N)),L),
                                get_most_common(L,Company).

get_most_common(L,Company) :- get_most_common(L,0,_C,Company).

get_most_common([],_,Comp,Comp) :- !.
get_most_common([C-N|T], Num, Acc, Comp) :-  (N > Num ->
                                            get_most_common(T,N,C,Comp)
                                        ;
                                            get_most_common(T,Num,Acc,Comp)
                                        ).

% c)
find_flights(Origin,Dest,Flights) :- find_flights(Origin,Dest,[Origin],Flights).

find_flights(Origin,Dest,Acc,Flights) :-    flight(Origin,Dest,_,_,_,_), append(Acc,[Dest],[O|F]),get_codes(O,F,[],Flights).
find_flights(Origin,Dest,Acc,Flights) :-    flight(Origin,Mid,_,_,_,_),
                                            \+ member(Mid, Acc),
                                            append(Acc,[Mid],New),
                                            find_flights(Mid,Dest,New,Flights).

get_codes(_,[],Flights,Flights).
get_codes(Origin,[H|T],Acc,Flights) :-  flight(Origin,H,_,Code,_,_),
                                        append(Acc,[Code],New),
                                        get_codes(H,T,New,Flights).

% d)    
find_flights_breadth(Origin,Dest,Flights) :- find_flights_breadth([Origin],Dest,[Origin],[[Origin]],Flights).

find_flights_breadth([Dest | _], Dest, _V, Acc, Flights) :- append(_,[[Dest|T]|_],Acc), append([],[Dest|T],P), invert(P,[O|F]), get_codes(O,F,[],Flights).

find_flights_breadth([S | R], F, V, Acc, Flights) :-
            findall(N, (flight(S,N,_,_,_,_), \+ member(N,V), \+ member(N, [S|R])),L),
            append_flights(L,S,Acc,[],New),
            append(R, L, NR),
            find_flights_breadth(NR,F,[S|V],New,Flights).

append_flights([],_,[],New,New).
append_flights(_L,S,[[H|T]|TT],Acc,New) :- \+ equal(H,S), append(Acc, [[H|T]], NAcc), append_flights(_L,S,TT,NAcc,New).
append_flights([],S,[_|TT],Acc,New) :- append_flights([],S,TT,Acc,New).
append_flights([A|AA],S,[H|TT],Acc,New) :-  append([A],H,F),
                                            append(Acc,[F],NAcc),
                                            append_flights(AA,S,[H|TT],NAcc,New).

% e)
find_all_flights(Origin, Dest, ListOfFlights) :- setof(Flights,Origin^Dest^find_flights(Origin,Dest,Flights),ListOfFlights).

% f)
find_flights_least_stops(Origins, Destinations, ListOfFlights) :- find_flights_least_stops(Origins, Destinations, [], ListOfFlights).

find_flights_least_stops([], [], ListOfFlights, ListOfFlights).
find_flights_least_stops([Origin|OT], [Dest|DT], Acc, ListOfFlights) :- find_flights_breadth(Origin, Dest, L),
                                                                        append(Acc,[L],New),
                                                                        find_flights_least_stops(OT,DT,New,ListOfFlights).
