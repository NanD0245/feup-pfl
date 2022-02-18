:- use_module(library(lists)).

% for testing
connected(porto, lisbon).
connected(lisbon, madrid).
connected(lisbon, paris).
connected(lisbon, porto).
connected(madrid, paris).
connected(madrid, lisbon).
connected(paris, madrid).
connected(paris, lisbon).
connected(california, new_york).
connected(new_york, california).
connected(california, florida).

% dfs_path(StartNode,FinalNode)
dfs(S, F):-
    dfs(S, F, [S]).

dfs(F, F, _Path).

dfs(S, F, T):-
    connected(S, N),
    \+ member(N, T),
    dfs(N, F, [N|T]).

% dfs_path(StartNode,FinalNode,Path)
dfs_path(S, F, Path):-
    dfs_path(S, F, [S], P),
    reverse(P,Path).

dfs_path(F, F, P, P).

dfs_path(S, F, T, P):-
    connected(S, N),
    \+ member(N, T),
    dfs_path(N, F, [N|T], P).

