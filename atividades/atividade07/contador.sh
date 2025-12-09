#!/bin/bash

# $1 é o nome digitado pelo usuário.

NOME=$1
SEGUNDOS=0

while true
do
    # 1. Imprimir a mensagem a cada segundo
    echo "Processo [$NOME] - Tempo: [$SEGUNDOS] - PID: [$$]"

    # 2. Esperar 1 segundo
    sleep 1

    # 3. Incrementar o contador
    SEGUNDOS=$((SEGUNDOS + 1))
done

# O loop só será encerrado por um comando 'kill' externo.