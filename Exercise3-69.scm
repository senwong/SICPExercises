(define st-pairs (pairs integers integers))
;(define all-tu-pairs (pairs integers integers))

; (define (tiple-pairs st tu) ;st (s0,t0),tu(t0,u0)
;   (cons-stream (append (stream-car st) (cdr (stream-car tu)))
;     (interleave
;         (stream-map (lambda (x) (append (stream-car st) (cdr x))) (stream-cdr tu))
;         (tiple-pairs (stream-cdr st) (stream-cdr tu))
;     )
;   )
; )
; (define all-triple-pairs (tiple-pairs all-st-pairs all-tu-pairs))
(define (Pythagorean-triples? s)
  (let ((i (car s))
        (j (cadr s))
        (k (caddr s))
        )
        (= (+ (square i) (square j)) (square k))
  )
)
(define (filtered-triple-pairs st u)
  (let ((i (car (stream-car st)))
        (j (cadr (stream-car st)))
        (k (stream-car u))
        )
        ;(cond ((<= j k)
         ;       (cond ((= (square k) (+ (square i) (square j)))
                        (cons-stream (list i j k)
                          (interleave (filtered-triple-pairs (stream-cdr st) u) (filtered-triple-pairs st (stream-cdr u)))
                        ))
          ;            ((> (square k) (+ (square i) (square j)))
           ;             (filtered-triple-pairs (stream-cdr st) u))
            ;          ((< (square k) (+ (square i) (square j)))
             ;           (filtered-triple-pairs  st (stream-cdr u)))
              ;  )
              ;)
              ;(else  (filtered-triple-pairs st (stream-cdr u)))
        ;)

      )
      ;)
(define (all-tirple-pairs st u)
  (cons-stream (append (stream-car st) (list (stream-car u)))
    (interleave
      (interleave
        (stream-map (lambda (x) (append  x (list (stream-car u)))) (stream-cdr st))
        (stream-map (lambda (x) (append (stream-car st) (list x))) (stream-cdr u))
      )
      (all-tirple-pairs (stream-cdr st) (stream-cdr u))
    )
  )
)
;(define p-triples (stream-filter Pythagorean-triples? (filtered-triple-pairs st-pairs integers)))
(define triple-pairs (all-tirple-pairs st-pairs integers))
(define p-pairs (stream-filter Pythagorean-triples? triple-pairs))
(define (triples s t u)
  (cons-stream
   (list
    (stream-car s)
    (stream-car t)
    (stream-car u))
   (interleave
    (stream-map
     (lambda (x) (append (list (stream-car s)) x))
     (stream-cdr (pairs t u)))
    (triples
     (stream-cdr s)
     (stream-cdr t)
     (stream-cdr u)))))
 
(define pythagorean-triples
  (stream-filter (lambda (t)
                   (= (+ (square (car t))
                         (square (cadr t)))
                      (square (caddr t))))
                 (triples integers integers integers) ))
                 (display-stream  pythagorean-triples )
