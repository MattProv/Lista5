%include        'functions.asm'

SECTION .data
msg         db      'Enter 5 digit number, ex: 12345', 0Ah, 0
addmsg      db      ' + ', 0
eqmsg       db      ' = ', 0

SECTION .bss
digit:      resb    5

SECTION .text
global _start

_start:
    mov     eax, msg
    call    sprint      ; print message 

    mov     edx, 5      ; read 5 characters
    mov     ecx, digit  ; store them in digit
    mov     ebx, 0      ; file descriptor 0 (stdin)
    mov     eax, 3      ; read syscall
    int     80h


    mov     edx, 1      ; print 1 character
    mov     ebx, 1      ; file descriptor 1 (stdout)
    mov     eax, 4      ; write syscall 

    xor     esi, esi    ; clear esi, will be used as sum

loop:
    mov    eax, 4       ; write syscall
    int    80h          

    mov al, byte [ecx]  ; Załaduj 8-bitową wartość z pamięci do AL
    sub al, '0'         ; Konwertuj ASCII na cyfrę (jeśli to liczba)
    add esi, eax        ; Dodaj wartość rozszerzoną do 32-bitowego rejestru ESI

    inc    ecx          ; increment pointer

    cmp   ecx, digit+5

    je     exitloop

    mov    eax, addmsg
    call   sprint

    cmp   ecx, digit+5
    jl     loop
exitloop:
    mov eax, eqmsg
    call sprint

    mov eax, esi
    call iprintLF

    call    quit