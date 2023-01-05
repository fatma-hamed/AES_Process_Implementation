
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

 Seperate Macro al 
   mov bl,al 
   and bl,00001111b
   mov bh,al
   rol bh,4
   and bh,00001111b
 ENDM 
 Addroundkey Macro 
    mov si,0 
nextcol:        mov di,0
    mov bp,si
nextelement:    mov al ,Array[bp]
    mov bl,key[bp]
    xor al,bl
    mov Array[bp],al
    add bp,4
    inc di 
    cmp di,4
    jnz nextelement
    add si,1
    cmp si,4
    jnz nextcol
    jmp finish
finish: 
    ENDM 
 Subbytes Macro bh bl 
    mov al, bh
    mov bh ,16
    mul bh
    add al,bl
    mov di,ax
    add bp,di                
    mov dl,[bp+1]
 ENDM
 Shiftrows Macro
     mov si,4
     mov al,1
     mov bp,3
loop3: mov bl,al
loop2: mov dl,Array[si]
       mov cl,Array[si+1] 
       mov Array[si],cl
       mov cl,Array[si+2]
       mov Array[si+1],cl  
       mov cl,Array[si+3]  
       mov Array[si+2],cl
       mov Array[si+3],dl 
       dec bl
       cmp bl,0
       jnz loop2
       add si,4
       inc al
       dec bp
       cmp bp,0
       jnz loop3
       jmp finish2 
finish2:
 ENDM 
 
 KeySchedule Macro
      mov al,Key[15] 
      mov NewKey[0],al
      
      mov al,,Key[3] 
      mov NewKey[12],al
       
      mov al,,Key[7] 
      mov NewKey[4],al
      
      mov al,,Key[11] 
      mov NewKey[8],al 
      
        mov cx,4
        mov si,0
back2:  lea bp,index
        mov al,NewKey[si]
        Seperate al
        Subbytes bh bl
        mov NewKey[si],dl
        add si,4
        loop back2 
        
      mov di,0 
      mov si,0
      mov cx,4
      add Rcon[0],1
back3:mov al,Rcon[si]
      mov bl,NewKey[di]
      mov dl,Key[di] 
      xor al,bl
      xor al,dl
      mov NewKey[di],al 
      inc si
      add di,4
      loop back3
      
       mov si,1 
       
nextcol2: mov cl,0
    mov bp,si
    mov bx,1
    add bx,si  
    mov di,0
nextelement3:   
 mov al ,Key[bp]
    mov dl,Newkey[di]
    xor al,dl
    mov NewKey[bp],al
    add bp,4 
    add di,4
    add bx,4
    inc cl 
    cmp cl,4
    jnz nextelement3
    add si,1
    cmp si,4
    jnz nextcol2
    jmp finish3
finish3: 
  
ENDM    
      
       
	.data segment  
	             buffer db 17,?, 17 dup(' ') 
	             msg2 db 'your data is',13,10,'$' 
	             Array db 16 dup('0') 
	             msg1 db 'Please enter the data you want to encrypt and press enter at the end',13,10,'  ',13,10,'$'  
	             index db 0 
	             sbox db 63h,7Ch,77h,7Bh,0f2h,6Bh,6Fh,0C5h,30h,01h,67h,2Bh,0FEh,0D7h,0ABh,76h,0CAh,82h,0C9h,7Dh,0FAh,59h,47h,0F0h,0ADh,0D4h,0A2h,0AFh,9Ch,0A4h,72h,0C0h,0B7h,0FDh,93h,26h,36h,3Fh,0F7h,0CCh,34h,0A5h,0E5h,0F1h,71h,0D8h,31h,15h,04h,0C7h,23h,0C3h,18h,96h,05h,9Ah,07h,12h,80h,0E2h,0EBh,27h,0B2h,75h,09h,83h,2Ch,1Ah,1Bh,6Eh,5Ah,0A0h,52h,3Bh,0D6h,0B3h,29h,0E3h,2Fh,84h,53h,0D1h,00h,0EDh,20h,0FCh,0B1h,5Bh,6Ah,0CBh,0BEh,39h,4Ah,4Ch,58h,0CFh,0D0h,0EFh,0AAh,0FBh,43h,4Dh,33h,85h,45h,0F9h,02h,7Fh,50h,3Ch,9Fh,0A8h,51h,0A3h,40h,8Fh,92h,9Dh,38h,0F5h,0BCh,0B6h,0DAh,21h,10h,0FFh,0F3h,0D2h,0CDh,0Ch,13h,0ECh,5Fh,97h,44h,17h,0C4h,0A7h,7Eh,3Dh,64h,5Dh,19h,73h,60h,81h,4Fh,0DCh,22h,2Ah,90h,88h,46h,0EEh,0B8h,14h,0DEh,5Eh,0Bh,0DBh,0E0h,32h,3Ah,0Ah,49h,06h,24h,5Ch,0C2h,0D3h,0ACh,62h,91h,95h,0E4h,79h,0E7h,0C8h,37h,6Dh,8Dh,0D5h,4Eh,0A9h,6Ch,56h,0F4h,0EAh,65h,7Ah,0AEh,08h,0BAh,78h,25h,2Eh,1Ch,0A6h,0B4h,0C6h,0E8h,0DDh,74h,1Fh,4Bh,0BDh,8Bh,8Ah,70h,3Eh,0B5h,66h,48h,03h,0f6h,0Eh,61h,35h,57h,0B9h,86h,0C1h,1Dh,9Eh,0E1h,0F8h,98h,11h,69h,0D9h,8Eh,94h
	             comp db 99h,1Eh,87h,0E9h,0CEh,55h,28h,0DFh,8Ch,0A1h,89h,0Dh,0BFh,0E6h,42h,68h,41h,99h,2Dh,0Fh,0B0h,54h,0BBh,16h
	             key db 16 dup(0FFh) 
	             NewKey db 16 dup(00h)
	             Rcon db 4 dup(00h)
	            
	.code segment 
	    call Inputuser
	    call Printinput 
	    mov bp,0 ;array
	    mov ax,2 ;buffer 
back:   mov di,si
        Add di,ax
        mov cx,[di]
        mov Array[bp],cl
	    inc bp
	    mov Array[bp],ch
	    Add ax,1
	    cmp bx,bp
	    jnz back 
	    mov al,'0'
        mov array[bx],al  
         keyschedule
       ; Shiftrows 
        ;Addroundkey
        mov cx,16
        mov si,0
back4:  lea bp,index
        mov al,Array[si]
        Seperate al
        Subbytes bh bl
        mov Array[si],dl
        inc si
        loop back4 
        
            
	            ret 
	            
	Inputuser proc 
	      mov dx, offset msg1
		mov ah, 9
		int 21h
		mov dx, offset buffer
		mov ah, 0ah
		int 21h 
		lea si,buffer
		;jmp print  
		
        ret 
	ENDP
	Printinput proc
		print:
		xor bx, bx
		mov bl, buffer[1] 
		 mov dx, offset msg2
		mov ah, 9
		int 21h
		mov buffer[bx+2], '$'
		mov dx, offset buffer + 2
		mov ah, 9
		int 21h
		ret 
	ENDP


ret  




