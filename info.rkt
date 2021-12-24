#lang info

(define drracket-tools '(("tool.rkt")))
(define drracket-tool-names '("wakatime"))
(define drracket-tool-icons '(#f))

(define collection "drracket-wakatime")
(define deps '("base"
               "webapi"
               "http-easy"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/drracket-wakatime.scrbl" ())))
(define pkg-desc "Wakatime integration")
(define version "0.0")
(define license '(Apache-2.0 OR MIT))
(define pkg-authors '(dannypsnl))
