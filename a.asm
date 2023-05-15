section .data
    prompt db 'Enter the number to search: '
    newline db 10
    found db 'Number found at index: '
    not_found db 'Number not found.'

section .bss
    number resd 1
    array resd 10  ; Assuming an array of size 10
    result resd 1

section .text
    global _start

_start:
    ; Display prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 28
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, number
    mov edx, 4
    int 0x80

    ; Initialize the array
    mov dword [array], 1
    mov dword [array + 4], 3
    mov dword [array + 8], 5
    mov dword [array + 12], 7
    mov dword [array + 16], 9
    mov dword [array + 20], 11
    mov dword [array + 24], 13
    mov dword [array + 28], 15
    mov dword [array + 32], 17
    mov dword [array + 36], 19

    ; Binary search algorithm
    mov eax, 0             ; lower bound
    mov ebx, 9             ; upper bound

binary_search:
    cmp eax, ebx           ; check if lower bound > upper bound
    jg not_found_label     ; if true, number not found

    mov ecx, ebx           ; save the upper bound
    sub ecx, eax           ; calculate the range

    shr ecx, 1             ; divide the range by 2
    add ecx, eax           ; add the lower bound to get the middle index

    mov edx, dword [array + ecx * 4] ; load the number at the middle index

    cmp edx, dword [number] ; compare the number with the middle element
    je found_label         ; if equal, number found

    jl lower_bound_label   ; if number < middle element, adjust the upper bound
    jg upper_bound_label   ; if number > middle element, adjust the lower bound

lower_bound_label:
    mov ebx, ecx           ; adjust the upper bound to middle - 1
    jmp binary_search

upper_bound_label:
    add eax, 1             ; adjust the lower bound to middle + 1
    jmp binary_search

found_label:
    mov dword [result], ecx ; save the index of the found number

print_result:
    ; Print the result
    mov eax, 4
    mov ebx, 1
    mov ecx, found
    mov edx, 21
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 4
    int 0x80

    jmp exit_program

not_found_label:
    ; Print "Number not found."
    mov eax, 4
    mov ebx, 1
    mov ecx, not_found
    mov edx, 16
    int 0x80

exit_program:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
