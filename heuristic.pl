:- [romania].

solvea(Start, Goal, Solution):-
  astar([[0, Start]], Goal, Solution).

astar([[Cost, Node|Path]|_], Goal, [Cost, Node|Path]):-
  Goal == Node.

astar([[Cost|Path]|Paths], Goal, Solution):-
  % write(Cost),
  % write(Path),
  %% same as breadthfirst
  extendu([Cost|Path], NewPaths),
  % nl,
  % write(this),
  % nl,
  % write(Res),
  % nl,
  %%mergesort(NewPaths, NewPathsSorted),

  %% this is different, we want to insert NewPaths in the proper position
  %% ie the queue needs to be kept in order of the cost or g(x)
  %% of each Path
  insert_list_a(NewPaths, Paths, Paths1),
  write(Paths1),
  nl,
  nl,
  %append(Paths, NewPa  ths, Paths1),
  % write(Res),
  % nl,
  % write(NewPaths),
  % nl,

  %% recursively call breadthfirst with the new set of paths that
  %% contains the explored head at the end of the priority queue
  %% Goal and Solution are static, in the sense that they will be the same down the entire call stack
  %% The algorithm doesn't seem to do anything with Solution except in the base case
  %% which is essentially the the head of the paths, if the head of the paths satisfy the goal
  %% that is it is a valid path from the Start Node to the End Node
  %% Goal is whatever variable is passed in from the beginning, however, at each iteration
  %% the algorithm checks that the top node of the top path is the goal, therefore it
  %% needs to be passed in at every breadthfirst call.
  astar(Paths1, Goal, Solution).

insert_a(X, [], [X]).
insert_a([H, Node1|T], [[H2, Node2|T2]|Rest], [[H, Node1|T],[H2, Node2|T2]|Rest]) :-
    h(Node1, DistNode1),
    Heu1 is DistNode1 + H,
    h(Node2, DistNode2),
    Heu2 is DistNode2 + H2,
    Heu1 @< Heu2, !.
insert_a(X, [Y|Rest0], [Y|Rest]) :-
    insert_a(X, Rest0, Rest).

insert_list_a([], Target, Target).
insert_list_a([H], [], [H]).
insert_list_a([H|T], Target, Res):-
  insert_a(H, Target, Res2),
  insert_list_a(T, Res2, Res).
  %insert_list(T, Res2, Res).
