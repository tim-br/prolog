mortal(X) :-
  human(X).

human(socrates).

human(fred).

fun(X) :-
  red(X),
  car(X).

fun(X) :-
  blue(X),
  bike(X).

fun(ice_cream).

blue(homer).
bike(homer).

% sad(X):-
%   a ,
%   b.
% a(bart).
% b(bart).

likes(john,mary).
likes(john,trains).
likes(peter,fast_cars).
likes(Person1,Person2):-
hobby(Person1,Hobby),
hobby(Person2,Hobby).
hobby(john,trainspotting).
hobby(tim,sailing).
hobby(helen,trainspotting).
hobby(simon,sailing).


eats(fred,oranges).                           /* "Fred eats oranges" */

eats(fred,t_bone_steaks).                     /* "Fred eats T-bone steaks" */

eats(fred, pears).

eats(fred, t_bone_steak).

eats(fred, apples).

eats(tony,apples).                            /* "Tony eats apples" */


eats(john,apples).                            /* "John eats apples" */


eats(john,grapefruit).                        /* "John eats grapefruit" */


age(john,32).                 /*  John is 32 years old */

age(agnes,41).                /*  Agnes is 41 */


age(george,72).               /*  George is 72 */


age(ian,2).                   /*  Ian is 2 */


age(thomas,25).               /*  Thomas is 25 */

hold_party(X):-
  birthday(X),
  happy(X).

birthday(tom).
birthday(fred).
birthday(helen).
birthday(jane).

happy(mary).
happy(jane).
happy(helen).
