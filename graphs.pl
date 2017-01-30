tem(graph([a,b,c,d], [e(a,b), e(b,d), e(b,c), e(c,d)])).

adjacent(X,Y,graph(_,E)):-
  member(e(X,Y), E)
  ;
  member(e(Y,X), E).

path(A,Z,Graph, Path):-
  path1(A, [Z], Graph, Path).

path1(A, [A|Path1], _, [A, Path1]).

path1(A, [Y|Path1], Graph, Path):-
  adjacent(X,Y,Graph),
  \+ member(X,Path1),
  path1(A, [X,Y | Path1], Graph, Path).

% node(N, graph(Nodes, _)):-
%   member(N, Nodes).

hamiltonian(Graph, Path):-
  path(_, _, Graph, Path),
  covers(Path, Graph).

covers(Path, Graph):-
  flatten(Path, Res),
  \+ (node(N, Graph), \+ member(N, Res)).

stree(graph(_, Edges), Tree):-
  member(Edge, Edges),
  spread([Edge], Tree, Graph).

node(Node, Tree):-
  adjacent_tree(Node,_,Tree).

addedge(Tree, [e(A,B) | EdgesT2], Graph):-
  adjacent(A,B,Graph),
  node(A, Tree),
  \+ node(B,Tree).

adjacent_tree(A,B,Tree):-
  member(e(A,B), Tree)
  ;
  member(e(B,A), Tree).

spread(Tree1, Tree, Graph):-
  addedge(Tree1, Tree2, Graph),
  spread(Tree2, Tree, Graph).

spread(Tree, Tree, Graph):-
  \+ addedge(Tree, _, Graph).
