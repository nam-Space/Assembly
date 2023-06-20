.Model Small
.Stack 100
.Data
    CRLF DB 13, 10, '$'
    ChaoTay DB 'hello!$'
    ChaoTa DB 'Chaoban!$'
.Code
MAIN Proc
    MOV AX, @Data
    MOV DS, AX
    
    MOV AH, 9
    
    LEA DX, ChaoTay
    INT 21H
    
    LEA DX, CRLF
    INT 21H
    
    LEA DX, ChaoTa
    INT 21H
    
    MOV AH, 4CH
    INT 21H
MAIN Endp
END MAIN