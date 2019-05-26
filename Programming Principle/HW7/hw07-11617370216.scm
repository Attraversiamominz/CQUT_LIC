#lang racket
;;================================
; cs220 Fall 2018, hw07-code.scm
;;================================
;
(define nil '())

(define (write-line term)
  (begin (display term)
         (newline)))

;;; some basic stream operations

(define (stream-map proc stream)
  (if (stream-empty? stream)
      empty-stream
      (stream-cons (proc (stream-first stream))
                   (stream-map proc (stream-rest stream)))))

(define (add-streams s1 s2)
  (cond ((stream-empty? s1) s2)
        ((stream-empty? s2) s1)
        (else
         (stream-cons (+ (stream-first s1) (stream-first s2))
                      (add-streams (stream-rest s1)
                                   (stream-rest s2))))))

(define (scale-stream c stream)
  (stream-map (lambda (x) (* x c)) stream))

;;; power series operations

(define add-series add-streams)

(define scale-series scale-stream)

(define (negate-series s)
  (scale-series -1 s))

(define (subtract-series s1 s2)
  (add-series s1 (negate-series s2)))

;;; display the first n coefficients of a series

(define (show-series s nterms)
  (if (= nterms 0)
      'done
      (begin (write-line (stream-first s))
             (show-series (stream-rest s) (- nterms 1)))))

;;; return the coefficient of x^n

(define (series-coeff s n)  (stream-ref s n))

;;; create a (finite) series from a list of coefficients

(define (coeffs->series list-of-coeffs)
  (define zeros (stream-cons 0 zeros))
  (define (iter lst)
    (if (null? lst)
        zeros
        (stream-cons (car lst)
                     (iter (cdr lst)))))
  (iter list-of-coeffs))

;;; create a series from a procedure: nth term is P(n)
;;; requires non-neg-integers to be 0,1,2,3....
(define ones (stream-cons 1 ones))

;
; Problem 1 - must be copied to as a comment
; define non-neg-integers here
; needed for Problem 1 solution
(define non-neg-integers (stream-cons 0 (add-streams non-neg-integers ones))) 

(define (proc->series proc)
  (stream-map proc non-neg-integers))

; Exercise 1 : the definitions are copied from the class note.
(define (stream-enumerate-interval low high)
  (if (> low high)
      empty-stream
      (stream-cons
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (stream-ref s n)
  (if (= n 0)
      (stream-first s)
      (stream-ref (stream-rest s) (- n 1))))

(define (display-line x)
  (newline)
  (display x))

(define (show x)
  (display-line x)
  x)

(define x (stream-map show (stream-enumerate-interval 0 10)))

(stream-ref x 7)

;77
; You need to explain why the output looks as you can see.
; Explain
; Stream has the effect of delayed evaluation, only part of the stream is evaluated.
; In this problem, the value is 7, so the flow will only be calculated from 0 to 7.
; Its return is 77, the first 7 is the return of "display-line" in "show", and the second 7 is the return of stream because value is 7.

;==============================================
; Exercise 2
(define integers (stream-cons 1 (add-streams integers ones)))
(define A (stream-cons 1 (scale-stream 2 A)))

(define (mul-streams a b)
  (stream-cons (* (stream-first a) (stream-first b))
               (mul-streams (stream-rest a)
                            (stream-rest b))))

(define B (stream-cons 1 (mul-streams B integers)))

; What is A?
; A is a series of (1 2 4 8 16 ... 2^n)

; What is B?
; B is a series of (1 1 2 6 24 ... n!)
;==============================================
;Exercise 3
(define (stream-pairs s)
  (if (stream-empty? s)
      empty-stream
      (stream-append
       (stream-map
        (lambda (sn) (list (stream-first s) sn))
        (stream-rest s))
       (stream-pairs (stream-rest s)))))

(define s '{1,2,3,4,5})

; Answers must come here!!
;(a)
;(stream-pairs {1, 2, 3, 4, 5}) is list ((1 ,2)(1 ,3)(1 ,4)(1 ,5)(,2 ,3)(,2 ,4)(,2 ,5)(,3 ,4)(,3 ,5)(,4 ,5))
;(b)
; This is a recursive process. If S is not empty, the first element of S is listed one-to-one with the remaining elements.
;(c)
; The first few elements of (stream-pairs s) are the first element of S listed with the second element of s, the first element of S listed with the third element of S.
(define i integers)
;test
;(show-series (stream-pairs i) 10)
; The returm is Interactions disabled
;modification :



;==============================================
;Problem 1
;The following line is copied from above!!!
;(define non-neg-integers "you need to write program text")

; test your definition.
;(show-series non-neg-integers 10)

;(define S1 "Your Progrm")
(define S1 (proc->series (lambda(x) 1)))
;(show-series S1 10)


(define (inc x) (+ x 1))
;(define S2 "Your Progrm")
(define S2 (proc->series (lambda(x) (inc x))))
;(show-series S2 10)

;==============================================
;Problem 2
(define (mul-series S1 S2)
  (stream-cons (* (stream-first S1)
                  (stream-first S2))
               (add-series (scale-series (stream-first S1) (stream-rest S2))
                           (mul-series (stream-rest S1) S2))))

;Here we check if s1*s1=s2: 
(define S3 (mul-series S1 S1))

;Value: "s3 --> (1 . #[promise 27])"
;(show-series (subtract-series S3 S2) 6)
;0
;0
;0
;0
;0
;0

;What is the coefficient of x^10 in s2*s2? 
;(series-coeff (mul-series S2 S2) 10)
;Value:  286

;==============================================
;Problem 3
(define (invert-unit-series s)
  (stream-cons 1 (negate-series (mul-series (stream-rest s) 
                                            (invert-unit-series s)))))
;Because stream is used, it will be delayed and will not loop indefinitely.

;==============================================
;Problem 4
(define (div-series s1 s2)
  (let ((const (stream-first s2)))
    (if (zero? const)
        'error
        (mul-series (scale-series (/ 1 const) s1)
                    (invert-unit-series (scale-series (/ 1 const)  s2))))))

;==============================================
;Problem 5
(define (integrate-series-tail s)
  (define (index-map str ind)
    (if (stream-empty? str)
        empty-stream
        (stream-cons (/ (stream-first str) ind) (index-map (stream-rest str) (inc ind)))))
  (index-map s 1))

;test
;(show-series (integrate-series-tail S2) 10)
;==============================================
;Problem 6
; Because e^x=1+f'(0)x/1!+f"(0)x^2/2!+...+f^n(0)x^n/n!
(define cos-series
  (stream-cons 1 (negate-series (integrate-series-tail sin-series))))

(define sin-series
  (stream-cons 0 (integrate-series-tail cos-series)))