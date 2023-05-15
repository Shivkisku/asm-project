section .data
    prompt db 'Enter a number: '
    newline db 10
    result db 'Prime factorization: '
    space db ' '

section .bss
    number resd 1

section .text
    global _start

_start:
    ; Display prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 18
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, number
    mov edx, 4
    int 0x80

    ; Initialize variables
    mov eax, 2             ; divisor = 2 (smallest prime number)
    mov esi, 0             ; factor count

check_divisible:
    mov edx, 0
    mov eax, [number]
    div dword eax          ; divide number by divisor

    cmp edx, 0             ; check if remainder is 0
    jne increment_divisor  ; if remainder is not 0, increment divisor

    ; Print the prime factor
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 20
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    ; Print the factor
    mov eax, [number]
    mov ebx, 10
    xor edx, edx
    div ebx                ; divide number by 10

    add edx, 48            ; convert digit to ASCII
    mov [result + 20 + esi], dl
    inc esi                ; increment factor count

    cmp eax, 0             ; check if number is 0
    jne check_divisible    ; if number is not 0, continue checking

    ; Print the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    add edx, esi
    mov edx, edx
    int 0x80

exit_program:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

