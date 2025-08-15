#lang racket
(define (f ls)
  (if (null? (cdr ls))
    (car ls)
    (if (< (car ls) (f (cdr ls)))
        (f (cdr ls))
        (car ls))))
(f '(3 9 8 4))
