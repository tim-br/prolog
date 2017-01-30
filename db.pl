% loves(romeo, juliet).
%
% loves(juliet, romeo) :- loves(romeo, juliet).
%

% happy(albert).
% happy(alice).
% happy(bob).
% happy(bill).
% with_albert(alice).

% :- equals if

runs(albert) :-
  happy(albert).

dances(alice) :-
  happy(alice),
  with_albert(alice).

does_alice_dance :- dances(alice),
  write('when alice is happy and with albert, she dances').

% this throws an error
swims(bob) :-
  happy(bob),
  near_water(bob).

swims(bill) :-
  happy(bill).

swims(bill) :-
  near_water(bill).

male(albert).
male(bob).
male(bill).
male(carl).

female(alice).
female(betsy).
female(diana).

parent(albert, bob).
parent(albert, betsy).
parent(albert, bill).

parent(alice, bob).
parent(alice, betsy).
parent(alice, bill).

parent(bob, carl).
parent(bob, yolo).

get_grandchild :-
  parent(albert, X),
  parent(X, Y),
  write('Alberts grandchild is '),
  write(Y), nl.


myreverse([], Reversed, Reversed).
myreverse([Head|Tail], SoFar, Reversed) :-
          myreverse(Tail, [Head|SoFar], Reversed).


% fname(sl21,john).
% fname(sl46,jen).
% fname(sl50,harry).
% fname(sl99,barry).

lname(sl21,white).
lname(sl46,craig).
lname(sl50,williams).
lname(sl99,potter).

sex(sl21,m).
sex(sl46,f).
sex(sl50,m).
sex(sl99,50).


salary(sl21,30000).
salary(sl46,8000).
salary(sl50,140000).
salary(sl99,2000).

%% selection, basically
greater(X,S):-
  salary(X,Y),
  Y > S,
  sex(X,Z),
  lname(X,Q),
  write('last name is '),
  write(Q),
  write(' sex is '),
  write(Z),
  %% should detail all the attributes here
  nl.

firstnameLastname(X):-
  fname(X,Z),
  lname(X,Y),
  write('the last name is '),
  write(Y),
  nl,
  write('the first name is '),
  write(Z),
  nl.

hasBranch(london).
hasBranch(aberdeen).
hasBranch(glasgow).
hasBranch(bristol).
hasBranch(berlin).
hasBranch(sanfranciso).

hasProperty(munich).
hasProperty(london).
hasProperty(aberdeen).
hasProperty(glasgow).
hasProperty(bristol).

hasPB(X):-
  hasBranch(X),
  hasProperty(X).

bNotP(X):-
  hasBranch(X),
  \+(hasProperty(X)).

hasPOrB(X):-
  hasBranch(X).
hasPOrB(X):-
  hasProperty(x).

fName(76,john).
fName(56,aline).
fName(74,mike).
fName(62,mary).

viewing(56,p14,toosmall).
viewing(76,p4,tooremote).
viewing(56,p4,x).
viewing(62,p14,nodiningroom).
viewing(56,p36,x).

%% cartesian product?
join(X,Y,Q,Z,T):-
  fName(X,Y),
  viewing(Q,Z,T),
  X == Q.
% T
relate(a,1).
relate(b,2).

%U
relate(1,x).
relate(1,y).
relate(3,z).

naturalJoin(A,B,C):-
  relate(A,B),
  relate(B,C).

semijoin(A,B):-
  relate(A,B),
  relate(B,C),
  (\+A=B), !.

leftJoin(A,B,C):-
  relate(A,B),
  relate(B,C).
leftJoin(A,B,C):-
  \+(B == Z),
  relate(A,B),
  relate(Z,C).

myreverse([], Reversed, Reversed).
myreverse([Head|Tail], SoFar, Reversed) :-
          myreverse(Tail, [Head|SoFar], Reversed).


completed(fred,database1).
completed(fred,database1).
completed(fred,compiler1).
completed(eugene,database1).
completed(eugene,compiler1).
completed(sarah,database1).
completed(sarah,database2).

dbproject(database1).
dbproject(database2).

div(X):-
  completed(X,Y),
  dbproject(Y).
