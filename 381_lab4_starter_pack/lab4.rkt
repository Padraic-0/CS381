#lang racket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     CS 381 - Programming Lab #4		;
;										;
;  < Padraic >					 	;
;  < berginp@oregonstate.edu>	                	;
;										;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; your code here
(define (member? e lst)
  (if (null? lst)
    #f ;return false if at end of lst
    (if (equal? e (car lst))
      #t ;return true is current head of lst is equal to e
      (member? e (cdr lst)))) ;recur with tail if current head is not e
)

(define (set? lst)
  (if (null? lst)
    #t
    (if (member? (car lst) (cdr lst))
      #f
      (set? (cdr lst))))
)

(define (union lst1 lst2)
(if (null? lst2)
  (if (null? lst1)
    '()
    (union lst2 lst1))
  (if (equal? #f (null? lst1)) ;if lst1 is not empty
    (union (cdr lst1) (cons (car lst1) lst2)) ;true: recurv with first element of lst1 tagged onto front of lst2
    (if (null? (cdr lst2))  ;false: if lst2 next element is nothing
      (cons (car lst2) '()) ; true: return lst with last val of lst2 (I think could just return lst2 instead of cons)
      (if (member? (car lst2) (cdr lst2)) ;false: if first val of lst2 is in the rest of lst2
        (union lst1 (cdr lst2)) ;true: skip this value for later
        (cons (car lst2) (union lst1 (cdr lst2))))))) ;false: current head of lst2 is not in the rest of lst2 so append to return of union
    
    
    

)

(define (intersect lst1 lst2)
(if (null? lst2)
  (if (null? lst1)
    '()
    (intersect lst2 lst1))
  ; complete this function definition
  (if (member? (car lst1) lst2) ;is current val1 in lst2
    (begin
      (if (null? (cdr lst1))  ;check if lst1 is at end to handle next
        (cons (car lst1) '()) ;when lst1 is end and current val is in lst2 return lst with current val in it
        (if (member? (car lst1) (cdr lst1)) ;if not at end check if this lst1 val is repeated in lst1 later
          (intersect (cdr lst1) lst2);if it is repeated skip it to add later
          (cons (car lst1) (intersect (cdr lst1) lst2))))); if its not repeated add it to the front of the recursion
    (if (null? (cdr lst1)) ;if not a member of lst2 but at the end of lst1
      '() ;return a empty lst meaning not a match
      (intersect (cdr lst1) lst2)))) ;if not a member but not at the end of the lst move to the next lst1 element
)

(define (difference lst1 lst2)
(if (null? lst2)
  (if (null? lst1)
    '()
    (difference lst2 lst1))
  ; complete this function definition
  (if (member? (car lst1) lst2) ;is current val1 in lst2
    (if (null? (cdr lst1)) ;if not a member of lst2 but at the end of lst1
      '() ;return a empty lst meaning not a match
      (difference (cdr lst1) lst2)) ;if not a member but not at the end of the lst move to the next lst1 element
    (begin
      (if (null? (cdr lst1))  ;check if lst1 is at end to handle next
        (cons (car lst1) '()) ;when lst1 is end and current val is in lst2 return lst with current val in it
        (if (member? (car lst1) (cdr lst1)) ;if not at end check if this lst1 val is repeated in lst1 later
          ;if it is repeated skip it to add later
          ; if its not repeated add it to the front of the recursion
          (difference (cdr lst1) lst2)
          (cons (car lst1) (difference (cdr lst1) lst2)))))))
)

(define (flatten lst1 lst2)
(if (null? lst2)
  (if (null? lst1)
    '()
    (flatten lst2 lst1))
  (if (null? lst1) ;check if lst1 is null, adding lst1 element to front of lst2
    (if (list? (car lst2)) ;if head of lst2 is a list
      (if (null? (cdr lst2)); then check if at the end of lst2
        (flatten lst1 (car lst2))
        (append (flatten lst1 (car lst2)) (flatten lst1 (cdr lst2))))
      (if (null? (cdr lst2))
        lst2
        (cons (car lst2) (flatten lst1 (cdr lst2)))))
    (flatten (cdr lst1) (cons (car lst1) lst2))));because lst1 wasnt null add car lst1 to front of lst2
)




;;;;;;;;;;;;;;;;;
;  DO NOT EDIT  ;
;;;;;;;;;;;;;;;;;
; enables testing via piping in stdin
(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))
(let loop ()
  (define line (read-line (current-input-port) 'any))
  (if (eof-object? line)
    (display "")
    (begin (print (eval (read (open-input-string line)) ns)) (newline) (loop))))