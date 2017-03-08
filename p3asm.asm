dosseg
.MODEL tiny

.CODE
public _peekb
public _pokeb
public _printNumBase


_pokeb PROC
	push bp
	mov bp,sp

	mov ds,[bp+4]
	mov bx,[bp+6]
	mov ax,[bp+8]

	mov [bx],ax

	pop bp
	ret
_pokeb ENDP

_peekb PROC
	push bp
	mov bp,sp

	mov ds,[bp+4]
	mov bx,[bp+6]

	mov ax,[bx]
	pop bp
	ret
_peekb ENDP

_printNumBase PROC
	push bp
	mov bp,sp
	;push ax
	;push bx
	;push cx
	;push dx
	mov ax,[bp+4]
	mov bx,[bp+6]
	;donde se le va a meter la base
	;mov 	bx,2

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
	jmp 	@@fin
	@@menor:
	;agrega a dh 30h
	add		dh,30h
	@@fin:
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
	;pop dx
	;pop cx
	;pop bx
	;pop ax
	pop bp
	ret 
_printNumBase ENDP

END

 ; Tabla para retornar valores
 ; ==============================================================
 ; Tipo de Valor Lacalidad para el Valor
 ; --------------------------------------------------------------
 ; unsigned char, char, enum 								AX
 ; unsigned short, short 									AX
 ; unsigned int, int 										AX
 ; unsigned long, long 									 DX:AX
 ; float, double, long double 				  Dirección offset
 ; struct y union 							  Dirección offset
 ; near * 												    AX
 ; far * 												 DX:AX
 ; ============================================================== 