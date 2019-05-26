#lang racket

;=========================
;Prolbem 1.;  SICP Ex 1-8  
;(3 points)
;==========================
; cube-root 

; cube-iter : nummber number -> number
; Compute the cube-root of number x  in interative process(어떤 코멘트라도 OK)
; (cube-iter 1 27) -> 3
; (cube-iter 1 8 ) -> 2    (Any test case is OK. 
;                          No comment stmts mean deduction.)

(define cube-iter
  (lambda (guess x)
         (if (good-enough? guess x)
             guess
             (cube-iter (improve guess x) x))))

(define improve
   (lambda (guess x)
     (/ (+ (/ x (* guess guess)) (* 2.0 guess)) 3.0)))

(define good-enough? 
   (lambda (guess x)
     (< (abs (- (* guess guess guess) x)) 0.001)))


;================================
;Problem 2. SICP Ex 1-10
;(3 point totals)
;==================================
;[1 point]
;(A 1 10) => (A 0 (A 1 9)) => (A 0 (A 0 (A 1 8))) =>  (A 0 (A 0 (A 0 (A 1 7))))
; ... ==>  (A 0 (A 0 (A 0 .....(A 1 1))))) => (A 0 (A 0 (A 0 ...(A 0 2)))))
;.... =>  (A 0 (2*2* ..*2))  => 2^10
;= 1024

;(A 2 4) => (A 1 (A 2 3)) => (A 1 (A 1 (A 2 2))) => (A 1 (A 1 (A 1 (A 2 1))))
; => (A 1 (A 1( A 1 2))) => (A 1 (A 1 (2*2))) => (A 1 2^4)) = (A 1 16)
; = 65536

;(A 3 3) => (A 2 (A 3 2)) => (A 2 (A 2 (A 3 1))) => (A 2 (A 2 2)) => (A 2 (A 1 (A 2 1)))
;=> (A 2 (A 1 2)) => (A 2 (A 0 (A 1 1))) => (A 2 (A 0 2)) => (A 2 4) => ...
; => 65536


;[2 point]
;   f(n) = 2*n where n >= 1

;   g(n) = 2^n where n >= 1

;   h(n) = 2^h(n-1)  where n >= 1



;=======================================
;Problem 3: Exercise 1.12
; 3 points
;============================
; Pascal's trangle
; pascal-triangle; number number -> number
; compute the component of Pascal's triagle

(define (pascal-triangle i j)
  (cond ((= i j) 1)
          ((= j 0) 1)
          (else  (+  (pascal-triangle (- i 1) (- j 1))
                    (pascal-triangle (- i 1)  j)))))



;===============================================================
;Problem 4. Ex 1-16
;Ex 1.16
; 3 points
;=================================================================

(define (fast-expt-iter b n)
  (define (help b n a)
    (cond ((= n 0) a)
          ((even? n)
           (help (* b b) (/ n 2) a))
          (else 
           (help b (- n 1) (* a b)))))
  (help b n 1))


;==================================
; Problem 5: Exercise 1.17
; Exercise 1.17
; 3 points
; =================================

; fast-mult: Num Num -> Num
; mutiply a,b with complexity O(log N)
; test: (fast-mult 0 4) -> 0
; test: (fast-mult 3 0) -> 0
; test: (fast-mult 3 4) -> 12
;
(define (double x) (* 2 x))
(define (halve x) (/ x 2))
(define (fast-mult  a b)
	(cond ((= b 0) 0)
       		((even? b) (double (fast-mult a (halve b))))
       		(else (+ a (fast-mult a (- b 1))))))

