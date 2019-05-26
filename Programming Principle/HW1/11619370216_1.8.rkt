#lang racket
(define (square x)
  (* x x)) ; define the meaning of square.

(define (cube x)
  (* x x x)) ; define the meaning of cube.

(define (cube-root x)
  (cube-iter 1 x))

(define (cube-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001)); just like 1.1.7 of text book, but there is cube.

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

