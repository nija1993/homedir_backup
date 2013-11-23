takeout(X, [X|R], R).
takeout(X, [F|R], [F|S]) :- takeout(X, R, S).
perm([],[]).
perm([A|B], C) :- perm(B, W), takeout(A, C, W).
