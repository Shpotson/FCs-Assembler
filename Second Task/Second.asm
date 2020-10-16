%include "io.inc"

section .bss 
    ; Инициализация индексатора и двух массивов
    N resd 1
    arr_A resd 500000
    arr_B resd 250000

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    GET_DEC 4, N
    
    mov ecx, 0
; Получаем массив A на вход
.get_A:
    GET_DEC 4, [arr_A + 4*ecx]
    inc ecx
    cmp ecx, dword[N]
    jne .get_A
    
    ; Очищаем
    mov eax, 0
    mov ebx, 0
; Заполняем массив B
.make_B:
    mov edx, 1
    and edx, [arr_A + 4*eax]
    cmp edx, 1
    je .add_B
    inc eax
    cmp eax, dword[N]
    jl .make_B
    cmp eax, dword[N]
    je .end
.add_B:
    mov edx, [arr_A + 4*eax]
    mov [arr_B + 4*ebx], edx
    inc eax
    inc ebx
    cmp eax, dword[N]
    jl .make_B
.end:    
    mov ecx, 0
    
; Выводим массив B
.print_B:
    PRINT_DEC 4, [arr_B + 4*ecx]
    inc ecx
    cmp ecx, ebx
    jl .print_B
    
    xor eax, eax
    ret