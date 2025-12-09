#!/bin/bash

read -p "Digite um nome para o processo em background: " nome_processo

# Inicia o processo em background e captura o PID
./contador.sh "$nome_processo" &
PID_CONTADOR=$!

echo "---------------------------------------------------------"
echo "Processo em background iniciado:"
echo " Nome: [$nome_processo]" 
echo " PID do contador.sh: [$PID_CONTADOR]"
echo "---------------------------------------------------------"

echo "Esperando 10 segundos antes de finalizar o processo..."
sleep 10
echo "Tempo de espera finalizado."


kill "$PID_CONTADOR" 

echo "..........................................................."
echo "Processo [$nome_processo] finalizado (PID: [$PID_CONTADOR])." 
echo "..........................................................."