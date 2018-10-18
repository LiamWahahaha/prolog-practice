preorder(Root, [Root]) :-
    leaf(Root).
preorder(nil, []).
preorder(Root, Res) :-
    node(Root, LC, RC),
    preorder(LC, LR),
    preorder(RC, RR),
    append([Root|LR], RR, Res).

preorder1(Node, List, Tail) :-
  node(Node, Child1, Child2),
  List = [Node|List1],
  preorder1(Child1, List1, Tail1),
  preorder1(Child2, Tail1, Tail).
preorder1(Node, [Node|Tail], Tail) :-
  leaf(Node).
preorder1(nil, Tail, Tail).

preorder1(Node, List) :-
  preorder1(Node, List, []).
