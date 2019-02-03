INCLUDE irvine32.inc
BUFMAX = 41;
KEYMAX = 11;
.data
INCLUDE hw5_1.inc
msgFin  BYTE    "Encrypted Text : ", 0
msgUn   BYTE    "Decrypted Text : ", 0
msgori  BYTE    "Original Text : ", 0
mesSize DWORD ?
keySize DWORD ?
newkey BYTE 11 DUP (?)
.code
main PROC
	mov keySize, LENGTHOF KeyRotate
	mov mesSize, LENGTHOF PlainText
	dec mesSize
	mov ECX, BUFMAX             ; maximum character count
	mov EDX, offset msgori
	call WriteString
	mov EDX, offset PlainText   ; point to the key
	call WriteString
	call Encryption
	mov EDX, offset msgFin
	call WriteString
	mov EDX, offset PlainText
	call WriteString
	mov ecx, keySize
	mov eax, 0
	iloop:
		mov bl, newkey[eax]
		mov KeyRotate[eax], bl
		inc eax
		loop iloop
	call Encryption
	mov EDX, offset msgUn
	call WriteString
	mov EDX, offset PlainText
	call WriteString
	call crlf
	popad
	INVOKE ExitProcess, 0
	exit
main ENDP
Encryption PROC
pushad
mov ECX, mesSize            ; loop counter
mov ESI, 0  
mov EAX, 0                  ; index 0 in message
mov EDX, 0
L1:
	cmp edx, mesSize
	je done
	inc edx
	mov bl, KeyRotate[eax]
	cmp bl, 0
	jg greater
	jl less
	je equal
	below:
	mov EAX, 0
	loop L1
	greater:
	movzx ebx, BL
	mov newkey[eax], bl
	sub newkey[eax], bl
	sub newkey[eax], bl
	mov ecx, ebx
	L3: 
		ror PlainText[ESI], 1
		loop L3
	inc ESI
	inc EAX
	cmp keySize, eax
	je below
	loop L1
	less:
	mov bh,0
	sub bh, bl
	movzx ecx, bh
	mov newkey[eax], bh
	L5:
		rol PlainText[ESI], 1
		loop L5
	inc ESI
	inc EAX
	cmp keySize, eax
	je below
	loop L1
	equal:
	mov newkey[eax], 0
	inc ESI
	inc EAX
	cmp keySize, eax
	je below
	loop L1
done:
call crlf
popad
ret
Encryption ENDP
END main