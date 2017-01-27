?- use_module(library(clpfd)).

start(state(2,2,0,0,w)).
goal(state(0,0,2,2,e)).

change(w,e).
change(e,w).

safe(state(V,C,V1,C2,_)):-
  V #>= C,
  V1 #>= C2.

transport(state(V,C,V1,C2,BOAT),[NumV, NumC], state(V3,C3,V4,C4,BOAT1)):-
  NumV + NumC #=< 2,
  change(BOAT, BOAT1),
  V4 #= V1 + NumV,
  V3 #= V - NumV,
  C4 #= C2 + NumC,
  C3 #= C - NumC.

% sol(X, []):-
%   goal(X).

sol(State, [X,Y]):-
  transport(State, [X,Y],NextState).


%safe(NextState).

%sol(NextState, OtherMoves)
test_num(X, fun(Y)):-
  number(X),
  Y is X + 1.

add(X,Y,Z):-
  Z #= X + Y.
