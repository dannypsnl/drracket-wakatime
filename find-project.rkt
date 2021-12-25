#lang racket/base
(provide find-project)

; return where we find `info.rkt` or `.git/`, else `#f`
(define (find-project dir)
  (cond
    [(file-exists? (build-path dir "info.rkt")) dir]
    [(directory-exists? (build-path dir ".git")) dir]
    [else (define-values [parent-dir file dir?] (split-path dir))
          (if parent-dir
              (find-project parent-dir)
              #f)]))

(module+ test
  (require rackunit)

  (check-equal? (find-project (current-directory))
                (current-directory)))
