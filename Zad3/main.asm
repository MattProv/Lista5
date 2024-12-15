%include        'functions.asm'

SECTION .data
eqmsg       db      ' = 0x', 0
nl          db      0Ah, 0

SECTION .text
global _start

_start:
    mov     eax, 12498
    call    iprint
    push    eax
    mov     eax, eqmsg
    call    sprint
    pop     eax
    call    xprint

    mov eax, nl
    call sprint

    call    quit