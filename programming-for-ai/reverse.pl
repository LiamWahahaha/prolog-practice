reverse(L, Res) :-
    reverse(L, [], Res).

reverse([],L, L).

reverse([X|Y], Accumulater, Res) :-
    reverse(Y, [X|Accumulater], Res).
