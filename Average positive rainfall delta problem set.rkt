;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Average positive rainfall delta problem set|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Lists problem set


#|


Design a program called average-positive-rain-delta that consumes a list of numbers representing daily
 change in rainfall amounts (as entered by a user). The list may contain the number -999
indicating the end of the data of interest. Produce the average of the non-negative values in the
list up to the first -999 (if it shows up). There may be negative numbers other than -999 in the list.
 These are considered valid data. Do not neglect the empty list case.


|#


;; Data definitions

;; list of number is
;; '()
;; (cons number lon)

;; average-positive-rain-delta is a number
;; that represents the average of all numbers in the list
;; up until the first -999 encountered
;; e.g. '(23 -10 70 40 -999 15 64 -999 1 3 4)  is 30.75 average-positive-rain-delta



;; Sample values

(define LIST1 '(23 -10 70 40 -999 15 64 -999 1 3 4))
(define LIST2 '())
(define LIST3 '(40 67 -10 -50 123))


#|

TO DO

1. Extract all of the numbers before the first -999
list -> list

2. Compute the average of those numbers
list -> number
subproblem: add all of the numbers in the list together
then divide in a separate function



|#



#|


FUNCTION TEMPLATE

1. 

(define (extract-before-999 a-list)
    (if (or (empty? a-list)
            (equal? (first a-list) -999)))
             empty)
     (...)))



|#

;; list -> list
;; Purpose: To extract the numbers before the first -999 out of the list
(define (extract-before-999 a-list)
  (if (or (empty? a-list)
          (equal? (first a-list) -999))
      empty
      (cons (first a-list) (extract-before-999 (rest a-list)))))


;; Tests

(check-expect (extract-before-999 LIST1) (list 23 -10 70 40))
(check-expect (extract-before-999 LIST2) '())
(check-expect (extract-before-999 LIST3) (list 40 67 -10 -50 123))


#|

FUNCTION TEMPLATE

adding numbers in a list
list -> number

(define (add-list a-list)
    (if (empty? a-list)
        0
       (...)))

|#

;; list -> number
;; Purpose: To add all numbers in a list
(define (add-list a-list)
  (if (empty? a-list)
      0
      (+ (first a-list) (add-list (rest a-list)))))

;; Tests

(check-expect (add-list (list 23 -10 70 40)) 123)
(check-expect (add-list '()) 0)
(check-expect  (add-list (list 40 67 -10 -50 123)) 170)



;; Function template

;;(define (compute-average a-list)
;;  (/ (...)
;;     (length a-list)))



;; list -> number
;; Purpose: Compute the average of the numbers in a list before the first -999
(define (compute-average a-list)
  (if (empty? (extract-before-999 a-list))
      0
      (/ (add-list (extract-before-999 a-list))
         (length (extract-before-999 a-list)))))

;;Tests
(check-expect (compute-average LIST1) 30.75)
(check-expect (compute-average LIST2) 0)
(check-expect (compute-average LIST3) 34)



