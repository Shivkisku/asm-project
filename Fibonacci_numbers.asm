section .data
    prompt db 'Prime Fibonacci Numbers in Range 1-10000:'
    newline db 10
    space db ' '
    result db 'Fibonacci:', 10

section .bss
    fibonacci resd 3     ; Array to store Fibonacci numbers

section .text
    global _start

_start:
    ; Display prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 37
    int 0x80

    ; Initialize Fibonacci sequence
    mov dword [fibonacci], 1     ; fibonacci[0] = 1
    mov dword [fibonacci + 4], 1 ; fibonacci[1] = 1

    ; Print the initial two Fibonacci numbers
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 11
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, fibonacci
    mov edx, 4
    int 0x80

    ; Calculate and print prime Fibonacci numbers within the range
    mov eax, 2      ; current Fibonacci index
    mov ebx, 2      ; current Fibonacci number

next_fibonacci:
    mov edx, dword [fibonacci]  ; fibonacci[index - 2]
    add edx, dword [fibonacci + 4]  ; fibonacci[index - 1]
    mov dword [fibonacci + 8], edx  ; fibonacci[index] = fibonacci[index - 2] + fibonacci[index - 1]

    ; Check if the Fibonacci number is prime
    mov esi, 2          ; divisor
    mov edx, 0          ; remainder

check_prime:
    mov eax, dword [fibonacci + 8]
    div esi             ; edx = eax % esi

    cmp edx, 0          ; check if remainder is 0
    je increment_index  ; if remainder is 0, not prime

    add esi, 1          ; increment divisor
    cmp esi, eax        ; compare divisor with the Fibonacci number
    jg print_fibonacci  ; if divisor > Fibonacci number, it is prime

    jmp check_prime

increment_index:
    add eax, 1          ; increment index
    mov ebx, dword [fibonacci + eax * 4]  ; move to the next Fibonacci number
    jmp next_fibonacci

print_fibonacci:
    ; Check if the Fibonacci number is within the range 1-10000
    cmp ebx, 10001
    jge exit_program

    ; Print the prime Fibonacci number
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, fibonacci + eax * 4
    mov edx, 4
    int 0x80

    jmp increment_index

exit_program:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
