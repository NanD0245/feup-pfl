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

a) a ra b na c
a xfy b xfx c
a xfy (b xfx c)

b) a la b na c
a yfx b xfx c
Conflito: 
    -> la: (a yfx b) xfx c
    -> na: a yfx (b xfx c)

c) a na b la c
a xfx b yfx c
(a xfx b) yfx c

d) a na b ra c
a xfx b xfy c
Conflito: 
    -> na: (a xfx b) xfy c
    -> ra: a xfx (b xfy c)

e) a na b na c
a xfx b xfx c
Conflito: 
    -> na1: (a xfx b) xfx c
    -> na2: a xfx (b xfx c)


f) a la b la c
a yfx b yfx c
(a yfx b) yfx c

g) a ra (b ra (c))
a xfy b xfy c
a xfy (b xfy c)
*/

/* EX4
:-op(550, xfx, de).
:-op(500, fx, aula).
:-op(550, xfy, pelas).
:-op(550, xfx, e).
:-op(600, xfx, as).

a) aula t de pfl as segundas pelas 11.
(fx t xfx pfl) xfx (segundas xfy 11)
((fx t) xfx pfl) xfx (segundas xfy 11)

b) aula tp de pfl as tercas pelas 10 e 30
(fx tp xfx pfl) xfx (tercas xfy 10 xfx 30)
((fx tp) xfx pfl) xfx (tercas xfy (10 xfx 30))

c) aula 11 e aula 12 as 4 pelas cinco pelas 6 pelas sete
(fx 11 xfx fx 12) xfx (4 xfy cinco xfy 6 xfy sete)
((fx 11) xfx (fx 12)) xfx (4 xfy (cinco xfy 6 xfy sete))
((fx 11) xfx (fx 12)) xfx (4 xfy (cinco xfy 6 (xfy sete)))
*/

% EX5
% a)
:- op(500,fx,flight).
:- op(600,xfx,from).
:- op(550,xfx,to).
:- op(550,yfx,at).
:- op(500,xfx,:).

flight tp1949 from porto to lisbon at 16:15.

% b)
:- op(550,fx,if).
:- op(600,xfy,then).
:- op(600,xfy,else).

if X then Y else _Z :- X,Y.
if X then _Y else Z :- \+ X, Z.

% EX6
% a)
:- op(500,xfx,exists_in).

X exists_in L :- member(X, L).

% b)
:- op(550,fy,append).
:- op(550,xfx,to).
:- op(600,yfx,results).

append A to B results C :- append(B,A,C).

% c)
:- op(550,fy,remove).
:- op(550,xfx,from).
:- op(600,yfx,results).

remove Elem from List results Result :- append(L1,[Elem|L2],List),
                                        append(L1,L2,Result).
