goal([1/3, _]).
goal([_, 1/5]).

fill_five_liter_pot([X/Y,Z/5],[X/Y,5/5]):-
  Z < 5.

fill_three_liter_pot([Z/3,X/Y],[3/3, X/Y]):-
  Z < 3.

empty_five_liter_pot([Z/3,X/5],[Z/3, C/5]):-
  X > 0,
  C is 0.

empty_three_liter_pot([Z/3,X/5],[Q/3, X/5]):-
  Z > 0,
  Q is 0.

pour_from_five_to_three([X/3,Z/5], [Q/3,C/5]):-
  Z > 0,
  X < 3,
  AvailableSpace is 3 - X,
  Z >= AvailableSpace,
  C is Z - AvailableSpace,
  Q is 3.

pour_from_five_to_three([X/3,Z/5], [Q/3,C/5]):-
  Z > 0,
  X < 3,
  AvailableSpace is 3 - X,
  Z < AvailableSpace,
  C is 0,
  Q is X + Z.

pour_from_three_to_five([X/3,Z/5], [Q/3,C/5]):-
  X > 0,
  Z < 5,
  AvailableSpace is 5 - Z,
  X >= AvailableSpace,
  Q is X - AvailableSpace,
  C is 5.

pour_from_three_to_five([X/3,Z/5], [Q/3,C/5]):-
  X > 0,
  Z < 5,
  AvailableSpace is 5 - Z,
  X < AvailableSpace,
  Q is 0,
  C is Z + X.

move(empty_five_liter_pot, X, Z):-
  empty_five_liter_pot(X,Z).

move(empty_three_liter_pot, X, Z):-
  empty_three_liter_pot(X,Z).

move(fill_five, X, [Z,V]):-
  write(five),
  fill_five_liter_pot(X, [Z,V]).

move(fill_three, X, [Z,V]):-
  write(check),
  fill_three_liter_pot(X, [Z,V]).

move(pour_from_five_to_three, X, [Z,V]):-
  pour_from_five_to_three(X, [Z,V]).

move(pour_from_three_to_five, X, [Z,V]):-
  pour_from_three_to_five(X, [Z,V]).

my_sol([1/3,_/5],_,_):- !.
my_sol([_,1/5],_,_):- !.

my_sol(In, [Op | NextOp], PrevStates):-
  move(Op, In, Out),
  \+ member(Out, PrevStates),
  my_sol(Out, NextOp, [Out|PrevStates]).

solve_assist([Y/3, 1/5], _, _):- !.

solve_assist(Pots, [FirstMove|OtherMoves], MemoizedStates):-
  move(FirstMove, Pots, NextPots)
  , \+ member(NextPots, MemoizedStates)
  , solve_assist(NextPots, OtherMoves, [Pots|MemoizedStates]).


  % solve(Pots, [FirstMove|OtherMoves]):-
  %   move(FirstMove, Pots, NextPots)
  %   solve_assis(NextPots, OtherMoves).

  % solve(Pots, [FirstMove|OtherMoves]):-
  %   \+ member(FirstMove, OtherMoves)
  %   , move(FirstMove, Pots, NextPots)
  %   , solve(NextPots, OtherMoves).

pour_from_left_to_right([1/1,0/1], [0/1,1/1]).
pour_from_right_to_left([0/1,1/1], [1/1, 0/1]).

multi_pour(left_to_right, X,Z):-
  pour_from_left_to_right(X,Z).

multi_pour(right_to_left, X,Z):-
  pour_from_right_to_left(X,Z).

sol(Input, Output,Move, Acc):-
  length(Acc, X),
  X > 7.

sol(Input, Output, Move, Acc):-
  %\+ member(Input, Acc),
  write(Acc),
  multi_pour(Move, Input, Output),
  sol(Output, NewOutput, Res, [Input|Acc]).
