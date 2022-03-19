section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov     edi, [ebp + 8]   ;key
    mov     esi, [ebp + 12]  ;haystack
    mov     ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    xor     eax, eax ; itereaza prin vectorul de ordine al coloanelor
    xor     ecx, ecx ; itereaza prin ciphertext
for_each_column:
    ;; edx itereaza prin elementele dintr-o coloana
    mov     edx, dword [edi + eax * 4]

for_each_ch_from_column:
    ;; Verificarea daca exista un caracter in matrice(in stringul haystack)
    ;; la pozitia edx (verificarea daca s-a ajuns la capatul coloanei):
    cmp     edx, dword [len_haystack]
    jl      construct_ciphertext

    ;; Daca s-a ajuns la capatul coloanei, atunci se trece la urmatoarea
    ;; coloana din vectorul de ordine
    inc     eax
    ;; Verificarea daca s-a ajuns la capatul vectorului de coloane:
    cmp     eax, dword [len_cheie]
    jl      for_each_column
    ;; Daca a fost criptat tot mesajul(a fost parcursa matricea),
    ;; atunci programul se termina
    jmp     end_program

construct_ciphertext:
    push    eax
    ;; Copierea caracterului din matrice(stringul haystack) in cyphertext
    mov     al, byte [esi + edx]
    mov     byte [ebx + ecx], al
    ;; Se incrementeaza ecx pentru urmatorul caracter ce trebuie pus in
    ;; cyphertext:
    inc     ecx
    pop     eax
    ;; Se trece la urmatorul caracter din coloana:
    add     edx, dword [len_cheie]
    jmp     for_each_ch_from_column
    
end_program:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY