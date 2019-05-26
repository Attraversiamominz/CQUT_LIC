#lang racket
;
; Homework No.5 - 2018 Fall CS220
; A.K.A. midterm exam 2018 Fall - CLKIP
;

; problem 1
; a: ==> 2
((lambda (a + b) (+ b a)) 2 - 4)
; returns 2

; b -> procedure
((lambda (a)
   (lambda (b)
     (+ (sqrt a) (sqrt b))))
 5)

; c -> 4
(define arg 7)
(define local-arg 5)
(define (proc arg)
    (let ((local-arg 3))
        (+ arg local-arg)))
(proc 1)

; d -> procedure
(let ((a 3) (b 4))
      (lambda () (+ a b)))

; e -> 5
((lambda (+) (+ 3)) (lambda (*) (+ * 2) ))

; f -> error - unbound x
;(let ((x 5)(y x))  (* x x y ))

; g -> error - x is undefined
#;(let ((x 100)
       (f (lambda (y) (+ x y))))
  (f 25))

; h -> 25
(define square (lambda (x) (* x x)))
(define f
 	     (lambda (g) 
              (lambda (f)
                  (f g))))
((f 5) square)

; I -> 12
;(define (square x) (* x x))
; If square is not defined, the answer is "error"
;
(define (cube x) (* x x x))
(define bop-funs
  (lambda (bop)
    (lambda (f g) (lambda (x) (bop (f x) (g x))))))
(((bop-funs +) square cube) 2)

; j -> 17
(define x 6)
(define (ff y)
  (define x 2)
  (define z (* x 4))
  (+ x y z))
(ff (+ x 1))

; Problem 2 =============================================
;(a) answer => log n
;  Whenever member? is called recursively,
;  argument is divied by 10.
;  So, it will terminate after log base 10 n

;(b) answer -> Iterative Process
;   It will generate iterative process
;  since there's nothing to do after recursive call.
;

; problem 3 ==============================================
;
;(a) It will generate re cursive process, 
;    since after return from recursive call "(even? (- n 2))"
;    the procedure should return either #t or #f anyway.
;

; (b) So we need to remove a sentence that returs "#t" or "#f".
;     Since (even? (- n 2)) will have the same value.
;     So the following will give the same result.
;
(define (even? n)
  (cond ((= n 0) #t)
        ((= n 1) #f)
        (else (even? (- n 2)))))

;; problem 4 =============================================
; This was the homework.
;
(define (fast-expt-iter b n)
  (define (help b n a)
    (cond ((= n 0) a)
          ((even? n)
           (help (* b b) (/ n 2) a))
          (else 
           (help b (- n 1) (* a b)))))
  (help b n 1))

;; problem 5 =============================================
(display "\nProblem 5\n")
; (a)
; Easy - solution
(define (min-of-f-x-and-g-x f g x)
  (min (f x) (g x)))

; test case
(min-of-f-x-and-g-x square cube -1)
; -1
(min-of-f-x-and-g-x square cube 2)
; 4

; (b) We need to replace "min" with "combiner".
(define (combine-f-x-and-g-x combiner f g x)
  (combiner (f x) (g x)))

; test case
(combine-f-x-and-g-x min square cube -1)
; -1

;
; Problem 6 ============================================
(display "\nProblem 6\n")
; It is asking message passing style.
; Given the constructor as follows,
(define (triad left label right)
  (lambda (m)
    (cond ((eq? m 1) left)
          ((eq? m 2) label)
          ((eq? m 3) right))))

; (a)
(define (label node) (node 2))
(define (left node) (node 1))
(define (right node) (node 3))

; test case
(define tridA (triad 3 7 4))
(label tridA)
; 7
(left tridA)
;3

; Problem 7 ==========================================
(display "\nProblem 7\n")
; Give the following program
(define (garply x)
  (+ (* x x) 1))
;
(garply ( (lambda (y) (* y 2)) (* 2 2)))
;
; (a-1) in normal order
; (garply ( (lambda (y) (* y 2)) (* 2 2))) ==>
; (+ (* ( (lambda (y) (* y 2)) (* 2 2))
;       ( (lambda (y) (* y 2)) (* 2 2))) 1) ==>
; (+ (* (* (* 2 2) 2)
;       (* (* 2 2) 2)) 1) ==>
;  65
;  Normal Order: 5 times of multiplication.
;
; (a-2) in applicative order
; (garply ( (lambda (y) (* y 2)) (* 2 2))) ==> 
; (garply ( (lambda (y) (* y 2)) 4))  => 
; (garply  (* 4 2))  =>
; (garply  8) =>
; (+ (* 8 8 ) 1) ==>
; (+ 64 1) ==> 65
;  Applicative Order: 3 times of multiplication.

; Answer  (a) normal order = 5 times, applicative order - 3 times
;     (b) in both case, returns 65


; Problem 8 ==========================================
;
; First the definition is
; (define zero (lambda (f) (lambda (x) x)))
; (define (add-1 n) (lambda (f) (lambda (x) (f ((n f) x)))))
; 
; Let's show that (add-1 zero) becomes one where
; one is "(lambda (f) (lambda (x) (f x)))"

; (add-1 zero) == (lambda (f) (lambda (x) (f ((zero f) x))))
; We need to compute the expression ((zero f) x)
; Why? Because zero is (lambda ....), "(zero f)" is the inner-most
; function application (compound expression)
;
; ( ( zero                        f ) x) ==
; ( ( (lambda (f) (lambda (x) x)) f ) x)  -->
; (               (lamdba (x) x)      x)  -->
;                             x

; So finally replace ((zero f) x) with x gives
; (add-1 zero) ==
;     (lambda (f) (lambda (x) (f ((zero f) x)  ))) ==
;     (lambda (f) (lambda (x) (f  x            ))) ==
; one

; q.e.d.






  