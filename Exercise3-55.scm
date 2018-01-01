(define (partial-sums stream)
  (cons-stream (stream-car stream)
      (add-stream (stream-cdr stream) (partial-sums stream))
  )
)
(define x (partial-sums integers))