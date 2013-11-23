;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to add a particular number of zeros to the start of the list. It takes in the following arguments : 
;	1. no   -   Number of zeros to be added.
;	2. list  -   The list in which it has to be added
;	It returns a list.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun addzero (no list)
(if (equal no 0) list
(cons 0 (addzero (- no 1) list))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to append a particular number of zeros to the end of the list. It takes in the following arguments : 
;	1. no   -   Number of zeros to be appended.
;	2. list  -   The list in which it has to be added.
;	It returns a list.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun appzero (no list)
(if (equal no 0) list
(appzero (- no 1) (append list '(0)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to multiply each element of a list with a particular number. It takes in the following arguments : 
;	1. n   -   The number to be multiplied
;	2. list -  The list over which it has to be multiplied.
;	It returns a list.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun mulnumlist (n list)
(if (null (cdr list)) (cons (* n (car list)) nil)
(append (cons (* n (car list)) nil) (mulnumlist n (cdr list)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to divide the number with each element of a list. It takes in the following arguments : 
;	1. n   -   The number used to divide.
;	2. list -  The list used to divide.
;	It returns a list.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun divnumlist (n list)
(if (null (cdr list)) (cons (/ n (car list)) nil)
(append (cons (/ n (car list)) nil) (divnumlist n (cdr list)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used by the function factor to find the factors of a particular number(no1). It takes in the following arguments :
;	1. no1  -  The number for which we have to find the factors.
;	2. no2  -  The number for checking if no1 is divisible or not.
;	It returns a list.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun factor(no1 no2)
(if (equal no2 1) '(1)
(if (equal (mod no1 no2) 0) (cons no2 (factor no1 (- no2 1)))
(factor no1 (- no2 1)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to find the factors of a particular number. It uses the function factors for this purpose. It takes in the following arguments : 
;	1. no  -  The number for which we have to find the factors.
;	It returns a list.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun factors(no)
(if (< no 0) (factors (- 0 no))
(reverse (factor no no))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to find the value of a polynomial.  It takes in the following arguments : 
;	1. listpoly  -  The polynomial as a list.
;	2. val         -  The value which has to be substituted.
;	It returns a number.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun valuepoly(listpoly val)
(if (null (cdr listpoly)) (car listpoly)
(+ (car (reverse listpoly)) (valuepoly (mulnumlist val (reverse (cdr (reverse listpoly)))) val))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function lists the possible zeros that are possible for a particular polynomial using the rational roots test. It takes in the following arguments :
;	1. conslist  -  The list which has the factors of the constant term.
;	2. firstlist   -  The list which has the factors of the first term of the polynomial.
;	It returns a list which are all possible combinations of the first factor divided by the second factor, including the negative ones.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun posszeros(conslist firstlist)
(if (null (cdr conslist)) (append (divnumlist (car conslist) firstlist) (divnumlist (- 0 (car conslist)) firstlist))
(remove-duplicates (append (append (divnumlist (car conslist) firstlist) (divnumlist (- 0 (car conslist)) firstlist)) (posszeros (cdr conslist) firstlist)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to get the zeros from the possible list of zeros by checking the value of the polynomial. It takes in the following arguments : 
;	1. mainlist  -  The polynomial for which we have to find the zeros.
;	2. zerolist   -  The possible values for the zero of the polynomial.
;	It returns a list containing the values for which the value of the polynomial is zero.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun chkzeros(mainlist zerolist)
(if (null zerolist) nil
(if (equal (valuepoly mainlist (car zerolist)) 0) (cons (car zerolist) (chkzeros mainlist (cdr zerolist)))
(chkzeros mainlist (cdr zerolist)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to add two polynomials. It takes in the following arguments ;
;	1. list1, list2  -  The polynomials to be added in the form of lists, where the first element is the coefficient with the highest degree.
;	It returns a list which is a polynomial containing the sum of the two polynomials.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun addpoly (list1 list2)
(if (> (length list1) (length list2)) (map 'list #'+ list1 (addzero (- (length list1) (length list2)) list2))
(map 'list #'+ list2 (addzero (- (length list2) (length list1)) list1))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to subtract one polynomial from the other. It takes in the following arguments ;
;	1. list1, list2  -  The polynomials in the form of lists, where the first element is the coefficient with the highest degree.
;	It returns a list which is a polynomial containing the difference of the two polynomials.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun subpoly (list1 list2)
(if (> (length list1) (length list2)) (map 'list #'- list1 (addzero (- (length list1) (length list2)) list2))
(map 'list #'- (addzero (- (length list2) (length list1)) list1) list2)))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to add multiply polynomials. It takes in the following arguments ;
;	1. list1, list2  -  The polynomials to be multiplied in the form of lists, where the first element is the coefficient with the highest degree.
;	It returns a list which is a polynomial containing the product of the two polynomials.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun multpoly (list1 list2)
(if (null (cdr list2)) (mulnumlist (car list2) list1)
(addpoly (mulnumlist (car (reverse list2)) list1) (reverse (addzero 1 (reverse (multpoly list1 (reverse (cdr (reverse list2))))))))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to multiply many polynomials. It takes in any number of arguments which must be in the form of lists.
;	It returns a list which is a polynomial containing the product of the polynomials.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun multmanypoly (list1 &rest restlist)
(if (equal (length restlist) 0) list1
(if (equal (length restlist) 1) (multpoly list1 (car restlist))
(apply #'multmanypoly (multpoly list1 (car restlist)) (cdr restlist)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to integrate a polynomial. It takes in the following argument ;
;	1. list  -  The polynomial to be integrated in the form of list, where the first element is the coefficient with the highest degree.
;	It returns a list which is a polynomial which is the integral of the given polynomial.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun integral (list)
(if (null (cdr list)) (cons (car list) '(0))
(append (list (/ (car list) (length list))) (integral (cdr list)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to add divide polynomials, i.e get the quotient and remainder. It takes in the following arguments ;
;	1. list1, list2  -  The polynomials to be divided in the form of lists, where the first element is the coefficient with the highest degree.
;	It returns a list which contains two lists : The first list contains the polynomial which is the quotient, and the second one contains the
;	polynomial which is the remainder.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun divpoly (list1 list2)
(if (< (length list1) (length list2)) (list '(0) list1)
(list (addpoly (appzero (- (length list1) (length list2)) (list (/ (car list1) (car list2)))) (car (divpoly (subpoly (cdr list1) (appzero (- (length list1) (length list2)) (mulnumlist (/ (car list1) (car list2)) (cdr list2)))) list2))) (cadr (divpoly (subpoly (cdr list1) (appzero (- (length list1) (length list2)) (mulnumlist (/ (car list1) (car list2)) (cdr list2)))) list2)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used get the zeros of a particular polynomial. It takes in the following arguments ;
;	1. list  -  The polynomial, in the form of list, where the first element is the coefficient with the highest degree.
;	It returns a list which contains the zeros of the polynomial.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun zeros(listpoly)
(let ((testzeros (posszeros (factors (car (reverse listpoly))) (factors (car listpoly)))))
(chkzeros listpoly testzeros)))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is to make each of the zeros of the polynomial in the form of individual polynomials. It takes in arguments :
;	1. list1  -  The list of zeros.
;	It returns a list of lists which contain the factors of the polynomial.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun makefactors(list1)
(if (null (cdr list1)) (list (cons 1 (list (- 0 (car list1)))))
(append (list (cons 1 (list (- 0 (car list1))))) (makefactors (cdr list1)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This is the main function which is used to factorize the polynomial. This takes into account the repeating zeros as well. It calculates the 
;	zeros by testing all the combinations of zeros obtained by division of the factors of the constant term and the factors of the first term of the 
;	polynomial. After that it converts each of the zeros into polynomials, and then divided the original polynomial and the product of the zeros 
;	of the polynomial thus obtained, and the process is continued till the divided result becomes a constant term. This method is carried out to 
;	take into account the possibility of the occurence of repeated zeros . It takes in as argument : 
;	1. listpoly  -  The polynomial as a list which has to be factorized.
;	It returns a list of lists which contain the factors of the particular polynomial
;	###		WARNING	-	This function works only when the coefficients are integers, and then polynomial can be strictly factorized only into 
;	linear factors.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun factorize(listpoly)
(if (< (length listpoly) 2) (list listpoly)
(let ((fac (factorize (car (divpoly listpoly (apply #'multmanypoly (car (makefactors (zeros listpoly))) (cdr (makefactors (zeros listpoly)))))))))
(if (equal fac '((1))) (makefactors (zeros listpoly))
(append (makefactors (zeros listpoly)) fac)))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function is used to remove the particular list from the list of lists.  It returns the listoflist with only one instance of list1 being removed.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun removelist(list1 listoflist)
(if (null listoflist) nil
(if (equal list1 (car listoflist)) (cdr listoflist)
(cons list1 (removelist list1 (cdr listoflist))))))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;	This function returns true if the list1 is in the listoflist which are passed as arguments. It returns false otherwise.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun isinlist(list1 listoflist)
(if (null listoflist) nil
(if (equal list1 (car listoflist)) T
(isinlist list1 (cdr listoflist)))))

(defun common(list1 list2)
(if (null list1) nil
(if (isinlist (car list1) list2) (cons (car list1) (common (cdr list1) (removelist (car list1) list2)))
(common (cdr list1) list2))))

(defun commonfactors(list1 list2)
(let ((fact1 (factorize list1)) (fact2 (factorize list2)))
(common fact1 fact2)))