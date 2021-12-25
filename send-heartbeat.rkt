#lang formatted-string racket/base
(provide send-heartbeat)

(require racket/system
         racket/port
         racket/match)

(define (send-heartbeat #:file filename #:key [key #f] #:project [project #f])
  (define cmd "$(find-executable-path "wakatime-cli") --entity $filename --language racket --plugin drracket-wakatime --write")
  (set! cmd (if project (string-append cmd " --project $project") cmd))
  (set! cmd (if key (string-append cmd " --key $key") cmd))
  (match-define (list stdout stdin pid stderr run)
    (process cmd))
  (run 'wait)
  (case (run 'status)
    [(done-ok) (void)]
    [(done-error) (error 'report-bug-to-drracket-wakatime (port->string stderr))])
  (close-input-port stdout)
  (close-input-port stderr)
  (close-output-port stdin))

#;(module+ test
    (require rackunit)

    (check-eq? (send-heartbeat #:file "main.rkt" #:project "drracket-wakatime-test")
               (void)))
