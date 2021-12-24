#lang racket
(provide heartbeats-form
         heartbeats-json)

(require racket/date)

(define heartbeats-form (list (cons 'entity (path->string (build-path (current-directory) "wakatime.rkt")))
                              (cons 'type "file")
                              (cons 'category "coding")
                              (cons 'time (date->string (seconds->date (current-seconds) #f)))
                              ; find `info.rkt`, fall back to find `.git`?
                              (cons 'project "drracket wakatime dev")
                              (cons 'branch "develop")
                              (cons 'language "racket")
                              (cons 'lines (number->string (sequence-length (in-lines (open-input-file "wakatime.rkt")))))
                              ))
(define heartbeats-json (hash 'entity (path->string (build-path (current-directory) "wakatime.rkt"))
                              'type "file"
                              'category "coding"
                              'time (date->string (seconds->date (current-seconds) #f))
                              ; find `info.rkt`, fall back to find `.git`?
                              'project "drracket wakatime dev"
                              'branch "develop"
                              'language "racket"
                              'lines (sequence-length (in-lines (open-input-file "wakatime.rkt")))
                              ))

heartbeats-json