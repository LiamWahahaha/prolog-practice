:- import append/3 from basics.
:- import member/2 from basics.

resolution(InputFile):-
    read_file(InputFile),
    transform_query,
    resolution_helper,
    !,
    (
        myClause(_Num, empty)
        ->
            writeln('resolution(success).'),
            print_result
        ;
            writeln('resolution(fail).')
    ).


resolution_helper:-
    resolution_helper(_, _).
resolution_helper(N, _):-
    myClause(N, empty),
    !.
resolution_helper(_, N):-
    myClause(N, emplty),
    !.
resolution_helper(N1, N2):-
    myClause(N1, Clause1),
    myClause(N2, Clause2),
    extract(Clause1, AtomList1_Dup),
    remove_duplicate(AtomList1_Dup, AtomList1),
    extract(Clause2, AtomList2_Dup),
    remove_duplicate(AtomList2_Dup, AtomList2),
    union(AtomList1, AtomList2, NewList),
    construct(NewList, NewClause),
    \+ clause_in_db(NewClause),
    get_next_id(Num),
    assertz(myClause(Num, NewClause)),
    assertz(result(N1, N2, NewClause, Num)),
    retract(myClause(N1, Clause1)),
    retract(myClause(N2, Clause2)),
    fail;
    true.

% helper functions
read_file(InputFile):-
    see(InputFile),
    repeat,
    read(Term),
    (
        Term == end_of_file
        ->
            true
        ;
            assertz(Term),
            fail
    ),
    seen,
    see(user).

transform_query:-
    myQuery(X, Y),
    extract(Y, ExpressionList),
    transform(ExpressionList, AtomList),
    retract(myQuery(X, Y)),
    add_new_clause(AtomList),
    !.


transform([], []).
transform([X|Xs], [neg(X)|Res]):-
    transform(Xs, Res).
transform([neg(X)|Xs],[X|Res]):-
    transform(Xs, Res).


add_new_clause([]).
add_new_clause([X|T]):-
    get_next_id(NextNum),
    asserta(myClause(NextNum, X)),
    add_new_clause(T).


get_next_id(NextNum):-
    findall(Num, myClause(Num, _), Nums),
    max_id(Nums, Num0),
    NextNum is Num0 + 1.


max_id([Num], Num):- !.
max_id([M, N|L], Res):-
    (
        M >= N
        ->
            max_id([M|L], Res)
        ;
            max_id([N|L], Res)
    ).


get_neg_atom([], []).
get_neg_atom([neg(X)|Xs], [neg(X)|Res]):-
    atom(X),
    !,
    get_neg_atom(Xs, Res).
get_neg_atom([_|Xs], Res):-
    get_neg_atom(Xs, Res).


clause_in_db(Clause):-
    myClause(_, Clause),
    !.


union(L1, L2, Result):-
    get_neg_atom(L1, [neg(A)|_]),
    member(A, L2),
    delete(neg(A), L1, RestOfL1),
    delete(A, L2, RestOfL2),
    append(RestOfL1, RestOfL2, RawResult),
    remove_duplicate(RawResult, Result).


delete(X, [X|Ys], Ys).
delete(X, [Y|Ys], [Y|Zs]):-
    delete(X, Ys, Zs).


remove_duplicate([], []).
remove_duplicate([H|T], [H|Res]):-
    \+ member(H, T),
    !,
    remove_duplicate(T, Res).
remove_duplicate([_|T], List):-
    remove_duplicate(T, List).


extract(neg(A), [neg(A)]):-
    atom(A),
    !.
extract(A, [A]):-
    atom(A),
    !.
extract(E, [Atom|L]):-
    E=.. [_Operation, RestExpression, Atom],
    atom(Atom),
    !,
    extract(RestExpression, L).
extract(E, Res):-
    E=.. [_Operation, RestExpression, Expression],
    extract(Expression, PartialRes),
    extract(RestExpression, PartialRes1),
    append(PartialRes, PartialRes1, Res).


construct([], empty).
construct([neg(A)], neg(A)):-
    atom(A),
    !.
construct([A], A):-
    atom(A),
    !.
construct([A1, A2], Res):-
    Res =.. [or, A2, A1].
construct([A1|T], or(Res, A1)):-
    construct(T, Res).


print_result:-
    result(N1, N2, Clause, N3),
    write('resolution('),
    write(N1), write(', '),
    write(N2), write(', '),
    write(Clause), write(', '),
    write(N3), write(').'),
    nl,
    fail.
