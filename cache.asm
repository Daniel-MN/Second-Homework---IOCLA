;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .text
    global load

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; address of reg
    mov     ebx, [ebp + 12] ; tags
    mov     ecx, [ebp + 16] ; cache
    mov     edx, [ebp + 20] ; address
    mov     edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE


    ;; Calcularea tagului si retinerea acestuia in eax pentru
    ;; viitoare comparatii:
    push    eax
    mov     eax, edx
    shr     eax, OFFSET_BITS

    ;; esi se foloseste ca intereator prin liniile din tags:
    mov     esi, CACHE_LINES
    dec     esi

    ;; Se verifica daca tagul se afla in lista de taguri si se retine
    ;; in esi indicele la care se afla
search_tag:
    cmp     eax, dword [ebx + esi * 4]
    je      CACHE_HIT
    dec     esi
    jns     search_tag

 

CACHE_MISS:
    ;; Se pune in tags pe linia to_replace tagul in caz de CACHE_MISS
    mov     dword [ebx + edi * 4], eax

    ;; In eax obtin adresa primul octet ce trebuie pus in cache
    shl     eax, OFFSET_BITS

    ;; Se muta 4 octeti de la adresa de la adresa eax in cache la 
    ;; linia edi(to_replace) din cache:
    mov     esi, dword [eax]
    mov     dword [ecx + edi * CACHE_LINE_SIZE], esi

    ;; Se muta urmatorii 4 octeti, care se afla la adresa eax + 4, in cache
    ;; la linia edi din cache:
    mov     esi, dword [eax + 4]
    mov     dword [ecx + edi * CACHE_LINE_SIZE + 4], esi

    ;; Daca s-a ajuns in CACHE_MISS atunci linia de la care trebuie luat octetul
    ;; din cache este edi(to_replace):
    mov     esi, edi

CACHE_HIT:
    ;; Octetul ce trebuie pus in reg este:
    ;; cache[indice din tags][offset]
    ;; indicele din tags este esi, care va fi fie to_replace(CACHE_MISS),
    ;; fie indicele din tags
    lea     eax, [ecx + esi * CACHE_LINE_SIZE]

    ;; Calcularea offsetului si retinerea acestuia in esi:
    mov     esi, 111b
    and     esi, edx

    ;; Obtinerea octetului din cache si punerea acestuia in reg
    mov     dl, byte [eax + esi]
    pop     eax
    mov     byte [eax], dl
    
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


