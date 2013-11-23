append([], X, X).
append([H|X], Y, [H|Z]) :- append(X, Y, Z).
reverse([],[]).
reverse([H|A], B) :- reverse(A, X), append(X, [H], B).
