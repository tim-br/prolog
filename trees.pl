tr(t(t(nil, 2, t(nil, 3, nil)), 4, t(t(nil, 8, nil), 9, nil))).

t(nil, 4, nil).

in(X, t(_, X, _)).

in(X, t(L, Q, _)):-
  Q > X,
  in(X, L).

in(X, t(_,Q,R)):-
  X > Q,
  in(X,R).

add(X, t(nil, nil, nil), t(nil, X, nil)).

add(X, t(nil, Root, nil), t(t(nil, X, nil), Root, nil)):-
  Root \= nil,
  X < Root.

add(X, t(L, Root, Right), t(L, Root, Right)):-
  X = Root.

add(X, t(L,Root, _), Result):-
  Root \= nil,
  X < Root,
  add(X, L, Result).
