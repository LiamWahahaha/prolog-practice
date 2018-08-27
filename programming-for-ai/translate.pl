means(0, zero).
means(1, one).
means(2, two).
means(3, three).
means(4, four).
means(5, five).
means(6, six).
means(7, seven).
means(8, eight).
means(9, night).

translate([],[]).
%translate(List, Res) :-
%    reverse(List, New_List),
%    translate_helper(New_List,[] , Res).

%translate_helper([], L, L).
%translate_helper([X|L], BeforeAcc, AfterAcc) :-
%    means(X, Eng),
%    translate_helper(L, [Eng|BeforeAcc], AfterAcc).

translate([X|Tail], [Y|Tail1]):-
    means(X, Y),
    translate(Tail, Tail1).
