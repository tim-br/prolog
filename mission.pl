removehead([_|Tail], Tail).

start_pos(state([[m,m,m],[c,c,c],[],[],w])).
start_pos2(state([[m,m,m],[c,c,c],[m],[],w])).
start_pos3(state([[m,m], [c,c], [m], [c,c,c], e])).
start_pos4(state([[m,m,m], [c,c,c,c], [m], [c,c], e])).

goal_pos(state([[],[c,c,c],[m,m,m],[],e])).

cons(X, Li, [X|Li]).

change(e,w).
change(w,e).

safe(state([MissionariesLeft, CarnivoresLeft, MissionariesRight, CarnivoresRight, _])):-
  length(MissionariesLeft, ML),
  length(CarnivoresLeft, CL),
  CL =< ML,
  length(MissionariesRight, M2),
  length(CarnivoresRight, C2),
  C2 =< M2.

safe(state([MissionariesLeft, _, MissionariesRight, CarnivoresRight, _])):-
  length(MissionariesLeft, ML),
  ML == 0,
  length(MissionariesRight, M2),
  length(CarnivoresRight, C2),
  C2 =< M2.

safe(state([MissionariesLeft, CarnivoresLeft, MissionariesRight, _, _])):-
  length(MissionariesLeft, ML),
  length(CarnivoresLeft, CL),
  CL =< ML,
  length(MissionariesRight, M2),
  M2 == 0.

safe(state([MissionariesLeft, _, MissionariesRight, _, _])):-
  length(MissionariesLeft, ML),
  ML == 0,
  length(MissionariesRight, M2),
  M2 == 0.

move_missionary_to_other_coast(state([MissionariesLeft1,CarnivoresWest1,MissionariesRight1,CarnivoresEast1,BoatPos])
                              ,state([MissionariesLeft2,CarnivoresWest1,MissionariesRight2,CarnivoresEast1,_])):-
  BoatPos == w,
  removehead(MissionariesLeft1, MissionariesLeft2),
  cons(m, MissionariesRight1, MissionariesRight2)
  ;
  BoatPos == e,
  removehead(MissionariesRight1, MissionariesRight2),
  cons(m, MissionariesLeft1, MissionariesLeft2).

move_carnivore_to_other_coast(state([MWest1,CarnivoresLeft1,MRight1,CarnivoresRight1,BoatPos])
                              ,state([MWest1,CarnivoresLeft2,MRight1,CarnivoresRight2,_])):-
  BoatPos == w,
  removehead(CarnivoresLeft1, CarnivoresLeft2),
  cons(c, CarnivoresRight1, CarnivoresRight2)
  ;
  BoatPos == e,
  removehead(CarnivoresRight1, CarnivoresRight2),
  cons(c, CarnivoresLeft1, CarnivoresLeft2).

move( state([MWest1,CarnivoresLeft1,MEast1,CarnivoresRight1,BoatPos])
    , [m]
    , state([MWest2,CarnivoresLeft2,MEast2,CarnivoresRight2,BoatPos2])):-
  move_missionary_to_other_coast(state([MWest1,CarnivoresLeft1,MEast1,CarnivoresRight1,BoatPos]), state([MWest2,CarnivoresLeft2,MEast2,CarnivoresRight2,BoatPos2])),
  change(BoatPos, BoatPos2).

move( state([MWest1,CarnivoresLeft1,MEast1,CarnivoresRight1,BoatPos])
    , [c]
    , state([MWest2,CarnivoresLeft2,MEast2,CarnivoresRight2,BoatPos2])):-
  move_carnivore_to_other_coast(state([MWest1,CarnivoresLeft1,MEast1,CarnivoresRight1,BoatPos]), state([MWest2,CarnivoresLeft2,MEast2,CarnivoresRight2,BoatPos2])),
  change(BoatPos, BoatPos2).

move(state([MissionariesLeft1,CarnivoresLeft1,MissionariesRight1,CarnivoresRight1,Coast])
    , [c,c]
    , state([MissionariesLeft1,CarnivoresLeft2,MissionariesRight1,CarnivoresRight2,Coast2])):-
  change(Coast, Coast2),
  move_carnivore_to_other_coast(state([MissionariesLeft1,CarnivoresLeft1,MissionariesRight1,CarnivoresRight1,Coast]), state([A,B,C,D,_])),
  move_carnivore_to_other_coast(state([A,B,C,D,Coast]), state([MissionariesLeft1,CarnivoresLeft2,MissionariesRight1,CarnivoresRight2,_])).


move(state([MissionariesLeft1,CarnivoresLeft1,MissionariesRight1,CarnivoresRight1,Coast])
    , [m,m]
    , state([MissionariesLeft2,CarnivoresLeft1,MissionariesRight2,CarnivoresRight1,Coast2])):-
  change(Coast, Coast2),
  move_missionary_to_other_coast(state([MissionariesLeft1,CarnivoresLeft1,MissionariesRight1,CarnivoresRight1,Coast]), state([A,_,C,_,_])),
  move_missionary_to_other_coast(state([A,_,C,_,Coast]), state([MissionariesLeft2,_,MissionariesRight2,_,_]))
  .

move(state([MissionariesLeft1,CarnivoresLeft1,MissionariesRight1,CarnivoresRight1,Coast])
    , [m,c]
    , state([MissionariesLeft2,CarnivoresLeft2,MissionariesRight2,CarnivoresRight2,Coast2])):-
  change(Coast, Coast2),
  move_missionary_to_other_coast(state([MissionariesLeft1,CarnivoresLeft1,MissionariesRight1,CarnivoresRight1,Coast]), state([A,B,C,D,_])),
  move_carnivore_to_other_coast(state([A,B,C,D,Coast]), state([MissionariesLeft2,CarnivoresLeft2,MissionariesRight2,CarnivoresRight2,_])).

solve_assist(X,[], _):-
  goal_pos(X).

solve_assist(FirstState, [FirstMove|OtherMoves], Accumulator):-
  %write(FirstState),
  %nl,
  %write(NextState),
  %nl,
  \+ member(FirstState, Accumulator),
  move(FirstState, FirstMove, NextState),
  %\+ member(NextState, Accumulator),
  %safe(NextState),
  cons(FirstState, Accumulator, X),
  %cons(NextState, X, Y),
  %write(Accumulator),
  %nl,
  %nl,
  solve_assist(NextState, OtherMoves, X).

solve(FirstState, Res):-
  solve_assist(FirstState, Res, []).
