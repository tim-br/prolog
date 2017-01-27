on_route(rome).

on_route(Place):-
  move(Place,Method,NewPlace),
  on_route(NewPlace).

move(home,taxi,halifax).
move(halifax,train,gatwick).
move(gatwick,plane,rome).
move(london,boat,copenhagen).

parent(john,paul).
parent(paul,tom).
parent(tom,mary).
parent(mary,ben).
parent(ben,raj).
parent(ben,jane).

ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):-
  parent(X,Z),
  ancestor(Z,Y).
% ancestor(X,Y):-
%   parent(X,P),
%   ancestor(P, T).

taller(bob,mike).
taller(mike,jim).
taller(jim,george).
taller(fred,jim).

taller(jake,eric).
taller(eric,barb).

is_taller(X,Y):-
  taller(X,Y).
is_taller(X,Y):-
  taller(X,Z),
  is_taller(Z,Y).

shorter(X,Y):-
  taller(Y,X).
shorter(X,Y):-
  taller(Y,Z),
  shorter(X,Z).

to(town1,town2).
to(town2,town3).
to(town3,town4).
to(town4,town5).
to(town5,town6).

can_get(X,Y):-
  to(X,Y).
can_get(X,Y):-
  to(X,Z),
  can_get(Z,Y).
