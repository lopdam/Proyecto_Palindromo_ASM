
; Proyecto Parcial Organizacion

; Palindromo

; Autores:
; Lopez Damian Dennys
; Damian Castillo

; Programa en Assembly que permita al usuario:
; Ingreso de una cadena de caracteres, y determine si la palabra o frase es un palindromo

; El usuario podra ingresar una cadena de hasta 40 caracteres
; (palabra o frase) y la utilizacion de
; la tecla ENTER indicara la finalizacion de la cadena.

name "Palindromo"

.model small


.stack 150h

.data


; Mensajes

numChar db ? ;cantidad de caracteres ingresados 

i db ? ;cantidad de caracteres ingresados

L DB ?
R DB ? ; variables para iterear extremo ixquiero y derecho respectivamente

msgInit1 db '   ***** INGRESE MAXIMO 40 CARACTERES ***** $' 

msgInit2 db ' INGRESE LA PALABRA: $'

  
msgSi db '  >> Si es Palindromo <<  $' 

msgNo db '  >> NO es Palindromo <<  $'

 
msgError db '   >> HA EXCEDIDO El MAXIMO DE 40 CARACTERES << $' 


msgOther db '   DESEA INGRESAR OTRA PALABRA [1] SI o [2] NO: $'

msgEnd db ' ***** GRACIAS ***** $'      



  

.code
.start           



; inicializacion de registros
MOV BX,0
MOV AX,0


main: 

DIM EQU 40   

A   DB  DIM    DUP(?) 
 
MOV SI, OFFSET A
MOV DI, OFFSET A 

MOV CX,0 ;iniciar el contador de numero maximo 40 caracteres, CL Cantidad de caracteres
MOV AX,0 
mov bl,0

MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;                       
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;  
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Dh          ;Retorno de Carro
INT 21h             ;

LEA DX,msgInit1        ;load efective address---> coloca contenido de variable msgInit1 en dx
MOV AX,0
MOV AH,09h         ;funcion para mostrar cadena de caracteres
INT 21h             ;interrupcion para mostrar contenido de dx en pantalla
MOV AX,0
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;                       
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;  
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Dh          ;Retorno de Carro
INT 21h             ;

lea DX,msgInit2        ;load efective address---> coloca contenido de variable msgInit2 en dx
MOV AX,0
MOV AH,09h         ;funcion para mostrar cadena de caracteres
INT 21h             ;interrupcion para mostrar contenido de dx en pantalla

	
INPUT:      ;Recibe los caracteres y empieza a verificar cuando se presione (ENTER)
MOV AH,1    ;Set para recibir un caracter desde la entrada standart
INT 21H
CMP AL,13   ;Comparamos si existe un salto de line, si es asi comenzamos a comparar
JE VERIFICAR  ; Verificar si es Palindromo cuando se haya insertado un enter(salto de linea)   

MOV AH,00H  ;limpiar parte alta de ax
CMP AL,97 ; comprobamos si la letra es minuscula
JL GUARDAR    ;guardar el numero, si no es minuscula


UPPERCASE: ;Si es una letra minuscula la transformamos a mayuscula.
MOV AH,00H  ;limpiar parte alta de ax
CMP AL,122  ;
JNLE GUARDAR ;SI no es una letra pasamos a guardarla
SUB AL,32 ;restamos 32 posiciones ne ASCII para que se tranforme a mayuscula


	   
	   	   
GUARDAR:  ;Guarda el caracter para posteriormente verificar

MOV numChar,CL ;Guardamos la cantidad de caracteres ingresados
MOV A[SI],AL
INC SI

ADD CL,1 ;  Agregar el numero de Carcteres Recibidos
CMP CL,41 ;comparamos si excede
JE ERROR  ;Si excede de 40 caracteres mostrar mensaje error
MOV AH,00H  ;limpiar parte alta de ax 

PUSH AX  ;  Agregar el Carcter Recibido a la pila
JMP INPUT ;Recibir el siguiente caracter
 
 
VERIFICAR: ;(NO IMPLEMENTADO) Verificar si es Palindromo

MOV SI, OFFSET A
MOV DI, OFFSET A

MOV numChar,CL ;Guardamos la cantidad de caracteres ingresados
SUB CL,1
MOV CH,0
ADD DI,CX

MOV CX,0
MOV AX,0 

MOV AL,numChar 
MOV BL, 2
DIV BL
MOV i,AL
MOV CH,i

EXTRAER:
ADD CL,1

MOV BH,A[SI]         ;Salto de linea
inc SI
MOV BL,A[DI]         ;Salto de linea
DEC DI

CMP BH,BL

JNE NotIS
  
cmp CH,CL
JLE IS

JMP EXTRAER     ;es Palindromo  

      
ERROR:    ; Error cuando excede los 40 caracteres
MOV AX,0
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;                       
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;  
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Dh          ;Retorno de Carro
INT 21h             ;

LEA DX,msgError      ;load efective address---> coloca contenido de variable  en dx
MOV AX,0
MOV AH,09h         ;funcion para mostrar cadena de caracteres
INT 21h             ;interrupcion para mostrar contenido de dx en pantalla

JMP main             ;Regresar al flujo principal


IS:                 ;ES Palindromo
MOV AX,0
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;                       
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;  
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Dh          ;Retorno de Carro
INT 21h             ;

LEA DX,msgSi        ;load efective address---> coloca contenido de variable  en dx
MOV AX,0
MOV AH,09h         ;funcion para mostrar cadena de caracteres
INT 21h             ;interrupcion para mostrar contenido de dx en pantalla
                                                               
JMP PREGUNTAR       ;Preguntar si desea continuar
  
  
NotIS:              ;No eS Palindromo
MOV AX,0
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;                       
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;  
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Dh          ;Retorno de Carro
INT 21h             ;

LEA DX,msgNo        ;load efective address---> coloca contenido de variable  en dx
MOV AX,0
MOV AH,09h         ;funcion para mostrar cadena de caracteres
INT 21h             ;interrupcion para mostrar contenido de dx en pantalla
                                                               
JMP PREGUNTAR      ;Preguntar si desea continuar


PREGUNTAR:    ;Preguntar si desea seguir ingresando palabras Si=[1] , No=[2]
MOV AX,0
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;                       
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;  
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Dh          ;Retorno de Carro
INT 21h             ;

LEA DX,msgOther        ;load efective address---> coloca contenido de variable  en dx
MOV AX,0
MOV AH,09h         ;funcion para mostrar cadena de caracteres
INT 21h             ;interrupcion para mostrar contenido de dx en pantalla
MOV AX,0                                                             
MOV AH,1               ;Recibir respuesta
INT 21H    
SUB AL,30H
CMP AL,1   ;Comparamos si DESEA SEGUIR INGRESANDO
JE main      ;Regresar al flujo principal si deseea
CMP AL,2     ;Verificar que no desee seguir Ingresando
Mov AX,0
JE end       ;Salir si no sea
JMP PREGUNTAR ;Volver a preguntar en caso de Error, en caso que el Usuario ingrese algo diferente de 1 o 2




end:
MOV AX,0
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;                       
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;  
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Dh          ;Retorno de Carro
INT 21h             ;

LEA DX,msgEnd        ;load efective address---> coloca contenido de variable  en dx
MOV AX,0
MOV AH,09h         ;funcion para mostrar cadena de caracteres
INT 21h             ;interrupcion para mostrar contenido de dx en pantalla    