#!/bin/bash

if [ $# -ne 1 ]

 then
    echo "Uso: $0 <diretório>"
    exit 2 
fi

if [ -d "$1" ] && [ -w "$1" ]

 then
    echo -e "Diretório ok. Listando:\n$(ls -l "$1")"
    exit 0
else
    echo "Erro: O diretório não existe ou não pode ser modificado."
    exit 1
fi