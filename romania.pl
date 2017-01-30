tem(graph([timisoara,
           zerind,
           sibiu,
           oradea],
           [e(arad, zerind, 75),
            e(arad, sibiu, 140),
            e(arad, timisoara, 118),
            e(zerind, oradea, 71),
            e(oradea, sibiu, 151),
            e(sibiu, rimnicu, 80),
            e(sibiu, fagaras, 99),
            e(timisoara, logoj, 111),
            e(logoj, mehadia, 70),
            e(mehadia, dobreta, 120),
            e(dobreta, craiova, 120),
            e(craiova, rimnicu, 146),
            e(craiova, pitesti, 138),
            e(pitesti, bucharest, 101),
            e(pitesti, rimnicu, 97),
            e(fagaras, bucharest, 211),
            e(bucharest, giurgiu, 90),
            e(bucharest, urziceni, 85),
            e(urziceni, vaslui, 142),
            e(vaslui, lasi, 92),
            e(lasi, neamt, 87),
            e(urziceni, hirsova, 98),
            e(hirsova, eforie, 86)])).

% distance of each city to bucharest as the crow flies
h(arad, 366).
h(bucharest, 0).
h(craiova, 160).
h(dobreta, 242).
h(eforie, 161).
h(fagaras, 176).
h(giurgiu, 77).
h(hirsova, 151).
h(lasi, 226).
h(lugoj, 244).
h(mehadia, 241).
h(neamt, 234).
h(oradea, 380).
h(pitesti, 100).
h(rimnicu, 193).
h(sibiu, 253).
h(timisoara, 329).
h(urziceni, 80).
h(vaslui, 199).
h(zerind, 374).

adjacent(X,Y,graph(_,E)):-
  member(e(X,Y,_), E)
  ;
  member(e(Y,X,_), E).

adjacent_cost(X,Y, graph(_,E), Cost):-
  adjacent(X,Y, graph(_,E)),
  member(e(X,Y,Cost), E)
  ;
  adjacent(X,Y, graph(_,E)),
  member(e(Y,X,Cost), E).

adjacent_cost_without_a_city(X,Y, Exclusion, graph(_,E), Cost):-
  adjacent(X,Y, graph(_,E)),
  member(e(X,Y,Cost), E),
  Y \= Exclusion
  ;
  adjacent(X,Y, graph(_,E)),
  member(e(Y,X,Cost), E),
  Y \= Exclusion.

adjacent_cost_without_cities(X,Y, Exclusions, graph(_,E), Cost):-
  adjacent(X,Y, graph(_,E)),
  member(e(X,Y,Cost), E),
  \+ member(Y, Exclusions)
  ;
  adjacent(X,Y, graph(_,E)),
  member(e(Y,X,Cost), E),
  \+ member(Y, Exclusions).

closest_neighbor(X, ClosestNeighbor, Cost):-
  tem(Graph),
  aggregate(min(Cost, ClosestNeighbor), adjacent_cost(X,ClosestNeighbor, Graph, Cost), min(Cost,ClosestNeighbor)).

closest_neighbor_with_exclusion(X, Exclusion, ClosestNeighbor, Cost):-
  tem(Graph),
  aggregate(min(Cost, ClosestNeighbor), adjacent_cost_without_a_city(X,ClosestNeighbor, Exclusion, Graph, Cost), min(Cost,ClosestNeighbor)).

closest_neighbor_with_exclusions(X, Exclusions, ClosestNeighbor, Cost):-
  tem(Graph),
  aggregate(min(Cost, ClosestNeighbor), adjacent_cost_without_cities(X,ClosestNeighbor, Exclusions, Graph, Cost), min(Cost,ClosestNeighbor)).


closest_to_bucharest(City) :-
  aggregate(min(Distance,City), h(City,Distance), min(_, City)).

take_shortest_neighbor(Dest, Dest, _, 0):- !.

take_shortest_neighbor(Start, Dest, PrevCity, TotalCost):-
  closest_neighbor_with_exclusion(Start, PrevCity, CN, Cost),
  write('walk to '),
  write(CN),
  nl,
  take_shortest_neighbor(CN, Dest, Start, NextCost),
  TotalCost is NextCost + Cost.

% uniform_search(Dest, Dest, _, 0, _):- !.
%
% uniform_search(Start, Dest, PrevCity, TotalCost, CurrentCost):-
%   closest_neighbor_with_exclusion(Start, PrevCity, CN, Cost),
%   NextCurrentCost is CurrentCost + Cost,
%   write('walk to '),
%   write(CN),
%   nl,
%   write(CurrentCost),
%   nl,
%   uniform_search(CN, Dest, Start, NextCost, NextCurrentCost),
%   TotalCost is NextCost + Cost.
%

% bfs(Start, Start).
% bfs(Start, Goal):-
%   tem(X),
%   findall(Neighbor, adjacent(Start, Neighbor, X), Z).

consed(A,B,[B|A]).

%% simple auxiliar, call with the Start Node and the Goal Node.
solve(Start, Goal, Solution):-
  breadthfirst([[Start]], Goal, Solution).

breadthfirst([[Node|Path]|_], Goal, [Node|Path]):-
  %% if the head of the top path from the list/ priority is the Goal,
  %% the algorithm has completed, the remaining paths in the queue don't have to be
  %% explored since the solution is already found.
  Goal == Node.

breadthfirst([Path|Paths], Goal, Solution):-

  %% extend the first path, New Paths may be a list of multiple paths if the
  %% current node is adjacent to > 2 nodes. If it is just connnected to 2 nodes,
  %% it will be just one list.
  extend(Path, NewPaths),

  %% we have explored the top path from the priority queue, now append this
  %% new set of paths to the remaining paths (Paths), the paths that haven't
  %% been explored this iteration. They will be explored next iteration.
  %% Note that this new set of paths is appended to the end of the list,
  %% since breadthfirst is FIFO, it will have to wait it's turn until the remaining
  %% paths have been explored.
  append(Paths, NewPaths, Paths1),

  %% recursively call breadthfirst with the new set of paths that
  %% contains the explored head at the end of the priority queue
  %% Goal and Solution are static, in the sense that they will be the same down the entire call stack
  %% The algorithm doesn't seem to do anything with Solution except in the base case
  %% which is essentially the the head of the paths, if the head of the paths satisfy the goal
  %% that is it is a valid path from the Start Node to the End Node
  %% Goal is whatever variable is passed in from the beginning, however, at each iteration
  %% the algorithm checks that the top node of the top path is the goal, therefore it
  %% needs to be passed in at every breadthfirst call.
  breadthfirst(Paths1, Goal, Solution).

%% first param is a list of current paths (like accumulator, or memoized)
%% Second parameter is all of these paths extended by one node, including each adjacent node
%% except for any neighbor nodes that are currently in the path
%% (to avoid exploring previous node resulting in an infinite loop)
extend([Node|Path], NewPaths):-
  tem(X),
  findall([NewNode, Node|Path],
          (adjacent(Node, NewNode, X), \+(member(NewNode, [Node|Path]))),
          NewPaths),
  !.

extend_best([Cost, Node|Path], NewPaths):-
  tem(X),
  findall([NC, NewNode, Node|Path],
          (adjacent_cost(Node, NewNode, X, EdgeCost),
          \+(member(NewNode, [Node|Path])),
           NC is Cost + EdgeCost),
          NewPaths),
  !.

best_first_search([[Cost, Node|Path]|_], Goal, [Cost, Node|Path]):-
  Goal == Node,
  !.

best_first_search([[Cost|Path]|Paths], Goal, Solution):-
  % write(Cost),
  % write(Path),
  %% same as breadthfirst
  extend_best([Cost|Path], NewPaths),
  % nl,
  % write(this),
  % nl,
  % write(Res),
  % nl,
  %%mergesort(NewPaths, NewPathsSorted),

  %% this is different, we want to insert NewPaths in the proper position
  %% ie the queue needs to be kept in order of the cost or g(x)
  %% of each Path
  insert_list(NewPaths, Paths, Paths1),
  %append(Paths, NewPaths, Paths1),
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
  uniform_cost_search(Paths1, Goal, Solution).

%% Since the breadthfirst search requires some kind of priority queue,
%% and a priority queue is required in a uniform cost search
%% algorithm, we can easily modify the breadthfirst search algorithm
%% to make it a uniform search algorithm
%% In fact, we can even reuse the extend predicate in its entirety.

grt([H|_], [H2|_]):-
  H > H2.

% sortl([H, H2|T], Res):-
%   grt(H, H2),

extendu([Cost, Node|Path], NewPaths):-
  tem(X),
  findall([NC, NewNode, Node|Path],
          (adjacent_cost(Node, NewNode, X, EdgeCost),
          \+(member(NewNode, [Node|Path])),
           NC is Cost + EdgeCost),
          NewPaths),
  !.

solveu(Start, Goal, Solution):-
  uniform_cost_search([[0, Start]], Goal, Solution).

uniform_cost_search([[Cost, Node|Path]|_], Goal, [Cost, Node|Path]):-
  Goal == Node.

uniform_cost_search([[Cost|Path]|Paths], Goal, Solution):-
  % write(Cost),
  % write(Path),
  %% same as breadthfirst
  extendu([Cost|Path], NewPaths),
  sort(NewPaths, Res),
  % nl,
  % write(this),
  % nl,
  % write(Res),
  % nl,
  %%mergesort(NewPaths, NewPathsSorted),

  %% this is different, we want to insert NewPaths in the proper position
  %% ie the queue needs to be kept in order of the cost or g(x)
  %% of each Path
  insert_list(NewPaths, Paths, Paths1),
  write(Paths1),
  nl,
  %append(Paths, NewPaths, Paths1),
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
  uniform_cost_search(Paths1, Goal, Solution).

% extend([Node|Path], NewPaths):-
%   tem(X),
%   findall([NewNode, Node|Path],
%           (adjacent(Node, NewNode, X)),
%           not(member(NewNode, [Node|Path])),
%           NewPaths),
%   !.

bfs(Goal, [[Goal|Visited]|_], Path):-
  reverse([Goal|Visited], Path).

bfs(Goal, [Visited|Rest], Path) :-                     % take one from front
    tem(G),
    Visited = [Start|_],
    Start \== Goal,
    findall(Neighbor, (adjacent(Neighbor, Start, G), \+ member(X, Visited)), [T|Extend]),
    % findall(X,
    %     (connected2(X,Start,_),not(member(X,Visited))),
    %     [T|Extend]),
    maplist( consed(Visited), [T|Extend], VisitedExtended),      % make many
    append(Rest, VisitedExtended, UpdatedQueue),       % put them at the end
    bfs( Goal, UpdatedQueue, Path ).

is_man(john).
is_man(alex).

%elems(city([H])):-


%% merge sort algorithm from stack overflow
%% http://stackoverflow.com/questions/4753663/bubble-sort-in-prolog-language

mergesort([],[]).    /* covers special case */
mergesort([A],[A]).
mergesort([A,B|R],S) :-
   split([A,B|R],L1,L2),
   mergesort(L1,S1),
   mergesort(L2,S2),
   merge(S1,S2,S).

split([],[],[]).
split([A],[A],[]).
split([A,B|R],[A|Ra],[B|Rb]) :-  split(R,Ra,Rb).

merge_m([A],[],[A]).
merge_m([],[B],[B]).
merge_m([[A|ATail]|Ra], [[B|BTail]|Rb], [[A|ATail]|M]) :-  A =< B, merge(Ra,[[B|BTail]|Rb],M).
merge_m([[A|Tail]|Ra],[[B|BTail]|Rb],[[B|BTail]|M]) :-  A > B,  merge([[A|ATail]|Ra],Rb,M).

insert(X, [], [X]).
insert([H|T], [[H2|T2]|Rest], [[H|T],[H2|T2]|Rest]) :-
    H @< H2, !.
insert(X, [Y|Rest0], [Y|Rest]) :-
    insert(X, Rest0, Rest).

insert_list([], Target, Target).
insert_list([H], [], [H]).
insert_list([H|T], Target, Res):-
  insert(H, Target, Res2),
  insert_list(T, Res2, Res).
  %insert_list(T, Res2, Res).
