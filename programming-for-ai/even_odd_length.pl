evenlength([]).

evenlength([X|L]) :-
    oddlength(L).

oddlength([X|L]) :-
    evenlength(L).
