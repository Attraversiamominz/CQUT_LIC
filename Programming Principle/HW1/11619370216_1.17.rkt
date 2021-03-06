#lang racket
(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-mult a (halve b))))
        (else
         (+ a (fast-mult a (- b 1)))))) ;like the example 'fast-expt' of 1.2.4 at SICP.
(define (double x)
  (+ x x))
(define (halve x)
  (/ x 2))