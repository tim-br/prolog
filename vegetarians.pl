solve(1, 0, _, _, left):-
  write('the vetetarian takes boat to the right side').

solve(1,1,_,_, left):-
  write('the vegetarian and the carnivore take the boat to the right side').

solve(0,1,_,_,left):-
  write('the carnivore takes the boat to the right side').

solve(V,C,_,_,right):-
  V > 0,
  C > 0,
  write('ok').

solve(_,_,V,C, _):-
  C > V,
  false.

solve(V,C,_,_,_):-
  C > V,
  false.


start(state(2,2,0,0,w)).
goal(state(0,0,2,2,e)).

safe(state(V,C,V1,C2,_)):-
  V >= C,
  V1 >= C2.

transport(state(V,C,V1,C2,BOAT),[NumV, NumC], state(V3,C3,V4,C4,BOAT1)):-
  change(BOAT, BOAT1),
  V4 is V1 + NumV,
  V3 is V - NumV,
  C4 is C2 + NumC,
  C3 is C - NumC.

sol(X, []):-
  goal(X).

sol(State, [[X,Y]|OtherMoves]):-
  transport(State, [X,Y],NextState),
  safe(NextState),
  sol(NextState, OtherMoves).

foo(state(1,2)).

state_check(state(X,Y), state(Z,Q)):-
  Q is X + 1,
  Z is Y + 2.

oneEq(X,X,_).
oneEq(X,_,X).

% safe([Man,Wolf,Goat,Cabbage]) :-
%     oneEq(Man,Goat,Wolf),     oneEq(Man,Goat,Cabbage).
%


move([X,X,Goat,Cabbage],wolf,[Y,Y,Goat,Cabbage]) :- change(X,Y).
move([X,Wolf,X,Cabbage],goat,[Y,Wolf,Y,Cabbage]) :- change(X,Y).
move([X,Wolf,Goat,X],cabbage,[Y,Wolf,Goat,Y]) :- change(X,Y).


solution([e,e,e,e],[]).
solution([Config,[FirstMove|OtherMoves]]):-
  move(Config, FirstMove, NextConfig),
  safe(NextConfig),
  solution(NextConfig, OtherMoves).

change(w,e).
change(e,w).
