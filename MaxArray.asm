
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data segment
    Array DB 5,2,1,9,3
    Max DB 0
.code segment 
    MOV Al,Max
    MOV SI,0
L1: MOV Al,Array[SI]
L2: INC SI
    CMP SI,5
    JZ  end
    CMP Al,Array[SI]
    JS  L1
    JMP L2
end: ret    




