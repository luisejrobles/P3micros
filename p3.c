extern unsigned char peekb(unsigned int segment,unsigned int offset);
extern void pokeb(unsigned int segment,unsigned int offset, unsigned char data);
extern void printNumBase(unsigned int dato, unsigned int base);
void putchar(char dato);
void puts(char *str);

char bienv[] = "\n\rPractica no.3: \n\rPrueba de memoria RAM\r\n";
char error[] = "\n\rError\n\r";
char bien[] = "\n\rTodo bien\n\r";
char dir[] = "\n\rDireccion: ";
char enter[] = "\n\r";

int main(void)
{
	unsigned int offset = 0x2200;
	unsigned int segment = 0x0;
	unsigned int direccion;
	unsigned char data1 = 0x55;
	unsigned char data2 = 0xAA;	
	unsigned char d;

	do
	{
		/*====Leyendo//Escribiendo 55====*/
		direccion = (segment*0x10) + offset;
		printNumBase(direccion,16);
		pokeb(segment,offset,data1);	/*Escribiendo dato*/
		d = peekb(segment,offset);		/*Leyendo dato*/
		if( d != data1)
		{
			putchat(' ');
			putchar('F');	/*Error*/
			while(1){}
		}
		pokeb(segment,offset,data2);	/*Escribiendo dato*/
		d = peekb(segment,offset);		/*Leyendo dato*/
		if(d != data2)
		{
			putchar(' ');
			putchar('F');	/*Error*/
			while(1){}
		}
		if(offset == 0xffff)
		{
			break;
		}
		offset++;
		putchar(10);
		putchar(13);
	}while(offset <= 0xffff);

	putchar(10);
	putchar(13);
	putchar('E'); /*Exito*/
	while(1){};
};

void putchar(char dato)
{
	asm mov dl,dato
	asm mov ah,2
	asm int 21h
}

