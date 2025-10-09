#!/bin/bash

#Crie um script chamado acessos_mais_frequentes.sh que mostre o endereço IP 
#que mais vezes acessou o servidor.

_acessos="/home/guilhermeo.lima/Documentos/script/atividades/atividade04/acessos.log "

_ipMasFrequente=$(
    cat "$_acessos" |
    cut -d',' -f1 |          # Extrai a coluna de IPs
    sort |                   # Ordena os IPs
    uniq -c |                # Conta as ocorrências de cada IP
    sort -nr |               # Ordena numericamente em ordem decrescente
    head -n 1 |              # Pega o IP com mais acessos
    awk '{print $2}'         # Extrai apenas o endereço IP
)

echo "O IP que mais acessou o servidor foi: $_ipMasFrequente"