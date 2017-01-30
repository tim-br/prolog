template([1,1,1]).

infinite_loop(X,[X,Res1]):-
  Res1 \= [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  write(Res1),
  infinite_loop(X, Res1).

infinite_loop(X,[X,Res1]):-
  Res1 == [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  write(Res1),
  true.

inf(X, Max):-
  X \= Max,
  write(X),
  M is X + 1,
  inf(M, Max).
