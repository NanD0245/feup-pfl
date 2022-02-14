:-dynamic played/4.

% player(Name,UserName, Age)
player('Danny', 'Best Player Ever',14).
player('Annie','Worst Player Ever', 24).
player('Harry', 'A-Star Player',26).
player('Manny','The Player', 14).
player('Jonny', 'A Player',16).

% game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

% played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% 1
% achievedALot(+Player)
achievedALot(Player) :- played(Player,_,_,Per),
                        Per >= 80.

% 2
% isAgeAppropriate(+Name, +Game)
isAgeAppropriate(Name, Game) :- player(Name,_,Age),
                                game(Game,_,MinAge),
                                Age >= MinAge.

% 3
% timePlayingGames(+Player, +Games, -ListOfTimes, -SumTimes)
timePlayingGames(Player, Games, ListOfTimes, SumTimes) :-
    timePlayingGamesAux(Player, Games, [], ListOfTimes),
    sumArray(ListOfTimes,SumTimes).

timePlayingGamesAux(_,[],List,List).
timePlayingGamesAux(Player, [Game | T], Acc, ListOfTimes) :-
    (played(Player,Game,Hours,_) ->
        append(Acc, [Hours], New)
        ;
        append(Acc, [0], New)
    ),
    timePlayingGamesAux(Player,T,New,ListOfTimes).

/*timePlayingGamesAux(_,[],List,List).
timePlayingGamesAux(Player, [Game | T], Acc, ListOfTimes) :-
    played(Player,Game,Hours,_),
    append(Acc, [Hours], New),
    timePlayingGamesAux(Player,T,New,ListOfTimes).

timePlayingGamesAux(Player, [Game | T], Acc, ListOfTimes) :-
    \+ played(Player,Game,Hours,_),
    append(Acc, [0], New),
    timePlayingGamesAux(Player,T,New,ListOfTimes).*/

sumArray([],0).
sumArray([H|T],Res) :-
    sumArray(T,NRes),
    Res is NRes + H.

% 4
% listGamesOfCategory(+Cat)
listGamesOfCategory(Cat) :- \+ listGamesOfCategoryAux(Cat).

listGamesOfCategoryAux(Cat) :- 
    game(Game,List,MinAge),
    member(Cat,List),
    write(Game), write(' ('), write(MinAge), write(')'), nl,
    fail.

% 5
% updatePlayer(+Player, +Game, +Hours, +Percentage)
updatePlayer(Player, Game, Hours, Percentage) :-
    played(Player, Game, H, P),
    retract(played(Player, Game, H, P)),
    NH is H + Hours,
    NP is P + Percentage,
    assert(played(Player, Game, NH, NP)).
    
% 6
% fewHours(+Player,-Games)
fewHours(Player,Games) :- fewHoursAux(Player,[],Games).

fewHoursAux(Player,Acc,Games) :-
    played(Player,G,H,_),
    \+ member(G,Acc),
    H < 10,
    !,
    append(Acc,[G],New),
    fewHoursAux(Player,New,Games).

fewHoursAux(_,L,L).

% 7
% ageRange(+MinAge, +MaxAge, -Players)

/*ageRange(MinAge,MaxAge,Players) :-
    ageRangeAux(MinAge,MaxAge,[],Players).

ageRangeAux(MinAge,MaxAge,Acc,Players) :-
    player(P,_,Age),
    \+ member(P,Acc),
    Age >= MinAge,
    Age =< MaxAge,
    !,
    append(Acc,[P],New),
    ageRangeAux(MinAge,MaxAge,New,Players).

ageRangeAux(_,_,P,P).*/

:- use_module(library(between)).
:- use_module(library(lists)).

ageRange(MinAge,MaxAge,Players) :-
    findall(P,(player(P,_,Age), between(MinAge,MaxAge,Age)),Players).

% 8
% averageAge(+Game,-AverageAge).
averageAge(Game,AverageAge) :-
    findall(Age,(played(P,Game,_,_), player(_,P,Age)),AgeList),
    sumlist(AgeList,Sum),
    length(AgeList, Len),
    AverageAge is Sum / Len.

% 9
% mostEffectivePlayers(+Game,-Players)
mostEffectivePlayers(Game,Players) :-
    findall(Average-P,(played(P,Game,H,Per), Average is Per / H),L),
    keysort(L, Sorted),
    reverse(Sorted, [Best-P1|T]),
    mostEffectivePlayersAux([Best-P1|T],[],Players,Best).

mostEffectivePlayersAux([],L,L,_).
mostEffectivePlayersAux([A-_P|_T],Acc,Players,Best) :-
    A < Best,
    !,
    Players = Acc.

mostEffectivePlayersAux([_A-P|T],Acc,Players,Best) :-
    append(Acc,[P],New),
    mostEffectivePlayersAux(T,New,Players,Best).

% 10
/*whatDoesItDo(X) :-
    player(Y,X,Z), !,
    \+ (played(X,G,L,M), game(G,N,W), W > Z).*/

/*
Verifica se o jogador com username X apenas joga jogos apropriados para a sua idade.
Retorna yes caso se verifique e no caso contrário
Cut é verde pois apenas melhora a eficiência diminuindo o backtracking e não altera nenhum resultado.
*/


% 11
% Representação por factos

/*distance(1,2,8).
distance(1,3,8).
distance(1,4,7).
distance(1,5,7).
distance(2,3,2).
distance(2,4,4).
distance(2,5,4).
distance(3,4,3).
distance(3,5,3).
distance(4,5,1).
distance(A,A,0).
distance(A,B,D) :- distance(B,A,D), !.*/

% L = [2/1-8,3/1-8,4/1-7,5/1-7,3/2-2,4/2-4,5/2-4,4/3-3,5/3-3,5/4-1].

% 12
% areClose(+Dist,+MatDist,-Pares)
areClose(Dist,MatDist,Pares) :- areCloseAux(Dist,MatDist,[],Pares).

areCloseAux(_,[],L,L).
areCloseAux(Dist,[H-D|T],Acc,Pares) :-
    Dist >= D,
    !,
    append(Acc,[H],New),
    areCloseAux(Dist,T,New,Pares).

areCloseAux(Dist,[_|T],Acc,Pares) :-
    areCloseAux(Dist,T,Acc,Pares).

% 13
% node(node(node(node(node(australia,node(node(stahelena,anguila),georgia_do_sul)),reino_unido),node(servia,franca)),node(node(niger,india),irlanda)),brasil)

% 14
