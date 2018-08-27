del(X, [X|L], L).
del(X, [Y|T], [Y|T1]) :-
    del(X, T, T1).

insert(X, L, Res) :-
    del(X, Res, L).

perm1([],[]).
perm1([X|L], P) :-
    perm1(L, L1),
    insert(X, L1, P).

perm2([],[]).
perm2(L, [X|P]) :-
    del(X, L, L1),
    perm2(L1, P).

