.model small
.stack 100
.data
    tb db 10, 13, 'So da nhap sang dang nhi phan: $'
    str db 100 dup('$')
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ax, '#'
        push ax
        
        mov ah, 10
        lea dx, str
        int 21h
        
        mov cl, [str + 1]
        mov ch, 0
        lea si, str + 2
        mov ax, 0
        mov bx, 10
        
        ThapPhan:
            mul bx
            mov dl, [si]
            sub dl, '0'
            add ax, dx
            inc si
            loop ThapPhan
            
        mov bx, 2 ;he so chia
        NhiPhan:
            mov dx, 0 ;du
            div bx
            push dx ;day ax vao ngan xep (al + ah) hay (thuong + du) 
            cmp ax, 0 ;thuong
            jne NhiPhan  
            
        mov ah, 9
        lea dx, tb
        int 21h     
        
        InRa:
            pop dx
            cmp dl, '#'
            je Done
            add dl, '0'
            mov ah, 2
            int 21h  
            jmp InRa
            
        Done:
            mov ah, 4ch
            int 21h
    main endp
end


