INCLUDE irvine32.inc
.data
INCLUDE hw2.inc
.code
main PROC
	mov ecx, val2
	add ecx, ecx
	add ecx, val2; ecx = 3*val2
	mov eax, val1
	add eax, ecx; eax = val1+3*val2
	add eax, eax; if eax=a, then a -> 2*a
	add eax, eax; 2*a -> 4*a
	mov ebx, eax; ebx = 4*a
	add eax, eax; 4*a -> 8*a
	add eax, ebx; 8*a -> 12*a
	sub ecx, val4
	add ecx, val3; ecx = 3*val2-val4+val3
	mov ebx, ecx; ebx = 3*val2-val4+val3 = b
	add ecx, ecx; b -> 2*b
	add ecx, ecx; 2*b -> 4*b
	add ecx, ebx; 4*b -> 5*b => ecx = 5(3*val2-val4+val3)
	add eax, ecx; eax = 12(val1+3*val2) + 5(3*val2-val4+val3)
	
	mov ebx, val1
	add ebx, val2
	add ebx, val4
	sub ebx, val3; ebx = val1+val2-val3+val4 = c
	add ebx, ebx; c -> 2*c
	add ebx, ebx; 2*c -> 4*c
	add ebx, ebx; 4*c -> 8*c
	add ebx, ebx; 8*c -> 16*c
	sub ebx, val1
	sub ebx, val1
	sub ebx, val2
	sub ebx, val2
	sub ebx, val2
	add ebx, val3
	sub ebx, val4; ebx = 16(val1+val2-val3+val4)-2*val1-3*val2+val3-val4

	call DumpRegs
	exit
main ENDP
END main