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
