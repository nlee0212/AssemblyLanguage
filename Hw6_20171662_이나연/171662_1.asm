INCLUDE irvine32.inc

.data
INCLUDE hw6_1.inc
msg BYTE "Copied String : ", 0

.code
main PROC
cld
movzx ecx, copyNum
mov esi, OFFSET strSrc
mov edi, OFFSET strDest
rep movsb
mov edx, OFFSET msg
call writestring
mov edx, OFFSET pos
call writestring
call crlf
exit
main ENDP
END main
