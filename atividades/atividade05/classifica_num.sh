#!/bin/bash

# Verifica se foi passado um argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <número entre 0 e 20>"
    exit 1
fi

numero=$1

case $numero in
    # Aceita apenas números de 0 a 20
    [0-9]|1[0-9]|20)
        case $numero in
            0)
                echo "O valor é nulo."
                ;;
            10|20)
                echo "Valor especial."
                ;;
            *)
                echo "Valor é $numero e não é especial."
                ;;
        esac
        ;;
    *)
        echo "Valor inválido! Digite um número entre 0 e 20."
        ;;
esac
