#lang formatted-string racket

(provide tool@)

(require drracket/tool
         framework
         "send-heartbeat.rkt"
         "find-project.rkt")

(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)

    (define (phase1) (void))
    (define (phase2) (void))

    (define drracket-editor-mixin
      (mixin (drracket:unit:definitions-text<%> racket:text<%>) ()
        (super-new)

        (define/augment (on-change)
          (define filename (send this get-filename))
          (define project
            (if filename
                (find-project (path-only filename))
                #f))
          (send-heartbeat #:file filename #:project project))))

    (drracket:get/extend:extend-definitions-text drracket-editor-mixin)))
