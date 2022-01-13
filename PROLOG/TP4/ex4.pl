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
flight(paris, ola, lufthansa, lh1177, 1230, 165).

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
find_flights_depth(Origin,Dest,Flights) :- find_flights_depth(Origin,Dest,[Origin],Flights).

find_flights_depth(Origin,Dest,Acc,Flights) :-  flight(Origin,Dest,_,_,_,_), append(Acc,[Dest],Flights).
find_flights_depth(Origin,Dest,Acc,Flights) :-  flight(Origin,Mid,_,_,_,_),
                                                \+ member(Mid, Acc),
                                                append(Acc,[Mid],New),
                                                find_flights_depth(Mid,Dest,New,Flights).

% d) 
find_flights_breadth(S, F, Path):- find_flights_breadth([S], F, [],Path). 

find_flights_breadth([F|_], F, V, [F]) :- !.
find_flights_breadth([S|R], F, V,Path) :-   findall(N,(flight(S,N,_,_,_,_), \+ member(N, V), \+ member(N, [S|R])),  L),
                                    append(R, L, NR),
                                    find_flights_breadth(NR, F, [S|V], OLDPath), !,
                                    append([H],T,OLDPath), 
                                    (flight(S,H,_,_,_,_) -> % not 100% sure about this solution
                                        append([S],OLDPath,Path)
                                    ;
                                        Path = OLDPath
                                    ).