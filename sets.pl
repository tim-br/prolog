gt(X,Y):-
  X > Y.

max(X,Y,Z):-
  X > Y,
  Z is X.

max(X,Y,Z):-
  X < Y,
  Z is Y.

max(X,Y,Z):-
  X = Y,
  Z is X.

% t(t(nil, b, nil), a, t(t(nil, d, nil), c, nil)).
%
% in(X, t(_, X, _)).
%
% in(X, t(L, _, _)):-
%   in(X, L).
%
% in(X, t(_,_,R)):-
%   in(X,R).

t(t(nil, 2, nil), 4, t(t(nil, 8, nil), 9, nil)).

t(t(nil, 2, t(nil, 3, nil)), 4, t(t(nil, 8, nil), 9, nil)).

in(X, t(_, X, _)).

in(X, t(L, Q, _)):-
  Q > X,
  in(X, L).

in(X, t(_,Q,R)):-
  X > Q,
  in(X,R).

count_elems(t(nil, nil, nil), Count):-
  Count is 0.

count_elems(t(nil, X, nil), Count):-
  X \= nil,
  Count is 1.

count_elems(t(L,_,nil), Count):-
  count_elems(L, Count1),
  Count is 1 + Count1.

count_elems(t(nil, _, R), Count):-
  count_elems(R, Count1),
  Count is 1 + Count1.

count_elems(t(L,_,R), Count):-
  L \= nil,
  R \= nil,
  write(R),
  count_elems(R, Count1),
  count_elems(L, Count2),
  Count is Count1 + Count2 + 1.

height(t(nil, X, nil), Height):-
  write('hee'),
  X \= nil,
  Height is 1.

height(t(nil, _, R), Height):-
  write('check'),
  height(R, Height1),
  Height is Height1 + 1.

height(t(L, _, nil), Height):-
  height(L, Height1),
  Height is Height1 + 1.

height(t(L, _, R), Height):-
  L \= nil,
  R \= nil,
  write('left is '),
  write(L),
  write('right is '),
  write(R),
  height(L, Height1),
  height(R, Height2),
  write(Height1),
  write(Height2),
  max(Height1,Height2,M),
  %Height is Max + 1
  Height is M + 1
  .
