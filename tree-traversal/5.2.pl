class(Number, positive) :- Number > 0, !.
class(Number, negative) :- Number < 0, !.
class(0, zero).
