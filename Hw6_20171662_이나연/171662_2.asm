INCLUDE irvine32.inc

.data
INCLUDE hw6_2.inc
msg BYTE "Position Value : ", 0
compare DWORD 0

.code
;----------------------------------------------------------------------------------
Str_find PROC,
ptarget : PTR BYTE,
psource : PTR BYTE

mov esi, psource
mov edi, ptarget
mov ebx, compare
mov eax, 0
mov edx, 0
mov ecx, LENGTHOF source
dec ecx

L1:
	mov al, [esi]
	mov dl, [edi]
	add pos, 1
	cmp al, dl
	je L2
	add esi, 1
	cmp al, 0
	jne L1
	jmp L4
L2:
	add esi, 1
	add edi, 1
	mov al, [esi]
	mov dl, [edi]
	add ebx, 1
	cmp al, dl
	je L2
	cmp ebx, ecx
	je L3
	mov edi, ptarget 
	jmp L1
L3:
	mov eax, pos
	sub eax, 1
	mov edx,OFFSET msg
	call WriteString
	call WriteDec
	call crlf
L4:
	ret
Str_find ENDP
;------------------------------------------

main PROC
mov pos, 0
INVOKE Str_find, ADDR source, ADDR target
exit
main ENDP
END main