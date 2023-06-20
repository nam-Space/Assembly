.model small
.stack 100h
.data
    str db 50 dup('$')
    tb db 10, 13, 'Nhap 1 chuoi: $'   
    tb2 db 10, 13, 'Chuoi dao nguoc la: $'
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        lea dx, tb
        mov ah, 9
        int 21h     
        
        mov cx, 0
        
        Start:
            inc cx
            mov ah, 1
            int 21h
            cmp al, '#'
            je Pro
            push ax
            jmp Start   
            
         
        Pro:    
            lea dx, tb2
            mov ah, 9
            int 21h  
            jmp In1
            
        In1:    
            mov ah, 2
            mov dl, 0; nhap dau cach   
            int 21h
            
            dec cx
            pop dx
            mov ah, 2
            int 21h
            
            cmp cx, 1
            jne In1
            
        mov ah, 4ch
        int 21h
    main endp
end
            



