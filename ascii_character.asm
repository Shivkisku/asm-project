section .data
    prompt db 'Enter a decimal value: '
    newline db 10
    result db 'Corresponding ASCII character: '

section .bss
    decimal resb 4

section .text
    global _start

_start:
    ; Display prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 25
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, decimal
    mov edx, 4
    int 0x80

    ; Convert decimal value to ASCII character
    movzx eax, word [decimal]
    mov [result + 27], al

    ; Display the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 29
    int 0x80

exit_program:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
