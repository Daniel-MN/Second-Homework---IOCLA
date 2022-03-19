section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    xor     ebx, ebx ; ebx = 0;
    ;; Am folosit registrul ebx ca un iterator de la 0 la len-1
forloop:
    ;; Se calculeaza caracter cu caracter folosind formula din enunt 
    ;; in al
    mov     al, byte [esi + ebx]
    xor     al, byte [edi + ecx - 1]
    
    ;; Valoarea calculata este pusa in ciphertext
    mov     byte [edx + ebx], al
    inc     ebx

    loop    forloop

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY