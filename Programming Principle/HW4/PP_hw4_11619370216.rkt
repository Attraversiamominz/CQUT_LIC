#lang racket
;##########################HW4_11619370216 _游忠敏##########################
;==========================================================================
;[5 points] 1.
(define (diagonal sentences)
  (define (then sentences)
    (if (null? sentences)
        '()
        (cons (cdr (car sentences))
              (then (cdr sentences)))))
  (if (null? sentences)
      '()
      (cons (car (car sentences))
            (diagonal (then (cdr sentences))))
      ))
(diagonal '((she loves you)(tell me why)(I want to hold your hand)))
;==========================================================================
;[5 points] 2.
(define (every-nth num list-of-sents)
   (define (then list-of-sents)
    (if (null? list-of-sents)
        '()
        (cons (cdr (car list-of-sents))
              (then (cdr list-of-sents)))))
  (if (null? list-of-sents)
      '()
      (if (= num 0)
          (cons (car (car list-of-sents))(every-nth num (cdr list-of-sents)))
          (every-nth (- num 1) (then list-of-sents)))))
(every-nth 2 '((a b c d) (e f g h)))
;==========================================================================
;[5 points] 3.
(define (transform n fun x)
  (define (helper temp count)
    (if (= count n)
        '()
        (cons temp
         (helper (fun temp)
                 (+ count 1)))))
  (helper x 0))
(define (square x)
  (* x x))
(transform 3 square 2)
;==========================================================================
;[10 points] 4
;[A]
(define (count-occurrence elm aset)
  (if (null? aset)
      0
      (+ (count-occurrence elm (cdr aset))
       (if (= elm (car aset))
           1
           0))))
(count-occurrence 3 '(3 5 2 3 3 6 5 4 3))
;==========================================================================
;[B]
(define (filter-list elm aset)
  (define (filter-iter lst result)
    (cond
      ((null? lst) result)
      ((equal? (car lst) elm) (filter-iter (cdr lst) result))
      (else (filter-iter (cdr lst)(append result(list (car lst)))))))
  (filter-iter aset '() ))
(filter-list 3 '(3 5 2 3 3 6 5 4 3))
