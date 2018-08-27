dividelist([], [], []).
dividelist([X], [X], []).
dividelist([X, Y| List], [X|List1], [Y|List2]) :-
    dividelist(List, List1, List2).
