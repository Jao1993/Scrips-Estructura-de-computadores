.data
mensaje_pedir: .asciiz "Ingrese cuántos números desea mostrar (máximo 5): "
mensaje_numeros: .asciiz "Los números son: "
mensaje_suma: .asciiz "La suma de los números es: "
mensaje_error: .asciiz "Error: la cantidad debe ser un número positivo y no mayor a 5.\n"

# Números a usar
numeros: .word 10, 30, 50, 70, 80  # Declarar los números

.text
main:
    # Mostrar mensaje para solicitar cantidad de números
    li $v0, 4                      # Syscall para imprimir string
    la $a0, mensaje_pedir
    syscall

    # Leer la cantidad de números a mostrar
    li $v0, 5                      # Syscall para leer entero
    syscall
    move $t0, $v0                  # Guardar la cantidad en $t0

    # Validar si la cantidad es positiva y no mayor a 5
    blt $t0, 1, error              # Si la cantidad es menor que 1, error
    li $t1, 5                      # Límite superior
    bgt $t0, $t1, error            # Si la cantidad es mayor que 5, error

    # Mensaje de inicio para mostrar los números
    li $v0, 4                      # Syscall para imprimir string
    la $a0, mensaje_numeros
    syscall

    # Inicializar suma
    li $t3, 0                      # Acumulador de suma

    # Bucle para mostrar los números y calcular la suma
    li $t4, 0                      # Inicializar contador
mostrar_numeros:
    bge $t4, $t0, mostrar_suma     # Si hemos mostrado la cantidad deseada, ir a mostrar suma

    # Calcular la dirección del número a cargar (numeros + $t4 * 4)
    mul $t5, $t4, 4                 # Multiplicar $t4 por 4 (tamaño de cada entero)
    lw $t6, numeros($t5)            # Cargar el número desde la lista usando el resultado de la multiplicación

    li $v0, 1                       # Syscall para imprimir entero
    move $a0, $t6                   # Mover el número a $a0
    syscall

    add $t3, $t3, $t6               # Sumar el número a la suma total

    addi $t4, $t4, 1                # Incrementar el contador
    j mostrar_numeros               # Repetir el bucle

error:
    # Mostrar mensaje de error si la entrada es no válida
    li $v0, 4
    la $a0, mensaje_error
    syscall
    j main                          # Regresar al inicio del programa

mostrar_suma:
    # Mostrar la suma total de los números
    li $v0, 4                       # Syscall para imprimir string
    la $a0, mensaje_suma
    syscall

    li $v0, 1                       # Syscall para imprimir entero
    move $a0, $t3                   # Mover la suma total a $a0 para imprimir
    syscall

    # Finalizar el programa
    li $v0, 10                      # Syscall para salir
    syscall