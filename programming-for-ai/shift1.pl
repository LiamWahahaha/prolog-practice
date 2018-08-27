shift([], []).
shift([X|L], Res) :-
    conc(L, [X], Res).
