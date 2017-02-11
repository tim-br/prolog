%% test queries: tem11(X), minimax_value(x, X, P).

%%%
%%%
%%% x will be max

%%% o will be min
%%% a win for x will be worth 1 point
%%% a win for o will be worth 0 point
tem(
board(r(row(nil,nil,nil)),
      r(row(nil,nil,nil)),
      r(row(nil,nil,nil)))).

tem2(
board(r(row(nil,nil,nil)),
      r(row(o,o,o)),
      r(row(nil,nil,nil)))).

tem3(
board(r(row(nil,nil,nil)),
      r(row(nil,nil,nil)),
      r(row(x,x,x)))).

tem4(
board(r(row(x,nil,nil)),
      r(row(x,nil,nil)),
      r(row(x,nil,nil)))).

tem5(
board(r(row(nil,nil,o)),
      r(row(nil,nil,o)),
      r(row(nil,nil,o)))).

tem6(
board(r(row(nil,nil,o)),
      r(row(nil,nil,nil)),
      r(row(nil,nil,o)))).

tem7(
board(r(row(nil,nil,o)),
      r(row(nil,o,nil)),
      r(row(o,nil,o)))).

tem8(
board(r(row(x,nil,o)),
      r(row(nil,x,nil)),
      r(row(o,nil,x)))).

%% tied board
tie(
board(r(row(o,x,x)),
      r(row(x,o,o)),
      r(row(x,o,x)))).

%% tied board
tem9(
board(r(row(nil,nil,x)),
      r(row(x,o,o)),
      r(row(x,o,x)))).

tem10(
board(r(row(nil,nil,x)),
      r(row(o,nil,x)),
      r(row(x,o,o)))).

tem11(
board(r(row(nil,nil,x)),
      r(row(nil,o,x)),
      r(row(x,o,o)))).

tem11(
board(r(row(nil,nil,x)),
      r(row(nil,o,x)),
      r(row(x,o,o)))).

%% o should win this board
tem12(
board(r(row(x,nil,x)),
      r(row(nil,o,x)),
      r(row(x,o,o)))).

write_cell(nil):-
  write(nil),
  write('  ').

write_cell(x):-
  write(x),
  write('    ').

write_cell(o):-
  write(o),
  write('    ').

dump_row(row(A,B,C)):-
  write_cell(A),
  write_cell(B),
  write_cell(C),
  nl.

pl(board(R1,R2,R3)).

dump_board(board(r(R1),r(R2),r(R3))):-
  dump_row(R1),
  dump_row(R2),
  dump_row(R3),
  nl.

smaller(X,Y,X):-
  X =< Y.

smaller(X,Y,Y):-
  X > Y.

greater(X,Y,X):-
  X >= Y.

greater(X,Y,Y):-
  Y > X.

winning_pos(board(r(row(Player, Player, Player)), _, _), Player):-
  Player \= nil.
winning_pos(board(_, r(row(Player, Player, Player)), _), Player):-
  Player \= nil.
winning_pos(board(_, _, r(row(Player, Player, Player))), Player):-
  Player \= nil.

winning_pos(board(r(row(Player, _, _)), r(row(Player, _, _)), r(row(Player, _, _))), Player):-
  Player \= nil.

winning_pos(board(r(row(_, Player, _)), r(row(_, Player, _)), r(row(_, Player, _))), Player):-
  Player \= nil.

winning_pos(board(r(row(_, _, Player)), r(row(_, _, Player)), r(row(_, _, Player))), Player):-
  Player \= nil.

winning_pos(board(r(row(Player, _, _)), r(row(_, Player, _)), r(row(_, _, Player))), Player):-
  Player \= nil.

winning_pos(board(r(row(_, _, Player)), r(row(_, Player, _)), r(row(Player, _, _))), Player):-
  Player \= nil.

row_not_nil(row(A,B,C)):-
  A \= nil,
  B \= nil,
  C \= nil.

board_not_nil(board(r(R1),r(R2),r(R3))):-
  row_not_nil(R2),
  row_not_nil(R3),
  row_not_nil(R1).

% x_board(row(nil,x,nil)),
%       row(x,nil,o)),
%       row(nil,o,nil))).

te_board(row(nil,x,x),
         row(x,nil,nil),
         row(o,nil,o)).

 te2_board(row(nil,x,x),
           row(x,nil,nil),
           row(o,o,o)).

available_move(x, Cell, x):-
  Cell == nil.

available_move(o, Cell, o):-
  Cell == nil.

available_move(_, Cell, none):-
  Cell == o.

available_move(_, Cell, none):-
  Cell == x.

available_moves_in_row(Player, row(X,Y,Z), row(Cell1, Cell2, Cell3)):-
  available_move(Player, X, Cell1),
  available_move(Player, Y, Cell2),
  available_move(Player, Z, Cell3).

make_move_in_row(Player, row(X,Y,Z), row(Cell1, Cell2, Cell3)):-
  available_moves_in_row(Player, row(X,Y,Z), row(Pos1, _, _)),
  Pos1 == Player,
  Cell1 = Player,
  Cell2 = Y,
  Cell3 = Z
  ;
  available_moves_in_row(Player, row(X,Y,Z), row(_, Pos2, _)),
  Pos2 == Player,
  Cell2 = Pos2,
  Cell1 = X,
  Cell3 = Z
  ;
  available_moves_in_row(Player, row(X,Y,Z), row(_, _, Pos3)),
  Pos3 == Player,
  Cell3 = Pos3,
  Cell1 = X,
  Cell2 = Y.

make_move_in_board(Player, board(r(R1), r(R2), r(R3)), board(r(R4), r(R5), r(R6))):-
  \+ winning_pos(board(r(R1), r(R2), r(R3)), _),
  make_move_in_row(Player, R1, R4),
  R5 = R2,
  R3 = R6.

make_move_in_board(Player, board(r(R1), r(R2), r(R3)), board(r(R4), r(R5), r(R6))):-
  \+ winning_pos(board(r(R1), r(R2), r(R3)), _),
  make_move_in_row(Player, R2, R5),
  R1 = R4,
  R3 = R6.

make_move_in_board(Player, board(r(R1), r(R2), r(R3)), board(r(R4), r(R5), r(R6))):-
  \+ winning_pos(board(r(R1), r(R2), r(R3)), _),
  make_move_in_row(Player, R3, R6),
  R1 = R4,
  R2 = R5.

minimax_value(_,Board, X, Board):-
  % dump_board(Board),
  % nl,
  winning_pos(Board, Player),
  Player == x,
  X is 1,
  dump_board(Board)
  ;
  % dump_board(Board),
  % nl,
  winning_pos(Board, Player),
  Player == o,
  X is 0,
  dump_board(Board)
  ;
  % dump_board(Board),
  % nl,
  board_not_nil(Board),
  X is 0,
  dump_board(Board).

minimax_value(x, Board, Res2, NextBoard):-
  % dump_board(Board),
  % nl,
  make_move_in_board(x, Board, Board2),
  % dump_board(Board2),
  % nl,
  %%minimax_value(o, Board2,Res),
  aggregate(max(Res, Board2), minimax_value(o, Board2,Res,_), max(Res2, NextBoard)),
  dump_board(NextBoard). %% get greatest of res

minimax_value(o, Board, Res2, NextBoard):-
  % dump_board(Board),
  % nl,
  make_move_in_board(o, Board, Board2),
  % dump_board(Board2),
  % nl,
  %%minimax_value(x, Board2,Res),
  aggregate(min(Res, Board2), minimax_value(x, Board2,Res,_), min(Res2, NextBoard)),
  dump_board(NextBoard). %% get smallest of Res
