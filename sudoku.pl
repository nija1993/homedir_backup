chk_member(H, [H|T]).
chk_member(X, [H|T]) :- chk_member(X, T).
delete_one(_, [], []).
delete_one(Term, [Term|Tail], Tail).
delete_one(Term, [Head|Tail], [Head|Result]) :- delete_one(Term, Tail, Result), not(Term = Head).
repeat_element(A) :- chk_member(X,A), delete_one(X, A, R), chk_member(X, R).
valid(A) :- not(repeat_element(A)).
valid_sudoku(A) :- A = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44],
Row1 = [S11,S12,S13,S14],
Row2 = [S21,S22,S23,S24],
Row3 = [S31,S32,S33,S34],
Row4 = [S41,S42,S43,S44],
Col1 = [S11,S21,S31,S41],
Col2 = [S12,S22,S32,S42],
Col3 = [S13,S23,S33,S43],
Col4 = [S14,S24,S34,S44],
Sq1 = [S11,S12,S21,S22],
Sq2 = [S13,S14,S23,S24],
Sq3 = [S31,S32,S41,S42],
Sq4 = [S33,S34,S43,S44],
valid(Row1),valid(Row2),valid(Row3),valid(Row4),valid(Col1),valid(Col2),valid(Col3),valid(Col4),valid(Sq1),valid(Sq2),valid(Sq3),valid(Sq4).
row_rotate(S, R) :- S = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44], R = [S12,S13,S14,S11,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44].
row_rotate(S, R) :- S = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44], R = [S11,S12,S13,S14,S22,S23,S24,S21,S31,S32,S33,S34,S41,S42,S43,S44]. 
row_rotate(S, R) :- S = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44], R = [S11,S12,S13,S14,S21,S22,S23,S24,S32,S33,S34,S31,S41,S42,S43,S44]. 
row_rotate(S, R) :- S = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44], R = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S42,S43,S44,S41]. 
col_rotate(S, R) :- S = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44], R = [S21,S12,S13,S14,S31,S22,S23,S24,S41,S32,S33,S34,S11,S42,S43,S44].
col_rotate(S, R) :- S = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44], R = [S11,S22,S13,S14,S21,S32,S23,S24,S31,S42,S33,S34,S41,S12,S43,S44].
col_rotate(S, R) :- S = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44], R = [S11,S12,S23,S14,S21,S22,S33,S24,S31,S32,S43,S34,S41,S42,S13,S44].
col_rotate(S, R) :- S = [S11,S12,S13,S14,S21,S22,S23,S24,S31,S32,S33,S34,S41,S42,S43,S44], R = [S11,S12,S13,S24,S21,S22,S23,S34,S31,S32,S33,S44,S41,S42,S43,S14].
validate(A,_,_) :- valid_sudoku(A).
validate(A,B,Y) :- row_rotate(A,X), not(chk_member(A,B)), Z is Y+1, validate(X,[A|B],Z).
validate(A,B,Y) :- col_rotate(A,X), not(chk_member(A,B)), write(Y), nl, Z is Y+1, validate(X,[A|B],Z).
validation(A,_,_) :- valid_sudoku(A).
validation(A,B,Y) :- col_rotate(A,X), not(chk_member(A,B)), write(Y), nl, Z is Y+1, validation(X,[A|B],Z).
validation(A,B,Y) :- row_rotate(A,X), not(chk_member(A,B)), write(Y), nl, Z is Y+1, validation(X,[A|B],Z).
