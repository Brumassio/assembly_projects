.section .data
    str_scan: .asciz "%d" 
    str_print: .asciz "%d "
    print_test: .asciz "Entrei aqui"
    vet1: .int 356, 2, 422, 10, 1112, 1, 35, -5
    count: .int 4
    count2: .int 0
    count3: .int 0
    count4: .int 28   
    valor: .int 0
    aux: .int 0
    aux2: .int 0
    chave: .int 0
 
.section .text
.globl _start

_start:
    call looping_for

looping_for:
    cmpl $32, count
    je printar_vetor
    
    # count2 = count-1
    movl count, %eax
    movl %eax, count2
    subl  $4, count2

    
    # chave = vet1[count]
    movl $vet1, %edi 
    addl count, %edi   
    movl (%edi), %eax
    movl %eax, chave

    jmp looping_while

    # vet1[count+1]=chave
    

looping_while:
    # ve se count2 é maior ou igual a zero se sim continua
    # agora compara se chave < vet1[count2] 

    cmpl $0, count2
    jl finalizar_while

    movl $vet1, %edi 
    addl count2, %edi   
    movl (%edi), %eax
    cmpl chave, %eax
    jge finalizar_while

    movl $vet1, %edi 
    addl count2, %edi   
    movl (%edi), %eax
    movl %eax, aux

    movl count2, %eax
    movl %eax, count3
    addl $4 , count3

    movl $vet1, %edi 
    addl count3, %edi
    movl aux, %eax   
    movl %eax, (%edi)

    subl $4, count2
    jmp looping_while
    
finalizar_while:
    movl count2, %eax
    movl %eax, aux
    addl $4, aux

    movl $vet1, %edi 
    addl aux, %edi   
    movl chave, %eax
    movl %eax, (%edi)
    
    addl $4, count
    jmp looping_for

printar_vetor:
    cmpl $-4, count4
    je quit

    movl $vet1, %edi
    addl count4, %edi
    movl (%edi), %eax

    pushl %eax
    pushl $str_print
    call printf
    addl $8, %esp

    subl $4, count4

    jmp printar_vetor

quit:
    addl $8, %esp
    call exit