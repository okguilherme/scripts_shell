#!/bin/bash

#Um script chamado soma.sh que faça a soma valor total dos produtos comprados.

_compras="/home/guilhermeo.lima/Documentos/script/atividades/atividade04/compras.txt"


# 1. 'cat' e 'tail -n +2': Exibe o conteúdo e remove a linha de cabeçalho.
# 2. 'cut -d',' -f2': Isola a segunda coluna (os valores) usando a vírgula como delimitador.
# 3. 'paste -sd'+'': Transforma a coluna de números em uma única string, usando '+' como separador. 
#    (Exemplo: "4999+9799+...")
# 4. 'sed 's/+$//'': Remove o sinal de '+' que sobra no final da string.
# 5. 'bc': Calcula a expressão matemática gerada e armazena o total em '_valorTotal'.

_valorTotal=$(
    cat "$_compras"|
    tail -n +2 |
    cut -d',' -f2 |
    paste -sd'+' |
    sed 's/+$//' |
    bc
)

echo -e "O valor total é: $"$_valorTotal 