;; Author: Damien Bayes; Email: damien_laboratories@live.com, damien.bayes.db@gmail.com. 2016 Inc.

#lang racket

(require racket/date
         ;net/url
         racket/runtime-path)

;; Regular Expressions

; Validate onlz words
(define (validate-words text) 
  (regexp-match* #rx"[a-zA-Z]+" text)
)

; Validate URL Address
(define (validate-url url)
  (regexp-match* #rx"(www.)[a-zA-Z0-9]+[.][_/-w]+" url)
)

(define (extract-body html)
  (regexp-match* #rx"<body(.|\n)*?</body>" html)
)



;;(define-runtime-path version-url "version.txt")

;;(define (read-data)
;;  (with-input-from-file version-url
;;    (lambda ()
;;      (read-bytes (file-size version-url)))))

;;(define (read-data)
;;  (with-input-from-file version-url
;;    (lambda ()
;;      (file->bytes-lines version-url))))


;; (length (file->bytes-lines "target/My Web Site/1.txt"))
;;(regexp-match #px" *([0-9]+)" (current-input-port))

;; (define (url->port url) (get-pure-port (string->url url)))

(printf "Racket: ~a" (date->string (current-date) "~1"))

(regexp-quote "cons")

;; (make-logger)

(define (print-greek-alphabet)
  (for ([i (in-range 25)])
  (display
   (integer->char
    (+ i (char->integer #\α))))))





;; Finds Racket sources in all subdirs
(for ([path (in-directory)]
      #:when (regexp-match? #rx"[.]rkt$" path))
  (printf "source file: ~a\n" path))


;; http://docs.racket-lang.org/reference/Filesystem.html#%28def._%28%28lib._racket%2Ffile..rkt%29._file-~3estring%29%29
;;(file-exists? "Data/input-template.txt")

;; (delete-file "Data/delete.txt")

;;(file->lines "Data/BBC News/1.txt")


;;(port->bytes(get-pure-port (string->url "http://www.bbc.com/news")))
