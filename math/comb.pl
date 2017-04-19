%% vars for memoization
:- dynamic is_already_present/1.

is_already_present([]).

is_al_memo(X) :-
  is_already_present(Y),
  retract(is_already_present(Y)),
  Y2 = [X | Y],
  assertz(is_already_present(Y2)).

flavor(chocolate).
flavor(banana).
flavor(lemon).
flavor(strawberry).
flavor(vanilla).

flavors(Length, X):-
  Length == 1,
  flavor(X).

flavors(2, [X,Y]):-
  is_already_present(Q),
  write(Q),
  flavor(X),
  flavor(Y),
  X \= Y,
  \+ member([Y,X], Q),
  is_al_memo([X,Y]).

% flavors(2, [X,X]):-
%   flavor(X).

% flavors(Length, Res):-
%   Length == 1,
%   flavor(X),
%   Res = [X].
%
% flavors(Length, Res):-
%   Length \= 1,
%   NewLength is Length - 1,
%   flavors(NewLength, NewRes),
%   flavor(X),
%   V = [X | NewRes],
%   \+is_al_memo(V),
%   %%check_lists(X, NewRes),
%   Res = V.
%
% rem_permutations(Li1, Li2):-
%   permutation(Li2, Res),
%   Li1 == Res.
%
% check_lists(Elem, List):-
%   findall(Res, permutation(List, Res), Res),
%   \+member(Elem, Res).
