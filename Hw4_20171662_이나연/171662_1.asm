INCLUDE irvine32.inc ;20131574 Hyunsuk's code

.data
str1 BYTE "Type_A_String_To_Reverse: ", 0
str2 BYTE "Reversed_String: ", 0
str3 BYTE "Bye!", 0Dh, 0Ah, 0
input BYTE 42 DUP(?)
byteCount DWORD 0

.code
main PROC
L1:
   mov edx, OFFSET str1 ; store address of str1
   call WriteString ; print str1

   mov edx, OFFSET input ; store address of input
   mov ecx, SIZEOF input ; store size of input
   call ReadString ; get string
   
   mov byteCount, eax ; save length of input
   cmp al, 40 ; if al > 40
   jg L1 ; jump to L1
   cmp al, 0 ; al == 0
   je L2 ; jump to L2

   call Reverse ; call Reverse procedure
   jmp L1 ; jump to L1
L2:
   mov edx, OFFSET str3 ; store address of str3
   call WriteString ; print str3
   
   exit
main ENDP
;----------------------
Reverse PROC
; Displays the reversed and uppercase to lowercase, lowercase to uppercase string
; Receives: nothing
; Returns: nothing
;----------------------
  
  mov ecx, byteCount
	mov esi, -1; input completed

	L4:
	inc esi
	
	cmp input[esi], 32
	je DONE
	cmp input[esi], 0
	je DONE

	cmp input[esi], 'a'
	jb uppercaseup; uppercase?

	cmp input[esi], 'a'
	jae lowercaseup
	
	uppercaseup:
		cmp input[esi], 'Z'
		jbe uppercaselow

	jmp DONE

	uppercaselow:
		cmp input[esi], 'A'
		jae Lag

	jmp DONE

	lowercaseup:
		cmp input[esi], 'z'
		jbe subtraction

	jmp DONE

	subtraction:
		sub input[esi], 32
			jmp DONE

	jmp DONE

	Lag:
		add input[esi],32
	DONE:
		loop L4
  
  mov ecx, byteCount ; set loop count
   mov esi, 0
L3:
   movzx eax, input[esi] ; get character
   push eax ; push on stack
   inc esi
   Loop L3
   
   mov edx, OFFSET str2 ; store address of str2
   call WriteString ; print str2

   mov ecx, byteCount ; set loop count
L5:
   pop eax ; get character
   call WriteChar
   Loop L5
   call Crlf
   ret
Reverse ENDP
END main