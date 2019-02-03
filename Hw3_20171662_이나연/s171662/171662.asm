INCLUDE irvine32.inc

.data
var1 BYTE "65", 0

.code
main PROC
	mov edi, OFFSET var1; edi에 var1의 주소를 저장한다. 
	mov ecx, LENGTHOF var1; ecx에 var1의 길이를 저장한다. ecx는 loop counter의 역할을 한다.
	dec ecx; ecx에 마지막 0(NULL)까지 길이에 포함되어서 그 부분을 뺀다. (원래 NULL까지 길이가 3이었다면 2로 줄인다.)
	mov eax, 0; eax를 0으로 초기화한다.

L1: 
	mov edx, eax; edx = eax
	add eax, eax; edx = 2 * eax
	add eax, eax; eax = 4 * eax
	add eax, eax; eax = 8 * eax
	sub eax, edx; eax = 7 * eax

	add al, [edi]; eax에 edi의 값을 넣어준다. (al을 사용한 것은 자료형의 크기를 맞춰주기 위해서이다.)
	sub al, 48d ; 문자열을 '0'의 아스키 코드값인 10진수인 48을 빼줌으로서 그 숫자 자체로 바꾼다. (예를 들어 '6'을 숫자 6으로 바꾸어 준다.)
	add edi, TYPE var1; 다음 배열을 가리키게 한다.
	loop L1; ecx = 0이 될 때 까지 반복한다.

	call DumpRegs
	INVOKE ExitProcess, 0
main ENDP
END main