
/* liner in space*/
my_rev([], []).
my_rev([H|T], R) :- my_rev(T, R2), append(R2, [H], R).

cons(4,nil).
