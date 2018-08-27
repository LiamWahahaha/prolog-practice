means(1, one).
means(2, two).
means(3, three).
means(4, four).
means(5, five).
means(6, six).
means(7, seven).
means(8, eight).
means(9, nine).
means(0, zero).

translate([], []).
translate([X|Xs], [Y|Ys]) :-
    means(X, Y),
    translate(Xs, Ys).
