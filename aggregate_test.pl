person(fred,1).
person(jake,1).
person(bill,0).
person(fran,1).
person(jazz,1).
bp(9).
bp(5).


b(4).
b(2).

youngest(Person) :-
  aggregate(min(Age,Pers), person(Pers,Age), min(_, Person)).

oldest(Person) :-
  aggregate(max(Age,Pers), person(Pers,Age), Person).

largest(Elem):-
  bp(X),
  aggregate(max(X), X, Elem).
