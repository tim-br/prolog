q(tree(max,
     tree(min,
          tree(max,
               tree(min,
                    term(84),
                    term(-29)),
               tree(min,
                    term(-37),
                    term(-25))),
          tree(max,
               tree(min,
                    term(1),
                    term(-43)),
               tree(min,
                    term(-75),
                    term(49)))),
     tree(min,
          tree(max,
               tree(min,
                    term(-21),
                    term(-51)),
               tree(min,
                    term(58),
                    term(-46))),
          tree(max,
               tree(min,
                    term(-3),
                    term(-13)),
               tree(min,
                    term(26),
                    term(79)))))).


jazz(tree(max,
     tree(min,
          term(84),
          term(-29)),
     tree(min,
          term(-37),
          term(-25)))).

cran(tree(max,
     tree(min,
          term(1),
          term(-43)),
     tree(min,
          term(-75),
          term(49)))).

bran(tree(min,
         tree(max,
              tree(min,
                   term(84),
                   term(-29)),
              tree(min,
                   term(-37),
                   term(-25))),
         tree(max,
              tree(min,
                   term(1),
                   term(-43),
              tree(min,
                   term(-75),
                   term(49)))))).

bl(tree(0, 3, 4)).
qr(tree(0, tree(0,term(2),term(2)), term(4))).

tet(tree(max,
     tree(min,
          term(-3),
          term(100)),
     tree(min,
          term(26),
          term(79)))).

jeb(tree(min,
     tree(max,
          term(-3),
          term(100)),
     tree(max,
          term(26),
          term(79)))).

tra(tree(max,
        term(26),
        term(79))).

cra(tree(min,
     tree(max,
          tree(min,
               term(-21),
               term(-51)),
          tree(min,
               term(58),
               term(-46))),
     tree(max,
          tree(min,
               term(-3),
               term(-13)),
          tree(min,
               term(26),
               term(79))))).

viz(tree(min,
         term(-46),
         term(26))).

terminal_node(tree(_,Y,Z)):-
  integer(Y),
  integer(Z).

children(tree(_,Y,Z), Y,Z).

smaller(X,Y,X):-
  X =< Y.

smaller(X,Y,Y):-
  X > Y.

greater(X,Y,X):-
  X >= Y.

greater(X,Y,Y):-
  Y > X.

minimax_value(term(X), X):-
  write(X),
  nl.

minimax_value(tree(min,X,Y), Res):-
  minimax_value(X,Z),
  minimax_value(Y,Q),
  smaller(Z,Q,Res).

minimax_value(tree(max,X,Y), Res):-
  minimax_value(X,Z),
  minimax_value(Y,Q),
  greater(Z,Q,Res).

%% run with
%% q(X), minimax_value(X, Re).
