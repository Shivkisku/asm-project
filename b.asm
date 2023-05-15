section .data
    msg db "Grade of marks for student ", 0xA, 0xD
    len equ $-msg

section .bss
    student resb 20

section .text
    global _start

_start:
    ; create a new student object
    mov eax, student
    mov ebx, 10
    mov [eax], ebx

    ; compute the grade of marks for the student
    call compute_grade

    ; print the grade of marks for the student
    push eax

    push dword len
    push dword msg

    call printf

    add esp, 12

    ; exit program with status code 0 (success)
    xor eax,eax 
    ret 

compute_grade:
    ; compute the grade of marks for the student
    mov eax, [student]
    cmp eax, 90
    jge .a

    cmp eax, 80
    jge .b

    cmp eax, 70
    jge .c

    cmp eax, 60
    jge .d

    jmp .f

.a:
    mov eax, 'A'
    ret

.b:
    mov eax, 'B'
    ret

.c:
    mov eax, 'C'
    ret

.d:
    mov eax, 'D'
    ret

.f:
    mov eax, 'F'
    ret

section .data 
msg2 db "%c",0xA,0xD 
len2 equ $-msg2 