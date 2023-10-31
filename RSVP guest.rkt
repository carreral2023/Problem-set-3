;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |RSVP guest|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

#|

Plan

1. Determine if the name is Bob or Charlie

2. Filter out the names of those who did attend


Data Definitions
A RSVP'D is a list of strings
'()
(cons string los)

A name is a string

|#


;; Sample values

(define RSVP1 (list "Alice" "Bob" "Charlie"))


;; Sample strings

(define BOB "Bob")
(define CHARLIE "Charlie")
(define ALICE "Alice")



;; string -> Boolean
;; Purpose: Determine if the guest is not "Alice"
(define (not-Alice? a-string)
  (not (equal? a-string "Alice")))
  

#|

EXTRA PLANNING:

We have to eliminate only the first meat

1. Everything up to the first "meat" we keep - extract all the elements before the first meat

2. When we encounter the first "meat", we extract the rest of the function

3. Combine two extracted lists of ingredients

Separate problems, separate functions


|#


;; list -> list
;; Purpose: To extract all the names who attended
(define (extract-guest-Alice a-list)
  (if (or (empty? a-list)
          (equal? (first a-list) "Alice"))
      empty
      (cons (first a-list) (extract-guest-Alice (rest a-list)))))

(check-expect (extract-guest-Alice RSVP1) '())



;; list -> list
;; Purpose: When we encounter the first "Alice", we extract the rest of the function
(define (extract-after-Alice a-list)
  (if (empty? a-list)
      '()
      (if (equal? (first a-list) "Alice")
          (rest a-list)
          (extract-after-Alice (rest a-list)))))

;; Tests 
(check-expect (extract-after-Alice RSVP1) (list "Bob" "Charlie"))





;; list -> list
;; Purpose: To return a RVSP without Alice 
(define (remove-Alice a-list)
  (append (extract-guest-Alice a-list) (extract-after-Alice a-list)))

;; Tests 
(check-expect (remove-Alice RSVP1) (list "Bob" "Charlie"))





