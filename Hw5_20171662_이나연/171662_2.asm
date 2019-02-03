INCLUDE irvine32.inc
.data
INCLUDE hw5_2.inc
msgbefore BYTE "Before sort : ", 0
msgafter BYTE "After sort : ", 0
msgcomma BYTE ", ", 0
OddData DWORD 100 DUP (?)
EvenData DWORD 100 DUP (?)
oddnum DWORD 0
evennum DWORD 0
tmpedi DWORD 1 DUP (0)
tmpedie DWORD 1 DUP (0)
Oddx DWORD 100 DUP (?)
Evenx DWORD 100 DUP (?)
.code
main PROC
	mov EDX, offset msgbefore
	call WriteString
	call Print_Array
	mov EDX, offset msgafter
	call WriteString
	call Sort
	call Print_Array
	INVOKE ExitProcess, 0
	exit
main ENDP
Print_Array PROC
pushad
	mov esi, 0
	mov EBX, SIZEOF ArrData
	sub ebx, 4
	L1:
		mov EAX, ArrData[esi]
		call WriteHex
		cmp esi, EBX
		jb comma
		je done
	comma:
		mov edx, offset msgcomma
		call WriteString
		add esi, 4
		jmp L1
	done:
		call crlf
		popad
		ret
Print_Array ENDP
Sort PROC
pushad
	mov edi, 0
	mov esi, 0
	mov EBX, SIZEOF ArrData
	sub ebx, 4
oddsit:
	cmp esi, ebx
	ja sortodd
	mov edx, oddnum
	add edx, edx
	add edx, edx
	mov eax, edx
	mov ecx, ArrData[esi]
	mov OddData[eax], ecx
	inc oddnum
	add esi, 4
	jmp evensit
evensit:
	cmp esi, ebx
	mov edi, 0
	ja sortodd
	mov edx, evennum
	add edx, edx
	add edx, edx
	mov eax, edx	
	mov ecx, ArrData[esi]
	mov EvenData[eax], ecx
	inc evennum
	add esi, 4
	jmp oddsit
sortodd:
	mov ecx, oddnum
	sub ecx, tmpedi
	dec ecx
	cmp ecx, 0
	je set
	mov esi, edi
	L2:
		add esi, 4
		mov edx, OddData[edi]
		cmp OddData[esi], edx
		jae nochange
			mov eax, OddData[esi]
			mov edx, OddData[edi]
			mov OddData[esi], edx
			mov OddData[edi], eax
		nochange:
			loop L2
			add edi, 4
			inc tmpedi
	jmp sortodd
set:
mov edi, 0
sorteven:
	mov ecx, evennum
	sub ecx, tmpedie
	dec ecx
	cmp ecx, 0
	je set1
	mov esi, edi
	L3:
		add esi, 4
		mov edx, EvenData[edi]
		cmp EvenData[esi], edx
		jbe nochangee
			mov eax, EvenData[esi]
			mov edx, EvenData[edi]
			mov EvenData[esi], edx
			mov EvenData[edi], eax
		nochangee:
			loop L3
			add edi, 4
			inc tmpedie
	jmp sorteven
set1:
	mov edi, 0
	mov tmpedi, 0
mov ecx, oddnum
mov eax, 0
L4:
	mov ebx, OddData[eax]
	movzx edx, bx
	sub ebx, edx
	mov Oddx[eax], ebx
	add eax, 4
	loop L4
mov ecx, evennum
mov eax, 0
L6:
	mov ebx, EvenData[eax]
	movzx edx, bx
	sub ebx, edx
	mov Evenx[eax], ebx
	add eax, 4
	loop L6
secoddsort:	
	mov ecx, oddnum
	sub ecx, tmpedi
	dec ecx
	cmp ecx, 0
	je set2
	mov esi, edi
	L5:
		add esi, 4
		mov edx, Oddx[edi]
		cmp Oddx[esi], edx
		jne nochangeso
			mov eax, OddData[esi]
			mov edx, OddData[edi]
			mov OddData[esi], edx
			mov OddData[edi], eax
		nochangeso:
			loop L5
			add edi, 4
			inc tmpedi
	jmp secoddsort
set2:
	mov edi, 0
	mov tmpedi, 0
secevensort:
	mov ecx, evennum
	sub ecx, tmpedi
	dec ecx
	cmp ecx, 0
	je endsort
	mov esi, edi
	L7:
		add esi, 4
		mov edx, Evenx[edi]
		cmp Evenx[esi], edx
		jne nochangese
			mov eax, EvenData[esi]
			mov edx, EvenData[edi]
			mov EvenData[esi], edx
			mov EvenData[edi], eax
		nochangese:
			loop L7
			add edi, 4
			inc tmpedi
	jmp secevensort
endsort:
	mov eax, 0
	mov ebx, 0
	mov edx, 0
	mov ecx, SIZEOF ArrData
	putin:
		cmp ecx, ebx
		je endput
		mov edx, OddData[eax]
		mov ArrData[ebx], edx
		add ebx, 4
		cmp ecx, ebx
		je endput
		mov edx, EvenData[eax]
		mov ArrData[ebx], edx
		add ebx, 4
		add eax, 4
		jmp putin
endput:
popad
ret
Sort ENDP
END main