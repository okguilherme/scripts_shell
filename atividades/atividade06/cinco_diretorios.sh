#!/bin/bash

# Verifica se o diretório 'cinco' existe
if [ ! -d cinco ]; then
    echo "Criando diretório 'cinco' e subdiretórios..."
    mkdir cinco
    for ((i=1; i<=5; i++)); do
        mkdir "cinco/dir$i"
        echo "  -> Criado 'cinco/dir$i'"
    done
else
    echo "Diretório 'cinco' já existe. Pulando criação de subdiretórios."
fi

# Criação dos arquivos em cada subdiretório
for ((i=1; i<=5; i++)); do
    for ((a=1; a<=4; a++)); do
        arquivo="cinco/dir$i/arq$a.txt"
        echo "Criando $arquivo..."
        > "$arquivo"  # limpa o arquivo antes de escrever
        for ((linha=1; linha<=a; linha++)); do
            echo "$a" >> "$arquivo"
        done
    done
done

echo "Processo concluído."
