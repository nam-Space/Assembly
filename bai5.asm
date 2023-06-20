.model small
.stack 100h
.data
    str db 256 dup('$') 
    tb db 10, 13, 'Nhap 1 chuoi bat ky: $'
    tb1 db 10, 13, 'Chuyen sang chuoi in thuong: $'
    tb2 db 10, 13, 'Chuyen sang chuoi in hoa: $'     
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        lea dx, tb
        mov ah, 9
        int 21h
        
        lea dx, str
        mov ah, 10
        int 21h
        
        mov ah, 9
        lea dx, tb1
        int 21h
        call inThuong
        
        mov ah, 9
        lea dx, tb2
        int 21h
        call inHoa
        
        mov ah, 4ch
        int 21h
    main endp
    
    inThuong proc
        lea si, str + 2
        Lap1: 
            mov dl, [si]
            cmp dl, 'A'
            jl In1
            cmp dl, 'Z'
            jg In1
            add dl, 32
        In1:
            mov ah, 2
            int 21h
            inc si
            cmp [si], '$'
            jne Lap1
        ret
    inThuong endp
    
    inHoa proc
        lea si, str + 2
        Lap2:
            mov dl, [si]
            cmp dl, 'a'
            jl in2
            cmp dl, 'z'
            jg in2
            sub dl, 32
        In2:
            mov ah, 2
            int 21h
            inc si
            cmp [si], '$'
            jne Lap2
        ret
    inHoa endp
end

