.model small
.stack 100h
.data
    tb1 db 10, 13, 'Nhap vao 1 so: $'
    tb2 db 10, 13, 'Giai thua: $'
    str db 50 dup('$')
      
    muoi dw 10
.code
    main proc
        mov ax, @data
        mov ds, ax 
        
        mov ah, 9
        lea dx, tb1
        int 21h
        
        mov ah, 10
        lea dx, str
        int 21h   
        
        mov ah, 9
        lea dx, tb2
        int 21h  
        
        mov ax, '#'
        push ax
        
        mov cl, [str + 1]
        lea si, str + 2
        mov ch, 0
        mov ax, 0
        mov bx, 10
        
        ThapPhan:
            mul bx
            mov dl, [si]
            sub dl, '0'
            add ax,dx
            inc si
            loop ThapPhan 
            
        mov bx, ax    
        dec bx
            
        GiaiThua:
            mul bx    
            dec bx
            cmp bx, 0
            jg GiaiThua  
            
        LapPush:  
            mov dx, 0
            div muoi
            add dx, '0'
            push dx
            cmp ax, 0
            jg LapPush               
                                         
        HienThi:
            pop dx
            cmp dx, '#'
            je Finish
            mov ah, 2
            int 21h
            loop HienThi
        
        Finish:
            mov ah, 4ch
            int 21h
    main endp
end



