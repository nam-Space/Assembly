.model small
.stack 100
.data
    str db 100 dup('$')
    tb1 db 10, 13, 'Nhap 1 chuoi xau: $'
    tb2 db 10, 13, '$' 
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
        
        lea si, str + 2   
        mov cx, 0 
        
        Lap:    
            push [si] 
            inc cx
            inc si 
            cmp [si], '$' 
            jne loop Lap  
            jmp Print
              
        Print:  
            mov ah, 9  
            lea dx, tb2
            int 21h  
            jmp Lap2
                    
        Lap2:  
            dec cx         
            pop dx 
            mov ah, 2
            int 21h  
              
            cmp cx, 0
            jnz loop Lap2                    
            
        mov ah, 4ch
        int 21h
    main endp
end



