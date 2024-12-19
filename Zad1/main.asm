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
    mov     eax, 4       ; write syscall
    int     80h          

    mov     al, byte [ecx]  ; load char to al
    sub     al, '0'         ; convert digit to its value
    add     esi, eax        ; add to sum

    inc     ecx          ; increment pointer

    cmp     ecx, digit+5    ; check if we read all 5 digits

    je      exitloop        ; if yes, exit loop

    mov     eax, addmsg     ; print addmsg
    call    sprint          ; 

    jmp     loop            ; loop
exitloop:
    mov     eax, eqmsg      ; print eqmsg
    call    sprint

    mov     eax, esi        ; print sum
    call    iprintLF

    call    quit