    list    n=0,c=132
    RADIX   dec
;                                                                              *
;    Filename:                                                                 *
;    Date:                                                                     *
;    File Version:                                                             *
;    Description:                                                              *
;                                                                              *

; PIC16F877 Configuration Bit Settings

; Assembly source line config statements

#include "p16f877.inc"

; CONFIG
; __config 0x3FBA
 __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _CP_OFF & _BOREN_OFF & _LVP_ON & _CPD_OFF & _WRT_ON


;
n1      UDATA   0x20
nbr1:   res     1

n2      UDATA   0x121
nbr2:   res     1

sum     UDATA   0x1A2
sum12:  res     1


common  UDATA_SHR
temp:   res     1

;**************
; Reset Vector
;**************

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program


;**************
; MAIN PROGRAM
;**************

MAIN_PROG CODE                      ; let linker place main program

START:
    banksel nbr2
    movlw   0x04
    movwf   nbr2

    banksel nbr1
    movlw   0x50
    movwf   nbr1

main:
    clrf    temp

    bankisel nbr1
    movlw   LOW(nbr1)
    movwf   FSR
    movf    INDF,W
    movwf   temp

    bankisel nbr2
    movlw   LOW(nbr2)
    movwf   FSR
    movf    INDF,W
    addwf   temp,F

    bankisel sum12
    movlw   LOW(sum12)
    movwf   FSR
    movf    temp,W
    movwf   INDF

    GOTO    main

    END