;#lang racket

;Homework No. 4 - Fall, 2018, CQUT
; Copy this code to the end of student's code
; And run ...
; Check whether you can see the right output that you expect

;==================================
; Problem 1: 
; 5 points
; =================================
; test Problem 1
(display "\nProblem 1 \n")
(diagonal '((I want) (You have a book) (He needs medicine to drink)))
;  returns '(I have medicine)
(diagonal '((He wants you) (You have a book) (You needs to drink)))
;  returns '(He have to)
(diagonal '((Mary wants you)))
; returns '(Mary)
(diagonal '())
; returns '()

;==================================
; Problem 2: 
; 5 points
; =================================
; test Problem 2
(display "\nProblem 2 \n")
(every-nth 2 '((a b c d) (e f g h)))
;   gives '(c g)
(every-nth 1 '((a b c) (d e f) (g h i)))
;   gives '(b e h)
(every-nth 0 '((a b c) (d e f) (g h i)))
;   gives '(a d g)
(every-nth 1 '((a b c)))
;   gives '(b)
(every-nth 0 '())
;   gives '()

;================================
;Problem 3: Exercise 1.12
;5 points
;============================
; test Problem 3
(display "\nProblem 3 \n")
(transform 3 (lambda (x) (* x x)) 2)
;    gives '(2 4 16)
(transform 5 (lambda (x) (+ x 2)) 3)
;   gives '(3 5 7 9 11)
(transform 6 (lambda (x) (* x 2)) 3)
;   gives '(3 6 12 24 48 96)

;=========================
;Prolbem 4 -A
;(5 points)
;==========================
;  test Problem 4-A
(display "\nProblem 4-A \n")
(count-occurrence 3 '(3 5 2 3 3 6 5 4 3))
;     returns 4
(count-occurrence 2 '(3 5 2 3 3 6 5 4 3))
;     returns 1
(count-occurrence 7 '(3 5 2 3 3 6 5 4 3))
;     returns 0
(count-occurrence 5 '(3 5 2 3 3 6 5 4 3))
;     returns 2

;=========================
;Prolbem 4 -B
;(5 points)
;==========================
;  test Problem 4-B
(display "\nProblem 4-B \n")
(filter-list 3 '(3 5 2 3 3 6 5 4 3 3))
;      returns '(5 2 6 5 4)
(filter-list 5 '(3 5 2 3 3 6 5 4 3 3))
;      returns '(3 2 3 3 6 4 3 3)
(filter-list 1 '(3 5 2 3 3 6 5 4 3 3))
;      returns '(3 5 2 3 3 6 5 4 3 3)
(filter-list 6 '(3 5 2 3 3 6 5 4 3 3))
;      returns '(3 5 2 3 3 5 4 3 3)

