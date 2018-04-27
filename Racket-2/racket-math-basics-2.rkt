#lang racket


;; -------------------------------------------------------------------
(define eq equal?)

(define (hanoi tw1 tw2 tw3 q)
  (cond
    ((eq q 0) null)
  (else
    (append (hanoi tw1 tw3 tw2 (- q 1)) (list (list 'move tw1 tw2)) (hanoi tw3 tw2 tw1 (- q 1)))
  ))
)

(define (size list)
  (cond 
    ((eq list '()) 0)
  (else
    (+ 1 (size (cdr list)))
  ))
)

(define (reverse list)
  (cond
    ((eq list null) null)
  (else
    (append (reverse (cdr list)) (cons (car list) null))
  ))
)

(define (mbr2 e list)
  (cond
    ((eq list null) null)
    ((eq e (car list)) list)
  (else
    (mbr2 e (cdr list))
  ))
)

(define (inters list1 list2)
  (cond 
    ((eq list1 null) null)
    ((eq list2 null) null)
    ((member (car list1) list2) (cons (car list1) (inters (cdr list1) list2)))
  (else
    (inters (cdr list1) list2)
  ))
)

;; (rpl '(I AM BIG) '((I YOU) (AM ARE) (BIG SMALL)))
(define (rpl lst1 lst2)
  (cond
    ((eq null lst1) null)
  (else
    (cons (rpl1 (car lst1) lst2) (rpl (cdr lst1) lst2))
  ))
)

;; (rpl1 'I '((I YOU) (AM ARE) (BIG SMALL)))
(define (rpl1 x lst)
  (cond
    ((eq null lst) x)
    ((eq x (caar lst)) (cadar lst))
  (else
    (rpl1 x (cdr lst))
  ))
)

;; (position 2 '(1 3 2 4))
(define (position e list)
  (cond
    ((not(member e list)) null)
    ((eq e (car list)) 1)
  (else
    (+ 1 (position e (cdr list)))
  ))
)

;; (nth 5 '(a b c))
(define (nth i list)
  (cond
    ((eq i 0) null)
    ((eq list null) null)
    ((eq i 1) (car list))
  (else
    (nth (- i 1) (cdr list))
  ))
)

;; (makefun 'tell '(who is the best boy) '(my friend Peter is the best boy at all))
;; (tell '(who is your wrong colleague at all))

;; (tell '(who has my beloved book))
(define (makefun name in out)
  (eval
    (list 'define (list name 's) (makeflist in out))
  )
)

(define (makeflist in out)
  (cond
    ((eq null out) 'null)
    ((member (car out) in) (list 'cons (list 'nth (position (car out) in) 's) (makeflist in (cdr out))))
  (else
    (list 'cons (list 'quote (car out)) (makeflist in (cdr out)))
  ))
)

;; (read) (write 12) (printf "hello") (printf "Hello, ~a ~a" 'Damien 'Bayes) (printf "Binary = ~b Hexadecimal = ~x" 13 13)