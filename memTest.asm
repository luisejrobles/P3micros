.model tiny
;----- Insert INCLUDE "filename" directives here
;----- Insert EQU and = equates here
locals
.data
.code
	org 100h
;*************************************************************
; Procedimiento principal
;*************************************************************
principal proc
	mov sp,0fffh ; inicializar SP (Stack Pointer)
	mov si,200h ;iniciando la direccion inicial 200h en si

	@@verifi55:
	mov ax,si
	mov bx,16
	;call printNumBase

	;printNumBase
		push ax
		push bx
		push cx
		push dx
		;donde se le va a meter la base
		;mov 	bx,10
			;aqui se va a meter en numero
		;mov 	ax,8
		;inicializar cx en 0
		mov 	cx,0
		
		@@division:
			;residuo debe estar en 0
			mov 	dx,0
			;div usa 'ax' y lo divide entre lo que pongas en div
			div 	bx
			;se mete el 'dx' (residuo) a la pila
			push 	dx
			;incrementar las veces que se hace la division
			inc 	cx
			cmp 	ax,0
			jne 	@@division
		
		@@sacarPila:
			;sacar de pila
			pop 	dx
			;interrupcion que imprime
			mov 	ah,02h
			;se mueve dl a dh
			mov 	dh,dl
			;compara dh con 9
			cmp 	dh,9
			;brinca a @@menor si es menor o igual a 9
			jbe 	@@menor
			;agrega 37h a dh
			add 	dh,37h
			;brinca a fin
			jmp 	@@finPrint
			@@menor:
			;agrega a dh 30h
				add		dh,30h
			@@finPrint:
				;se mueve dh a dl para imprimir
				mov 	dl,dh
			;imprime
			int 	21h
			;decrementa en 1 a cx
			dec		cx
			;compara con 0
			cmp 	cx,0
			;loop a @@sacarPila  si cx no es igual a 0
			jne 	@@sacarPila
			pop dx
			pop cx
			pop bx
			pop ax
	;fin printNumBase ===========================

	;verificacion con 55
	mov byte ptr [si],55h
	cmp byte ptr [si],55h
	jne @@error
	;verificacion con AA 
	mov byte ptr [si],0AAh
	cmp byte ptr [si],0AAh
	je @@avanzaMEM
	@@error:
	mov dl,' '
	;putchar
		push ax
		mov ah,2 ; imprimir caracter DL
		int 21h ; usando servicio 2 (ah=2)
		pop ax
	;fin putchar

	mov dl,'F'
	;putchar
		push ax
		mov ah,2 ; imprimir caracter DL
		int 21h ; usando servicio 2 (ah=2)
		pop ax
	;fin putchar
	jmp @@fin

	@@avanzaMEM:
	mov dl,10
	;putchar
		push ax
		mov ah,2 ; imprimir caracter DL
		int 21h ; usando servicio 2 (ah=2)
		pop ax
	;fin putchar
	mov dl,13
	;putchar
		push ax
		mov ah,2 ; imprimir caracter DL
		int 21h ; usando servicio 2 (ah=2)
		pop ax
	;fin putchar
	;inc bx
	cmp si,0fffh
	je @@fin
	inc si
	jmp @@verifi55

	@@fin:
	mov dl,'E'
	;putchar
		push ax
		mov ah,2 ; imprimir caracter DL
		int 21h ; usando servicio 2 (ah=2)
		pop ax
	;fin putchar
	@@loopfin:
	jmp @@loopfin
		ret ; nunca se llega aquí
	endp
