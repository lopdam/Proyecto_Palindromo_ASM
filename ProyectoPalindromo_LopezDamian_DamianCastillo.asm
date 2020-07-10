
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


.stack

.data


; Mensajes
msgInit1 db '   ***** INGRESE MAXIMO 40 CARACTERES ***** $' 

msgInit2 db ' INGRESE LA PALABRA: $'

  
msgSi db '  >> Si es Palindromo <<  $' 

msgNo db '  >> Si es Palindromo <<  $'

 
msgError db '   >> HA EXCEDIDO El MAXIMO DE 40 CARACTERES << $' 


msgOther db '   DESEA INGRESAR OTRA PALABRA [1] SI o [2] NO: $'

msgEnd db ' ***** GRACIAS ***** $'


.code
.start

; inicializacion de registros
MOV BX,0
MOV AX,0


main:
MOV CX,0 ;iniciar el contador de numero maximo 40 caracteres
CALL SALTO     ;Salto de linea y retorno de carro
LEA DX,msgInit1        ;load efective address---> coloca contenido de variable msgInit1 en dx
CALL MENSAJE           ;imprimir mensaje
CALL SALTO
lea DX,msgInit2        ;load efective address---> coloca contenido de variable msgInit2 en dx
CALL MENSAJE           ;imprimir mensaje

	
INPUT:      ;Recibe los caracteres y empieza a verificar cuando se presione (ENTER)
MOV AH,1    ;Set para recibir un caracter desde la entrada standart
INT 21H
CMP AL,13   ;Comparamos si existe un salto de line, si es asi comenzamos a comparar
JNE GUARDAR    ;guardar el numero
JMP VERIFICAR  ; Verificar si es Palindromo cuando se haya insertado un enter(salto de linea)
	   
	   	   
GUARDAR:  ;Guarda el caracter para posteriormente verificar
ADD CL,1 ;  Agregar el numero de Carcteres Recibidos
CMP CL,41 ;comparamos si excede
JE ERROR  ;Si excede de 40 caracteres mostrar mensaje error
MOV AH,00H  ;limpiar parte alta de ax
PUSH AX  ;  Agregar el Carcter Recibido a la pila
JMP INPUT ;Recibir el siguiente caracter
 
 
VERIFICAR: ;(NO IMPLEMENTADO) Verificar si es Palindromo

JMP IS     ;es Palindromo  

      
ERROR:    ; Error cuando excede los 40 caracteres
CALL SALTO           ; Saltar linea
LEA DX,msgError      ;load efective address---> coloca contenido de variable  en dx
CALL MENSAJE         ;Mostrar mensaje erro
JMP main             ;Regresar al flujo principal


IS:                 ;ES Palindromo
CALL SALTO          ;salto de linea
LEA DX,msgSi        ;load efective address---> coloca contenido de variable  en dx
CALL MENSAJE        ;mostrar mensaje                                                                
JMP PREGUNTAR       ;Preguntar si desea continuar

NotIS:              ;No eS Palindromo
CALL SALTO          ;salto de linea
LEA DX,msgNo        ;load efective address---> coloca contenido de variable  en dx
CALL MENSAJE        ;mostrar mensaje                                                                
JMP PREGUNTAR      ;Preguntar si desea continuar


PREGUNTAR:    ;Preguntar si desea seguir ingresando palabras Si=[1] , No=[2]
CALL SALTO
LEA DX,msgOther        ;load efective address---> coloca contenido de variable  en dx
CALL MENSAJE           ;mostar mensaje pregunta                                                             
MOV AH,1               ;Recibir respuesta
INT 21H    
SUB AL,30H
CMP AL,1   ;Comparamos si DESEA SEGUIR INGRESANDO
JE main      ;Regresar al flujo principal si deseea
CMP AL,2     ;Verificar que no desee seguir Ingresando
JE end       ;Salir si no sea
JMP PREGUNTAR ;Volver a preguntar en caso de Error, en caso que el Usuario ingrese algo diferente de 1 o 2


MENSAJE PROC ;Mostrar mensajes del registro DX
MOV AX,0
MOV AH,09h         ;funcion para mostrar cadena de caracteres
INT 21h             ;interrupcion para mostrar contenido de dx en pantalla
RET       ;Regresar a la llamada


SALTO PROC          ; Salto de linea y Retorno de Carro
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;                       
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Ah          ;Salto de linea
INT 21h             ;  
MOV AH,02h         ;Configurar para imprimir un caracter
MOV DL,0Dh          ;Retorno de Carro
INT 21h             ;
RET                 ;Regresar a la llamada


end:
CALL SALTO
LEA DX,msgEnd        ;load efective address---> coloca contenido de variable  en dx
CALL MENSAJE    