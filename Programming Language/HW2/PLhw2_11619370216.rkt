#lang plai
;======================PLhw2游忠敏11619370216======================
(define-type WAE
  [num (n number?)]
  [add (lhs WAE?)
       (rhs WAE?)]
  [sub (lhs WAE?)
       (rhs WAE?)]
  [with (name symbol?)
        (named-expr WAE?)
        (body WAE?)]
  [id (name symbol?)])

;;;;;;;;;;;No.1;;;;;;;;;;;
;; free-ids: WAE ->list-of-sym
;; to contain a symbol for each free identifier
;; unordered-free:WAE -> list-of-sym
(define (unordered-free wae)
  (type-case WAE wae
    [num (n) '()]
    [add (lhs rhs) (append (unordered-free lhs) (unordered-free rhs))]
    [sub (lhs rhs) (append (unordered-free lhs) (unordered-free rhs))]
    [with (nm ne bo) (append (unordered-free ne) (remove* (list nm) (unordered-free bo)))]
    [id (nm) (list nm)]))

;;(remove-duplicates ->lst
;;                     [same?
;;                      #:key extract-key]) → list?
(define (free-ids wae)
  (remove-duplicates (sort (unordered-free wae) symbol<?)))

(test (free-ids (with 'x (num 3) (add (id 'x) (sub (num 3) (id 'x))))) '())
(test (free-ids (with 'x (num 3) (sub (id 'a) (add (num 4) (id 'x))))) '(a))
(test (free-ids (with 'x (num 3) (sub (id 'b) (sub (id 'a) (id 'x)))))
      '(a b))
(test (free-ids (with 'x (num 3) (sub (id 'a) (sub (id 'b) (add (id 'x) (id 'b))))))
      '(a b))
(test (free-ids (with 'x (num 3) (sub (id 'y) (with 'y (num 7) (add (id 'x) (sub (id 'b) (id 'a)))))))
      '(a b y))
(test (free-ids (with 'x (id 't) (sub (id 'x) (with 'y (id 'y) (add (id 'x) (sub (id 'b) (id 'a)))))))
      '(a b t y))
(test (free-ids (with 'x (with 'y (num 3) (sub (id 'x) (id 'y))) (add (id 'x) (id 'y))))
      '(x y))
(test (free-ids (add (with 'x (num 10) (with 'x (num 3) (sub (id 'y) (with 'y (num 7) (add (id 'x) (sub (id 'c) (id 'b)))))))(with 'a (id 'a) (id 'a))))
      '(a b c y))
(test (free-ids (add (with 'x (num 10) (with 'x (num 3) (sub (id 'y) (with 'y (num 7) (add (id 'x) (sub (id 'c) (id 'b)))))))(with 'a (id 'd) (id 'a))))
      '(b c d y))
(test (free-ids (add (with 'x (num 10) (with 'x (num 3) (sub (id 'y) (with 'y (num 7) (add (id 'x) (sub (id 'c) (id 'b)))))))
                     (with 'a (id 'd) (id 'z))))
      '(b c d y z))

;;;;;;;;;;;No.2;;;;;;;;;;;
;; binding-ids: WAE ->list-of-sym
;; to contain a symbol for each binding identifier
(define (unordered-bind wae)
  (type-case WAE wae
    [num (n) '()]
    [add (lhs rhs) (append (unordered-bind lhs) (unordered-bind rhs))]
    [sub (lhs rhs) (append (unordered-bind lhs) (unordered-bind rhs))]
    [with (nm ne bo) (append (unordered-bind ne)  (list nm) (unordered-bind bo))]
    [id (nm) '()]))
(define (binding-ids wae)
  (remove-duplicates (sort (unordered-bind wae) symbol<?)))

(test (binding-ids (add (num 3) (sub (id 'x) (id 'y)))) '())
(test (binding-ids (with 'y (num 3) (with 'x (id 'x) (id 'y)))) '(x y))
(test (binding-ids (with 'y (num 3) (with 'y (id 'x) (add (id 'x) (id 'y)))))
      '(y))
(test (binding-ids (with 'y (num 3) (with 'y (with 'x (add (num 3) (id 'y)) (sub (id 'x) (id 'y))) (add (id 'x) (id 'y)))))
      '(x y))
(test (binding-ids (with 'z (num 3) (with 'w (with 'z (add (num 3) (id 'y)) (sub (id 'x) (id 'y))) (with 'w (id 'y) (add (num 7) (id 'w))))))
      '(w z))


;;;;;;;;;;;No.3;;;;;;;;;;;
;; bound-ids : WAE -> list-of-sym 
;; to contain a symbol for each bound identifier
(define (unordered-bound wae)
  (type-case WAE wae
    [num (n) '()]
    [add (lhs rhs) (append (unordered-bound lhs) (unordered-bound rhs))]
    [sub (lhs rhs) (append (unordered-bound lhs) (unordered-bound rhs))]
    [with (nm ne bo)
          (append (if (equal? (member nm (free-ids bo)) #f)
                        '()
                        (list nm))
                      (unordered-bound ne)
                      (unordered-bound bo))]
    [id (nm) '()]))
(define (bound-ids wae)
  (remove-duplicates (sort (unordered-bound wae) symbol<?)))

(test (bound-ids (with 'x (num 3) (add (id 'y) (num 3)))) '())
(test (bound-ids (with 'x (num 3) (add (id 'x) (sub (id 'x) (id 'y))))) '(x))
(test (bound-ids (with 'x (num 3) (add (id 'x) (with 'y (num 7) (sub (id 'x) (id 'y)))))) '(x y))
(test (bound-ids (with 'x (num 3) (with 'y (id 'x) (sub (num 3) (id 'y))))) '(x y))
(test (bound-ids (with 'x (num 3) (add (id 'y) (with 'y (id 'x) (sub (num 3) (num 7)))))) '(x))
(test (bound-ids (with 'x (id 'x) (add (id 'y) (with 'y (id 'y) (sub (num 3) (with 'z (num 7) (sub (id 'z) (id 'x)))))))) '(x z))
(test (bound-ids (with 'x (with 'y (num 3) (add (id 'x) (id 'y))) (add (id 'y) (with 'y (id 'y) (sub (num 3) (num 7)))))) '(y))
(test (bound-ids (with 'x (id 'a) (with 'y (id 'b) (with 'z (id 'c) (add (id 'd) (sub (id 'x) (add (id 'y) (id 'z)))))))) '(x y z))
(test (bound-ids (add (with 'x (num 10) (with 'x (num 3) (sub (id 'y) (with 'y (num 7) (add (id 'x) (sub (id 'c) (id 'b))))))) (with 'a (id 'd) (id 'a))))
      '(a x))
(test (bound-ids (add (with 'x (num 10) (with 'x (num 3) (sub (id 'y) (with 'y (num 7) (add (id 'x) (sub (id 'c) (id 'b))))))) (with 'a (id 'd) (id 'z))))
      '(x))