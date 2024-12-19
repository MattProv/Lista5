%include        'functions.asm'

SECTION .data
welcomemsg       db      'Liczby pierwsze od 1 do 100 000:', 0Ah, 0
array           times   100000 db 0     ; tablica do sita eratostenesa

SECTION .text
global _start

; zwraca w edi 1 jesli liczba nie jest pierwsza, 0 w przeciwnym wypadku
getzsita:
    push    eax
    mov     al, [array + esi]   ; Pobierz odpowiedni bajt
    test    al, al              ; Sprawdź, czy jest różny od 0
    mov     edi, 0              ; Domyślnie ustaw edi (return) na 0 (liczba jest pierwsza)
    jz      not_prime           ; Jeśli al == 0, przejdź do not_prime
    mov     edi, 1              ; Liczba nie jest pierwsza
not_prime:
    pop     eax
    ret



; ustawia tablice[eax] na 1 (liczba niepierwsza)
setsito:
    push    eax

    mov     byte [array + eax], 1 ; Zapisz zmieniony bajt z powrotem do tablicy

    pop     ecx
    ret    

_start:
    mov     eax, welcomemsg ; wypisz informacje
    call    sprint

    mov     esi, 2          ; zaczynamy od 2
    mov     eax, esi        ; wypisz 2
    call    iprintLF        ; 
loop:
    call    getzsita        ; sprawdz czy liczba jest pierwsza
    cmp     edi, 1          ; jesli nie jest, przejdz do incesi
    je      incesi          ;
    
    mov     eax, esi        ; wypisz liczbe (jest pierwsza)
    call    iprintLF
innerloop:
    call    setsito         ; ustawic tablice[eax] na liczbe niepierwsza

    add     eax, esi        ; zwieksza eax o wartosc aktualnej liczby pierwszej
    cmp     eax, 100000     ; sprawdz czy przekroczylismy zakres
    jl      innerloop       ; jesli nie, kontynuuj
    
incesi:
    inc     esi             ; zwieksz esi
    cmp     esi, 100000     ; sprawdz czy przekroczylismy zakres
    jl      loop            ; jesli nie, kontynuuj

    call    quit
