.model small
.stack 100h
.data       
    tb1 db 10, 13, 'Nhap vao 1 so nguyen: $'
    tb2 db 10, 13, 'So sang he 16 la: $'
    str db 50 dup('$')
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ax, '#'
        push ax   
        
        mov ah, 9
        lea dx, tb1
        int 21h
        
        mov ah, 10
        lea dx, str
        int 21h   
        
        mov ah, 9
        lea dx, tb2
        int 21h
        
        mov cl, str + 1
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
            
        call printNum16
        mov ah, 4ch
        int 21h    
    main endp
    
    printNum16 proc
        mov bx, 16
        mov cx, 0
        
        hexa:  
            mov dx, 0
            div bx
            push dx
            inc cx
            cmp ax, 0
            je ketQua
            jmp hexa
       
        ketQua:
            inkt:
                pop dx
                cmp dx, 10
                je hex_a
                cmp dx, 11
                je hex_b
                cmp dx, 12
                je hex_c
                cmp dx, 13
                je hex_d
                cmp dx, 14
                je hex_e
                cmp dx, 15
                je hex_f
                
                add dx, '0'
                jmp print 
                
            hex_a:
                mov dx, 'A'
                jmp print
            hex_b:
                mov dx, 'B'
                jmp print
            hex_c:
                mov dx, 'C'
                jmp print
            hex_d:
                mov dx, 'D'
                jmp print
            hex_e:
                mov dx, 'E'
                jmp print
            hex_f:
                mov dx, 'F'
                jmp print 
                
            print:
                mov ah, 2
                int 21h
                loop inkt
             
        ret
    printNum16 endp
end
        
            
                
            

