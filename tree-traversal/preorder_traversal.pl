node(25, 15, 50).
node(15, 10, 22).
node(10, 4, 12).
node(22, 18, 24).
node(50, 35, 70).
node(35, 31, 44).
node(70, 66, 90).
leaf(4).
leaf(12).
leaf(18).
leaf(24).
leaf(31).
leaf(44).
leaf(66).
leaf(90).

append([], L, L).
append([X | L1], L2, [X | L3]):-
    append(L1, L2, L3).

preorder(Root, [Root]):- leaf(Root).

preorder(Root, [Root|L]) :-
    node(Root, Child1, Child2),
    preorder(Child1, L1),
    preorder(Child2, L2),
    append(L1, L2, L).

postorder(node(Root, L, R), Res) :-
    postorder(L, Ls),
    postorder(R, Rs),
    append(Ls, Rs, Res1),
    append(Res1, [X], Res).
post(void, []).
