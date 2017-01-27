operation(fill_5, [In3, In5], [In3, 5]) :- In5 < 5.
operation(fill_3, [In3, In5], [3, In5]) :- In3 < 3.

operation(empty_5, [In3, In5], [In3, 0]) :- In5 > 0.
operation(empty_3, [In3, In5], [0, In5]) :- In3 > 0.

operation(pour_53, [In3, In5], [Out3, Out5]) :-
    In3 < 3,
    In5 > 0,
    CanPour is 3 - In3,
    ToPour is min(CanPour, In5),
    Out3 is In3 + ToPour,
    Out5 is In5 - ToPour.

operation(pour_35, [In3, In5], [Out3, Out5]) :-
    In3 > 0,
    In5 < 5,
    CanPour is 5 - In5,
    ToPour is min(CanPour, In3),
    Out3 is In3 - ToPour,
    Out5 is In5 + ToPour.

solve(X) :- solve([0,0], X, [[0,0]]), format("Result: ~p~n", [X]).

solve([1,_], _, _) :- !.
solve([_,1], _, _) :- !.

solve(In, [Op | NextOp], PrevStates) :-
    operation(Op, In, Out),
    \+ member(Out, PrevStates),
    solve(Out, NextOp, [Out | PrevStates]).
