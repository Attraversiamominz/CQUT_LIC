#lang racket
(define (pascal-triangle i j)
  (if (or (= i j) (= j 0))
      1
      (+ (pascal-triangle (- i 1) (- j 1)) (pascal-triangle (- i 1) j))))
;the value of triangle is the sum of the two number above it, for example (pascal-triangle 4 3) is the sum of (pascal-triangle 3 2) and (pascal-triangle 3 3)