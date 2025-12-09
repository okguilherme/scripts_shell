#!/bin/bash

# Verifica se foi passado um parâmetro
if [ -z "$1" ]; then
    echo "Uso: $0 <diretório>"
    exit 1
fi

diretorio="$1"

# Verifica se o diretório existe
if [ ! -d "$diretorio" ]; then
    echo "Erro: diretório '$diretorio' não encontrado."
    exit 1
fi

echo "Arquivos em '$diretorio' ordenados por quantidade de linhas:"
echo "................................................................"

# Lista os arquivos .txt com suas contagens de linhas e ordena
for arquivo in "$diretorio"/*.txt; do
    linhas=$(wc -l < "$arquivo")
    echo "$linhas $arquivo"
done | sort -n
