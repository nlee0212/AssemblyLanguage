INCLUDE irvine32.inc

     BUFMAX = 128 ; maximum buffer size


   .data

    key BYTE BUFMAX+1 DUP(0)
    keySize DWORD ?

    mes BYTE BUFMAX+1 DUP(0)
    mesSize DWORD ?

    msgEn   BYTE    "Enter a key : ", 0
    msgMe   BYTE    "Enter a plain text : ", 0
    msgFin  BYTE    "Encrypted Text : ", 0
    msgUn   BYTE    "Decrypted Text : ", 0
	msgori  BYTE    "Original Text : ", 0
	msgbye	BYTE	"Bye!", 0

.code
main PROC

L2:
mov EDX, offset msgMe       ; display a prompt
call WriteString

mov ECX, BUFMAX             ; maximum character count

mov EDX, offset mes         ; point to the key
call ReadString             ; input the string

mov mesSize, EAX            ; save the length for message

cmp mes[0],0
je L3

mov EDX, offset msgEn       ; display a prompt
call WriteString

mov ECX, BUFMAX             ; maximum character count

mov EDX, offset key         ; point to the key
call ReadString             ; input the string

mov keySize, EAX            ; save the length for key
call Crlf

mov EDX, offset msgori
call WriteString

mov EDX, offset mes
call WriteString


call Encryption


mov EDX, offset msgFin
call WriteString

mov EDX, offset mes
call WriteString

call Encryption

mov EDX, offset msgUn
call WriteString

mov EDX, offset mes
call WriteString
call Crlf
call Crlf
jmp L2

L3:
	mov EDX, offset msgbye      ; display a prompt
	call WriteString
	

call Crlf
popad
exit


main ENDP





Encryption PROC
pushad
mov ECX, mesSize            ; loop counter
mov ESI, 0  
mov EAX, 0                  ; index 0 in message

L1:
mov AL, key[EAX]
xor mes[ESI], AL        ; translate a byte
inc ESI 
inc EAX

cmp keySize, EAX
jb  below

loop L1

below:
mov EAX, 0
loop L1


call crlf
popad
ret

Encryption ENDP


END main