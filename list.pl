p([H|T], H, T).

on(Item,[Item|Rest]).
on(Item,[NotIt|Tail]):-
  on(Item,Tail).

%List2 = [prolog|List1]

is_in(X):-
  on(X, [london_buckingham_palace,
         paris_eiffel_tower,
         york_minster,
         pisa_leaning_tower,
         athens_parthenon]).

append2([],List,List).
append2([Head|Tail],List2,Result):-
  append2(Tail,List2,Result).

sift([],[]).
sift([X|T],[X|Result]):-
  X > 6,
  sift(T,Result).
sift([ThrowAway|Tail],Result):-
  sift(Tail,Result).

delete_all([],Foo,[]).
delete_all([Foo|Tail],Foo,Result):-
  delete_all(Tail,Foo,Result).
delete_all([H|Tail],Foo,[H|Result]):-
  delete_all(Tail,Foo,Result).

replace_all([],Target,Replacement,[]).
replace_all([Target|Tail],Target,Replacement,[Replacement|Result]):-
  replace_all(Tail,Target,Replacement,Result).
replace_all([Head|Tail],Target,Replacement,[Head|Result]):-
  replace_all(Tail,Target,Replacement,Result).
