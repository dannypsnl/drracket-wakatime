#lang formatted-string racket

(provide tool@)

(require drracket/tool
         framework)

(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)

    (define (phase1) (void))
    (define (phase2) (void))

    (define drracket-editor-mixin
      (mixin (drracket:unit:definitions-text<%> racket:text<%>) ()
        (super-new)
        (define plugin-name "drracket-wakatime")
        (define current-edit-file #f)
        (define project #f)

        (define/augment (on-load-file filename format)
          ; set project to where we find `info.rkt` or `.git/`
          (define resolved-f (resolve-path filename))
          (set! project #f)
          (set! current-edit-file filename))

        (define/augment (on-change)
          (define cmd "wakatime-cli --entity $current-edit-file --alternate-language racket --plugin $plugin-name --write")
          (set! cmd (if project
                        (string-append cmd "--alternate-project $project")
                        cmd))
          (when (find-executable-path "wakatime-cli")
            (system cmd)))))

    (drracket:get/extend:extend-definitions-text drracket-editor-mixin)))