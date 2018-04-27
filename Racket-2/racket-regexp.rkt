;; Damien Bayes - The Racket Guide (Specimens)
;; Email: damien_laboratories@live.com

;; The code was written by Damien Bayes. © 2016 Damien Bayes. All rights reserved. All trademarks are property of their respective owners.
;; For more information: https://docs.racket-lang.org/guide

;; Namespace
#lang racket

(provide GetLettersFromWord GetWordsFromSentence GetLettersFromSentence)

;; Regular Expressions

;; (regexp-quote "cons")

;; (regexp-quote "list?")

;; (regexp-match-positions #rx"bird" "bird")

;; (regexp-split #rx"" "smithereens")
(define (GetLettersFromWord word)
  (regexp-split #rx"" word)
)

;; (regexp-split #rx" +" "split pea     soup")
(define (GetWordsFromSentence sentence)
  (regexp-split #rx" +" sentence)
)

;; (regexp-split #rx" *" "split pea     soup")
(define (GetLettersFromSentence sentence)
  (regexp-split #rx" *" sentence)
)

;; (regexp-replace #rx"te" "liberte" "ty")
(define (FindWordAndReplace str oldWord newWord)
  (regexp-replace (string-append "#rx" oldWord) str newWord)
)

