(define inital-value 10)
(define (rand m)
  (define (generate)
    (begin (set! inital-value (random inital-value)) inital-value)
  )
  (define (reset new-value)
    (begin (set! inital-value new-value) inital-value)
  )
  (cond ((eq? 'generate m) (generate))
          ((eq? 'reset m) reset)
          (else (error "Unkonw method" m))
  )
)