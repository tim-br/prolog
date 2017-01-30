likes(fred, [1,2]).

subset([], []).
subset([E|Tail], [E|NTail]):-
  subset(Tail, NTail).
subset([_|Tail], NTail):-
  subset(Tail, NTail).


parent(john,paul).
parent(paul,tom).
parent(tom,mary).
parent(mary,ben).
parent(ben,raj).
parent(ben,jane).


ancestor(X,Y):-
  parent(X,Y).

ancestor(X,Y):-
  parent(Z,Y),
  ancestor(X,Z).
