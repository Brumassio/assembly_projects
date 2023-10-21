.section .data

    # SCANNERS
    int_scan: .asciz "%d"
    float_scan: .asciz "%f" 
    float_print: .asciz "%f"

    # PERGUNTAS
    
    pergunta1: .asciz "\nQual operação deseja realizar?\n [1]Soma😎\n [2]Subtracao😁\n [3]Divisao🤞\n [4]Multiplicacao😆\n [5]Area do triangulo🐱‍🐉\n [6]Raiz quadrada🤢\n [7]Sair do Programa😢"
    pergunta2: .asciz "\nQuantos números deseja operar?😍"
    pergunta3: .asciz "\nDigite um numero 🙌: "
    pergunta4: .asciz "\nDigite o valor da base do triangulo 😎: "
    pergunta5: .asciz "\nDigite o valor da altura do triangulo 😎: "
    pergunta6: .asciz "\nDigite o número que deseja tirar a raiz quadrada 😜: "
    pergunta7: .asciz "\nDigite o primeiro numero 😜: "
   
    # RESULTADOS
    res_soma: .asciz "\nSoma = %.2f 😁\n"
    res_subtracao: .asciz "\nSubtracao = %.2f 😁\n"
    res_divisao: .asciz "\nDivisao = %.2f 😁\n"
    res_multiplicacao: .asciz "\nMultiplicacao = %.2f 😁\n"
    res_area: .asciz "\nArea do Triangulo = %.2f 😁\n"
    res_raiz: .asciz "\nRaiz quadrada = %.2f 😁\n"

    # INTEIROS
    quantidade_nums: .int 0
    escolha: .int 0
 
    # FLOATS
    valor: .single 0
    valor1: .single 0
    base: .single 0
    altura: .single 0
    div_triangulo: .single 2.0
    raiz: .single 0
    
 
.section .text
	.global main

main:

    finit 

    call pergunta
    call primeiro_valor

    # Pergunta para saber qual operação vai ser selecionada
    pushl $pergunta1
    call printf
    addl $4, %esp

    pushl $escolha
    pushl $int_scan
    call scanf
    movl escolha, %eax
    addl $8, %esp
    
    cmpl $0, %eax
    je quit
    cmpl $1, %eax
    je soma
    cmpl $2, %eax
    je subtracao
    cmpl $3, %eax
    je divisao
    cmpl $4, %eax
    je multiplicacao
    cmpl $5, %eax
    je triangulo
    cmpl $6, %eax
    je raizquadrada
    cmpl $7, %eax
    je quit

pergunta:
    # Pergunta para saber quantos valores do vetor sofrerao a operação
    pushl $pergunta2
    call printf
    addl $4, %esp

    pushl $quantidade_nums
    pushl $int_scan
    call scanf
    addl $8, %esp
    
    movl quantidade_nums, %ebx
    cmpl $0, %ebx
    je quit
    ret
    
primeiro_valor:
    pushl $pergunta7       # pede o valor
    call printf            # printa a pergunta
    addl $4, %esp

    pushl $valor1          # joga variavel para receber o valor
    pushl $float_scan      # para scanear um float
    call scanf             # scaneia o valor
    addl $8, %esp

    flds valor1   
    
    ret
    
printa_valor_soma:
    fstl (%esp)
    pushl $res_soma
    call printf
    addl $20, %esp
    jmp main

printa_valor_sub:
    fstl (%esp)
    pushl $res_subtracao
    call printf
    addl $20, %esp
    jmp main

printa_valor_div:
    fstl (%esp)
    pushl $res_divisao
    call printf
    addl $20, %esp
    jmp main

printa_valor_mult:
    fstl (%esp)
    pushl $res_multiplicacao
    call printf
    addl $20, %esp
    jmp main

printa_valor_area:
    fstl (%esp)
    pushl $res_area
    call printf
    addl $20, %esp
    jmp main

printa_valor_raiz:
    fstl (%esp)
    pushl $res_raiz
    call printf
    addl $20, %esp
    jmp main

soma:
    subl $4, %esp
    subl $1, %ebx          # condicao para ver se acabaram os valores desejados
    cmp $0, %ebx
    jle printa_valor_soma

    pushl $pergunta3       # pede o valor
    call printf            # printa a pergunta
    addl $4, %esp

    pushl $valor           # joga variavel para receber o valor
    pushl $float_scan      # para scanear um float
    call scanf             # scaneia o valor
    addl $8, %esp
 
    flds valor             # carrega o valor
    subl $8, %esp          # abre espaço de 8 bytes no topo da pilha de sistema para fazer operação entre 2 floats simples
    faddp                  # adiciona os dois numeros do topo da pilha e atualiza o valor na primeira posição
  
    jmp soma               # chama funcao soma de novo

subtracao:
    subl $4, %esp
    subl $1, %ebx       # condicao para ver se acabaram os valores desejados
    cmp $0, %ebx
    jle printa_valor_sub

    pushl $pergunta3    # pede o valor
    call printf         # printa a pergunta
    addl $4, %esp

    pushl $valor        # joga variavel para o topo e recebe o valor
    pushl $float_scan   # para scanear um float
    call scanf          # scaneia o valor
    addl $8, %esp
 
    flds valor          # carrega o valor
    subl $8, %esp       # abre espaço de 8 bytes no topo da pilha de sistema para fazer operação entre 2 floats simples
    fsubp               # subtrai os dois numeros do topo da pilha e já atualiza o valor do topo com o resultado
   
    jmp subtracao       # chama funcao subtracao de novo

divisao:
    subl $4, %esp
    subl $1, %ebx       # condicao para ver se acabaram os valores desejados
    cmp $0, %ebx
    jle printa_valor_div

    pushl $pergunta3    # pede o valor
    call printf         # printa a pergunta
    addl $4, %esp

    pushl $valor        # joga variavel para o topo e recebe o valor
    pushl $float_scan   # para scanear um float
    call scanf          # scaneia o valor
    addl $8, %esp
 
    flds valor          # carrega o valor
    # subl $8, %esp     abre espaço de 8 bytes no topo da pilha de sistema para fazer operação entre 2 floats simples
    fdivp               # divide os dois numeros do topo da pilha e já atualiza o valor do topo com o resultado
   
    jmp divisao         # chama funcao divisao de novo

multiplicacao:
    subl $1, %ebx       # condicao para ver se acabaram os valores desejados
    cmp $0, %ebx
    jle printa_valor_mult

    pushl $pergunta3    # pede o valor
    call printf         # printa a pergunta
    addl $4, %esp

    pushl $valor        # joga variavel para o topo e recebe o valor
    pushl $float_scan   # para scanear um float
    call scanf          # scaneia o valor
    addl $8, %esp
 
    flds valor          # carrega o valor
    # subl $16, %esp    abre espaço de 8 bytes no topo da pilha de sistema para fazer operação entre 2 floats simples
    fmulp               # divide os dois numeros do topo da pilha e já atualiza o valor do topo com o resultado
   
    jmp multiplicacao         # chama funcao multiplicacao de novo

triangulo:
    pushl $pergunta4
    call printf
    addl $4, %esp

    pushl $base
    pushl $float_scan
    call scanf
    add $8, %esp

    pushl $pergunta5
    call printf
    addl $4, %esp

    pushl $altura
    pushl $float_scan
    call scanf
    add $8, %esp

    flds base
    flds altura
    subl $16, %esp

    fmulp

    flds div_triangulo

    fdivp 
    
    jmp printa_valor_area

raizquadrada:
    # Pergunta para saber o número que deseja saber a raiz
    pushl $pergunta6
    call printf
    addl $4, %esp

    pushl $raiz
    pushl $float_scan
    call scanf
    addl $8, %esp

    flds raiz 

    subl $8, %esp

    fsqrt 
    
    jmp printa_valor_raiz

quit:
    pushl $0
    call exit
