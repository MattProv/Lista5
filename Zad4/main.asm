%include        'functions.asm'

SECTION .data
welcomemsg       db      'Liczby pierwsze od 1 do 100 000:', 0Ah, 0
array           times   100000 db 0

SECTION .text
global _start

; zwraca w edi 1 jesli liczba nie jest pierwsza 0 w przeciwnym wypadku
getzsita:
    push eax
    mov al, [array + esi] ; Pobierz odpowiedni bajt
    test al, al           ; Sprawdź, czy jest różny od 0
    mov edi, 0            ; Domyślnie ustaw edi na 0 (liczba jest pierwsza)
    jz not_prime          ; Jeśli al == 0, przejdź do not_prime
    mov edi, 1            ; Liczba nie jest pierwsza
not_prime:
    pop eax
    ret



; ustawia pozycje w tablicy okreslona w eax na 1
setsito:
    push eax

    mov byte [array + eax], 1 ; Zapisz zmieniony bajt z powrotem do tablicy

    pop ecx
    ret    

_start:
    mov     eax, welcomemsg
    call    sprint

    mov esi, 2
    mov eax, esi
    call iprintLF
loop:
    call getzsita
    cmp edi, 1
    je incesi
    ;liczba jest pierwsza, wypisac ja
    mov eax, esi
    call iprintLF
innerloop:

    ;ustawic dana flage na 1
    call setsito

    add eax, esi
    cmp eax, 100000
    jl innerloop
    
incesi:
    inc esi
    cmp esi, 100000
    jl loop

    call    quit
