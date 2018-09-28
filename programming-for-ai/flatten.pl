flatten([X|L], Flatten) :-
    flatten(X, Flatten_Head),
    flatten(L, Flatten_Tail),
    conc(Flatten_Head, Flatten_Tail, Flatten).
flatten([], []).
flatten(X, [X]).
