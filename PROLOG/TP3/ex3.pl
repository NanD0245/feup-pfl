:- use_module(library(between)).

% EX1
s(1).
s(2):- !.
s(3).
/*
a) 1? -> 2? -> no
b) X=1,Y=1? -> X=1,Y=2? -> X=2,Y=1? -> X=2,Y=2? -> no
c) X=1,Y=1? -> X=1,Y=2? -> no
*/

% EX2
data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a(five).
cut_test_b(X):- data(X), !.
cut_test_b(five).
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c(five, five).

/*
a) "one\ntwo\ntree\nfive"
b) "one"
c) "one-one\none-two\none-tree"
*/

% EX3
person(p1). turtle(t1). spider(s1). bat(b1). age(t1,55). % examples

immature(X):- adult(X), !, fail. % a)
immature(X).
adult(X):- person(X), !, age(X, N), N >=18. % b)
adult(X):- turtle(X), !, age(X, N), N >=50. % c)
adult(X):- spider(X), !, age(X, N), N>=1. % d)
adult(X):- bat(X), !, age(X, N), N >=5. % e)
/*
a) red
b) green
c) green
d) green
e) green
*/

% EX4
% a)
print_n(S,0) :- !.
print_n(S,N) :- N1 is N-1,
                write(S),
                print_n(S,N1).

% b)
print_text(T,S,P) :-    write(S),
                        print_n(' ',P),
                        print_string(T),
                        print_n(' ',P),
                        write(S).

print_string([]) :- !.
print_string([H | T]) :- put_code(H),
print_string(T).
                
% c)
print_banner_full(T,S,P) :- length(T,L),
                            Len is L + (P * 2) + 2,
                            print_n(S,Len),
                            nl.

print_banner_edge(T,S,P) :- length(T,L),
                            Len is L + P * 2,
                            print_n(S,1),
                            print_n(' ',Len),
                            print_n(S,1),
                            nl.

print_banner(T,S,P) :-  print_banner_full(T,S,P),
                        print_banner_edge(T,S,P),
                        print_text(T,S,P), nl,
                        print_banner_edge(T,S,P),
                        print_banner_full(T,S,P).

% d)
read_number(X) :-   read_number(X,0).

read_number(X,X) :- peek_code(10), !, skip_line.

read_number(X,Acc) :-   get_code(Char),
                        char_code('0',Zero),
                        N is Char - Zero,
                        Next is Acc * 10 + N,
                        read_number(X,Next).

% e)
read_until_between(Min,Max,Value) :- repeat, read_number(Value), between(Min,Max,Value).

% f)
read_string(X) :- read_string(X,[]).

read_string(X,X) :- peek_code(10), !, skip_line.

read_string(X,Acc) :-   get_code(Char),
                        append(Acc,[Char],Next),
                        read_string(X,Next).

% g)
banner :-   print_string("Text = "),
            read_string(T), nl,
            print_string("Symbol = "),
            get_char(S), skip_line, nl,
            print_string("Padding = "),
            read_number(P), 
            nl,nl,
            print_banner(T, S, P).

% h)
print_multi_banner([H|T],S,P) :-    get_string_max_len([H|T],SMAX),
                                    print_banner_full(SMAX,S,P),
                                    print_banner_edge(SMAX,S,P),
                                    length(SMAX,Len),
                                    print_multi_banner([H|T],S,P,Len),
                                    print_banner_edge(SMAX,S,P),
                                    print_banner_full(SMAX,S,P). 

print_multi_banner([],_,_,_) :- !.
print_multi_banner([H|T],S,P,Len) :-    length(H,L1),
                                        (((Len - L1)) mod 2 =:= 0 ->
                                            append([],H,NH),
                                            NP is P + (Len - L1) div 2
                                        ;
                                            append(H,[32],NH),
                                            NP is P + (Len - L1) div 2
                                        ),
                                        print_text(NH,S,NP),
                                        nl,
                                        print_multi_banner(T,S,P,Len).

get_string_max_len(L,S) :- get_string_max_len(L,0,[],S).

get_string_max_len([],_,S,S) :- !.
get_string_max_len([H|T], Acc, SAcc, S) :-  length(H,Length),
                                            (Length > Acc -> 
                                                get_string_max_len(T,Length,H,S)
                                            ; 
                                                get_string_max_len(T,Acc,SAcc,S)
                                            ).

% i)
oh_christmas_tree(N) :- get_tree(N,1),
                        N1 is N - 1,
                        print_n(' ',N1),
                        print_n('*',1),
                        print_n(' ',N1).

get_tree(0,_).
get_tree(N,C) :-    N1 is N - 1,
                    C1 is C + 2,
                    print_n(' ',N1),
                    print_n('*',C),
                    print_n(' ',N1),
                    nl, get_tree(N1,C1).

% EX5

female('Grace').
male('Frank').
female('DeDe').
male('Jay').
female('Gloria').
male('Javier').
female('Barb').
male('Merle').
male('Phill').
female('Claire').
female('Mitchell').
male('Joe').
female('Manny').
male('Cameron').
female('Pameron').
male('Bo').
male('Dylan').
female('Haley').
female('Alex').
male('Luke').
female('Lily').
male('Rexford').
male('Calhoun').
male('George').
female('Poppy').

parent('Grace','Phill').
parent('Frank','Phill').
parent('DeDe','Claire').
parent('Jay','Claire').
parent('DeDe','Mitchell').
parent('Jay','Mitchell').
parent('Gloria','Joe').
parent('Jay','Joe').
parent('Gloria','Manny').
parent('Javier','Manny').
parent('Barb','Cameron').
parent('Merle','Cameron').
parent('Barb','Pameron').
parent('Merle','Pameron').
parent('Phill','Haley').
parent('Claire','Haley').
parent('Phill','Alex').
parent('Claire','Alex').
parent('Phill','Luke').
parent('Claire','Luke').
parent('Mitchell','Lily').
parent('Cameron','Lily').
parent('Mitchell','Rexford').
parent('Cameron','Rexford').
parent('Pameron','Calhoun').
parent('Bo','Calhoun').
parent('Dylan','George').
parent('Haley','George').
parent('Dylan','Poppy').
parent('Haley','Poppy').

% a)
children(Person, Children) :- findall(Child, parent(Person,Child), Children).

% b)
children_pair(P,C) :- findall(P-Child, parent(P,Child),C).

children_of(LP,LC) :- children_of(LP,[],LC).

children_of([],L,L) :- !.
children_of([H|T],Acc,L) :- children_pair(H,L1),
                            append(Acc,L1,New),
                            children_of(T,New,L).

% c)
relative(P1,P2) :- parent(P1,P2).
relative(P1,P2) :- parent(P2,P1).

family(F) :- setof(P2, P1^relative(P1,P2),F).

% d)
couple(X-Y) :- parent(X,Z), parent(Y,Z), X \= Y.

% e)
couples(L) :- setof(C, couple(C), L).

% f)
spouse_children(P,S/C) :- setof(C, (couple(P-S), parent(P,C), parent(S,C)), C).

% g)
spouse_children_list(P,L) :- setof(S/L1, spouse_children(P,S/L1), L).

parents(Child,Parents) :- findall(P,parent(P,Child),Parents).

immediate_family(Person, P-C) :-    parents(Person,P),
                                    spouse_children_list(Person,C).

% h)
parents_of_two(Parents) :- setof(P, X^Y^(parent(P,X),parent(P,Y),X \= Y), Parents).

% EX6
uc(algoritmos).
uc(bases_de_dados).
uc(compiladores).
uc(estatistica).
uc(redes).

teacher(adalberto,algoritmos).
teacher(bernardete,bases_de_dados).
teacher(capitolino,compiladores).
teacher(diogenes,estatistica).
teacher(ermelinda,redes).

student(alberto,algoritmos).
student(bruna,algoritmos).
student(cristina,algoritmos).
student(diogo,algoritmos).
student(eduarda,algoritmos).
student(antonio,bases_de_dados).
student(bruno,bases_de_dados).
student(cristina,bases_de_dados).
student(duarte,bases_de_dados).
student(eduardo,bases_de_dados).
student(alberto,compiladores).
student(bernardo,compiladores).
student(clara,compiladores).
student(diana,compiladores).
student(eurico,compiladores).
student(antonio,estatistica).
student(bruna,estatistica).
student(claudio,estatistica).
student(duarte,estatistica).
student(eva,estatistica).
student(alvaro,redes).
student(beatriz,redes).
student(claudio,redes).
student(diana,redes).
student(eduardo,redes).

% a)
teachers(Teachers) :- setof(T,UC^teacher(T,UC),Teachers).

% b) --the same

% c)
students_of(T, S) :- setof(A,UC^(teacher(T,UC), student(A,UC)),S).

% d)
teachers_of(S, T) :- setof(P, UC^(student(S,UC), teacher(P,UC)),T).

% e)
common_courses(S1, S2, C) :- setof(UC,(student(S1,UC),student(S2,UC)),C).

% f)
more_than_one_course(L) :- setof(S,UC1^UC2^(student(S,UC1),student(S,UC2),UC1 \= UC2),L).

% g)
colleague(X,Y) :- student(X,_UC), student(Y,_UC), X \= Y.

strangers(X,Y) :- \+ colleague(X,Y), X \= Y.

strangers(L) :- setof(S1-S2, UC1^UC2^(student(S1,UC1), student(S2,UC2), strangers(S1,S2)),L).

% h)
good_groups(L) :- setof(S1-S2,colleague(S1,S2),L).

% EX7

class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).
class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).
class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).
class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).
class(rc, t, '4 Qui', 8, 2).
class(rc, tp, '5 Sex', 10.5, 2).

% a)
same_day(UC1, UC2) :-   class(UC1,_,D,_,_),
                        class(UC2,_,D,_,_).

% b)
daily_courses(Day, Courses) :- findall(UC,class(UC,_,Day,_,_),Courses).

% c)
short_classes(L) :- findall(UC-Day/Hour, (class(UC,_,Day,Hour,D), D < 2), L).

% d)
course_classes(Course, Classes) :- findall(Day/Hour/Type, class(Course,Type,Day,Hour,_), Classes).

% e)
courses(L) :- setof(UC, A^B^C^D^class(UC,A,B,C,D), L). 

% f)
schedule :- setof(Day/Time-Dur/UC/Type, class(UC,Type,Day,Time,Dur), L),
            write(L).

% g)
translate('1 Seg','seg'). 
translate('2 Ter','ter'). 
translate('3 Qua','qua'). 
translate('4 Qui','qui'). 
translate('5 Sex','sex').

schedule_formatted :-   setof(New/Time-Dur/UC/Type, Day^(class(UC,Type,Day,Time,Dur),translate(Day,New)), L),
                        write(L).

% h)
find_class :-   read(Day),
                read(Hour),
                class(UC,Type,Day,Hour,Dur),
                write(UC/Type/Day/Hour/Dur).

