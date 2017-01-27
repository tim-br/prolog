subset([], []).
subset([_|Tail], NTail):-
  subset(Tail, NTail).

append2([],List,List).
append2([Head|Tail],List2,[Head|Result]):-
  Head > 6,
  append2(Tail,List2,Result).

