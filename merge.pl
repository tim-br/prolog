cons(X, Li, [X|Li]).

merge_sort([H|T], Sorted):-
  length(T,1),
  H < T,
  append(H,T,Sorted).

merge_sort([H|T], Sorted):-
  length(T,1),
  H > T,
  append(T,H,Sorted).
