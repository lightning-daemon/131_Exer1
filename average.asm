section .data
	prompt db "Enter a 3-digit number: "
	prompt_len equ $-prompt
	newline db 10

section .bss
	f_huns resb 1
	f_tens resb 1
	f_ones resb 1
	s_huns resb 1
	s_tens resb 1
	s_ones resb 1
	num1 resw 1
	num2 resw 1
	ave_huns resb 1
	ave_tens resb 1
	ave_ones resb 1
	quotient resb 1
	remainder resb 1
	test_value resb 1

section .text
	global _start

_start:
	
	; prompt user for first 3-digit number

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, prompt_len
	int 80h

	; get first num 
	
	mov eax, 3 
	mov ebx, 0 
	mov ecx, f_huns
	mov edx, 1
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, f_tens
	mov edx, 1
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, f_ones
	mov edx, 2
	int 80h
	
	; prompt user for second 3-digit number

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, prompt_len
	int 80h
	
	; get second num 
	
	mov eax, 3 
	mov ebx, 0 
	mov ecx, s_huns
	mov edx, 1
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, s_tens
	mov edx, 1
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, s_ones
	mov edx, 2
	int 80h

    ; convert to numbers 
    sub byte [f_huns], 30h
    sub byte [f_tens], 30h
    sub byte [f_ones], 30h
    
    sub byte [s_huns], 30h
    sub byte [s_tens], 30h
    sub byte [s_ones], 30h
    
    ; first number
    ; multiplies 100 to f_huns
    mov al, [f_huns]
    mov bl, 100
    mul bl 
    mov word[num1], ax
    
    ; multiplies 10 to f_tens
    mov al, [f_tens]
    mov bl, 10
    mul bl
    
    ; adds all and saves to num1
    add byte[num1], al
    mov al, byte[f_ones]
    add byte[num1], al 
    
    ; second number
    ; multiplies 100 to s_huns
    mov al, [s_huns]
    mov bl, 100
    mul bl 
    mov word[num2], ax
    
    ; multiplies 10 to s_tens
    mov al, [s_tens]
    mov bl, 10
    mul bl
    
    ; adds all and saves to num2
    add byte[num2], al
    mov al, byte[s_ones]
    add byte[num2], al 
    
    ; combine both numbers
    mov ax, word[num2]
    add word[num1], ax
    
    ; divide by 2
    mov ax, word[num1]
    mov bl, 2
    div bl
    
    mov byte[quotient], al
    mov byte[remainder], ah
    
    ; div quotient by 100
    mov al, byte[quotient]
    mov bl, 100
    div bl
    
    ; quotient to ave_huns, remainder to ave_tens
    mov byte[ave_huns], al
    mov byte[ave_tens], ah
    
    ; div by 10
    mov ah, 0
    mov al, [ave_tens]
    mov bl, 10
    div bl
    
    ; quotient to tens, remainder to ones
    mov byte[ave_tens], al
    mov byte[ave_ones], ah
    
    ; convert to characters
    add byte[ave_huns], 30h
    add byte[ave_tens], 30h
    add byte[ave_ones], 30h
    
    ; printing
	mov eax, 4
	mov ebx, 1
	mov ecx, ave_huns
	mov edx, 1
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, ave_tens
	mov edx, 1
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, ave_ones
	mov edx, 1
	int 80h

	; terminate

	mov eax, 1
	mov ebx, 0
		int 80h