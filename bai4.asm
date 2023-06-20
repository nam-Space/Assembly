.model small 
.stack 100
.data       
    tb1 db 10, 13, 'Nhap 1 ky tu: $'
    tb2 db 10, 13, 'Ky tu in hoa: $'
    tb3 db 10, 13, 'Ky tu in thuong: $'
    cha db ?   
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        lea dx, tb1
        mov ah, 9
        int 21h  
        
        mov ah, 1
        int 21h
        mov cha, al
        
        call InHoa  
        call InThuong
        
        mov ah, 4ch
        int 21h
    main endp
    
    InHoa proc    
        lea dx, tb2
        mov ah, 9
        int 21h
        
        mov dl, cha
        cmp dl, 'a'
        jl In1
        cmp dl, 'z'
        jg In1
        sub dl, 32
        
        In1:
            mov ah, 2
            int 21h   
            
        ret
    InHoa endp  
    
    InThuong proc   
        lea dx, tb3
        mov ah, 9
        int 21h
        
        mov dl, cha
        cmp dl, 'A'
        jl In2
        cmp dl, 'Z'
        jg In2
        add dl, 32
        
        In2:
            mov ah, 2
            int 21h   
            
        ret
    InThuong endp
end
            
        



