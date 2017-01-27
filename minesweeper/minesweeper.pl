:- dynamic(ms_isopen/2).
height(15).
width(11).
ms_isopen((6,10)).

ms_ismine((1,2)).
ms_ismine((1,3)).
ms_ismine((1,9)).
ms_ismine((1,10)).
ms_ismine((1,11)).
ms_ismine((1,12)).

ms_ismine((2,1)).
ms_ismine((2,4)).
ms_ismine((2,7)).
ms_ismine((2,9)).
ms_ismine((2,10)).
ms_ismine((2,12)).
ms_ismine((2,15)).

ms_ismine((3,1)).
ms_ismine((3,7)).
ms_ismine((3,8)).
ms_ismine((3,9)).

ms_ismine((4,1)).
ms_ismine((4,7)).
ms_ismine((4,9)).
ms_ismine((4,13)).
ms_ismine((4,15)).

ms_ismine((5,1)).
ms_ismine((5,13)).

ms_ismine((6,5)).
ms_ismine((6,14)).
ms_ismine((6,15)).

ms_ismine((7,6)).

ms_ismine((8,7)).
ms_ismine((8,8)).
ms_ismine((8,9)).
ms_ismine((8,10)).
ms_ismine((8,13)).
ms_ismine((8,15)).

ms_ismine((9,1)).
ms_ismine((9,4)).
ms_ismine((9,15)).

ms_ismine((10,1)).
ms_ismine((10,15)).

ms_ismine((11,4)).
ms_ismine((11,6)).
ms_ismine((11,8)).
ms_ismine((11,11)).
ms_ismine((11,12)).
ms_ismine((11,15)).

ms_ismarked((-1, -1)).

inside((X,Y)) :- width(W), height(H), between(1, W, X), between(1, H, Y).

neighbour((X, Y), (Xn, Yn)) :- 
    inside((X, Y)), 
    member(D1, [-1,0,1]), 
    member(D2, [-1,0,1]), 
    (D1, D2) \= (0,0), 
    Xn is X + D1,
    Yn is Y + D2,
    inside((Xn, Yn)).

:- dynamic ms_ismarked/1.
:- dynamic ms_score/1.
:- dynamic ms_error.

ms_score(0).

isopen(C, N) :- 
    ms_isopen(C), 
    findall(Cn, (neighbour(C, Cn), ms_ismine(Cn)), L), 
    length(L, N).

ismarked(C) :- ms_ismarked(C).

opencell(C) :-
    ms_isopen(C), !.

opencell(C) :-
    ms_ismine(C), !,
    write('You hit a mine at '), write(C), nl,
    assertz(ms_error),
    fail.

opencell(C) :-
    not(inside(C)), !,
    write(C), write(' is outside the bounds'), nl,
    assertz(ms_error),
    fail.

opencell(C) :-
    assertz(ms_isopen(C)),
    write('Opening cell '), write(C), nl,
    ms_addscore.

ms_addscore :-
    ms_score(S),
    retract(ms_score(S)),
    S2 is S + 1,
    assertz(ms_score(S2)).

markcell(C) :-
    ms_ismarked(C), !.

markcell(C) :-
    not(ms_ismine(C)), !,
    write(C), write(' is not a mine'), nl,
    assertz(ms_error),
    fail.

markcell(C) :- 
	not(inside(C)), !,
    write(C), write(' is outside the bounds'), nl,
    assertz(ms_error),
    fail.

markcell(C) :-
    assertz(ms_ismarked(C)),
    write('Marking cell '), write(C), nl,
    ms_addscore.

drawcell(C) :-
    isopen(C,N), !,
    (N > 0 ->   write(N) ; write(' ')).

drawcell(C) :-
    ms_ismarked(C), !, write('M').

drawcell(_) :- write('*').

drawfield :-
    width(W),
    height(H),
    between(1, H, Y),
    between(1, W, X),
    drawcell((X,Y)),
    (   X =:= W ->   nl ; true),
    fail.

drawfield.
