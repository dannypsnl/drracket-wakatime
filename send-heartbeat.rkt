#lang formatted-string racket/base
(provide send-heartbeat)

(require racket/system)

(define (send-heartbeat #:file filename #:project [project #f])
  (define cmd "wakatime-cli --entity $filename --language racket --plugin drracket-wakatime --write")
  (set! cmd (if project
                (string-append cmd " --project $project")
                cmd))
  (system cmd))

(module+ test
  (require rackunit)

  (check-eq? (send-heartbeat #:file "main.rkt" #:project "drracket-wakatime-test")
             #t))
