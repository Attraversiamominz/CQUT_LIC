#lang racket
;1(a)
(define previnstr '*first-call*)
(define (prev instr)
    (define para previnstr)
    (set! previnstr instr)
    para)

(prev 'a)
(prev 3)
(prev (+ 1 5))
;1(b)
(define (make-prev next-result)
  (lambda (next-instr)
    (define para next-result)
    (set! next-result next-instr)
    para))
;(define prev
; (make-prev '*first-call*))
