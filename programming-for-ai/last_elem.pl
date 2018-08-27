last_elem(X, [X]).

last_elem(X, [_|L]) :-
    last_elem(X, L).
