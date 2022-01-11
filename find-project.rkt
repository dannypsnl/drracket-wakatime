#lang racket/base
(provide basename
         find-project-dir)

(define (basename path)
  (define maybe-cut? (split-path path))
  (if maybe-cut?
      (let-values ([(base file dir?) maybe-cut?])
        (path->string file))
      #f))

; return where we find `info.rkt` or `.git/`, else `#f`
(define (find-project-dir dir)
  (cond
    [(file-exists? (build-path dir "info.rkt")) dir]
    [(directory-exists? (build-path dir ".git")) dir]
    [else (define parent-dir (basename dir))
          (if parent-dir
              (find-project-dir parent-dir)
              #f)]))

(module+ test
  (require rackunit)

  (check-equal? (find-project-dir (current-directory))
                (current-directory)))
