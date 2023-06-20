.model small
.stack 100h
.data
    tb1 db 10, 13, 'Nhap vao gia tri a: $'  
    tb2 db 10, 13, 'Nhap vao gia tri b: $'
    tb3 db 10, 13, 'UCLN: $'
    tb4 db 10, 13, 'BCNN: $'
    a db 50 dup('$')
    b db 50 dup('$')  
    var1 dw ?
    var2 dw ?          
    ucln dw ?
    
    muoi dw 10
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 9
        lea dx, tb1
        int 21h   
        
        mov ah, 10
        lea dx, a
        int 21h   
        mov cl, [a + 1]  
        lea si, a + 2
        mov ch, 0 
        mov ax, 0   
        mov bx, 10   
        
        tinhThapPhan:
            mul bx  
            mov dl, [si]
            sub dl, '0'
            add ax, dx
            inc si 
            loop tinhThapPhan               
            
        mov var1, ax
            
        mov ah, 9
        lea dx, tb2
        int 21h
        
        mov ah, 10
        lea dx, b
        int 21h    
        mov cl, [b + 1]  
        lea si, b + 2  
        mov ch, 0 
        mov ax, 0   
        mov bx, 10 
        
        tinhThapPhan2:                     
            mul bx  
            mov dl, [si]
            sub dl, '0'
            add ax, dx
            inc si 
            loop tinhThapPhan2  
               
        mov var2, ax       
        
        mov ax, '#'
        push ax  
        
        mov ax, var1  
        mov bx, var2  
        
        tinhUCLN:
            cmp ax, bx
            je in1
            cmp ax, bx 
            jg truAB   
            cmp ax, bx
            jl truBA  
            
            truAB:
                sub ax, bx 
                loop tinhUCLN 
            truBA:
                sub bx, ax
                loop tinhUCLN 
            in1:
                mov ah, 9
                lea dx, tb3
                int 21h   
                
                mov ax, bx 
                mov ucln, bx  
                
                dayStack:  
                    mov dx, 0
                    div muoi 
                    add dx, '0'
                    push dx
                    cmp ax, 0
                    jg dayStack 
                
                inRa:
                    pop dx
                    cmp dx, '#'
                    je tinhBCNN    
                    mov ah, 2
                    int 21h             
                    loop InRa  
            
        tinhBCNN: 
                mov ah, 9
                lea dx, tb4
                int 21h  
                
                mov ax, '#'
                push ax    
                mov ax, var1  
                mov bx, var2
                mul bx
                div ucln 
                
                dayStack2:  
                    mov dx, 0
                    div muoi 
                    add dx, '0'
                    push dx
                    cmp ax, 0
                    jg dayStack2 
                
                inRa2:
                    pop dx
                    cmp dx, '#'
                    je ketThuc    
                    mov ah, 2
                    int 21h    
                    loop InRa2
         
        ketThuc:       
            mov ah, 4ch
            int 21h 
    main endp  
end


