% EX1
% 1.1

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

/* 1.2
a) female('Haley'). -> yes
b) male('Gil'). -> no
c) parent('Frank','Phill'). -> yes
d) parent(X, 'Claire'). -> DeDe ; Jay
e) parent('Gloria', X). -> Joe ; Manny 
f) parent('Jay', Y),parent(Y,X). -> Haley ; Alex ; Luke ; Lily ; Rexford
g) parent('Alex',X). -> no
j) parent('Jay', X),\+ parent('Gloria', X). -> Claire ; Mitchell
*/

% 1.3
father(X,Y) :- parent(X,Y),male(X).
grandparent(X,Z) :- parent(X,Y),parent(Y,Z).
siblings(X,Y) :- parent(P1,X),parent(P2,X),parent(P1,Y),parent(P2,Y),P1\=P2,X\=Y.
halfsiblings(A, B) :- parent(P, A), parent(P, B), A \= B, \+ siblings(A, B).
cousins(X,Y) :- parent(Z,X),siblings(Z,W),parent(W,Y),\+parent(Z,Y).
uncle(X,Y) :- parent(P,Y),siblings(P,X),male(X).

/* 1.4
cousins('Haley','Lily').
father(X,'Luke').
uncle(X,'Lily').
grandparent(X,_),female(X).
siblings(X,Y).
halfsiblings(X,Y).
*/

% 1.5
married('Jay','Gloria',2008).
married('Jay','Dede',1968).
divorce('Jay','Dede',2003).


% EX2
% 2.1

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

/* 2.2
teacher(diogenes,UC).
teacher(felisma,_).
student(claudio,UC).
student(dalmindo,_).
student(eduarda,_UC),teacher(bernardete,_UC).
student(alberto,_UC), student(alvaro,_UC).
*/

% 2.3
student_of(X,T) :- student(X,_UC), teacher(T,_UC). % i. && ii.

teacher_of(T,X) :- student(X,_UC), teacher(T,_UC).

student_of(X,T1,T2) :-  student(X,UC1),
                        student(X,UC2),
                        UC1 \= UC2, 
                        teacher(T1,UC1),
                        teacher(T2,UC2).

colleague(X,Y) :- student(X,_UC), student(Y,_UC), X \= Y.
colleague(X,Y) :- teacher(X,_), teacher(Y,_), X \= Y.

more_than_one_uc(A) :- student(A,UC1), student(A,UC2), UC1 \= UC2. 


% EX3
% 3.1

pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team_of(breitling,lamb).
team_of(red_bull,besenyei).
team_of(red_bull,chambliss).
team_of(mediterranean_racing_team,maclean).
team_of(cobra,mangold).
team_of(matador,jones).
team_of(matador,bonhomme).

plane_of(mx2,lamb).
plane_of(edge540,besenyei).
plane_of(edge540,chambliss).
plane_of(edge540,maclean).
plane_of(edge540,mangold).
plane_of(edge540,jones).
plane_of(edge540,bonhomme).

circuits(instanbul).
circuits(budapest).
circuits(porto).

winner_of(jones,porto).
winner_of(mangold,budapest).
winner_of(mangold,instanbul).

num_gates_of(9,instanbul).
num_gates_of(6,budapest).
num_gates_of(5,porto).

team_win(T,C) :- team_of(T,P),winner_of(P,C).

/* 3.2
winner_of(P,porto).

team_win(T,porto).

num_gates_of(N,C),N > 8.

plane_of(PL,P), PL \= edge540.

winner_of(P,_C1),winner_of(P,_C2),_C1\=_C2.

plane_of(PL,P),winner_of(P,porto).
*/

% EX4

meaning_of('Integer Overflow', 1).
meaning_of('Divisao por zero', 2).
meaning_of('ID Desconhecido', 3).

traduz(Codigo, Significado) :- meaning_of(Significado,Codigo).

% EX5

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

/* 5.1
Qual é o cargo do sisnando e que é chefe dos analistas?

Qual é o cargo que é chefe dos técnicos e que tem cargos superiores?

Quem é que tem cargo que é chefiado pelos supervisores?

Qual é o cargo, sem ser o da felismina, que é chefiado pelo diretor?
*/

/* 5.2
X = supervisor

X = engenheiro, Y = supervisor

J = analista,P = leonilde

P = supervisor_chefe
*/

% 5.3
chefe(X,Y) :- cargo(C1,X),cargo(C2,Y),chefiado_por(C2,C1).

chefiadas_por(X,Y,_) :- cargo(C1,X),
                        cargo(C2,Y),
                        cargo(C3,_),
                        chefiado_por(C1,C3),
                        chefiado_por(C2,C3).

nao_chefia(C) :- cargo(C,_), \+chefiado_por(_,C).

sem_chefe(P) :- cargo(C,P), \+chefiado_por(C,_).

/* EX6

X = 2 ; Y = 4 ? no
X = 2 ; Y = 16 ? no
X = 4 ; Y = 4 ? yes
X = 4 ; Y = 16 ? no
X = 1 ? yes

pairs(X,Y). -> (2,4) ; (1,1)
*/

% EX7

a(a1, 1).
a(A2, 2).
a(a3, N).

b(1, b1).
b(2, B2).
b(N, b3).

c(X, Y):- a(X, Z), b(Z, Y). 

d(X, Y):- a(X, Z), b(Y, Z).
d(X, Y):- a(Z, X), b(Z, Y).

/* 7.1
a(A, 2). -> yes
b(A, foobar). -> A = 2
c(A, b3). -> A = a1
c(A,B). -> A = a1, B = b1
d(A,B). -> A = a1, B = 2
*/
