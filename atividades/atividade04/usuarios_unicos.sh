#!/bin/bash

#Crie um script chamado usuarios_unicos.sh que mostre a lista de usuários 
#únicos que acessaram o servidor, ordenados alfabeticamente.

_acessos="/home/guilhermeo.lima/Documentos/script/atividades/atividade04/acessos.log "

users=$(cat "$_acessos" | cut -d',' -f2 | sort | uniq)

echo "$users" | tr ' ' '\n'

