;; https://docs.racket-lang.org/reference/pairs.html?q=cdr#%28def._%28%28quote._~23~25kernel%29._cdr%29%29

;; Damien Bayes - The Racket Guide (Specimens)
;; Email: damien_laboratories@live.com

;; The code was written by Damien Bayes. © 2016 Damien Bayes. All rights reserved. All trademarks are property of their respective owners.
;; For more information: https://docs.racket-lang.org/guide

;; ------------------------------------------------------------------------------------
;; RACKET - DIRECTIVES
;; A program module is written as #lang <langname> <topform>*
;; <topform> - is either a <definition> or an <expr>
#lang racket/base

;; Modules
(require racket/contract)
;; The racket/draw library provides a drawing API that is based on the PostScript drawing model. It supports line drawing, shape filling, bitmap copying, alpha blending, and affine transformations (i.e., scale, rotation, and translation).
(require racket/draw)
;(require 2htdp/image)

;(require "racket-module-basics.rkt")
(require "racket-math-basics.rkt")
;; ------------------------------------------------------------------------------------



;; ------------------------------------------------------------------------------------
;; RACKET - VARIABLES
;(define _copyright "© 2016 Damien Bayes. All rights reserved. All trademarks are property of their respective owners.")

;; defines pi to be 3.14159 because it's a mathematical constant
(define _pi 3.14159)

(define _a (random 100))
(define _b (random 100))

(define _listOfNumbers (list 20 -40 600 8000))
;; ------------------------------------------------------------------------------------






;; ------------------------------------------------------------------------------------
;; RACKET - FUNCTIONS
;; Templates
;(define (functionName1 argument1)
;  (substring argument1 0 6))

;(define (print arg)
;  string-append arg "Hello, world!")

;; Example: Multiple expressions for the function's body
;(define (fruits arg1)
;  (printf "The function <fruits> was called successfully! \n")
;  (string-append arg1 " pear"))

;; (absolute (list 2 4 -8 12 -14))
(define (absolute listOfNumbers)
  (if(andmap number? listOfNumbers)
     (map (lambda (i)
            (abs i))
          listOfNumbers)
     0))

;; (uppercase string-upcase (list "ready" "set" "go"))
;(define (uppercase function listOfStrings)
;  (cond
;    [(empty? listOfStrings) empty]
;    [else (cons (function (first listOfStrings))
;                (uppercase function (rest listOfStrings)))]))

(define (sigma f a b)
  (if (= a b)
      0
      (+ (f a) (sigma f (+ a 1) b))))
;; ------------------------------------------------------------------------------------






;; ------------------------------------------------------------------------------------
;; RACKET -MAIN
;_copyright



; VARIABLES
; ===============================================
(define a 10)
(define b 20)
; ===============================================

(define f (lambda (x y) (+ x y 1)))
(f a b)
(define g (λ (x y) (+ x y 1)))
(g a b)
(define (h x y) (+ x y 1))
(h a b)

(equal? 1 1)

(define (eq a b) (equal? a b))
(eq 1 1)

(eq 1 2)

(define (first l) (car l))
(first '(1 2 3 4))

(define (second l) (cadr l))
(second '(1 2 3))

(define (mbr e l) (
                   cond
                    ((eq l null) #f)
                    ((eq e (car l)) #t)
                    (else (mbr e (cdr l))))
)

(mbr 1 '(1 2 3 4))
(mbr 2 '(1 2 3 4))

(mbr 8 '(1 2 3 4))

(mbr 8 (quote (1 2 3 4)))

(mbr 8 (list 1 2 3 18 10))

(let ([x (random 4)]
      [y (random 4)])
  (cond
    [(> x y) "X wins"]
    [(> y x) "Y wins"]
    [else "cat's game"]
    ))

(define (DisplayPosition currentPosition listOfNumbers)
  (list-ref listOfNumbers currentPosition))

(DisplayPosition 4 (list 1 2 3 18 10))


                                        
;(list-ref (list "hop" "skip" "jump") 0)



;;(string-append "+ " "- " "* " "/")
;;(+ _a _b)
;;(- _a _b)
;;(* _a _b)
;;(/ _a _b)

;;(absolute _listOfNumbers)
;; ------------------------------------------------------------------------------------















;; ------------------------------------------------------------------------------------
;; THE RACKET GUIDE - WELCOME TO RACKET - 1

;; RACKET is: 
;; 1) a programming language - a dialect of Lisp and a descendant of Scheme
;; 2) a family of programming languages
;; 3) a set of tools

;; RACKET's main tools are:
;; 1) the core compiler, interpreter, and run-time system
;; 2) the programming environment
;; 3) command-line tool for executing racket commands that install packages, build libraries and etc.

;; INTERACTING WITH RACKET


;; DEFINITIONS AND INTERACTIONS
;(define (extract str)
;  (substring str 4 7))

;(extract "the boy out of the country")
;(extract "the country out of the boy")
;; ------------------------------------------------------------------------------------







;; ------------------------------------------------------------------------------------
;; Racket values include - Numbers, Booleans, Strings and Byte Strings
;; Numbers are written in the usual way, including fractions and imaginary numbers


;; Strings are written between doublequotes


;; Booleans are #t for true and #f for false. In conditionals, however, all non-#f values are treated as true

;; ------------------------------------------------------------------------------------







;; ------------------------------------------------------------------------------------
;; Racket - Function Calls (Procedure Applications) !The syntax of a function call is: ( <id> <expr>*)

;; appends strings


;; extracts a substring


;; gets a string's length


;; recognizes strings & numbers and etc.


;; finds a square root


;; adds numbers


;; substracts numbers


;; compares numbers


;; compares anything

;; ------------------------------------------------------------------------------------








;; ------------------------------------------------------------------------------------
;; Racket - Identifiers ! ( ) [ ] { } " , ' ` ; # | \
;; ------------------------------------------------------------------------------------










;(define (reply s)
  ;(if (if ((string? s)
   ;        ((equal? "hello" (substring s 0 5))
    ;        #f)
     ;      "hi!"
      ;     "huh?")
      ;"huh?"))

;(reply "hello racket")