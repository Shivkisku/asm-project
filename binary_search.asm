section .data
    prompt db 'Enter a letter (a-z): '
    newline db 10
    result_found db 'Letter found at index: '
    result_not_found db 'Letter not found.'

section .bss
    letter resb 1
    array resb 26

section .text
    global _start

_start:
    ; Display prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 24
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, letter
    mov edx, 1
    int 0x80

    ; Read the sorted array
    mov eax, 3
    mov ebx, 0
    mov ecx, array
    mov edx, 26
    int 0x80

    ; Binary search algorithm
    mov eax, 0        ; low index
    mov ebx, 25       ; high index
    sub ebx, eax      ; range = high - low
    shr ebx, 1        ; range / 2
    add ebx, eax      ; mid = low + range / 2
    xor esi, esi      ; counter for comparisons

binary_search:
    cmp byte [array + ebx], byte [letter]
    jl letter_not_found     ; If array[mid] < letter, continue search in the upper half
    jg letter_not_found     ; If array[mid] > letter, continue search in the lower half

    ; Letter found at array[mid]
    mov eax, 4
    mov ebx, 1
    mov ecx, result_found
    mov edx, 21
    int 0x80

    ; Print the index of the found letter
    movzx eax, byte [array + ebx]
    sub eax, 97     ; Subtract ASCII value of 'a'
    add eax, 48     ; Convert to ASCII character
    mov [result_found + 21], al
    mov eax, 4
    mov ebx, 1
    mov ecx, result_found
    mov edx, 22
    int 0x80

    jmp exit_program

letter_not_found:
    ; Letter not found
    mov eax, 4
    mov ebx, 1
    mov ecx, result_not_found
    mov edx, 15
    int 0x80

exit_program:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
