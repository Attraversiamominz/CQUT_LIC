#lang racket
;##########################HW5_11619370216 _游忠敏##########################
;==========================================================================
;1.
;A.
((lambda (a + b) (+ b a)) 2 - 4)
;2

;B.
((lambda (a)
   (lambda (b)
     (+ (sqrt a) (sqrt b))))
 5)
;procedure

;C.
(define arg 7)
(define local-arg 5)
(define (proc arg)
  (let ((local-arg 3))
    (+ arg local-arg)))
(proc 1)
;4

;D.
(let ((a 3) (b 4))
  (lambda () (+ a b)))
;procedure

;E.
((lambda (+) (+ 3)) (lambda (*) (+ * 2) ))
;5

;F.
;(let ((x 5)(y x))  (* x x y ))
;error, x: unbound identifier in: x

;G.
;(let ((x 100)
;      (f (lambda (y) (+ x y))))
; (f 25))
;error, x: unbound identifier in: x

;H.
(define square (lambda (x) (* x x)))
(define f
  (lambda (g)
    (lambda (f)
      (f g))))
((f 5) square)
;25

;I.
(define (square1 x) (* x x))
(define (cube x) (* x x x))
(define bop-funs
  (lambda (bop)
    (lambda (f g) (lambda (x) (bop (f x) (g x))))))
(((bop-funs +) square1 cube) 2)
;12

;J.
(define x 6)
(define (f1 y)
  (define x 2)
  (define z (* x 4))
  (+ x y z))
(f1 (+ x 1))
;17

;==========================================================================
;2, 3 in the paper

;==========================================================================
;4.
(define (fast-expt b n)
  (define (fast-iter b counter a)
    (if (= counter 0)
        a
        (if (even? counter)
            (fast-iter (square b) (/ counter 2) a)
            (fast-iter b (- counter 1) (* a b)))))
  (fast-iter b n 1))

;==========================================================================
;5.
(define (min-of-f-x-and-g-x f g x)
  (min (f x) (g x)))
;(min-of-f-x-and-g-x square cube -1)
;(min-of-f-x-and-g-x square cube 2)

(define (combine-f-x-and-g-x combiner f g x)
  (combiner (f x) (g x)))
;(combine-f-x-and-g-x min square cube -1)

;==========================================================================
;6.
(define (triad left label right)
  (lambda (m)
    (cond ((eq? m 1) left)
          ((eq? m 2) label)
          ((eq? m 3) right)))
  )

(define (label note)
  (note 2))

(define tridA (triad 3 7 4))
(label tridA)
 

;==========================================================================
;7, 8. in the paper