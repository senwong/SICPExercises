(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))
  )
)

; (define (cons-stream a b)
;   (cons a (delay b))
; )
(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin(proc (stream-car s))
    (stream-for-each proc (stream-cdr s)))
  )
)
(define (display-stream s)
  (stream-for-each display-line s)
)
(define (display-line x)
(newline)
(display x))

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))
(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream low
        (stream-enumerate-interval (+ low 1) high))
  )
)
(define (stream-filter pred s)
      (cond ((stream-null? s) the-empty-stream)
            ((pred (stream-car s))
                (cons-stream (stream-car s)
                  (stream-filter pred (stream-cdr s))
                )
            )
            (else (stream-filter pred (stream-cdr s)))
      )
)


(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result
          )
          result
      )
    )
  )
)
; (define (delay proc)
;   (memo-proc (lambda () proc)))
; (define (delay proc)
;    (lambda () proc))

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
      '()
      (cons-stream
      (apply proc (map (lambda (s) (stream-car s)) argstreams))
      (apply stream-map
            (cons proc (map (lambda (s) (stream-cdr s)) argstreams))))))