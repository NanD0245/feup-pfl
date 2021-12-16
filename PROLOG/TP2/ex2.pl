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




