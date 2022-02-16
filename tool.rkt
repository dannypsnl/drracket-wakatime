#lang racket

(provide tool@)

(require drracket/tool
         framework
         racket/gui/base
         "send-heartbeat.rkt"
         "find-project.rkt")

(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)

    (define (phase1)
      (unless (get-preference 'wakatime-api-key)
        (put-preferences '(wakatime-api-key)
                         (list (get-text-from-user "wakatime api-key" "enter key:")))))
    (define (phase2) (void))

    (define drracket-editor-mixin
      (mixin (drracket:unit:definitions-text<%> racket:text<%>) ()
        (super-new)

        (define (local-send-heartbeat)
          (thread
           (lambda ()
             (define filename (send this get-filename))
             (when filename
               (define project
                 (if filename
                     (find-project-dir (path-only filename))
                     #f))
               (send-heartbeat #:file filename #:key (get-preference 'wakatime-api-key) #:project project)))))

        (define/augment (on-change)
          (local-send-heartbeat))))

    (drracket:get/extend:extend-definitions-text drracket-editor-mixin)))
