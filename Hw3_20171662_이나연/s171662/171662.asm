INCLUDE irvine32.inc

.data
var1 BYTE "65", 0

.code
main PROC
	mov edi, OFFSET var1; edi�� var1�� �ּҸ� �����Ѵ�. 
	mov ecx, LENGTHOF var1; ecx�� var1�� ���̸� �����Ѵ�. ecx�� loop counter�� ������ �Ѵ�.
	dec ecx; ecx�� ������ 0(NULL)���� ���̿� ���ԵǾ �� �κ��� ����. (���� NULL���� ���̰� 3�̾��ٸ� 2�� ���δ�.)
	mov eax, 0; eax�� 0���� �ʱ�ȭ�Ѵ�.

L1: 
	mov edx, eax; edx = eax
	add eax, eax; edx = 2 * eax
	add eax, eax; eax = 4 * eax
	add eax, eax; eax = 8 * eax
	sub eax, edx; eax = 7 * eax

	add al, [edi]; eax�� edi�� ���� �־��ش�. (al�� ����� ���� �ڷ����� ũ�⸦ �����ֱ� ���ؼ��̴�.)
	sub al, 48d ; ���ڿ��� '0'�� �ƽ�Ű �ڵ尪�� 10������ 48�� �������μ� �� ���� ��ü�� �ٲ۴�. (���� ��� '6'�� ���� 6���� �ٲپ� �ش�.)
	add edi, TYPE var1; ���� �迭�� ����Ű�� �Ѵ�.
	loop L1; ecx = 0�� �� �� ���� �ݺ��Ѵ�.

	call DumpRegs
	INVOKE ExitProcess, 0
main ENDP
END main