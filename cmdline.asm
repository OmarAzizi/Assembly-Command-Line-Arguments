; Command Line Arguments Example
; ------------------------------------

section     .data
    ; some constants
    LF              EQU     10      ; line feed
    NULL            EQU     0       ; end of a string
    EXIT_SUCCESS    EQU     0

    STDOUT          EQU     1
    
    ; suscalls
    SYS_READ        EQU     0
    SYS_WRITE       EQU     1
    SYS_EXIT        EQU     60

    newline         db      LF, NULL

section     .text
global main
main:
    ; Get command line arguments and echo to screen.
    ; rdi = argc (argument cound)
    ; rsi = argv (argument vector)

    mov     r12, rdi
    mov     r13, rsi

    ; Simple loop to display each argument to the screen.
    ; Each argument is a NULL terminated string

print_arguments:
    mov     rdi, newline
    call    print_string
    
    mov     rbx, 0
print_loop:
    mov     rdi, qword[r13 + rbx * 8]   ; calculating the offset
    call    print_string

    mov     rdi, newline
    call    print_string

    inc     rbx
    cmp     rbx, r12                    ; comparing rbx with argc (argument count)
    jl      print_loop                  ; if less then repeat

exit:
    mov     rax, SYS_EXIT
    mov     rdi, EXIT_SUCCESS
    syscall

print_string:
    push    rbp
    mov     rbp, rsp
    push    rbx

    ; ---------------
    ; counting the length of the string
    mov     rbx, rdi
    mov     rdx, 0
str_count_loop:
    cmp     byte [rbx], NULL
    je      str_count_done
    inc     rdx
    inc     rbx
    jmp     str_count_loop
str_count_done:
    cmp     rdx, 0
    je      print_done

    ; call SYS_WRITE
    mov     rax, SYS_WRITE
    mov     rsi, rdi
    mov     edi, STDOUT
    syscall
print_done:
    ; string printed, return to the calling routine
    pop     rbx
    pop     rbp
    ret

