; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    dec     edx

    ;; Se itereaza prin toate zilele de nastere decrementand edx
forloop:
    mov     eax, dword [esi + my_date.year] ; in eax este retinut anul curent

    ;; Se compara anul curent cu anul naterii fiecarei persoane
    cmp     eax, dword [edi + my_date_size * edx + my_date.year]
    jle     yearsold0

    ;; Diferenta anilor
    sub     eax, dword [edi + my_date_size * edx + my_date.year]

    mov     bx, word [esi + my_date.month] ; in bx se retine luna curenta
    cmp     bx, word [edi + my_date_size * edx + my_date.month]
    jl      oneyearless
    je      verifica_ziua

    mov     dword [ecx + edx * 4], eax
    ;; Daca edx < 0 dupa decrementare, atunci se ajunge la end_program
    dec     edx
    jns     forloop
    jmp     end_program

yearsold0:
    ;; Daca anul curent este mai mare sau egal cu anul nasterii unei persoane,
    ;; atunci varsta va fi 0
    mov     dword [ecx + edx * 4], 0
    ;; Daca edx < 0 dupa decrementare, atunci se ajunge la end_program
    dec     edx
    jns     forloop
    jmp     end_program

oneyearless:
    ;; Daca diferenta de ani (intre anul curent si anul nasterii) este x, dar
    ;; persoana respectiva inca nu si-a serbat ziua :( in anul curent
    dec     eax
    mov     dword [ecx + edx * 4], eax
    ;; Daca edx < 0 dupa decrementare, atunci se ajunge la end_program
    dec     edx
    jns     forloop
    jmp     end_program

verifica_ziua:
    mov     bx, word [esi + my_date.day] ; in bx se retine ziua curenta
    cmp     bx, word [edi + my_date_size * edx + my_date.day]
    jl      oneyearless

    ;; Daca ziua este mai mare sau egala cu ziua curenta:
    mov     dword [ecx + edx * 4], eax
    ;; Daca edx < 0 dupa decrementare, atunci se ajunge la end_program
    dec     edx
    jns     forloop

end_program:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
