;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Kebab problem set|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

#|

PLAN


1. Determine if a word is "meat"

2. Filter out the first "meat" of the list



DATA DEFINITIONS


A kebab is a list of strings
'()
(cons string los)

An ingredient is a string

|#


;; Sample values

(define KEBAB1 (list "garlic" "onions" "meat" "veggies" "tomatoes"))
(define KEBAB2 (list "meat" "sesame" "bread" "mayo" "pepper"))
(define KEBAB3 (list "garlic" "onions" "meat" "veggies" "meat" "tomatoes"))

;; Sample strings

(define MEAT "meat")
(define GARLIC "garlic")


;; string -> Boolean
;; Purpose: Determine if a word is not "meat"
(define (not-meat? a-string)
  (not (equal? a-string "meat")))
  

#|

EXTRA PLANNING:

We have to eliminate only the first meat

1. Everything up to the first "meat" we keep - extract all the elements before the first meat

2. When we encounter the first "meat", we extract the rest of the function

3. Combine two extracted lists of ingredients

Separate problems, separate functions


|#


;; list -> list
;; Purpose: To extract all the elements before "meat"
(define (extract-before-meat a-list)
  (if (or (empty? a-list)
          (equal? (first a-list) "meat"))
      empty
      (cons (first a-list) (extract-before-meat (rest a-list)))))

(check-expect (extract-before-meat KEBAB3) (list "garlic" "onions"))
(check-expect (extract-before-meat KEBAB2) '())
(check-expect (extract-before-meat KEBAB1) (list "garlic" "onions"))

;; list -> list
;; Purpose: When we encounter the first "meat", we extract the rest of the function
(define (extract-after-meat a-list)
  (if (empty? a-list)
      '()
      (if (equal? (first a-list) "meat")
          (rest a-list)
          (extract-after-meat (rest a-list)))))

;; Tests 
(check-expect (extract-after-meat KEBAB3) (list "veggies" "meat" "tomatoes"))
(check-expect (extract-after-meat KEBAB2) (list "sesame" "bread" "mayo" "pepper"))
(check-expect (extract-after-meat KEBAB1) (list "veggies" "tomatoes"))




;; list -> list
;; Purpose: To return a kebab without the first meat
(define (remove-meat a-list)
  (append (extract-before-meat a-list) (extract-after-meat a-list)))

;; Tests 
(check-expect (remove-meat KEBAB3) (list "garlic" "onions" "veggies" "meat" "tomatoes"))
(check-expect (remove-meat KEBAB2) (list "sesame" "bread" "mayo" "pepper"))
(check-expect (remove-meat KEBAB1) (list "garlic" "onions" "veggies" "tomatoes"))