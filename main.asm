section .data
    zerot db "Zero", 10
    negt db "Negative", 10
    post db "Positive", 10

section .text
    global _start

_start:
    mov eax, -1
    cmp eax, 0
    je zero
    jg positive
    jl negative

negative:
    mov eax, 1                        ; sys_write
    mov ebx, 1                       ; stdout
    mov ecx, negt                ; Message to display
    mov edx, 9
    int 0x80                          ; Call the kernel
    jmp exit

positive:
    mov eax, 1                        ; sys_write
    mov ebx, 1                        ; stdout
    mov ecx, post                 ; Message to display
    mov edx, 9                        ; Length of message (including newline)
    int 0x80
    jmp exit

zero:
    mov eax, 1                        ; sys_write
    mov ebx, 1                        ; stdout
    mov ecx, zerot                     ; Message to display
    mov edx, 5
    int 0x80
    jmp exit

exit:
    mov eax, 1                        ; System call number for sys_exit
    xor ebx, ebx                      ; Exit code 0
    int 0x80                          ; Call the kernel