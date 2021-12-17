% EX1
% a)
fatorial(0,1).
fatorial(N,F) :-    N > 0,
                    N1 is N-1,
                    fatorial(N1,FN1),
                    F is N*FN1.

% b)
somaRec(1,1).
somaRec(N,Sum) :-   N > 0,
                    N1 is N - 1,
                    somaRec(N1,S1),
                    Sum is S1+1.

% c)
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F) :-   N > 1,
                    N1 is N - 1,
                    N2 is N - 2,
                    fibonacci(N1,F1),
                    fibonacci(N2,F2),
                    F is F1+F2.

% d)
isPrime(X) :-   X1 is X - 1,
                isPrime(X,X1).

isPrime(X,1).
isPrime(X,N) :- N > 1,
                X mod N =\= 0,
                N1 is N - 1,
                isPrime(X,N1).

% EX2
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

ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(Z,Y), ancestor(X,Z).

descendent(X,Y) :- parent(Y,X).
descendent(X,Y) :- parent(Y,Z), descendent(X,Z).

% EX3
cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).

chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

superior(X,Y) :- chefiado_por(X,Y).
superior(X,Y) :- chefiado_por(X,Z), superior(Z,Y).

/* EX4

a) yes
b) no
c) yes
d) yes - H = pfl ; T = [pfl,lbaw,redes] 
e) yes - H = lbaw ; T = [ltw]
f) yes - H = leic ; T = []
g) no
h) yes - H = leic ; T = [pfl, ltw, lbaw, redes]
i) yes - H = leic ; T = Two
j) yes - Inst = gram ; Leic = feup
k) yes - One = 1 ; Two = 2 ; Tail = [3,4]
l) yes - One = leic ; Rest = [Two | Tail]

*/

% EX5
% a)
list_size([],0).
list_size([H|T],S) :-   list_size(T,S1),
                        S is S1+1.

% b)
list_sum([],0).
list_sum([H|T],S) :-    list_sum(T,S1),
                        S is S1 + H.

% c)
list_prod([],1).
list_prod([H|T],P) :-   list_prod(T,P1),
                        P is P1 * H.

% d)
inner_product([],[],[]).
inner_product([H1|T1],[H2|T2],[H3|T3]) :-   inner_product(T1,T2,T3),
                                            H3 is H1*H2.

% e)
count(X,[],0).
count(X,[H|T],S) :- count(X,T,S1),
                    (X =:= H -> S is S1 + 1 ; S is S1).


% EX6
% a)
invert(L1,L2) :- reverse(L1,L2,[]).

reverse([],L2,L2).
reverse([H|T],L2,Acc) :- reverse(T,L2,[H|Acc]).

% b)
del_one(X,L1,L2) :- append(La,[X|Lb],L1),
                    append(La,Lb,L2).

% c)
del_all(X,L,L) :- \+member(X,L).

del_all(X,L1,L2) :- del_one(X,L1,L), 
                    del_all(X,L,L2).

% d)
del_all_list([],L,L).
del_all_list([H|T],L1,L2) :-    del_all(H,L1,R),
                                del_all_list(T,R,L2).

% e)
del_dups(L1,L2) :-  del_dups_aux(L1,[],R),
                    invert(R,L2).
        
del_dups_aux([],L,L).
del_dups_aux([H|T],L,L2) :- \+ member(H,L), del_dups_aux(T,[H|L],L2).
del_dups_aux([H|T],L,L2) :- member(H,L), del_dups_aux(T,L,L2).

% f)
list_perm([],L) :- L =:= [].
list_perm([H|T],L2) :-  del_one(H,L2,L),
                        list_perm(T,L).

% g)
my_replicate(N,X,L) :- replicate_aux(N,X,[],L).

replicate_aux(0,X,L,L).
replicate_aux(N,X,L1,L) :-  N > 0,
                            N1 is N - 1,
                            replicate_aux(N1,X,[X|L1],L).

% h)
intersperse(X,[H|T],R) :-   intersperse_aux(X,T,[H],R1),
                            invert(R1,R).

intersperse_aux(X,[],R,R).
intersperse_aux(X,[H|T],L1,R) :- intersperse_aux(X,T,[H,X|L1],R).

% i)
insert_elem(I,L,E,R) :- insert_elem_aux(I,L,E,[],R1),
                        invert(R1,R).

insert_elem_aux(I,[],X,L,L).
insert_elem_aux(0,[H|T],X,L1,R) :-  insert_elem_aux(-1,T,X,[H,X|L1],R).
insert_elem_aux(I,[H|T],X,L1,R) :-  I =\= 0,
                                    I1 is I - 1,
                                    insert_elem_aux(I1,T,X,[H|L1],R).

% j)
delete_elem(I,L,E,R) :- delete_elem_aux(I,L,E,-1,[],R1),
                        invert(R1,R).

delete_elem_aux(I,[],X,X,L,L).
delete_elem_aux(0,[H|T],X,X1,L1,R) :-   delete_elem_aux(-1,T,X,H,L1,R).
delete_elem_aux(I,[H|T],X,X1,L1,R) :-   I =\= 0,
                                        I1 is I - 1,
                                        delete_elem_aux(I1,T,X,X1,[H|L1],R).

% k)
replace(L1,I,O,N,L2) :- delete_elem(I,L1,O,L),
                        insert_elem(I,L,N,L2).


% EX7
% a)
list_append([],L2,L2).
list_append([H|T],L2,[H|T3]) :- list_append(T,L2,T3). 

% b)
list_member(X,[X|_]).
list_member(X,[H|T]) :- list_member(X,T).

% c)
list_last([H|T],R) :- append([H],T,[R|T]).

% d)
list_nth(0,[X|T],X).
list_nth(N,[H|T],X) :-  N > 0,
                    N1 is N - 1,
                    list_nth(N1,T,X).

% e)
list_append(L1,R) :- list_append_aux(L1,[],R).

list_append_aux([],L,L).
list_append_aux([H|T],Acc,L) :- append(Acc,H,R),
                                list_append_aux(T,R,L).

% f)
list_del(L1,X,R) :- append(La,[X|Lb],L1),
                    append(La,Lb,R).

% g)
list_before(X,Y,L) :-   append(La,[X|Lb],L),
                        append(Lc,[Y|Ld],Lb).

% h)
list_replace_one(X,Y,L1,L2) :-  append(La,[X|Lb],L1),
                                append(La,[Y|Lb],L2).

% i)
list_repeated(X,L) :-   append(La,[X|Lb],L),
                        append(Lc,[X|Ld],Lb).

% j)
list_slice(L1,I,N,R) :- append(La,Lb,L1),
                        length(La, I),
                        append(R,Ld,Lb),
                        length(R,N).
                        
% k)
list_shift_rotate(L1,N,R) :-    append(La,Lb,L1),
                                length(La, N),
                                append(Lb,La,R).
                                
% EX8
% a)
list_to(N,L) :- list_to_aux(N,[],L).

list_to_aux(0,L,L).
list_to_aux(N, Acc, L) :-   N > 0,
                            N1 is N - 1,
                            list_to_aux(N1,[N|Acc],L).

% b)
list_from_to(Inf,Sup,R) :- list_from_to_aux(Inf,Sup,[],R).

list_from_to_aux(Inf,Sup,Acc,L) :-  Sup >= Inf,
                                    N is Sup - 1,
                                    list_from_to_aux(Inf,N,[Sup|Acc],L).
list_from_to_aux(Inf,Sup,L,L).

% c)
list_from_to_step(Inf,Step,Sup,R) :-    list_from_to_step_aux(Inf,Step,Sup,[],R).

list_from_to_step_aux(Inf,Step,Sup,Acc,L) :-    Inf =< Sup,
                                                N is Inf + Step,
                                                append(Acc,[Inf],S),
                                                list_from_to_step_aux(N,Step,Sup,S,L).
list_from_to_step_aux(Inf,Step,Sup,L,L).

% e)
primes(N,L) :- primes_aux(N,[],L).

primes_aux(1,L,L).
primes_aux(N,Acc,L) :-  N > 1,
                        N1 is N - 1,
                        (isPrime(N) -> primes_aux(N1,[N|Acc],L) ; primes_aux(N1,Acc,L)).

% f)
fibs(N,L) :-    N1 is N - 1,
                fibs_aux(N1,[],L1),
                (N =:= 0 -> append([],L1,L) ; append([0],L1,L)).

fibs_aux(0,L,L).
fibs_aux(N,Acc,L) :-    N > 0,
                        N1 is N - 1,
                        fibonacci(N,F),
                        fibs_aux(N1,[F|Acc],L).

% EX9
% a)
rle(L1,R) :- rle_aux(L1,[],R).

rle_aux([],L,L).
rle_aux([H|T],Acc,R) :- \+ member(H-X,Acc),
                        append(Acc,[H-1],L1),
                        rle_aux(T,L1,R).

rle_aux([H|T],Acc,R) :- append(La,[H-X|Lb],Acc),
                        X1 is X+1,
                        append(La,[H-X1|Lb],L),
                        rle_aux(T,L,R).

% b)
un_rle(L1,R) :- un_rle(L1,[],R).

un_rle([],L,L).
un_rle([P-V|T],Acc,R) :-    un_rle_aux(V,P,Acc,L),
                            un_rle(T,L,R).

un_rle_aux(0,X,L,L).
un_rle_aux(N,X,Acc,L) :-    N > 0,
                            N1 is N - 1,
                            append(Acc,[X],L1),
                            un_rle_aux(N1,X,L1,L).

