goldbach(4, [2, 2]) :-
    !.

goldbach(N, L) :-
   N mod 2 =:= 0,
   N > 4,
   goldbach(N, L, 3).

goldbach(N, [P, Q], P) :-
    Q is N - P,
    is_prime(Q),
    Q > P.

goldbach(N, L, P) :-
    P < N,
    !,
    next_prime(P1, P),
    goldbach(N, L, P1).

next_prime(P1, P) :-
    P1 is P + 2,
    is_prime(P1),
    !.

next_prime(P1, P) :-
    P2 is P + 2,
    next_prime(P1, P2).

is_prime(2).
is_prime(3).
is_prime(P) :-
    P > 3,
    P mod 2 =\= 0,
    \+ has_factor(P, 3).

% has_factor(N, L) :- N has an odd factor F >= L
has_factor(N, L) :-
    N mod L =:= 0.

has_fator(N, L) :-
    L * L < N,
    L2 is L + 2,
    has_factor(N, L2).

% goldbach(12, L), write(L), nl, fail; true.
