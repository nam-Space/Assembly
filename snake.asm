
data segment
    food_x db 0; luu vi tri cot cua thuc an
    food_y db 0  ; luu vi tri hang cua thuc an
    main1 db "Nhom 16 lop thay truong"
    main2 db "An 7 vien do an de chien thang:"
    main3 db "An de thang"
    main4 db "Di chuyen ran bang cac nut w,a,s,d"
    main5 db "w:di len"
    main6 db "s:di xuong"
    main7 db "d:sang phai"
    main8 db "a:sang trai"
    main9 db "Dau ran hien thi la D o giua man hinh"
    main10 db "Go phim bat ki de tiep tuc..."
    hlths db "Lives:",3,3,3     ;hien thi mang cua ran
    letnum db 7 ;so luong food an duoc 
    fin db 7 ;theo doi so luong food 
    hlth db 6 ;/2 ;dem so mang con lai         
    sadd dw 07D2h,10 Dup(0) ; dia chi dau ran 
    snake db 'D',10 Dup(0) ;mang luu ran
    snakel db 1 ;do dai cua ran 
    etadd dw    0  ; vi tri cua food cuoi cung truoc khi 
    letadd dw  09b4h   ; vi tri cua food dau tien
    dletadd dw  09b4h  ; luu lai de restart game
    left equ 2 ; vien trai 
    top equ 3 ; vien tren 
    
    point dw  '1'  ; so diem
    poin db 'point: '
    gmwin db "Ban da thang"      ; hien thi win 
    gmov db "Ban da thua"      ; hien thi thua
    endtxt db "Nhan esc de thoat"   ; thoat game sau khi choi
    
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    mov ax,0b800h  ; truy xuat vao es
    mov es, ax 
    
    cld ; xoa cac co huong
    
    
    ; xoa con tro van ban
    mov ah,1
    mov ch,2bh
    mov cl,0bh
    int 10h  
    
    call main_menu  ; goi ham hien thi
    
    startag:
    
    call bild ; ke vien 
    
    xor cl,cl 
    xor dl,dl ; xoa cac gia tri ban cua cl,dl
    
    read: ;doc cac gia tri vao  
    
    mov ah,1
    int 16H   ; kiem tra bo dem cua ban phim 
    
    jz s1
    mov ah,0
    int 16H
    and al,0dfh 
    mov dl,al
    jmp s1
    
    s1: ;check if esc button is pressed
    cmp dl,1bh
    je ext
    
    left:
    cmp dl,'A'
    jne right
    call ml
    jmp read
    
    right:
    cmp dl,'D'
    jne up
    call mr
    jmp read
    
    up:
    cmp dl,'W'
    jne down
    call mu 
    jmp read
    
    down:
    cmp dl,'S'
    jne read
    call md
    jmp read
    
    
    ext:
    xor cx,cx
    mov dh,24
    mov dl,79
    mov bh,7
    mov ax,700h
    int 10h 
    
    mov ax, 4ch 
    int 21h    
ends 


main_menu proc
    
    mov di,186h
    lea si,main1
    mov cx,23
    lopem1:
    movsb 
    inc di
    loop lopem1
    
    mov di,33Eh
    lea si,main2
    mov cx,31
    lopem2:
    movsb 
    inc di
    loop lopem2
    
    mov di,3DEh
    lea si,main3
    mov cx,11
    lopem3:
    movsb 
    inc di
    loop lopem3
    
    mov di,47Eh
    lea si,main4
    mov cx,34
    lopem4:
    movsb 
    inc di
    loop lopem4
    
    mov di,5dch
    lea si,main5
    mov cx,8
    lopem5:
    movsb 
    inc di
    loop lopem5
    
    mov di,67ch
    lea si,main6
    mov cx,10
    lopem6:
    movsb 
    inc di
    loop lopem6
    
    mov di,71ch
    lea si,main7
    mov cx,11
    lopem7:
    movsb 
    inc di
    loop lopem7
    
    mov di,7bch
    lea si,main8
    mov cx,11
    lopem8:
    movsb 
    inc di
    loop lopem8
    
    mov di,0ABEh
    lea si,main9
    mov cx,38
    lopem9:
    movsb 
    inc di
    loop lopem9
    
    mov di,0b5Eh
    lea si,main10
    mov cx,26
    lopem10:
    movsb 
    inc di
    loop lopem10
    
    
    
       
    mov ah,7
    int 21h
    
    call clearall
    
    
ret
endp    
 
bild proc ;is for placing borders and set chracters on the screen
   
    call border 
    
    lea si,hlths
    mov di,0
    mov cx,9
    loph:
    movsb 
    inc di
    loop loph
    
    lea si,poin 
    mov di,88h
    mov cx,7 
    loph1:
    movsb 
    inc di
    loop loph1  
    
    lea si, point
    movsb 
    
    xor dx,dx
    mov di,sadd
    mov dl,snake 
    es: mov [di],dl  
    ;Place chracters in game screen
    es: mov [09b4h],'*'
    
    ret
endp  

;snake move:
;left:
ml proc ;snake move left function
    push dx 
    call shift_addrs
    sub sadd,2
    
    call eat
    
    call move_snake
    pop dx
ret    
endp
;right:
mr proc ;snake move right function
    push dx 
    call shift_addrs
    add sadd,2
    
    call eat
    
    call move_snake 
    
    pop dx
    
ret    
endp
;up:
mu proc ;snake move up function
    push dx 
    call shift_addrs
    sub sadd,160
    
    call eat
    
    call move_snake
    pop dx
ret    
endp
;down:
md proc ;snake move down function
    push dx 
    call shift_addrs
    add sadd,160
    
    call eat
    
    call move_snake
    pop dx
ret    
endp

shift_addrs proc
    push ax
    xor ch,ch
    xor bh,bh
    mov cl,snakel
    inc cl
    mov al,2
    mul cl
    mov bl,al
    
    xor dx,dx
    
    shiftsnake:
    mov dx,sadd[bx-2]
    mov sadd[bx],dx
    sub bx,2
    loop shiftsnake:
pop ax
ret     
endp  
check_body proc
    
    xor ch,ch
    xor bh,bh
    mov cl,snakel
    mov al,2
    mul cl
    mov bl,al 
   
     
    check_body_continue:
    cmp dx,sadd[bx]
    jne check 
    mov ax,1 
    mov cx,1
    check: 
    sub bx,2
    loop check_body_continue

ret 
endp
eat proc ;to check if the snake hit a letter or not and add it to the snake
    push ax 
    push cx   
 
    mov ax, 0  
    mov dx, sadd
    call check_body
    cmp ax, 1
    jz wallk
    
    mov di,sadd 
    es: cmp [di],0 
    jz no
    es: cmp [di],20h
    jz wall 

    es: cmp [di],'*'    
    jz addf
    jmp wall
    addf:
    xor bh,bh
    mov bl,snakel
    mov snake[bx], '*'
    add snakel,1  
    call print_food
    sub fin,1
    inc point
    lea si,poin 
    mov di,88h
    mov cx,7 
    lop:
    movsb 
    inc di
    loop lop  
    
    lea si, point
    movsb 
     
    mov dl,7
    mov ah,2
    int 21h 
    
    cmp fin,0 
    jz win
    jmp no
    wall:
    cmp di,320
    jle wallk
    cmp di,3840
    jge wallk
    mov ax,di
    mov bl,160
    div bl
    cmp ah,0
    je wallk
    cmp ah,158  
    je wallk
    jmp no
    wallk:
    xor bh,bh
    mov bl,hlth
    es: mov [bx+10],0
    mov hlths[bx+2],0
    sub hlth,2
    cmp hlth,0
    jne rest
    pop cx
    pop ax
    call game_over 
    rest: 
    pop cx
    pop ax
    call restart
     
    no:
    pop cx
    pop ax
ret
endp      
print_food: proc; prints food after prev food was eaten according to food_x and food_y values  
    mov ch, food_y
    mov cl, food_x
regenerate:

    mov ah, 00
    int 1Ah
  
    mov ax, dx 
    push dx
    xor dx, dx
    xor bh, bh
    mov bl, 20
    div bx
    mov food_y, dl 
    add food_y, 4
    
    
    pop dx
    mov ax,dx
    mov bl,77 
    dec dl
    xor bh, bh
    xor dx, dx
    div bx
    mov food_x, dl
    inc food_x
    
    cmp food_x, cl
    jne nevermind
    cmp food_y, ch
    jne nevermind
    jmp regenerate             
nevermind:
    call check_cover 
    cmp ax,1
    je regenerate 
    
    mov ah,2
    mov bh,0
    mov dh, food_y
    mov dl, food_x  
    mov etadd, dx
    int 10h
     
    mov ah,9
    mov al,'*'
    mov bh,0
    mov bl,7
    mov cx,1
    int 10h

  ret
   
endp     
check_cover proc ; checks if the snake covers the cordinate (x=al,y=ah). is so dl=1 else dl=0     
  lea di,snake 
  mov ax, 0 
  mov cl,snakel
        check_cover_loop:  
          cmp es:[di],dx 
          jnz check_cover_continue
          mov ax,1    ; cover found 
          mov cx,1 
          check_cover_continue:                                 
          add di, 1 
        loop check_cover_loop  
  ret  
endp
move_snake proc
    xor ch,ch
    xor si,si
    xor dl,dl
    mov cl,snakel
    xor bx,bx
    l1mr:
    mov di,sadd[si]
    mov dl,snake[bx]
    es: mov [di],dl
    add si,2
    inc bx
    loop l1mr
    mov di,sadd[si] 
    es:mov [di],0
ret
endp

border proc ;build borders function
    mov ah,0
    mov al,3
    int 10h
    
    mov ah,6
    mov al,0 
    mov bh,0ffh 
    
    mov ch,1
    mov cl,0
    mov dh,1
    mov dl,80
    int 10h
  
    mov ch,3
    mov cl,0
    mov dh,24
    mov dl,0
    int 10h
   
    mov ch,24
    mov cl,0
    mov dh,24
    mov dl,79
    int 10h
    
    mov ch,1
    mov cl,79
    mov dh,24
    mov dl,79
    int 10h

ret
endp

restart proc
    xor ch,ch  
    xor si,si
    mov cl,snakel
    inc cl
    delt: 
    mov di,sadd[si]
    es:mov [di],0
    add si,2
    loop delt
    mov dx,etadd
    mov ah,2
    mov bh,0
    int 10h
     
    mov ah,9
    mov al,0 
    mov bh,0
    mov bl,7
    mov cx,1
    int 10h  
    mov fin,7
    mov point,'1' 
    lea si,poin 
    mov di,88h
    mov cx,7 
    lop1:
    movsb 
    inc di
    loop lop1  

    mov sadd,07D2h
    mov cl,snakel
    inc cl
    xor si,si
    inc si
    xor di,di
    add di,2
    emptsn:
    mov snake[si],0
    mov sadd[di],0
    add di,2
    inc si
    loop emptsn
    mov snakel,1
    
    xor ch,ch
    mov cl,letnum
    xor si,si
    reslet:
    mov bx,dletadd
    mov letadd,bx
    add si,2
    add bx,2
    loop reslet      
    xor si,si
    mov snake[si],'D'

    jmp startag

endp


win proc 
    call clearall
     
    mov di,7cah
    lea si,gmwin
    mov cx,12
    lope1w:
    movsb 
    inc di
    loop lope1w
    
    mov di,862h
    lea si,endtxt
    mov cx,17
    lope2:
    movsb 
    inc di
    loop lope2
    
    qwer1:         
    mov ah,7
    int 21h
    cmp al,1bh         
    jz ext
    jmp qwer1
    
    ret
    endp
game_over proc
    call clearall
  
    mov di,7c8h
    lea si,gmov
    mov cx,11
    lope1:
    movsb 
    inc di
    loop lope1
    
    mov di,862h
    lea si,endtxt
    mov cx,17 
    lope2w:
    movsb 
    inc di
    loop lope2w 
    
    qwer:         
    mov ah,7
    int 21h
    cmp al,1bh         
    jz ext
    jmp qwer
    
endp

clearall proc
    
    xor cx,cx
    mov dh,24
    mov dl,79
    mov bh,7
    mov al,00h
    mov ah, 07h 
    int 10h 
    
ret
endp    

    
end start ; set entry point and stop the assembler.

