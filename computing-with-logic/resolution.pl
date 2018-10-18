:- import append/3 from basics.
:- import member/2 from basics.

resolution(InputFile):-
    read_file(InputFile),
    transform_query,
    resolution_helper,
    !,
    myClause(_, empty)
    ->
        writeln('resolution(success).'),
        print_result
    ;
        writeln('resolution(fail).').

resolution_helper:-
    resolution_helper(_, _).

resolution_helper(N, _):-
    myClause(N, empty), !.

resolution_helper(_, N):-
    myClause(N, empty), !.

resolution_helper(N1, N2):-
    myClause(N1, Clause1),
    myClause(N2, Clause2),
    extract(Clause1, AtomList1),
    extract(Clause2, AtomList2),
    union(AtomList1, AtomList2, NewList),
    inverse(NewList, NewClause),
    \+ clause_in_db(NewClause),
    get_next_id(Num),
    assertz(myClause(Num, NewClause)),
    assertz(result(N1, N2, NewClause, Num)),
    retract(myClause(N1, Clause1)),
    retract(myClause(N2, Clause2)), fail;
    true.

% read file
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


%main(InputFile):-
%    open(InputFile, read, Str),
%    read_file(Str, _),
%    close(Str).

%read_file(Stream,[]):-
%    at_end_of_stream(Stream), !.

%read_file(Stream,[X|L]):-
%    \+ at_end_of_stream(Stream),
%    read(Stream,X),
%    assert(X),
%    read_file(Stream,L).

% add new clause auxiliary function
get_next_id(NextNum) :-
    findall(Num, myClause(Num, _), Nums),
    max_id(Nums, Num0),
    NextNum is Num0 + 1.

max_id([Num], Num).
max_id([M,N|L], Res):-
    M >= N
    -> max_id([M|L], Res)
    ;
       max_id([N|L], Res).

get_neg_atom([], []).

get_neg_atom([neg(X)|Xs], [neg(X)|Rest]):-
    atom(X),
    !,
    get_neg_atom(Xs, Rest).

get_neg_atom([_|Xs], Rest):-
    get_neg_atom(Xs, Rest).


clause_in_db(Clause) :-
    myClause(_, Clause), !.

union(L1, L2, Result):-
    get_neg_atom(L1, [neg(A)|_]),
    member(A, L2),
    delete(neg(A), L1, RestOfL1),
    delete(A, L2, RestOfL2),
    append(RestOfL1, RestOfL2, RawResult),
    remove_duplicate(RawResult, Result).

delete(X, [X|Ys], Ys).

delete(X, [Y|Ys], [Y|Zs]) :-
    delete(X, Ys, Zs).

remove_duplicate([], []).
remove_duplicate([H|T], [H|Res]):-
    \+ member(H, T),
    !,
    remove_duplicate(T, Res).
remove_duplicate([_|T], List):-
    remove_duplicate(T, List).

transform_query:-
    myQuery(X, Y),
    atom(Y),
    asserta(myClause(X, neg(Y))),
    retract(myQuery(X, Y)),
    !.

transform_query:-
    myQuery(X, neg(Y)),
    atom(Y),
    asserta(myClause(X, Y)),
    retract(myQuery(X, neg(Y))),
    !.

print_clause:-
    myClause(X, Y),
    write(X),
    write(' '),
    write(Y),
    nl,
    fail.

print_clause:-
    myQuery(X, Y),
    write(X),
    write(' '),
    write(Y),
    nl.

print_result:-
    result(N1, N2, Clause, N3),
    write('resolution('),
    write(N1), write(', '),
    write(N2), write(', '),
    write(Clause), write(', '),
    write(N3), write(').'), nl,
    fail.

extract(neg(A), [neg(A)]):-
    atomic(A), !.

extract(A, [A]):-
    atomic(A), !.

extract(E,[Atom1|L]):-
	E =.. [_Operation,RestExpression,Atom1],
	extract(RestExpression,L).

inverse([], empty).

inverse([neg(A)], neg(A)):-
    atomic(A), !.

inverse([A], A):-
    atomic(A), !.

inverse([E1, E2], Res):-
    Res =.. [or, E2, E1].

inverse([E1 | T], or(Res, E1)):-
    inverse(T, Res).

%member(X, [X|_]):- !.
%member(X, [_|T]):-
%    member(X, T).
