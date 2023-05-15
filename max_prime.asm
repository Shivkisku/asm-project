section .data
    prompt db 'Enter a number: '
    newline db 10
    result db 'The maximum prime digit is: '
    
section .bss
    number resb 10

section .text
    global _start

_start:
    ; Display prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 16
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, number
    mov edx, 10
    int 0x80

    ; Find maximum prime digit
    mov bl, 0   ; maximum prime digit
    mov esi, 0  ; current digit
    mov ecx, 10 ; number of digits to check
    mov edi, number

loop_digits:
    movzx eax, byte [edi + esi]
    sub eax, 48  ; convert ASCII to digit value

    cmp eax, 2
    jl next_digit ; skip if digit < 2

    mov ebx, eax ; initialize maximum prime digit

    mov ecx, 2  ; divisor
check_prime:
    cmp ecx, eax
    jge next_digit ; next digit if no divisors found

    mov edx, 0  ; clear remainder
    div ecx     ; eax = eax / ecx, edx = eax % ecx

    cmp edx, 0
    je next_digit ; not prime, check next digit

    inc ecx
    jmp check_prime

next_digit:
    inc esi
    loop loop_digits

    ; Display the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 25
    int 0x80

    add bl, 48 ; convert digit value to ASCII
    mov [result + 25], bl
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 26
    int 0x80

exit:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
