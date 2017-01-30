%%http://www.cse.unsw.edu.au/~billw/Justsearch.html

edge(1, 2).         %        1
edge(1, 3).         %       / \
edge(2, 4).         %      2   3
edge(3,5).          %      |   |
edge(5,6).
goal(6).

% solve(Start, Solution).
%  Solution is a path (in reverse order)
%  from Start to a goal.

solve(Start, Solution) :-
  breadthfirst([[Start]], Solution).

% breadthfirst([Path1, Path2, ...], Solution).
%  Solution is an extension to a goal of
%  one of the paths.

breadthfirst([[Node|Path]|_], [Node|Path]) :-
  goal(Node).
  % Always first check if goal reached

% If not, then extend this path by all
% possible edges, put these new paths on the
% end of the queue (Paths1) to check, and do
% breadthfirst on this new collection of
% paths, Paths1:
breadthfirst([Path|Paths], Solution) :-
  extend(Path, NewPaths),
  append(Paths, NewPaths, Paths1),
  breadthfirst(Paths1, Solution).

% extend([N|Rest], NewPaths).
% Extend the path [N|Rest] using all edges
% through N that are not already on the path.
% This produces a list NewPaths.
extend([Node|Path], NewPaths) :-
  findall([NewNode, Node|Path],
          (edge(Node, NewNode),
           not(member(NewNode,[Node|Path]))),
          NewPaths),
  !.
extend(Path,[]). %findall failed: no edge
