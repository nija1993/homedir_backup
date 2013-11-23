%reverse([], X, X).
%reverse([A|B], X, W) :- reverse(B, [A|X], W).
%reverse(A, R) :- reverse(A, [], R).
reverses([],[]).
reverses([H|T], [X|H]) :- reverses(T,X).
