template([1/Y1,2/Y2,3/Y3,4/Y4,5/Y5,6/Y6,7/Y7,8/Y8]).

solution([]).

solution([X/Y|Others]):-
  solution(Others),
  member(Y,[1,2,3,4,5,6,7,8]),
  noattack(X/Y, Others).

noattack(_, []).

noattack(X/Y, [X1/Y1 | Tail]):-
  Y =\= Y1,
  Y1 - Y =\= X1 - X,
  Y1 - Y =\= X - X1,
  noattack(X/Y, Tail).

jump(X/Y, X1/Y1):-
  member(X1,[1,2,3,4,5,6,7,8]),
  member(Y1,[1,2,3,4,5,6,7,8]),
  X1 is X - 1,
  Y1 is Y - 2.

jump(X/Y, X1/Y1):-
  member(X1,[1,2,3,4,5,6,7,8]),
  member(Y1,[1,2,3,4,5,6,7,8]),
  X1 is X + 1,
  Y1 is Y - 2.

jump(X/Y, X1/Y1):-
  member(X1,[1,2,3,4,5,6,7,8]),
  member(Y1,[1,2,3,4,5,6,7,8]),
  X1 is X + 2,
  Y1 is Y - 1.

jump(X/Y, X1/Y1):-
  member(X1,[1,2,3,4,5,6,7,8]),
  member(Y1,[1,2,3,4,5,6,7,8]),
  X1 is X + 2,
  Y1 is Y + 1.

jump(X/Y, X1/Y1):-
  member(X1,[1,2,3,4,5,6,7,8]),
  member(Y1,[1,2,3,4,5,6,7,8]),
  X1 is X + 1,
  Y1 is Y + 2.

jump(X/Y, X1/Y1):-
  member(X1,[1,2,3,4,5,6,7,8]),
  member(Y1,[1,2,3,4,5,6,7,8]),
  X1 is X - 1,
  Y1 is Y + 2.

jump(X/Y, X1/Y1):-
  member(X1,[1,2,3,4,5,6,7,8]),
  member(Y1,[1,2,3,4,5,6,7,8]),
  X1 is X - 2,
  Y1 is Y + 1.

jump(X/Y, X1/Y1):-
  member(X1,[1,2,3,4,5,6,7,8]),
  member(Y1,[1,2,3,4,5,6,7,8]),
  X1 is X - 2,
  Y1 is Y - 1.

knightpath_assist(_, []).

knightpath_assist(H, [H1|Tail]):-
  jump(H,H1),
  knightpath_assist(H1, Tail).

knightpath(H|Tail):-
  knightpath_assist(H, Tail).

% knightpath([H|Tail]).
%   knightpath_assist(H, Tail),
%   knightpath(H1, Tail).
