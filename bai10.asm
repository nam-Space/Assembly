.model small
.stack 100h
.data
    tb1 db 10, 13, 'Nhap vao 1 chuoi: $'
    tb2 db 10, 13, 'Tong chieu dai cua chuoi: $'
    str db 100 dup('$')
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        lea dx, tb1
        mov ah, 9
        int 21h
        
        lea dx, str
        mov ah, 10
        int 21h
        
        lea dx, tb2
        mov ah, 9
        int 21h
        
        mov ax, 0
        mov al, str + 1
        mov cx, 0
        mov bx, 10
        
        Lapdem1:
            mov dx, 0
            div bx
            push dx
            inc cx
            cmp ax, 0
            jnz Lapdem1
            
        Lapdem2:
            pop dx 
            add dx, '0'
            mov ah, 2
            int 21h
            loop Lapdem2
            
        mov ah, 4ch
        int 21h
    main endp
end




