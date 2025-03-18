.data
    prompt_count: .asciiz "Ingrese la cantidad de números a comparar (3-5): "
    prompt_number: .asciiz "Ingrese un número: "
    result_msg: .asciiz "El número mayor es: "
    numbers: .space 20   # Espacio para almacenar los números

.text
.globl main
main:
    # Pedir cantidad de números
    li $v0, 4
    la $a0, prompt_count
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  # Guardar cantidad en $t0

    li $t1, 0      # Índice
    li $t2, -2147483648  # Inicializar con el menor valor posible (min int)

loop_input:
    beq $t1, $t0, find_max  # Si ya ingresó todos los números, ir a buscar el mayor

    li $v0, 4
    la $a0, prompt_number
    syscall

    li $v0, 5
    syscall
    move $t3, $v0  # Guardar número en $t3

    bgt $t3, $t2, update_max  # Si es mayor, actualizar máximo
    j continue_input

update_max:
    move $t2, $t3  # Guardar nuevo máximo

continue_input:
    addi $t1, $t1, 1
    j loop_input

find_max:
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 10
    syscall  # Salir del programa
