likes(mary,food).
likes(mary,wine).
likes(john,wine).
likes(john,mary).
likes(fred,wine).
likes(voo,voo).

likes(john,X):-
  likes(mary,X).

likes(john,Y):-
  likes(Y,wine).

likes(john,Y):-
  likes(Y,Y).

male(james1).
male(charles1).
male(charles2).
male(james2).
male(george1).

female(catherine).
female(elizabeth).
female(sophia).

parent(charles1, james1).
parent(elizabeth, james1).
parent(charles2, charles1).
parent(catherine, charles1).
parent(james2, charles1).
parent(sophia, elizabeth).
parent(george1, sophia).

mother(C,P):-
  parent(C,P),
  female(P).

father(C,P):-
  parent(C,P),
  male(P).

sibling(X,Y):-
  parent(X,P),
  parent(Y,P).

sister(X,S):-
  sibling(X,S),
  female(S).

brother(X,B):-
  sibling(X,B),
  male(B).

aunt(X,A):-
  parent(X,P),
  sister(P,A).

cousin(X,Y):-
  parent(X,P),
  parent(Y,P2),
  sibling(P,P2).


 move(1,X,Y,_) :-
     write('Move top disk from '),
     write(X),
     write(' to '),
     write(Y),
     nl.
 move(N,X,Y,Z) :-
     N>1,
     M is N-1,
     move(M,X,Z,Y),
     move(1,X,Y,_),
     move(M,Z,Y,X).

size([],0).
size([H|T],N) :- size(T,N1), N is N1+1.

% size([_|T],N) :-
%  size(T,N1),
%  N is N1+1.


sumlist([],0).
sumlist([H|T],N) :- sumlist(T,N1), N is N1+H.

member1(X,[X|_]).
member1(X,[_|T]) :- member1(X,T).

reverse([], Reversed, Reversed).
reverse([Head|Tail], SoFar, Reversed) :-
  reverse(Tail, [Head|SoFar], Reversed).

taller(bob,mike). %% bob is taller than mike
taller(mike,jim).
taller(jim,george).
taller(fred,jim).

taller(jake,eric).
taller(eric,barb).
taller(newman,jake).

taller(X,Y):-
  taller(X,Z),
  taller(Z,Y).

% is_taller(X,Y):-
%   taller(Z,Y),
%   is_taller(X,Z).











shorter(X,Y):-
  taller(Y,X).
shorter(X,Y):-
  taller(Y,Z),
  shorter(X,Z).
