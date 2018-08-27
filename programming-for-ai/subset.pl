subset([], []).
subset([First|Rest], [First|Sub]) :-
    subset(Rest, Sub).
subset([First|Rest], Sub) :-
    subset(Rest, Sub).
