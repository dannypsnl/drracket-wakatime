#lang racket

(require webapi/oauth2
         net/http-easy)

(define @api-prefix "https://wakatime.com/api/v1/")

(define server
  (oauth2-auth-server
   #:auth-url "https://wakatime.com/oauth/authorize"
   #:token-url "https://wakatime.com/oauth/token"))

(define client-id "NEjAViaya1siVUyCew1hnrsz")
(define secret "sec_JvGhfUDNkny27kAGeOLIV61eOCG4I4GjaaL9LIPtKDxTwLLLXQg1LMjYoXDWY5NvzZRZ2EFMtXmJFX0d")
(define client
  (oauth2-client #:id client-id
                 #:secret secret))

(displayln
 (send server get-auth-request-url
       #:client client
       #:scopes '("email,read_stats,read_logged_time")
       #:state "hello"
       #:redirect-uri "https://wakatime.com/oauth/test"))

(display "print enter your code: ")
(define auth-code (symbol->string (read)))
(define oauth2result
  (oauth2/auth-code	server
                    client
                    auth-code
                    #:redirect-uri "https://wakatime.com/oauth/test"))

(define (wakatime api-uri)
  (response-json (get (string-append @api-prefix api-uri)
                      #:auth (bearer-auth (send oauth2result get-access-token)))))

; (wakatime "users/current")
; (wakatime "editors")
(define projects (hash-ref (wakatime "users/current/projects") 'data))
(for ([proj projects])
  (displayln (hash-ref proj 'name)))
