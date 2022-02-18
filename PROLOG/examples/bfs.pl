:- use_module(library(lists)).

% for testing
edge(a,b).
edge(a,c).
edge(a,d).
edge(b,e).
edge(b,f).
edge(c,b).
edge(c,d).
edge(c,e).
edge(d,a).
edge(d,e).
edge(d,f).
edge(e,f).

% bfs(StartNode,FinalNode)
bfs(S, F):-
    bfs([S], F, [S]).

bfs([F|_], F, _V).
bfs([S|R], F, V):-
    findall(N, ( 
        edge(S, N),
        \+ member(N, V),
        \+ member(N, [S|R])
    ), L),
    append(R, L, NR),
    bfs(NR, F, [S|V]).

% bfs_path(StartNode,FinalNode,Path)
bfs_path(S, F, Path) :-
    bfs_path_aux([[S]], F, P),
    reverse(P,Path).

bfs_path_aux([[F|T]|_], F, [F|T]).

bfs_path_aux([[S|T]|R], F, P) :-
    findall([N,S|T],(
        edge(S, N),
        \+ member(N, [S|T])
    ), L),
    append(R, L, NR),
    bfs_path_aux(NR, F, P).

% bfs_path_prohibited(StartNode,FinalNode,ProhibitedNodes,Path)
bfs_path_prohibited(S,F,PN,Path) :-
    bfs_path_prohibited_aux([[S]], F, PN, P),
    reverse(P,Path).

bfs_path_prohibited_aux([[F|T]|_], F, _, [F|T]).

bfs_path_prohibited_aux([[S|T]|R], F, PN, P):-
    findall([N,S|T], ( 
        edge(S, N),
        \+ member(N, PN),
        \+ member(N, [S|T])
    ), L),
    append(R, L, NR),
    bfs_path_prohibited_aux(NR, F, PN, P).



