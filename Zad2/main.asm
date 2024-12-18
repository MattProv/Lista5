%include        'functions.asm'

SECTION .data
msg1         db      'Enter 9 values of matrix as follows:', 0Ah, 0
msg2         db      '[a1 a2 a3]', 0Ah, 0
msg3         db      '[b1 b2 b3]', 0Ah, 0
msg4         db      '[c1 c2 c3]', 0Ah, 0
eq1          db      'Suma elementow: ', 0
eq2          db      'Suma przekatnej: ', 0

SECTION .bss
number:      resb    32

SECTION .text
global _start

zeronumber:
    push eax
    push ecx
    push edx
    push edi

    mov     edi, number      ; adres początku pamięci do wyzerowania
    mov     ecx, 32          ; liczba bajtów do wyzerowania
    xor     eax, eax         ; wypełnienie zerami (ustawia AL na 0)
    rep     stosb                ; wykonanie zapisu zer w pamięci

    pop edi
    pop edx
    pop ecx
    pop eax
    ret

;return int in eax
readint:

    call    zeronumber
    
    push    ecx
    push    edx
    mov     edx, 32     ; read 32 characters
    mov     ecx, number  ; store them in digit
    mov     ebx, 0  ; file descriptor 0 (stdin)
    mov     eax, 3  ; read syscall
    int     80h

    xor     eax, eax    ; clear eax, will be used as sum
                        ; ecx is already set to number
addchar: 
                        ; eax is value to return
                        ; edx is current character
                        ; ecx is current position
                        ; ebx is base
    movzx   edx, byte [ecx]
    cmp     edx, 0Ah
    je      retint
    cmp     edx, 0
    je      retint
    cmp     ecx, number + 32
    je      retint
    
    imul    eax, 10
    sub     edx, 48
    add     eax, edx

    inc     ecx
    jmp     addchar

retint:
    pop edx
    pop ecx
    ret

_start:
    mov     eax, msg1
    call    sprint     
    mov     eax, msg2
    call    sprint
    mov     eax, msg3
    call    sprint
    mov     eax, msg4
    call    sprint

    ; esi is sum of all elements
    ; edi is sum of diagonal elements

    mov     esi, 0
    mov     edi, 0

    ; a1
    call readint
    add esi, eax
    add edi, eax

    ; a2
    call readint
    add esi, eax

    ; a3
    call readint
    add esi, eax

    ; b1
    call readint
    add esi, eax

    ; b2
    call readint
    add esi, eax
    add edi, eax

    ; b3
    call readint
    add esi, eax

    ; c1
    call readint
    add esi, eax

    ; c2
    call readint
    add esi, eax
    
    ; c3
    call readint
    add esi, eax
    add edi, eax

    mov     eax, eq1
    call    sprint

    mov     eax, esi
    call    iprintLF

    mov     eax, eq2
    call    sprint

    mov     eax, edi
    call    iprintLF

    call    quit