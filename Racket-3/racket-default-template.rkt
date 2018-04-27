#lang racket

(require racket/trace)

;; ------------------------------------------------------------------------------------
; https://docs.racket-lang.org/reference/pairs.html?q=cdr#%28def._%28%28quote._~23~25kernel%29._pair~3f%29%29
;; PAIR CONSTRUCTORS AND SELECTORS

;; Returns #t if v is a pair, #f otherwise.
;; (pair? 1) = #f
;; (pair? (cons 1 2)) = #t
;; (pair? (list 1 2)) = #t
;; (pair? '(1 2)) = #t
;; (pair? '()) = #f

;; Returns #t if v is the empty list, #f otherwise.
;; (null? 1) = #f
;; (null? '(1 2)) = #f
;; (null? '()) = #t
;; (null? (cdr (list 1))) = #t

;; Returns a newly allocated pair whose first element is a and second element is d.
;; (cons 1 2) = '(1 . 2)
;; (cons 1 '()) = '(1)

;; Returns the first element of the pair p.
;; (car '(1 2)) = 1
;; (car (cons 2 3)) = 2

;; Returns the second element of the pair p.
;; (cdr '(1 2)) = '(2)
;; (cdr '(1)) = '()

;; The empty list.
;; null = '()
;; '() = '()
;; (eq? '() null) = #t

;; Returns #t if v is a list: either the empty list, or a pair whose second element is a list. This procedure effectively takes constant time due to internal caching (so that any necessary traversals of pairs can in principle count as an extra cost of allocating the pairs).
;; (list? '(1 2)) = #t
;; (list? (cons 1 (cons 2 '()))) = #t
;; (list? (cons 1 2)) = #f

;; Returns a newly allocated list containing the vs as its elements.
;; (list 1 2 3 4) = '(1 2 3 4)
;; (list (list 1 2) (list 3 4)) = '((1 2) (3 4))


;; Like list, but the last argument is used as the tail of the result, instead of the final element. The result is a list only if the last argument is a list.
;; (list* 1 2) = '(1 . 2)
;; (list* 1 2 (list 3 4)) = '(1 2 3 4)

;; Creates a list of n elements by applying proc to the integers from 0 to (sub1 n) in order. If lst is the resulting list, then (list-ref lst i) is the value produced by (proc i).
;; (build-list 10 values) = '(0 1 2 3 4 5 6 7 8 9)
;; (build-list 5 (lambda (x) (* x x))) = '(0 1 4 9 16)
;; ------------------------------------------------------------------------------------

;; ------------------------------------------------------------------------------------
;; LIST OPERATIONS 

;; Returns the number of elements in lst.
;; (length (list 1 2 3 4)) = 4
;; (length '()) = 0

;; Returns the element of lst at position pos, where the list’s first element is position 0. If the list has pos or fewer elements, then the exn:fail:contract exception is raised. The lst argument need not actually be a list; lst must merely start with a chain of at least (add1 pos) pairs.
;; (list-ref (list 'a 'b 'c) 0) = 'a
;; (list-ref (list 'a 'b 'c) 1) = 'b
;; (list-ref (list 'a 'b 'c) 2) = 'c
;; (list-ref (cons 1 2) 0) = 1
;; (list-ref (cons 1 2) 1) = EXCEPTION IS RAISED

;; Returns the list after the first pos elements of lst. If the list has fewer than pos elements, then the exn:fail:contract exception is raised. The lst argument need not actually be a list; lst must merely start with a chain of at least pos pairs.
;; (list-tail (list 1 2 3 4 5 6 7 8 9) 2) = '(3 4 5 6 7 8 9)
;; (list-tail (cons 1 2) 1) = 2
;; (list-tail (cons 1 2) 2) = EXCEPTION IS RAISED
;; (list-tail 'not-a-pair 0) = 'not-a-pair

;; When given all list arguments, the result is a list that contains all of the elements of the given lists in order. The last argument is used directly in the tail of the result. The last argument need not be a list, in which case the result is an “improper list.”
;; (append (list 1 2) (list 3 4)) = '(1 2 3 4)
;; (append (list 1 2) (list 3 4) (list 5 6) (list 7 8)) '(1 2 3 4 5 6 7 8)

;; Returns a list that has the same elements as lst, but in reverse order.
;; (reverse (list 1 2 3 4)) = '(4 3 2 1)

;; ------------------------------------------------------------------------------------
;; LIST ITERATION

;; Applies proc to the elements of the lsts from the first elements to the last. The proc argument must accept the same number of arguments as the number of supplied lsts, and all lsts must have the same number of elements. The result is a list containing each result of proc in order.
;; (map (lambda (number)(+ 1 number))'(1 2 3 4)) = '(2 3 4 5)
;; (map (lambda (number1 number2)(+ number1 number2))'(1 2 3 4)'(10 100 1000 10000)) = '(11 102 1003 10004)

;; The andmap function is actually closer to foldl than map, since andmap doesn’t produce a list. Still, (andmap f (list x y z)) is equivalent to (and (f x) (f y) (f z)) in the same way that (map f (list x y z)) is equivalent to (list (f x) (f y) (f z)).
;; Similar to map in the sense that proc is applied to each element of lst, but 1- the result is #f if any application of proc produces #f, in which case proc is not applied to later elements of the lsts; and 2- the result is that of proc applied to the last elements of the lsts; more specifically, the application of proc to the last elements in the lsts is in tail position with respect to the andmap call. If the lsts are empty, then #t is returned.
;; (andmap positive? '(1 2 3)) = #t
;; (andmap positive? '(1 2 a)) = EXCEPTION IS RAISED
;; (andmap positive? '(1 -2 a)) = #f
;; (andmap + '(1 2 3) '(4 5 6)) = 9

;; To continue the andmap note above, (ormap f (list x y z)) is equivalent to (or (f x) (f y) (f z)).
;; Similar to map in the sense that proc is applied to each element of lst, but 1- the result is #f if every application of proc produces #f; and 2- the result is that of the first application of proc producing a value other than #f, in which case proc is not applied to later elements of the lsts; the application of proc to the last elements of the lsts is in tail position with respect to the ormap call. If the lsts are empty, then #f is returned.
;; (ormap eq? '(a b c) '(a b c)) = #t
;; (ormap positive? '(1 2 a)) = #t
;; (ormap + '(1 2 3) '(4 5 6)) = 5

;; Similar to map, but proc is called only for its effect, and its result (which can be any number of values) is ignored.
;; (for-each (lambda (arg) (printf "Got ~a\n" arg) 23) '(1 2 3 4)) = Got 1 Got 2 Got 3 Got 4

;; Like map, foldl applies a procedure to the elements of one or more lists. Whereas map combines the return values into a list, foldl combines the return values in an arbitrary way that is determined by proc. If foldl is called with n lists, then proc must take n+1 arguments. The extra argument is the combined return values so far. The proc is initially invoked with the first item of each list, and the final argument is init. In subsequent invocations of proc, the last argument is the return value from the previous invocation of proc. The input lsts are traversed from left to right, and the result of the whole foldl application is the result of the last application of proc. If the lsts are empty, the result is init. Unlike foldr, foldl processes the lsts in constant space (plus the space for each call to proc).
;; (foldl cons '() '(1 2 3 4)) = '(4 3 2 1)
;; (foldl + 0 '(1 2 3 4)) = 10
;; (foldl (lambda (a b result) (* result (- a b))) 1 '(1 2 3) '(4 5 6)) = -27

;; Like foldl, but the lists are traversed from right to left. Unlike foldl, foldr processes the lsts in space proportional to the length of lsts (plus the space for each call to proc).
;; (foldr cons '() '(1 2 3 4)) = '(1 2 3 4)
;; (foldr (lambda (v l) (cons (add1 v) l)) '() '(1 2 3 4)) = '(2 3 4 5)
;; ------------------------------------------------------------------------------------
;; LIST FILTERING

;; Returns a list with the elements of lst for which pred produces a true value. The pred procedure is applied to each element from first to last.
;; (filter positive? '(1 -2 3 4 -5)) = '(1 3 4)

;; Returns a list that is like lst, omitting the first element of lst that is equal to v using the comparison procedure proc (which must accept two arguments).
;; (remove 2 (list 1 2 3 2 4)) 
;; (remove 2 (list 1 2 3 2 4) =)
;; (remove '(2) (list '(1) '(2) '(3)))
;; (remove "2" (list "1" "2" "3"))
;; (remove #\c (list #\a #\b #\c))
;; ------------------------------------------------------------------------------------

;; ------------------------------------------------------------------------------------
;(+ 2 3)
;(cons 3 5)
;(+ 3 5)
;(+'3 5 1 2)
;(cons 3 (cons 5 (cons 7 (cons 8 null))))
;'(+ 3 4)
;(eval '(+ 3 4))
;(quote (+ 3 4))
;(cons 2 null)
;(cons 1 (cons 2 null))
;(car '(1 . 2))
;(cdr '(1 . 2))
;(car '(1 2 3 4))
;(cdr '(1 2 3 4))
;(car (cdr '(1 2 3 4)))
;(cadr '(1 2 3 4))
;(caddr '(1 2 3 4))
;((lambda (x y) (+ x y 1)) 3 4)

;(equal? 5 "Damien")
;(equal? 1 1)
;(< 2 1)
;(>= 2 1)
;(- 7 2)
;(+ 5 2)
;(sqrt 16)
;(sqrt -16)
;(string? "Research Centrum")
;(number? 5)
;(number? "Research Centrum")
;(string-length "Damien Bayes")
;(substring "Damien Bayes" 0 6)
;(string-append "rope" "twine" "yarn")
;#t
;#f
;"Hello, Damien Bayes!"
;"Benjamin \"Bugsy\" Siegel"
;"Bugs \u0022Figaro\u0022 Bunny"
;"λx:(μα.α→α).xx"
;1
;1/2
;1+2i
;3.14
;6.02e+23
;9999999999999999999999
;1.0000
;> 5
;"Hello, world!"
;(substring "the boy out of the country" 4 7)
;(substring "Simple Scheme" 0 6)
;(number? 5)
;(string? "Racket")
;(print "String")
;(sqrt 4)
;(string-length "Prague")
;(string-append "Apple" "&Pear")
;(equal? 6 6)
;(regexp-quote "cons")
;(if (> 2 3)
;    "bigger"
;    "smaller")
;(> 2 3)
;(let ([x (random 4)]
;      [y (random 4)])
;  (cond
;    [(> x y) "X wins"]
;    [(> y x) "Y wins"]
;    [else "cat's game"]))
;(let* ([x (random 4)]
;       [y (random 4)]
;       [diff (number->string (abs (- x y)))])
;  (cond
;    [(> x y) (string-append "X wins by " diff)]
;    [(> y x) (string-append "Y wins by " diff)]
;    [else "cat's game"]))
;(list "red" "green" "blue")
;(list 1 2 3 18 10)
;(length (list "hop" "skip" "jump"))
;(list-ref (list "hop" "skip" "jump") 0)
;(append (list "hop" "skip") (list "appended jump"))
;(reverse (list "hop" "skip" "jump"))
;(member "fall" (list "hop" "skip" "jump")) = #f
;(member "Groucho" '("Harpo" "Groucho" "Zeppo" "D"))

;(if 
;  (member "Groucho" '("Harpo" "Zeppo"))
;'yep
;'nope
;)

;(cond 
;  [(> 3 4) "Three is bigger than four"]
;  [(< 3 4) "Three is less than four"]
;  [else "Three is equal to four"]
;)

(define-struct account (name amount id))

(define-struct posn (x y [z #:auto])
   #:auto-value 0
   #:transparent)

; (make-posn 1 2)



;(for 
;  ([i '(1 2 3)])
;(display i))

;(for 
;  ([i "abc"])
;(printf "~a..." i))

;(for 
;  ([i (in-range 3)])
;  (display i)
;)

;(for 
;  ([i (in-range 1 4)])
;  (display i)
;)

;(for 
;  ([i 4])
;(display i))


;(map (lambda (i)
;       (string-append i "!"))
;     (list "peanuts" "popcorn" "cracker-jack"))
;(map sqrt (list 1 4 9 16))
;(andmap string? (list "a" "b" "c"))
;(ormap number? (list "a" "b" 6))
;(map (lambda (s n) (substring s 0 n))
;     (list "peanuts" "popcorn" "cracker-jack")
;     (list 6 3 7))
;(filter positive? (list 1 -2 6 7 0))
;(filter string? (list "a" "b" 6))
;(foldl (lambda (elem v)
;         (+ v (* elem elem)))
;       0
;       '(1 2 3))
;(first (list 1 2 3))
;(rest (list 1 2 3))
;empty
; (cons "head" empty) = '("head")
;(cons "dead" (cons "head" empty))
;(empty? empty)
;(empty? (cons "head" empty))
;(quote ((1) (2 3) (4)))
;(map sqrt (list 1 4 9 16))
;(= 2 (+ 1 1))
;(if "no" 1 0)
;#x03BB
;#e0.5
;(/ 1 2)
;(inexact->exact 0.1)
;(sin 0)
;(sin 1/2)
;(time (round (sigma (lambda (x) (/ 1 x)) 1 2000)))
;(abs -5)
;(sin -5+2i)
;(eqv? 1 1.0)
;"\u03BB"
;; ------------------------------------------------------------------------------------
