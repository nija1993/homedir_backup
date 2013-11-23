(defun appzero (no list)
(if (equal no 0) list
(cons 0 (appzero (- no 1) list))))

(defun mulnumlist (n list)
(if (null (cdr list)) (cons (* n (car list)) nil)
(append (cons (* n (car list)) nil) (mulnumlist n (cdr list)))))

(defun addpoly (list1 list2)
(if (> (length list1) (length list2)) (map 'list #'+ list1 (appzero (- (length list1) (length list2)) list2))
(map 'list #'+ list2 (appzero (- (length list2) (length list1)) list1))))

(defun subpoly (list1 list2)
(if (> (length list1) (length list2)) (map 'list #'- list1 (appzero (- (length list1) (length list2)) list2))
(map 'list #'- (appzero (- (length list2) (length list1)) list1) list2)))

(defun multpoly (list1 list2)
(if (null (cdr list2)) (mulnumlist (car list2) list1)
(addpoly (mulnumlist (car (reverse list2)) list1) (reverse (appzero 1 (reverse (multpoly list1 (reverse (cdr (reverse list2))))))))))

(defun integral (list)
(if (null (cdr list)) (cons (car list) '(0))
(append (list (/ (car list) (length list))) (integral (cdr list)))))

(defun divpoly (list1 list2)
(if (< (length list1) (length list2)) (list '(0) list1)
))
;0) univariate
;1) polynomial arithmetic
;2) division of 2 polynomials
;3) listing factors of polynomial
;4) identifying common factors for a given polynomial
;5) computing the integral of a polynomial
;6) extra credit 10% decomposing