.model small
.stack 100h
.data
    crlf db 13, 10, '*'
    msg db 'hello world!$'
.code 
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 9
        lea dx, crlf
        int 21h
        
        mov ah, 9
        lea dx, msg
        int 21h
        
        mov ah, 4ch
        int 21h
    main endp
end Main




