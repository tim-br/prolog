% consec([], []).
%
% consec([X], [X]).
%
% consec([H1|T1], [H1|T2]):-
%   prefix([H1|T1], [H1|T2]).
%
% consec([H1|T2], [H1|T2]):-
%   consec([H1|T1], T2).
%
% consec([H1|T1],[H2|T2]):-
%   consec(T1, [H2|T2]).

% clip([X], Min, Max, [Max]):-
%   X > Max.
%
% clip([X], Min, Max, [Min]):-
%   X < Min.
%
% clip([X], Min, Max, [X]):-
%   X > Min,
%   X < Max.

clip([], _, _, []) :- !.

clip([H|T], Min, Max, [Max|Res]):-
  H >= Max,
  clip(T, Min, Max, Res).

clip([H|T], Min, Max, [Min|Res]):-
  H =< Min,
  clip(T, Min, Max, Res).

clip([H|T], Min, Max, [H|Res]):-
  H =< Max,
  H >= Min,
  clip(T, Min, Max, Res).

dosido([], []):- !.

dosido([X], [X]):- !.

dosido([H1, H2 | T], [H2, H1 | T2]):-
  dosido(T, T2).

prefix([], L) :- is_list(L).
prefix([X|L], [X|T]) :- prefix(L, T).

% consec([], []):- !.
%
% consec([], [_]):- !.
%
% consec([H|T], [H|T2]):-
%   consec(T, T2).
%
% consec([H|T], [H2|T2]):-
%   H \= H2,
%   consec(T,[H2|T2]).
%
% consec([H|T], [H2|T2]):-
%   H \= H2,
%   consec([H|T], T2).

consec([X], [X]).

consec([], [_]).

consec([H|T], [H|T2]):-
  prefix(T,T2).

consec([H|T], [_|T2]):-
  consec([H|T],T2).

fun(X,Y):-
  X = Y.

check([_,3 | _]).

check(X):-
  X = [_,3|_].

% sublist([1,4,6,3],[1,3])
% sublist([1,4,6,3],[4,6,3])
% sublist([1,4,6,3],[4,3])
% sublist([1,4,6,3],[1,4,3])

sublist([_|_], []).
sublist([X], [X]).

sublist([H|T], [H|T2]):-
  sublist(T, T2).

sublist([H|T], [H2|T2]):-
  sublist(T, [H2|T2]).

subset([], []).
subset([E|Tail], [E|NTail]):-
  subset(Tail, NTail).
subset([_|Tail], NTail):-
  subset(Tail, NTail).

hamming([], [], 0).

hamming([H|T], [H|T1], Res):-
  hamming(T, T1, Res).

hamming([H|T], [H1|T1], Res):-
  H \= H1,
  hamming(T,T1, Res2),
  Res is Res2 + 1.

subset_sum([], [], 0).

subset_sum([H|T], [H|Res], Goal):-
  NewGoal is Goal - H,
  subset_sum(T, Res, NewGoal).

subset_sum([_|T], Res, Goal):-
  subset_sum(T, Res, Goal).

accum([], [0]).
accum([X], [X]).
accum([H, H2], [H, H3]):- H3 is H + H2.
accum([H, H2|T], [H|Res]):-
  NewHead is H + H2,
  accum([NewHead, H2 | T], Res).
