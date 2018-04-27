;; Damien Bayes - The Racket Guide (Specimens)
;; Email: damien_laboratories@live.com

;; For more information: https://docs.racket-lang.org/guide/syntax-overview.html?q=performance

;; ------------------------------------------------------------------------------------
;; RACKET - DIRECTIVES
#lang racket
;; ------------------------------------------------------------------------------------



;; ------------------------------------------------------------------------------------
;; RACKET - PUBLIC
(provide _copyright)
(provide _a)
(provide _b)
;; ------------------------------------------------------------------------------------





;; ------------------------------------------------------------------------------------
;; RACKET - VARIABLES
(define _copyright "© 2016 Damien Bayes. All rights reserved. All trademarks are property of their respective owners.")

; 2.2.7 Anonymous Functions with lambda
(define _a (random 100))
(define _b (random 100))

;; Templates
;(define (functionName1 argument1)
;  (substring argument1 0 6))

;(define (print arg)
;  string-append arg "Hello, sb/sth")

;; Example: Multiple expressions for the function's body
;(define (fruits arg1)
;  (printf "The function <fruits> was called successfully! \n")
;  (string-append arg1 " pear"))
;; ------------------------------------------------------------------------------------





;; ------------------------------------------------------------------------------------
;; RACKET - FUNCTIONS
; 2.2.6 Function Calls, Again
(define (Double arg)
  ((if (string? arg) string-append +) arg arg))
; 2.2.7 Anonymous Functions with lambda
; (twice sqrt 16)
(define (Twice function arg)
  (function (function arg)))

; (twice louder "hello")
(define (Louder arg)
  (string-append arg "!"))

;(define (MakeAddSuffix 
;; ------------------------------------------------------------------------------------




;; ------------------------------------------------------------------------------------
;; RACKET - MAIN
(Twice (lambda (arg) (string-append arg "!"))
       "hello")

(Twice (lambda (arg) (string-append arg "?!"))
       "hello")
;; ------------------------------------------------------------------------------------