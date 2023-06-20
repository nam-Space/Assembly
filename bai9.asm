.model small
.stack 100h
.data
    crlf db 10, 13, '$'
    begmsg db 'Input a binary number: $'
    errmsg db 'You have entered wrong number!$'
    endmsg db 'The hex number is: $'
    x dw ?
    y dw ?
    divi dw 16
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        begin:
            mov ah, 9
            lea dx, begmsg
            int 21h
            mov cl, 7
            mov x, 0
            mov y, 0
            mov bx, 2
            
        inputting:
            cmp cl, -1
            je inputted
            mov ah, 1
            int 21h
            cmp al, '#'
            je inputted
            cmp al, '0'
            jl error
            cmp al, '1'
            jg error
            
            sub al, '0'
            mov ah, 0
            mov y, ax
            
            mov ax, x
            mul bx
            add ax, y
            
            mov x, ax
            dec cl
            jmp inputting
            
            error:
                mov ah, 9
                lea dx, crlf
                int 21h
                lea dx, errmsg
                int 21h
                lea dx, crlf
                int 21h
                jmp begin
                
            inputted:
                mov bx, x
                mov ah, 9
                lea dx, crlf
                int 21h
                lea dx, endmsg
                int 21h
                mov ax, x
                jmp dectohex
                
            dectohex:
                mov cx, 0
                for:
                    mov dx, 0
                    div divi
                    push dx
                    inc cx
                    cmp ax, 0
                    jg for
                    
                print:
                    pop dx
                    cmp dl, 10
                    jl case1
                    jge case2
                    case1:
                        add dl, '0'
                        jmp break
                    case2:
                        sub dl, 10    
                        add dl, 'A'
                    break:
                        mov ah, 2
                        int 21h
                    loop print
        mov ah, 4ch
        int 21h     
    main endp
end