.model small
.stack 100h
.data
    list db 6, 5, 4, 7, 8, 1, 2, 3, 9
    tb1 db 10, 13, 'Phan tu lon nhat: $'
    tb2 db 10, 13, 'Phan tu nho nhat: $'
.code
    main proc
        mov ax, @data
        mov ds, ax   
        
        lea dx, tb1
        mov ah, 9
        int 21h
        call TimMax   
        
        lea dx, tb2
        mov ah, 9
        int 21h
        call TimMin  
            
        mov ah, 4ch
        int 21h
    main endp   
    
    TimMax proc
        mov cx, 9
        lea si, list
        mov bl, [si]  
        
        Start1:
            lodsb
            cmp bl, al
            jge ByPass1
            mov bl, al 
        
        ByPass1: 
            loop Start1 
            
        add bl, '0'
        mov dl, bl
        mov ah, 2
        int 21h  
        ret
    TimMax endp   
    
    TimMin proc
        mov cx, 9
        lea si, list
        mov bl, [si]  
        
        Start2:
            lodsb
            cmp bl, al
            jle ByPass2
            mov bl, al 
        
        ByPass2: 
            loop Start2 
            
        add bl, '0'
        mov dl, bl
        mov ah, 2
        int 21h  
        ret
    TimMin endp 
end
               



