last([], 0).
last([X], X).
last([_|T], L):-
    last(T, L).
