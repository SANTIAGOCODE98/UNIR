.data
    prompt: .asciiz "Ingrese la cantidad de números de la serie Fibonacci "
    error_msg: .asciiz "Número no válido. Intente nuevamente.\n"
    result_msg: .asciiz "Serie Fibonacci: "
    sum_msg: .asciiz "\nSuma total: "

.text
.globl main
main:
    # Pedir la cantidad de números
ask_again:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  # Guardar cantidad en $t0

    # Validar que esté entre 1 y 12
    blt $t0, 1, invalid_input
    bgt $t0, 12, invalid_input
    j continue_execution

invalid_input:
    li $v0, 4
    la $a0, error_msg
    syscall
    j ask_again  # Volver a pedir el número

continue_execution:
    # Mostrar mensaje de inicio
    li $v0, 4
    la $a0, result_msg
    syscall

    # Inicializar valores de Fibonacci
    li $t1, 0   # Fib(0)
    li $t2, 1   # Fib(1)
    move $a0, $t1
    li $v0, 1
    syscall
    li $a0, ' '
    li $v0, 11
    syscall

    beq $t0, 1, end  # Si solo pidió un número, terminar

    move $a0, $t2
    li $v0, 1
    syscall
    li $a0, ' '
    li $v0, 11
    syscall

    # Inicializar suma
    add $t3, $t1, $t2  # Suma total de Fibonacci

    # Generar serie
    li $t4, 2  # Contador

fibonacci_loop:
    beq $t4, $t0, print_sum  # Si alcanzamos la cantidad pedida, mostrar suma

    add $t5, $t1, $t2  # Fib(n) = Fib(n-1) + Fib(n-2)
    move $t1, $t2
    move $t2, $t5

    # Imprimir número
    move $a0, $t5
    li $v0, 1
    syscall
    li $a0, ' '
    li $v0, 11
    syscall

    # Sumar resultado
    add $t3, $t3, $t5

    addi $t4, $t4, 1  # Incrementar contador
    j fibonacci_loop

print_sum:
    li $v0, 4
    la $a0, sum_msg
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

end:
    li $v0, 10
    syscall  # Terminar el programa
