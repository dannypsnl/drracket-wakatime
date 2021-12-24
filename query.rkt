#lang racket

(require net/http-easy
         "value.rkt")

(define token "sec_IsCOX3BnIP7ktnbro9CdlRoCZbLJPdPNAJSqvsz2A7V4k3SyNgo6rpWar2Tu7P5o1HmsUEopMzuuq38H")

(define (@wakatime-api uri)
  (string-append "https://wakatime.com/api/v1/" uri))
(define (wakatime api-uri)
  (response-json (get (@wakatime-api api-uri)
                      #:auth (bearer-auth token))))

(response-json (post (@wakatime-api "users/current/heartbeats")
                     #:auth (bearer-auth token)
                     ; #:form heartbeats-form
                     #:json heartbeats-json
                     ))
