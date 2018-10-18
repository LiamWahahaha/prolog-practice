inorder(Root, [Root]) :-
    leaf(Root).
inorder(nil, []).
inorder(Root, Res) :-
    node(Root, LC, RC),
    inorder(LC, RL),
    inorder(RC, RR),
    append(RL, [Root|RR], Res).


inorder1(Node, List, Tail) :-
  node(Node, Child1, Child2),
  inorder1(Child1, List, Tail1),
  Tail1 = [Node|List1],
  inorder1(Child2, List1, Tail).
inorder1(Node, [Node|Tail], Tail) :-
  leaf(Node).
inorder1(nil, Tail, Tail).
inorder1(Node, List) :-
  inorder1(Node, List, []).

