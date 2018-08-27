conc([], L, L).
conc([X|Tail_of_L1], L2, [X|Tail_of_L3]) :-
    conc(Tail_of_L1, L2, Tail_of_L3).

member(X, L) :-
    conc(_,[X|_], L).

truncate_last_three(L, L1) :-
    conc(L1, [_,_,_], L).

truncate_three_elements_from_both_ends(L, L2) :-
    conc([_,_,_|L2], [_,_,_], L).

last_elem(Item, List) :-
    conc(_, [Item], List).
