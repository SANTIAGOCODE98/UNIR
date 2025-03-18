.data
    prompt_count: .asciiz "Ingrese la cantidad de números a comparar (3-5): "
    prompt_number: .asciiz "Ingrese un número: "
    result_msg: .asciiz "El número menor es: "
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
    li $t2, 2147483647  # Inicializar con el mayor valor posible (max int)

loop_input:
    beq $t1, $t0, find_min  # Si ya ingresó todos los números, ir a buscar el menor

    li $v0, 4
    la $a0, prompt_number
    syscall

    li $v0, 5
    syscall
    move $t3, $v0  # Guardar número en $t3

    blt $t3, $t2, update_min  # Si es menor, actualizar mínimo
    j continue_input

update_min:
    move $t2, $t3  # Guardar nuevo mínimo

continue_input:
    addi $t1, $t1, 1
    j loop_input

find_min:
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 10
    syscall  # Salir del programa
