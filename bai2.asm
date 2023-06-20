.model small
.stack
.data
    Tbao1 db "Hay nhap 1 ky tu: $"
    Tbao2 db 13, 10, "Ky tu da nhap: $"
    output db ?
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        lea dx, Tbao1
        mov ah, 9
        int 21h
        
        mov ah, 1
        int 21h               
        mov output, al
        
        lea dx, Tbao2
        mov ah, 9
        int 21h
        
        mov ah, 2
        mov dl, output
        int 21h
        
        mov ah, 4ch
        int 21h
    main endp
End