.data
mensaje_resultado: .asciiz "El número mayor es: "   # Mensaje para mostrar el resultado

.text
main:
    # Inicializar los números
    li $t0, 10      # Primer número
    li $t1, 30      # Segundo número
    li $t2, 50      # Tercer número
    li $t3, 70      # Cuarto número
    li $t4, 80      # Quinto número

    # Inicializar $t5 con el primer número como el mayor
    move $t5, $t0   # $t5 será el número mayor actual

    # Comparar con $t1
    bgt $t1, $t5, actualizar_t1   # Si $t1 > $t5, actualizar $t5
    j comparar_t2                 # Saltar a la siguiente comparación

actualizar_t1:
    move $t5, $t1                 # Actualizar el mayor
comparar_t2:

    # Comparar con $t2
    bgt $t2, $t5, actualizar_t2   # Si $t2 > $t5, actualizar $t5
    j comparar_t3                 # Saltar a la siguiente comparación

actualizar_t2:
    move $t5, $t2                 # Actualizar el mayor
comparar_t3:

    # Comparar con $t3
    bgt $t3, $t5, actualizar_t3   # Si $t3 > $t5, actualizar $t5
    j comparar_t4                 # Saltar a la siguiente comparación

actualizar_t3:
    move $t5, $t3                 # Actualizar el mayor
comparar_t4:

    # Comparar con $t4
    bgt $t4, $t5, actualizar_t4   # Si $t4 > $t5, actualizar $t5
    j mostrar_mayor               # Saltar a mostrar el número mayor

actualizar_t4:
    move $t5, $t4                 # Actualizar el mayor

mostrar_mayor:
    # Mostrar el número mayor
    li $v0, 4                     # Syscall para imprimir string
    la $a0, mensaje_resultado     # Cargar el mensaje
    syscall

    li $v0, 1                     # Syscall para imprimir entero
    move $a0, $t5                 # Mover el número mayor a $a0
    syscall

    # Terminar el programa
    li $v0, 10                    # Syscall para salir
    syscall