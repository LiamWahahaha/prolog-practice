del(X, [X|L], L).
del(X, [Y|Tail], [Y|Tail1]) :-
    del(X, Tail, Tail1).

member(X, L) :-
    del(X, L, _).
