:- use_module(library(lists)).

% EX1
% a)
double(X, Y):- Y is X*2.

map(Pred,L1,L2) :- map_aux(Pred,L1,[],L2).

map_aux(_,[],Res,Res) :- !.
map_aux(Pred, [H|T], Acc, Res) :-   Op =.. [Pred,H,Y], Op,
                                    append(Acc,[Y],New),
                                    map_aux(Pred,T,New,Res).

% b)
sum(A, B, S):- S is A+B.
mul(A, B, S):- S is A*B.

fold(_,V,[],V).
fold(Pred, StartValue, [H|T], FinalValue) :-    Op =.. [Pred,StartValue,H,S], Op,
                                                fold(Pred,S,T,FinalValue).

% c)
even(X):- 0 =:= X mod 2.

separate(List, Pred, Yes, No) :- separate_aux(List, Pred, [], Yes, [], No).

separate_aux([],_,Y,Y,N,N).
separate_aux([H|T], Pred, YAcc, Yes, NAcc, No) :-   Op =.. [Pred,H],
                                                    Op, 
                                                    append(YAcc,[H],YNew),
                                                    separate_aux(T,Pred,YNew,Yes,NAcc,No).
                                    
separate_aux([H|T], Pred, YAcc, Yes, NAcc, No) :-   append(NAcc,[H],NNew),
                                                    separate_aux(T,Pred,YAcc,Yes,NNew,No).

% d)
ask_execute :-  write('Input what you want to run'),nl,
                read(C),
                callable(C),
                call(C).                                                

% EX2
% a)
my_arg(Index, Term, Arg) :- Term =.. List,
                            append(L1,[Arg|_],List),
                            length(L1,Index).

my_functor(Term,Name,Arity) :-  nonvar(Term),
                                Term =.. [Name|Args],
                                length(Args,Arity). 

my_functor(Term,Name,Arity) :-  var(Term),
                                append([],Args,Args),
                                length(Args,Arity),
                                Term =.. [Name|Args].

% b)
univ(Term,List) :-  nonvar(Term),
                    functor(Term, Name, Arity),
                    get_args(Term,Arity,[],Args),
                    List = [Name|Args].
                    
univ(Term,[Name|Args]) :-   nonvar([Name|Args]),
                            length(Args,Arity),
                            functor(Term,Name,Arity),
                            add_args(Term,Arity,Args).

get_args(_,0,Args,Args).
get_args(Term,Arity,Acc,Args) :-    arg(Arity,Term,Arg),
                                    append([Arg],Acc,NAcc),
                                    New is Arity - 1,
                                    get_args(Term,New,NAcc,Args).

add_args(_,0,[]).
add_args(Term,Arity,[Arg|T]) :- arg(Arity,Term,Arg),
                                New is Arity - 1,
                                add_args(Term,New,T).

%c
:- op(1200, xfx, univ).

/* EX3 -> not sure
:-op(500, xfx, na).
:-op(500, yfx, la).
:-op(500, xfy, ra).

a) a ra (b na c)
b) a la b na c
c) (a na b) la c
d) a na b ra c
e) a na b na c
f) ((a) la b) la c
g) a ra (b ra (c))
*/