section .data
    hello db 'Hello, world!', 0

section .text
    global _start

_start:
    ; Write the string to stdout
    mov eax, 4            ; system call number (sys_write)
    mov ebx, 1            ; file descriptor (stdout)
    mov ecx, hello        ; pointer to the string
    mov edx, 13           ; string length
    int 0x80              ; make the system call

    ; Exit the program
    mov eax, 1            ; system call number (sys_exit)
    xor ebx, ebx          ; exit code 0
    int 0x80              ; make the system call
