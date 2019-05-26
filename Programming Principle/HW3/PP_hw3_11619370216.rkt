#lang racket
;##########################HW3_11619370216 _游忠敏##########################
;==========================================================================
;[4 points] Exercise 2.27 of the text book.
;2.18 reverse
(define (reverse lst)
  (if (null? lst)
      empty
      (append (reverse (cdr lst))
              (list (car lst)))))

(define x (list (list 1 2) (list 3 4)))

(define (deep-reverse x)
  (cond ((null? x) empty);if the tree is empty, append empty.
        ((pair? x);if x is not a leaf.
         (append (deep-reverse (cdr x))
                 (list (deep-reverse (car x)))))
        (else x)));if x is a leaf.

;==========================================================================
;[12 points] Exercise 2.29 of the text book.
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;a
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))
;test
(define mobile1
  (make-mobile (make-branch 1 2)
               (make-branch 5
                            (make-mobile (make-branch 5 2)
                                         (make-branch 2 6)))))
;mobile1

;b
;For a moblie, the total weight is sum of branchs weight.
;For a branch, if the structure part of the branch is a number,
;then that number is the weight of the branch; 
;if the structure part of the branch points to another mobile,
;then the total weight of the mobile is the weight of the branch.
(define (mobile? structure)
  (list? structure))

(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (mobile? structure)
        (total-weight structure)
        structure)))

(define (total-weight mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (+ (branch-weight left)
       (branch-weight right))))
;test
;(total-weight mobile1)
;

;c
(define (torque branch)
  (* (branch-length branch) (branch-weight branch)))
 
(define (balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (= (torque left) (torque right))
         (if (mobile? (branch-structure left)) (balanced? left) #t)
         (if (mobile? (branch-structure right)) (balanced? right) #t))))
;test
;(torque (left-branch mobile1))
;(torque (right-branch mobile1))
;(balanced? mobile1)

;d. only need to change the accessors of mobile and branch
;(define (left-branch mobile) (car mobile))
;(define (right-branch mobile) (cdr mobile))
;(define (branch-length branch) (car branch))
;(define (branch-structure branch) (cdr branch))
;==========================================================================
;[3 points] Exercise 2.34 of the text book.
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))));Codes from text book.

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) 
                (+ this-coeff
                   (* higher-terms x)))
              0
              coefficient-sequence))
;test
;(horner-eval 2 (list 1 3 0 5 0 1))
;==========================================================================
;[3 points] Exercise 2.36 of the text book.
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      empty
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))
(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
;test
;(accumulate-n + 0 s)
;==========================================================================
;[4 points ] Exercise 2.38 of the text book.
;Write your answer on the paper and submit it at the class.
(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest))))
    (iter initial sequence))

(define fold-right accumulate)

;(fold-right / 1 (list 1 2 3))
;(fold-left / 1 (list 1 2 3))
;(fold-right list '() (list 1 2 3))
;(fold-left list '() (list 1 2 3))
;==========================================================================
;[4 points ] Write a function subsequence
(define (subsequence fun alist)
  (if (null? alist)
      empty
      (cons (fun alist)
            (subsequence fun (cdr alist)))))
(define (sum alist)
  (if (null? alist)
      0
      (+ (car alist) (sum (cdr alist)))))
;test
;(subsequence sum '(7 9 3 5)) 
;==========================================================================